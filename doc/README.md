# card-343

### Sistema para Apontamento de Refugo no MES para componentes

```sh
Apontamento de Defeitos de Componentes MES 
 
Aplicações alteradas PP007, PP006, PP001

Pkgs Alteradas:
# chrpp_mf007_pkg
# chrpp_mf006_pkg
# chrpp_mf001_pkg


Tabela SAP que será alterada: 
# ZTPP_APT_DESVIO
```


```sh
1 - Na tabela ZTPP_APT_DESVIO incluir um novo campo com o codigo do componente. 
Se o apontamento for do item pai, fica em branco
SELECT * FROM ZTPP_APT_DESVIO;

2 - Para exibir a lista técnica do produto, deve utilizar a pkg chrpp_mf014_pkg.lista_tecnica_componentes , que tem uma rfc com o sap. 

3 - A pkg PP007 deve conter a procedure para salvar o apontamento do item filho (componente) e também editar a qtde qdo necessário

4 - Na aplicação PP007 deve ser criados os campos para atender os apontamentos, etc (conforme desenho)

5 - Na aplicação PP006, quando clicar no botão apontamento de defeitos de componentes, tem que chamar a pkg  com o detalhes dos componentes

6 - Na aplicação PP001 criar um campo novo não editavel com a qtde total da OP menos a qtde de defeitos 
 
** observar o apontamento por grupinho (Luzivania)

```


```sh
# Anotações:

O Porjeto deve contar duas telas de exibição

1º Fase do projeto:
-- TELA DE EXIBIÇÃO:
# Para começar a produção o operador precisar ir na PP001 e fazer o setup com as informações disponibilizada pelo PCP.
 Apontamento de Desvios # Já existe!!!
 Criar a possibilidade de apontar o refugo de componente(Apontamento de Defeito Componente)

Hoje temos o código do produto!
Precisamos criar a lista técnica dos componentes de cada produto
           criar a lista técnica dos subcomponentes de cada componente...

-- TELA DE EXIBIÇÃO:
Na PP007 contém a tela de exibição, e aquele apontamento realizado na PP001 o sistema permite visualizar aqui na PP007.
Será necessário implementar a lista de refugo dos componente e subcomponentes.


################################
#  EXPLICAÇÃO TÉCNICA DA JAQUE #
################################
Já temos no M.E.S o apontamento de produto, como por exemplo. fecho, retrator etc tanto de produção, de defeito e de paradas.
a PP006 é alimentado pelos apontamentos de refugo de produtos acabado, que é o código montado!

Foi solicitado pelo usuário a possibilidade de apontar um componente ou subcomponente que está abaixo do produto acabado.

1º alteração PP007.
Falando em tabelas: Sugestão da Jaque: Criar um campo a mais em uma tabela que já exixte.
Tabela utilizado hoje para apontar os desvios --> ZTPP_APT_DESVIO
Foi criado essa tabela no SAP para gerenciar os refugos porque é gerado vários relatório dentro do SAP.


criar um novo atributo chamado COMPONENTE # Se esse campo estiver preenchido sign. que é apontamento de componente!
                                          # Se estiver nulo sign. que é apontamento de produto acabado.

A ideia de adicionar um novo campo na tebala existente é evitar ficar criando joins...

Tem uma função que já existe no  M.E.S que explode a lista técnica dos componentes no SAP.
A coluna nova deve receber os códigos dos componentes e subcomponentes #(Preciso daber se é pai ou filho)

Em resumo vamos trabalhar com APP007 explosão ed lista técnica
                              Alteração de uma tabela                            
                              APP001 na hora de chamar para exibir na tela os apontamentos.



Já existe uma tabela com os códigos dos defeito 
Quando o usuário clicar em desvio, o sistema já exibe todos os defeitos, tem uma procedure que chama essa lista de defeito no SAP. Em caso de dúvida perguntar para a Jaque.

Na PP007 tem uma procedure chamada (lista_desvios) 





################################################################################################################################################

2º Fase:
Contagem de peça na estação 10, 2º estação ao iniciar a produção.
Hoje essa estação faz a contagem de refugo como se fosse produto acabado, porque ainda é um componente.
A produção está solicitando para contar o refugo dos componentes!


Será mantido o ponto de contagem da máquina, porém, no final da produção os apontamentos de defeitos vão abater da quantidade produzida para dar a quantidade real de peças prontas!



PP007 --> Onde é feito o "apontamento de desvio de produto"
 Parâmetros da Tela:
 Cód. Desvio 
 Quantidade 
 FAM            # Do setup do dia..
 Observação     # Motivo

 # Obs.: Esse é o apontamento de defeito para o produto acabado!


A ideia é criar dentro da mesma tela o "apontamento de defeito de compontes"
Vamos precisar de uma tabela que vai exibir uma lista técnica do produto cadastrado na máquina para que o operador possa selecionar qual o componente que ele quer apontar. 


operador precisa ter a opção de "selecionar  um ou mais COMPONENTE" e deve retornar todos os SUBCOMPONENTES daquele COMPONENTE para que ele possa selecionar os componentes desejados subtrair, adicionar.


Ao salvar fica um registro na tela 
cód Desvio
Desc. Desvio Quantidade 

```

