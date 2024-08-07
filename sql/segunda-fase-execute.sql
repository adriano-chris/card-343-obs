Select * --Sum()
From Ztpp_Apt_Desvio z
Where 0=0
--And z.data_Criacao >= 20240715
And z.maquina = '0720'
--And z.sq_lote = '219441'
--And z.Index_Comp > 0
order By 2 ;
--
--
Select *  -- qt_contador
From pd_op_apontamento     poa --(PK: MAQUINA_COD, NR_OP, SQ_OP_APONTA)
Where 0=0
And poa.nr_op = Lpad('1851782', 12, 0)
And poa.Sq_Lote = '219441'
Order By poa.dh_adicionado;


--
--
Select Nro_Op            As Nro_Op
                       , Maquina_Cod       As Maquina
                       , Qtde_Lote         As Qtde_Op
                       , Part_No           As Part_No
                       , Dt_Setup          As Dt_Setup
                       , Data_Ini          As Dt_Ini
                       , Data_Fim          As Dt_Fim
                       , Qtde_Lote         As Qt_Lote
                       , Qtde_Maq          As Qtde_Realizada
                       , Sq_Controle_Op    As Sq_Controle_Op
                  From (
                    With Cte_Poa As (
                         Select poa.maquina_cod
                              , poa.nr_op
                              , poa.Dh_Adicionado
                              , poa.Sq_Controle_Op
                              , poa.Qt_Contador
                              , poa.sq_lote              
                          From pd_op_apontamento     poa --(PK: MAQUINA_COD, NR_OP, SQ_OP_APONTA)
                    ),
                         Cte_Plr As (
                         Select plr.Dh_Lote
                              , plr.Part_No
                              , plr.Sq_Lote
                              , plr.dh_adicionado
                         From pd_lote_rastrea        plr --(PK: SQ_LOTE)
                    )
                    Select Poa.maquina_cod                                                                As maquina_cod
                         , Trunc(poa.nr_op)                                                               As Nro_Op
                         , Min(plr.Dh_Lote)                                                               As Dt_Setup
                         , Trunc(poa.Dh_Adicionado)                                                       As Data
                         , poa.Sq_Controle_Op                                                             As Sq_Controle_Op
                         ,( Max(poa.qt_contador)- min(poa.qt_contador) + 1 )                              As qtde_maq
                         , Min(poa.dh_adicionado)                                                         As data_ini
                         , Max(poa.dh_adicionado)                                                         As data_fim
                         , Round((To_Number(Max(poa.Dh_Adicionado) - min(poa.dh_adicionado) ) * 24 * 60)) As Total_Hr_Prod_OP
                         , plr.part_no                                                                    As part_No
                         , ( Select plr2.Qt_lote
                               From pd_lote_rastrea plr2
                              Where plr2.Sq_Lote In ( Select min(poa2.Sq_Lote)
                                                        From pd_op_apontamento poa2
                                                       Where Trunc(poa2.Nr_Op)  = Trunc(poa.nr_op)
                                                        And poa2.maquina_cod    = poa.maquina_cod
                                                        And poa2.Sq_Controle_Op = poa.Sq_Controle_Op)
                                                        )                                                 As Qtde_lote
                    From Cte_Poa           poa
                    Inner Join Cte_Plr     plr
                        On Poa.Sq_Lote = plr.Sq_Lote
                        And Trunc(Poa.Dh_Adicionado) = Trunc(Plr.Dh_Adicionado)
                    Where 0=0 
                    -- PARA TESTE:
                    And trunc(poa.dh_adicionado) between To_Date('15/07/2024','dd/mm/rrrr') And To_Date('15/07/2024', 'dd/mm/rrrr')
                    --And poa.nr_op       = Lpad('0', 12, 0)
                    --And Poa.maquina_cod = Lpad('0720', 5, 0)
                    --And poa.nr_op       = Lpad('1759743', 12, 0)
                    And Plr.Part_No     = '6075117036'
                                            -----------------------
                                            -- FILTRO DO RELATORIO:
                                            -----------------------
                     /*                       
                     And Trunc(Poa.dh_adicionado) Between To_Date(P_Inicio, 'dd/mm/rrrr')
                                                      And To_Date(P_Fim, 'dd/mm/rrrr')
                     And Lpad(Poa.maquina_cod,5,0) = nvl(Lpad(P_Maquina, 5, 0),Lpad(Poa.maquina_cod, 5, 0))
                     And Trunc(Poa.nr_op)          = nvl(Lpad(P_Nr_Op, 12, 0), Poa.nr_op)
                     And Plr.Part_No               = nvl(P_Produto, Plr.Part_No)
                     */
                     --
                    Group By poa.maquina_cod
                           , poa.Nr_Op
                           , trunc(poa.Dh_Adicionado)
                           , poa.Sq_Controle_Op
                           , plr.Part_No
                   ) Result_View_Poa
                   Where Total_Hr_Prod_OP > 0
                   And maquina_cod        <> '2196' --C_Maquina_Cod --maquina de solda n�o entra no MES                   
                   --And Rownum <= 2
                  Order By Nro_Op;
