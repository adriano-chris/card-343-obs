-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
                                                    -- LISTA DESVIO OP 
                                                    -- VISÃO SINTETIZADA DO COMPONENTE PAI + FILHO
                                                    -- OBSERVAÇÃO, SÓ RETORNA DESVIOS APONTADOS NO DIA
-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE
    
 P_cursor                           SYS_REFCURSOR;
 V_Table_Zad                        Ztpp_Apt_Desvio_Tst%RowType;
 V_Table_Zd                         Ztpp_Desvio%RowType;
 V_Table_Plr                        Pd_Lote_Rastrea%RowType;   
    
    
BEGIN
    ------------------------------------------
    -- VISÃO SINTÉTICA COMPONENTE PAI + FILHO: 
    ------------------------------------------
    chrpp_mf007_pkg.Lista_Desvio_OP(   P_Cod_Maquina  => '0880'
                                     , P_Nr_Op        => '1851486'
                                     , P_cursor       => P_cursor
                                     );
                    
    LOOP
    
        FETCH P_cursor INTO V_Table_Zad.maquina 
                          , V_Table_Zad.Centro_Trabalho
                          , V_Table_Zad.Contador
                          , V_Table_Zad.Codigo_Defeito
                          , V_Table_Zd.Descricao
                          , V_Table_Zad.Qtde
                          , V_Table_Zad.Observacao
                          , V_Table_Zad.sq_lote
                          , V_Table_Plr.Cd_Fam;

                          
        EXIT WHEN P_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE( 'maquina: '              || V_Table_Zad.maquina        ||' '||
                              'Centro_Trabalho: '      || V_Table_Zad.Centro_Trabalho||' '||
                              'Contador: '             || V_Table_Zad.Contador       ||' '||
                              'Codigo_Defeito: '       || V_Table_Zad.Codigo_Defeito ||' '||
                              'Descricao: '            || V_Table_Zd.Descricao       ||' '||
                              'Qtde: '                 || V_Table_Zad.Qtde           ||' '||
                              'Observacao: '           || V_Table_Zad.Observacao     ||' '||
                              'sq_lote: '              || V_Table_Zad.sq_lote        ||' '||
                              'Nr_Rastrea: '           || V_Table_Plr.Cd_Fam );
      END LOOP;    
    CLOSE P_cursor;
END;

-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
                                                        -- APONTAMENTO DE DEFEITO(PAI)
-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------

DECLARE
  P_Sq_Lote             Pd_Lote_Rastrea.Sq_Lote%Type    := '219348';
  P_Terminal            Varchar2(30)                    := 'NBCHRIS114';  
  P_Cod_Desvio          Varchar2(10)                    := '64AA';  
  P_Qtde                Number(4)                       := 100;  
  P_Observacao          Varchar2(50)                    := 'Apontamento Componente Pai';
  P_Contador            Number                          := Null;  
  --
  --
  P_Erro_Num            Number(5); 
  P_Erro_Des            Varchar2(500);  

BEGIN
             
  ------------------------------------------------------------------  
  CHRISERP.CHRPP_MF007_PKG.Grava_Apontamento_Desvio(   P_Sq_Lote  
                                                          , P_Terminal    
                                                          , P_Cod_Desvio 
                                                          , P_Qtde
                                                          , P_Observacao                                                         
                                                          , P_Contador                                                          
                                                          , P_Erro_Num   
                                                          , P_Erro_Des );
                                                 
    --dbms_output.put_line(P_Contador);
END;

-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
                                        -- APONTAMENTO DE DEFEITO(FILHO)
-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE
  P_Sq_Lote             Pd_Lote_Rastrea.Sq_Lote%Type    := '219348'; --219347, 219217
  P_Terminal            Varchar2(30)                    := 'NBCHRIS114';  
  P_Cod_Desvio          Varchar2(10)                    := '64AA';  
  P_Qtde                Number(4)                       := 10;  
  P_Observacao          Varchar2(50)                    := 'Apontamento Componente Filho';
  --P_Lista_Comp          VARCHAR2(2000)                  := '000000006081130376;000000006040128766;000000006067110273'; --;000000006040128766;000000006068131170;000000006067110273;000000000606402045;000000000606111287;000000006152110218;000000000606224364;000000006068104322;000000006062104041;000000006049110138;000000001057204053;000000000606413042;000000006045130379;000000000606413041;000000000606496936;000000000606496934;000000000607245914'; 
  P_Lista_Comp          VARCHAR2(2000)                  := '000000006067110273;000000006040128766';
  --P_Lista_Comp          VARCHAR2(2000);
  P_index_comp          Ztpp_Apt_Desvio.Index_comp%Type := Null; -- (Null Flag), (Passar o índice p/ apontar por agrupamento) 
  --P_Contador            Number                          := Null;  
  --
  --
  P_Erro_Num            Number(5); 
  P_Erro_Des            Varchar2(500);  

