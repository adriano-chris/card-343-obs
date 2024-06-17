### Apontamento de componentes

0 - criar os campos codigo componente e sequencial do grupo na tabela Ztpp_Apt_Desvio

1 - Fazer uma nova procedure para listar todos os componentes rastreaveis da OP

            Select Rsnum --nro da reserva
              From Afko
             Where Mandt = '400' --trocar para 400
               And Aufnr = lpad('1851486',12,0);
               
               
               select a.baugr, a.matnr, c.maktx
               from resb a,
                    Mara b,
                    makt c
               where  rsnum = '0033464090'
             and   a.Mandt = '400' --trocar para 400
               And a.Aufnr = lpad('1851486',12,0)
               AND A.MATNR = B.MATNR 
               and A.MATNR = c.MATNR 
               AND Ltrim(Rtrim(b.Normt)) Is Null
               order by baugr;               

--no cursor não é para mostrar o campo baugr, porém ordenar por ele

2 - Botão Gravar: Se tiver preenchido os componentes, chamar a procedure chrpp_mf007_pkg.Grava_Apontamento_Desvio_Comp, senão chamar a procedure já existente chrpp_mf007_pkg.Grava_Apontamento_Desvio
Se for componentes, gravar os codigos dos componentes (000000006068131170;000000006067110273;000000006152110218) e sequencial por grupo (Ztpp_Apt_Desvio)

Se for produto, gravar em branco os codigos dos componentes e sequencial 0 (Ztpp_Apt_Desvio)

Se for para Gravar passar o P_Contador nulo, se for para editar passar o P_Contador preenchido.


3 - Gerar uma nova procedure para listar os componentes por grupo.


------------------------------------------------------------------------------------------------------------------------------------------
#                                                                                                                                        #
------------------------------------------------------------------------------------------------------------------------------------------
```sh
REFINAMENTO 02/05/2024:

na tabela from resb a 
Quando eu falo que tem que fazer 1200 produtos(retrator) mediante uma ordem de producao, eu vou precisar de vário componentes.
Para abastecer a linha os colaboradores do almoxarifado precisam separar várias caixas desses componentes.
E são esses compontes usados para apontar os defeitos, ou seja, quando eu não consigo chega no produto final, é por conta desses apontamento de componentes e subcomponentes.

1º VAI EXPLODIR TUDO!
 Criar objeto que vai retornar uma lista de componente e subcomponentes para o backend.


No SAP é gerado um núnero de reserva que é como se fosse um sequencial, esse número de reserva tem na tabela  (resb)


```sql
--select * from all_objects where 0=0 and regexp_like(object_name, 'Afko','i')


-- O SAP gera um ordem de reserva
--select * from all_objects where 0=0 and regexp_like(object_name, 'Afko','i')


-- O SAP gera um ordem de reserva
Select a.Rsnum  --nro da reserva
     , a.aufnr  -- Ordem de Prod. SAP  
     , a.* 
  From Afko a
  Where a.Mandt = '400' 
    And a.Aufnr = lpad('1851486',12,0); -- Ordem de Prod. SAP
--
--        
select a.baugr
     , a.matnr
     , c.maktx
from resb a,
    Mara b,     -- Somente itens rastreados
    makt c
where  rsnum = '0033464090'
and   a.Mandt = '400' --trocar para 400
And a.Aufnr = lpad('1851486',12,0)
AND A.MATNR = B.MATNR 
and A.MATNR = c.MATNR 
AND Ltrim(Rtrim(b.Normt)) Is Null
order by baugr;
--        

--no cursor não é para mostrar o campo baugr, porém ordenar por ele

```sh
 Obs.: A Jaque falou que a tebela (Afko) é extremamente lenta, para contornar isso a sugestão é criar um web service. 
 Ou seja, enviar esse escopo para o Franklin, ele faz uma RFC com uma função dentro do SAP e o DB consome essa função do SAP. Esse é o mesmo processo da PP0014, que chama a função do SAP....

 RFC --> Envia um xml(q é um web service) e retorna um xml(q é um web service).
 

# P_Sq_Controle_Op --> Esse parâmetro é opcional na mf014. Acontece o seguinte, quando o PCP libera uma Otipo c/ 1500 peças, signfica q precisar ser produzido 1500 pçs, porém, não necessáriamente entrará linha no mesmo dia para produção, as vezes é feito os 1500 de forma parcial, esse parâmetro é utilizado para persistir na PP001 para indicar a sequencia na PP006 onde esse dado precisa ser exibido de modo agrupado. Esse exemplo não está sendo utilizado atualmente, porém, ficou como um padrão para ser usado quando necessário.


 Ficaria da seguinte maneira:
  # Criaria uma proc do nosso lado que chamaria a função criada no SAP onde retornaria essas informações.
  # A Jaque prefere fazer isso direto, porque é mais simples.

  Analisar a performance de fazer essa query no PL/SQL.
--

Implementar esse OBJ na PP007,  

# audio 17:25 -- Seguir daqui
```