```sh
###############################################################################################################################################
                                                                1º FASE:         
###############################################################################################################################################
1 - Na tabela ZTPP_APT_DESVIO incluir um novo campo com o codigo do componente. 
```sh
Se o apontamento for do item pai, fica em branco
SELECT * FROM ZTPP_APT_DESVIO;
```

#### SOLUÇÃO: 
```sql
ALTER TABLE Ztpp_Desvio ADD (apontamento VARCHAR2(18)); 

Alterar a Procedure Grava_Apontamento_Desvio e adicionar o novo campo no processo. 
Tabela Ztpp_Apt_Desvio....


.. CONTINUAR DAQUI....

```









```

2 - Para exibir a lista técnica do produto, deve utilizar a pkg chrpp_mf014_pkg.lista_tecnica_componentes , que tem uma rfc com o sap.
CHRISERP.
    CHRPP_MF014_PKG.
        LISTA_TECNICA_COMPONENTES


SELECT * 
FROM Pd_Caalm_Op pco -- PK: NR_OP, SQ_CONTROLE_OP, SQ_OP_ALMOX
WHERE 0=0
AND pco.nr_op = 000001783097
AND pco.sq_controle_op = 1
AND pco.sq_op_almox = 1
AND TRUNC(pco.dh_adicionado) != to_date('15/09/2022', 'DD/MM/RRRR');


-- CODIGO           DESCRICAO         
000000000607243310	ALT DIR INJ DAILY PTO C050
000000010031118547	BUCHA MET ESP 19x17,5X10,2 ZC PT
000000000606317487	ARRUELA PL RETENCAO PARAF M10 PTO
000000001003320415	PARAF TORX M10X40,3 C/NY
--
--
begin
  -- Call the procedure
  chriserp.chrpp_mf014_pkg.lista_tecnica_componentes(p_nr_op          => :p_nr_op,              -- 000001783097
                                                     p_sq_controle_op => :p_sq_controle_op,     -- 1
                                                     p_cursor         => :p_cursor,
                                                     p_erro_num       => :p_erro_num,
                                                     p_erro_des       => :p_erro_des
                                                     );
end;



-- Testar a chamada da chriserp.chrpp_mf014_pkg.lista_tecnica_componentes
DBMS_OUTPUT.PUT_LINE('V_Nr_Op');




3 - A pkg PP007 deve conter a procedure para salvar o apontamento do item filho (componente) e também editar a qtde qdo necessário
CHRISERP.CHRPP_MF007_PKG


MF007 Grava_Apontamento_Desvio retorna o "p_nr_op" que vou precisa na chamada da chrpp_mf014_pkg.lista_tecnica_componentes p/ retornar os componentes.
Procedure Grava_Apontamento_Desvio
  Begin
          Select Lpad(Nr_Op,12,0)
            Into V_Nr_Op
            From Pd_Lote_Op
           Where Sq_Lote = P_Sq_Lote;
        Exception
             When Others Then
               P_Erro_Num := SqlCode;
               P_Erro_Des := 'Chrpp_Mf007_Pkg.Grava_Apontamento_Desvio - Erro ao buscar o Nro da Ordem de Produção ' || SqlErrM;
               Return;
        End;

```

---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
```sh
# STATUS:
# DATA: 18/04/2024

```

Depto Rastreabilidade
Entidade, componente, fica pendurado todos os processos...




Depto PCP
 Aplicação SAP
 Tem que criar a OP

 MES

FAC
FAN --> Produto acabado é sempre um FAM
RIR

PD_RASTREABILIDADE
 Lista a rastreabilidade

 Apenas a ordem de producao que nao tem rastreabilidade...

Lote 
 --> visto fora da empresa


No momento de salvar é que o sistema gera o lote e persiste o dado.

---------------------
---------------------
-- Criar um novo lote
Nro Rastrea -- copia
 Novo FAM -- cola 461242
Nro Rastrea 


--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
> STATUS: \
> DATA: 19/04/2024

INCONSISTÊNCIAS NO PROCESSO:
1 - Ao criar o setup foi gerado um lote 000001880380, porém, esse lote não está retornando na chrpp_mf014_pkg.
    Outros lotes de teste funcionam, reproduzir esse cenário com o auxíio da LU.

2 - Não está gerando o centro de custo desse processo.




> STATUS: \
> DATA: 19/04/2024
```sh
1 - Na tabela ZTPP_APT_DESVIO incluir um novo campo com o codigo do componente. # OK

