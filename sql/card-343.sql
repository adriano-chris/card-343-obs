-- CLONE_NEW:
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
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
                                 -- FAM: FICHA DE ACOMPANHAMENTO MONTAGEM
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
-- Para produtos pai registrados em set up na PD_LOTE_RASTRE (Cadastrados nos touch no inicio de produ��o)
SELECT plr.cd_fam    -- CD_FAM  NUMBER(15) not null,
     , plr.* 
FROM chriserp.pd_lote_rastrea plr -- PK: SQ_LOTE
WHERE 0=0
AND plr.sq_lote = 6809;
--
--
-- Para produto pai e filhos na PD_RASTREABILIDADE (Lote gerado para se cadastrar nos touch)
SELECT * 
FROM chriserp.pd_rastreabilidade pr -- PK: SQ_RASTREA
WHERE 0=0
AND pr.sq_rastrea = 6672;



-- 07/05/2024:

--SELECT * FROM Pd_Lote_Rastrea WHERE Maquina_Cod = '0734' AND VF_ENCERRADO = 'N'; -- LOTES ATIVOS
--SELECT * FROM Pd_Lote_Op WHERE Sq_Lote = '219217';
--SELECT * FROM Ztpp_Apt_Desvio WHERE SQ_LOTE = '219217';  
SELECT * FROM chriserp.stg_desvio_comp WHERE sq_lote = '219217' And Contador = 1;--order by 2;
-- SELECT DISTINCT(Codigo_Defeito) FROM ztpp_apt_desvio Tabela de código de defeito no SAP



Como implementar um algorítmo que valida combinações exixtentes no pl/sql para o campo componente?
Select Componente
from chriserp.stg_desvio_comp
WHERE sq_lote = '219217' And Contador = 1;




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


Select * from chriserp.stg_desvio_comp Where Ordem_Producao = '000001880380' Order By 2;

/*
Insert Into chriserp.stg_desvio_comp (  mandt, contador, ordem_producao, produto, centro_trabalho, maquina, turno, codigo_defeito, qtde, sq_lote, observacao, data_criacao, usuario_criacao, data_alteracao, usuario_alteracao, hora_criacao, hora_alteracao, componente, Index_Comp) Values (  '400' , 20  ,'000001880380' ,'000000006082138305' , '669' , '0254' , '1' , '64AA' , 50.000 , '219217' ,'Update Teste!' , '20240509' , 'TI_ADRIANO' , '20240509' , 'TI_ADRIANO' , '165134' , '135225', '000000000624560576' , 2 );
Insert Into chriserp.stg_desvio_comp (  mandt, contador, ordem_producao, produto, centro_trabalho, maquina, turno, codigo_defeito, qtde, sq_lote, observacao, data_criacao, usuario_criacao, data_alteracao, usuario_alteracao, hora_criacao, hora_alteracao, componente, Index_Comp) Values (  '400' , 21  ,'000001880380'   ,'000000006082138305' , '669' , '0254' , '1' , '64AA' , 50.000 , '219217' ,'Update Teste!' , '20240509' , 'TI_ADRIANO' , '20240509' , 'TI_ADRIANO' , '165134' , '135225', '000000000624560576' , 3 );
Insert Into chriserp.stg_desvio_comp (  mandt, contador, ordem_producao, produto, centro_trabalho, maquina, turno, codigo_defeito, qtde, sq_lote, observacao, data_criacao, usuario_criacao, data_alteracao, usuario_alteracao, hora_criacao, hora_alteracao, componente, Index_Comp) Values (  '400' , 22  ,'000001880380'   ,'000000006082138305' , '669' , '0254' , '1' , '64AA' , 50.000 , '219217' ,'Update Teste!' , '20240509' , 'TI_ADRIANO' , '20240509' , 'TI_ADRIANO' , '165134' , '135225', '000000000624560576' , 3 );
*/


-- 14/06/2024:


-- Alinhamento feito com a Jaque em 17/05/24
Regras de atualização:

Botão de editar...
Só se aplica para o MESMO DEFEITO!

Qtde 
Observação
(Mesmo) Código de defeito/cod_Desvio -  Somente efetuar update 
--
--
quando atualização de componente(filho) necessário informar os parâmetros 

Sq_Lote                       -- app fornence
Terminal                      -- app fornence
Código de defeito/cod_Desvio  
Qtde 
Observação
index_comp


Obs.: Para atualização/update tem que utilizar na claúsula o index_Comp  + os sq_lote 
o que foi definido com o usuário é que o apontamento deve ser feito por grupo, portanto, o  index_Comp  + sq_lote
qualquer apontamento de componente(filho), qualquer coisa diferente, apontar um novo grupo p/ que seja gerado um novo sequencial.



-- VAMOS SEGUIR PARA SEGUNDA FASE DO PROJETO:


DEFEITO PARA 
APONTADO PARA O PAI 
PRECISA APONTAR PARA O FILHO


BOTÃO DE DEFEITO COMPONENTE 
 CHAMA PROC A SER DESENVOLVIDA...
PP007 - essa retorna apenas uma visualização(relatório)




 
--Lista_Apontamento_Por_Grupo
 --Tem que retornar a descrição do componente, atualmente está retornando a descrição do defeito.
  
Retornar a descrição do compoente 