## IMPLEMENTAR PIPELINE TABLE FUNCTION:
```sql
Declare
 
 P_Nr_Ordem                  Afko.Aufnr%Type:= '1851486';  
 P_Mandt                     Afko.Mandt%Type:= '400';
 
 --
 -- Variable Type Table
 Type_Afko                   Afko%Rowtype; 
 --V_Rsnum                     Afko.Rsnum%Type; 
 
 
Begin 
  
  Select a.rsnum   
       , a.aufnr 
    Into Type_Afko.Rsnum 
       , Type_Afko.Aufnr
   From Afko a
  Where a.Mandt = P_Mandt
    And a.Aufnr = lpad(P_Nr_Ordem,12,0);
    
 --dbms_output.put_line(Type_Afko.Rsnum||CHR(13)|| Type_Afko.aufnr);    

  
  For Reg In (  Select a.matnr          As Cod_SubComponente
                     , c.maktx          As Desc_Subcomponente
                From resb a
                   , Mara b     -- Somente itens rastreados
                   ,  makt c
                Where  rsnum  = Type_Afko.Rsnum  --'0033464090'
                And   a.Mandt = P_Mandt --'400' --trocar para 400
                And a.Aufnr   = Lpad(Type_Afko.Aufnr,12,0)
                AND A.MATNR   = B.MATNR 
                And A.MATNR   = c.MATNR 
                AND Ltrim(Rtrim(b.Normt)) Is Null
                Order By a.baugr
                ) Loop
                
                      dbms_output.put_line('Cod_SubComponente: '||Reg.Cod_SubComponente||' '||'Desc_Subcomponente: '||Reg.Desc_Subcomponente);
                  End Loop;
  
End;
```



```sql
-- EXECUTE:
DECLARE
            
    v_Cod_SubComponente         resb.matnr%TYPE;    
    v_Desc_Subcomponente        makt.maktx%TYPE;
    --
    v_cursor                    SYS_REFCURSOR;
    V_Erro_Num                  Number;
    V_Erro_Des                  Varchar2(100);

BEGIN
  
    chrpp_mf007_pkg.Lista_Todos_Componentes(  P_Nr_Ordem    => '1851486'
                                            , P_Mandt       => '400'
                                            , P_Cursor      => v_cursor
                                            , P_Erro_Num    => V_Erro_Num
                                            , P_Erro_Des    => V_Erro_Des
                                             );

    LOOP
        FETCH v_cursor INTO v_Cod_SubComponente
                          , v_Desc_Subcomponente;
        EXIT WHEN v_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(v_Cod_SubComponente||'   '|| v_Desc_Subcomponente);
    END LOOP;
    CLOSE v_cursor;
      
END;

```