BEGIN
             
  ------------------------------------------------------------------  
  CHRISERP.CHRPP_MF007_PKG.Grava_Apontamento_Desvio_Comp(   P_Sq_Lote  
                                                          , P_Terminal    
                                                          , P_Cod_Desvio 
                                                          , P_Qtde
                                                          , P_Observacao                                                         
                                                          --, P_Contador
                                                          , P_Lista_Comp
                                                          , P_index_comp
                                                          , P_Erro_Num   
                                                          , P_Erro_Des );
  --DBMS_OUTPUT.PUT_LINE(P_Contador);                                                 

END;
-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
                                                    -- LISTA_TECNICA_COMP_FILHO
-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE
            
    v_Cod_SubComponente             resb.matnr%TYPE;    
    v_Desc_Subcomponente            makt.maktx%TYPE;
    --
    v_cursor                        SYS_REFCURSOR;
    V_Erro_Num                      Number;
    V_Erro_Des                      Varchar2(100);

BEGIN
  
    chrpp_mf007_pkg.Lista_Tecnica_Comp_Filho(  P_Nr_Ordem    => '1851486' 
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




-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
                                                      -- LISTA APONTAMENTOS POR GRUPO
-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE
  V_Table_Zad                     Ztpp_Apt_Desvio%RowType;
  V_Table_Zd                      Ztpp_Desvio%RowType;                   
  --    
  P_Cursor                        SYS_REFCURSOR;
  P_Erro_Num                      Number;
  P_Erro_Des                      Varchar2(100);

BEGIN
     ----------------------------------
     -- VISÃO ANALÍTICA DO APONTAMENTO:
     ----------------------------------
     chrpp_mf007_pkg.Lista_Apontamento_Por_Grupo(  P_Nr_Ordem              => '1851486'
                                                 , P_Idex_Comp             => 1
                                                 , P_Cursor                => P_Cursor
                                                 , P_Erro_Num              => P_Erro_Num
                                                 , P_Erro_Des              => P_Erro_Des 
                                                 );
    LOOP
        FETCH P_Cursor INTO V_Table_Zad.index_Comp
                          , V_Table_Zad.componente
                          , V_Table_Zd.descricao;
        EXIT WHEN P_Cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE( V_Table_Zad.index_Comp ||'   '|| 
                              V_Table_Zad.componente ||'  '|| 
                              V_Table_Zd.descricao );
    END LOOP;
    CLOSE P_Cursor;     
                                      
   --dbms_output.put_line(P_Erro_Des);                                      
END;



-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
                                                    -- FUNCÃO GENERICA MF007
                                                    -- GERENCIA O CONTADOR DO COMPONETE (CONTADOR E INDEX_COMP)
-------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
Declare

 V_Teste      Varchar2(100);
 --
 V_Erro_Num        Number;
 V_Erro_Des        Varchar2(100);
Begin 
  
 V_Teste      := chriserp.chrpp_mf007_pkg.fun_calc_generico (   P_Calc       => 2
                                                              , P_Erro_Num   => V_Erro_Num
                                                              , P_Erro_Des   => V_Erro_Des
                                                             );

  dbms_output.put_line(V_Teste);                                                                                                                                                                                           
End;   



Select * 
from Ztpp_Apt_Desvio 
Where 0=0 
AND ORDEM_PRODUCAO = '000001851486' 
AND Sq_Lote = '219348' 
Order By Contador
       , Index_Comp; 


/*
-- (PK: SQ_LOTE)       
Select * from Pd_Lote_Rastrea where Sq_Lote = '219348'
P_Maquina    0880 
P_Inicio     16/05/2024 16:20:14
P_Fim        16/05/2024 16:20:14       
P_Produto    6081128769
P_Nr_Op     
*/