-- EFETUAR ESSA IMPLEMENTAÇÃO NO 
    -- Lista_Apontamento_Por_Grupo


Select a.index_Comp As Index_Comp 
     , r.matnr      As Componente
     , m.maktx      As Descricao 
From resb r
Inner Join Mara m
  On Lpad(r.matnr, 18, 0) = Lpad(m.matnr, 18, 0) 
  And r.mandt = m.mandt 
Inner Join Ztpp_Apt_Desvio a
  On Lpad(a.componente, 18, 0) = Lpad(r.matnr, 18, 0)  
Where m.matnr = Lpad('6068131170', 18, 0) -- 6068104322,  06067110273
And m.mandt = '400';                           

 Precisa retornar a descricao do componente...

/*
--
Select a.index_Comp     As Index_Comp 
     , a.componente     As Componente
     , m.maktx          As Descricao 
From ztpp_apt_desvio        a   
Inner Join  Mara            m
 On Lpad(a.componente, 18, 0) = Lpad(m.maktx, 18, 0)
--From resb r
--Inner Join Mara m
  --On Lpad(r.matnr, 18, 0) = Lpad(m.matnr, 18, 0) 
  --And r.mandt = m.mandt 
--Inner Join Ztpp_Apt_Desvio a
  --On Lpad(a.componente, 18, 0) = Lpad(r.matnr, 18, 0)   
Where 0=0
--And a.Data_Criacao = To_Char(Sysdate,'YYYYMMDD') -- filtrar apenas apontamentos do dia
--And a.Data_Criacao = To_Char(Sysdate,'YYYYMMDD') -- filtrar apenas apontamentos do dia para OP
--And Lpad(a.Ordem_Producao,12,0) = Lpad('1851685',12,0) --Lpad(P_Nr_Ordem,12,0)
--And a.Index_Comp                = 8 --P_Idex_Comp    
and regexp_like(a.componente, '6245102004', 'i')
--And a.componente = Lpad('6245102004', 12, 0) 




 Select  a.Index_Comp 
       , a.Componente
       , b.Descricao 
    --Into T.Index_Comp
      -- , T.componente      
      -- , T.Descricao                                                                                  
   From Ztpp_Apt_Desvio a,
        Ztpp_Desvio b,
        Pd_Lote_Rastrea c
  Where a.Mandt = b.Mandt
    And Codigo_Defeito = b.Cod
    And a.Data_Criacao = To_Char(Sysdate,'YYYYMMDD') -- filtrar apenas apontamentos do dia
    And a.Data_Criacao = To_Char(Sysdate,'YYYYMMDD') -- filtrar apenas apontamentos do dia para OP
    And a.Sq_Lote = c.Sq_Lote  
    --
    And Lpad(Ordem_Producao,12,0) = Lpad('1851486',12,0) --Lpad(P_Nr_Ordem,12,0)
    And a.Index_Comp              = 8 --P_Idex_Comp    



Select a.index_Comp As Index_Comp 
     , r.matnr      As Componente
     , m.maktx      As Descricao 
From resb r
Inner Join Mara m
  On Lpad(r.matnr, 18, 0) = Lpad(m.matnr, 18, 0) 
  And r.mandt = m.mandt 
Inner Join Ztpp_Apt_Desvio a
  On Lpad(a.componente, 18, 0) = Lpad(r.matnr, 18, 0)  
Where 0=0
And m.mandt = '400'
And a.Data_Criacao = To_Char(Sysdate,'YYYYMMDD') -- filtrar apenas apontamentos do dia
And a.Data_Criacao = To_Char(Sysdate,'YYYYMMDD') -- filtrar apenas apontamentos do dia para OP
And Lpad(Ordem_Producao,12,0) = Lpad('1851486',12,0) --Lpad(P_Nr_Ordem,12,0)
And a.Index_Comp              = 8 --P_Idex_Comp      
*/

0624560576   CAD POLI 2L C/MONO 13% PTO C050
6081130376   CAD MONT TR CT 3580 PTO C050
6040128766   EIXO DO RETRATOR K3 M ALUM MOD 02
6068131170   CJ MOLA/PLACA K3 0,23X8X2950 M(27V) SR
6067110273   CARC MET RET C/ LOC CT C/PORCA
0606402045   PINO PL RET CAD N90
0606111287   CAPA PL MEC K3 PTO N236 C050
6152110218   SCJ MECANISMO 90/67 0,45G BRONZE C090 SR
0606224364   CAPA PL RETR K3 PTO-M
6068104322   SCJ RODA DENT C/MOLA PL C/ A. RUID
6062104041   GUIA PL CADARÇO SR
6049110138   ELEMENTO DE FIXACAO TERM TR CT X6H
1057204053   CORDONE NYLON  BRANCO TE002
0606413042   BOTAO PL LIM INF N115 PRETO C050
6045130379   CAD C/MONO 2860MM 2L PTO C050
0606413041   BOTAO PL LIM SUP N115 PRETO C050
0606496936   BOTAO PL LIM INF MENOR PRETO C050
0606496934   BOTAO PL LIM SUP MENOR PRETO C050
0607245914   LING INJ DOB GM PTO



Criar CTE e testar...

 Seguir para a próxima 2º etapa do projeto....