# STATUS 
```sh

1ª Fase: Criar procedure para retornar a lista de componentes (filhos) Em anexo Lista_Todos_Componentes. #Ok

2ª Fase: Criar procedure para efetuar o apontamento de componente efetivamente + persistência de dados na tabela do SAP. 
# Ok

INDEX_COMP   NUMBER(10)



NUMBER(10)

Campo Numérico 1º vez 1
               2º vez 2

Implementar a opção de edição do agrupamento

Pai grava 0 e componente vazio
Filho grava o seq...


-- TEMPLATE DE QUERY P/ IMPLEMENTAR A VALIDAÇÃO DO AGRUPAMENTO DOS COMPONENTES...
SELECT  Distinct(componente) 
      --, Index_Comp 
      --, mandt
      --, contador
      --, ordem_producao
      --, produto
      --, centro_trabalho
      --, maquina
      --, turno
      --, codigo_defeito
      --, qtde
      --, sq_lote
      --, observacao
      --, data_criacao
      --, usuario_criacao
      --, data_alteracao
      --, usuario_alteracao
      --, hora_criacao
      --, hora_alteracao 
      --, Index_Comp     
FROM chriserp.stg_desvio_comp
WHERE 0=0 
And Ordem_Producao = '000001880380'
AND sq_lote = '219217'  
Group By componente
        --, Index_Comp    
        --, mandt
        --, contador
        --, ordem_producao
        --, produto
        --, centro_trabalho
        --, maquina
        --, turno
        --, codigo_defeito
        --, qtde
        --, sq_lote
        --, observacao
        --, data_criacao
        --, usuario_criacao
        --, data_alteracao
        --, usuario_alteracao
        --, hora_criacao
        --, hora_alteracao           
Order By Contador  


# Aguardando o Franklin criar o novo campo....

## 29:14 continuar daqui.....




# ---------------------------------------
# ---------------------------------------

Gravar sequencial por grupo.

O trabalho no .NET é receber informar p/ o DB na chamada da proc Grava_Apontamento_Desvio_Comp a lista de componente.

Trabalho no DB receber uma lista de componente como parâmetro de entrada, desmembrar e persistir o dado.

Ao gravar no banco devolver um parâmetro de saída para .NET.. Na tela terá que fazer o gerenciamento do agrupamento p/ saber quando 
editar e quando inserir.

Posso usar o parâmetro contador para retornar, pensar melhor nesse ponto da implementação.
o .NET tem que passar o parâmetro contador preenchido da linha correta, vai editar a linha errada.
No momento de efetuar a alteração pelo contaor, será alterado várias linhas correspondente ao contador informado.

Ou seja, quando for editar precisa retornar uma lista dos defeitos já apontados para que o usuário possa selecionar qual grupo ele quer apontar.


Em qual tabela fica cadastrado o código de erro, ztpt_desvio...

```


```sql

Select * from Ztpp_Apt_Desvio Where Sq_Lote = '219217' Order By 2; 



SELECT A.* --MAX(a.Cd_Centro_Custo)
      , B.CD_MAQUINA
--INTO T.Centro_Trabalho
FROM Tg_Maq_Ct_Terminal a,
   Tg_Maquina b
WHERE a.Sq_Maquina         = b.Sq_Maquina 
 AND b.Cd_Maquina         = '0254'  --For Update            --Type_Comp.Maquina  0720
 AND Upper(a.Nm_Terminal) = 'NBCHRIS078'; 

--Select * from Tg_Maquina b Where b.Cd_Maquina = '0720'; --FOR UPDATE;


Select Nvl(Max(To_Number(Contador)),0) + 1
  --Into T.contador
 From Ztpp_Apt_Desvio;
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

Select Maquina
     , a.Centro_Trabalho
     , To_Char(Contador) Contador
     , Codigo_Defeito
     , b.Descricao
     , Qtde
     , Observacao
     , a.sq_lote
     , c.Cd_Fam Nr_Rastrea
     , a.componente
From Ztpp_Apt_Desvio a,
    Ztpp_Desvio b,
    Pd_Lote_Rastrea c
Where a.Mandt = b.Mandt
And Codigo_Defeito = b.Cod
And a.Data_Criacao = To_Char(Sysdate,'YYYYMMDD') -- filtrar apenas apontamentos do dia
And Lpad(Ordem_Producao,12,0) = Lpad('1880380',12,0)
And Maquina                   = '0254'--P_Cod_Maquina
And a.Data_Criacao = To_Char(Sysdate,'YYYYMMDD')-- filtrar apenas apontamentos do dia para OP
And a.Sq_Lote  = c.Sq_Lote
And Index_Comp = 0

Union All

Select Maquina
     , a.Centro_Trabalho
     , Replace(To_Char(Contador), To_Char(Contador), Index_Comp) Contador
     , Codigo_Defeito
     , b.Descricao
     , Qtde
     , Observacao
     , a.sq_lote
     , c.Cd_Fam Nr_Rastrea
     , a.componente
From Ztpp_Apt_Desvio a,
    Ztpp_Desvio b,
    Pd_Lote_Rastrea c
Where a.Mandt = b.Mandt
And Codigo_Defeito = b.Cod
And a.Data_Criacao = To_Char(Sysdate,'YYYYMMDD') -- filtrar apenas apontamentos do dia
And Lpad(Ordem_Producao,12,0) = Lpad('1880380',12,0)
And Maquina                   = '0254'--P_Cod_Maquina
And a.Data_Criacao = To_Char(Sysdate,'YYYYMMDD')-- filtrar apenas apontamentos do dia para OP
And a.Sq_Lote = c.Sq_Lote
And Index_Comp > 0;
```