2 - Para exibir a lista técnica do produto, deve utilizar a pkg chrpp_mf014_pkg.lista_tecnica_componentes , que tem uma rfc com o sap. # ok

3 - A pkg PP007 deve conter a procedure para salvar o apontamento do item filho (componente) e também editar a qtde qdo necessário # ok

/*
SELECT t.codigo_defeito  -- campo editável
     , t.qtde            -- campo editável
     , t.observacao      -- campo editável
     , t.componente      -- Parâmetros de Alteração
     , t.* 
FROM chriserp.Ztpp_Apt_Desvio_Tst t WHERE t.SQ_LOTE = '219217'; 
*/
SELECT * FROM chriserp.Stg_Desvio_Comp; 
--DELETE FROM chriserp.Stg_Desvio_Comp;
--FROM chriserp.Ztpp_Apt_Desvio_Tst t WHERE t.componente = '000000000607243310'; 
--DELETE FROM chriserp.Ztpp_Apt_Desvio_Tst; 

4 - Na aplicação PP007 deve ser criados os campos para atender os apontamentos, etc (conforme desenho)  # ok



5 - Na aplicação PP006, quando clicar no botão apontamento de defeitos de componentes, tem que chamar a pkg  com o detalhes dos componentes
# Aguardando definição referente agrupamento. Seguir para o item 5.


6 - Na aplicação PP001 criar um campo novo não editavel com a qtde total da OP menos a qtde de defeitos 
 
** observar o apontamento por grupinho (Luzivania)

```



 # Definir a lista de subcomponentes no 
 # definir o agrupamento 

```sql
/*
-- RANDOM STRING 5 CARACTER
DECLARE
    v_random_string               VARCHAR2(20); -- Defina o tamanho desejado da string aleatória
    v_chars                       VARCHAR2(100) := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    v_length                      NUMBER;
    v_index                       NUMBER;
BEGIN
    v_length := LENGTH(v_chars);
    
    -- Loop para construir a string aleatória
    FOR i IN 1..20 LOOP -- Altere 20 para o comprimento desejado da string aleatória
        v_index := CEIL(DBMS_RANDOM.VALUE(1, v_length));
        v_random_string := v_random_string || SUBSTR(v_chars, v_index, 1);
    END LOOP;
        

    -- Exibe a string aleatória gerada
    --DBMS_OUTPUT.PUT_LINE('String aleatória: ' || SUBSTR(v_random_string), -5 );
    DBMS_OUTPUT.PUT_LINE('String aleatória: ' || SUBSTR(v_random_string, 1, 5));

END;
/*
RbeQ5
okmQT
33rdz
J0TXy
*/
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
DECLARE
    v_random_number INTEGER;
BEGIN
    -- Gera um número aleatório entre 1 e 100 e atribui a v_random_number
    v_random_number := DBMS_RANDOM.VALUE(1, 1000);
    
    -- Exibe o número aleatório gerado
    DBMS_OUTPUT.PUT_LINE('Número aleatório: ' || SUBSTR(v_random_number, 1, 5));
END;
/*
972
606
560
*/
```

```md

> STATUS: \
> DATA: 02/05/2024
```sh
1 - Na tabela ZTPP_APT_DESVIO incluir um novo campo com o codigo do componente. # OK

2 - Para exibir a lista técnica do produto, deve utilizar a pkg chrpp_mf014_pkg.lista_tecnica_componentes , que tem uma rfc com o sap. # Marcos

3 - A pkg PP007 deve conter a procedure para salvar o apontamento do item filho (componente) e também editar a qtde qdo necessário # ok



/*
SELECT t.codigo_defeito  -- campo editável
     , t.qtde            -- campo editável
     , t.observacao      -- campo editável
     , t.componente      -- Parâmetros de Alteração
     , t.* 
FROM chriserp.Ztpp_Apt_Desvio_Tst t WHERE t.SQ_LOTE = '219217'; 
*/
SELECT * FROM chriserp.Stg_Desvio_Comp; 
--DELETE FROM chriserp.Stg_Desvio_Comp;
--FROM chriserp.Ztpp_Apt_Desvio_Tst t WHERE t.componente = '000000000607243310'; 
--DELETE FROM chriserp.Ztpp_Apt_Desvio_Tst; 

4 - Na aplicação PP007 deve ser criados os campos para atender os apontamentos, etc (conforme desenho)  # ok

5 - Na aplicação PP006, quando clicar no botão apontamento de defeitos de componentes, tem que chamar a pkg  com o detalhes dos componentes
# Aguardando definição referente agrupamento. Seguir para o item 5.


6 - Na aplicação PP001 criar um campo novo não editavel com a qtde total da OP menos a qtde de defeitos 
 
** observar o apontamento por grupinho (Luzivania)





```









  

