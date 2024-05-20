CREATE OR REPLACE PACKAGE CHRISERP.chrpp_mf006_pkg IS

   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Criar o tipo REF CURSOR que será o cursor
   -- Autor.....: Jaqueline Orrico
   -- Data......: 13/02/2017
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Type G_Cursor Is Ref Cursor;

      -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Gravar Apontamento Automático da Maquina
   -- Autor.....: Jaqueline Orrico
   -- Data......: 06/09/2018
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Grava_Apontamento_Maquina (P_Cod_Maquina   In Pd_Lote_Rastrea.Maquina_Cod%Type,
                                        P_Flag_Aponta   In  Varchar2,
                                        P_Qt_Lote       In  Number,
                                        P_Qt_Contador   In  Number,
                                        P_Qt_Acumulada  In  Number,
                                        P_Erro_Num          Out Number,
                                        P_Erro_Des          Out Varchar2);


   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade..: Consulta Detalhes da Ordem de Produção
   -- Autor.......: Jaqueline Orrico
   -- Data........: 06/09/2018
   -- Data Revisão: 25/06/2019
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Lista_OP_Maquina(P_Maquina   In Pd_Lote_Rastrea.Maquina_Cod%Type,
                              P_Inicio    In Pd_Lote_Rastrea.Dh_Adicionado%Type,
                              P_Fim       In Pd_Lote_Rastrea.Dh_Adicionado%Type,
                              P_Produto   In Pd_Lote_Rastrea.Part_No%Type,
                              P_Nr_Op     In Pd_Lote_Op.Nr_Op%Type,
                              P_Cursor       Out G_Cursor);


   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Lista Apontamentos de Paradas por OP
   -- Autor.....: Jaqueline Orrico
   -- Data......: 25/06/2019
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Lista_Paradas(P_Maquina         In Pd_Lote_Rastrea.Maquina_Cod%Type,
                           P_Nr_Op           In Pd_Lote_OP.Nr_Op%Type,
                           P_Data_Ini        In Pd_Lote_Rastrea.Dh_Lote%Type,
                           P_Sq_Controle_Op  In Pd_Op_Apontamento.Sq_Controle_Op%Type,
                           P_Cursor             Out G_Cursor);  --declarando o cursor

   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Consulta Lotes da Ordem de Produção e Data
   -- Autor.....: Jaqueline Orrico
   -- Data......: 25/06/2018
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Lista_Lotes_OP(P_Maquina   In Pd_Lote_Rastrea.Maquina_Cod%Type,
                            P_Nr_Op     In Pd_Lote_OP.Nr_Op%Type,
                            P_Data_Ini  In Pd_Lote_Rastrea.Dh_Lote%Type,
                            P_Sq_Controle_Op  In Pd_Op_Apontamento.Sq_Controle_Op%Type,
                            P_Cursor       Out G_Cursor);  --declarando o cursor


   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Lista Desvios por OP
   -- Autor.....: Jaqueline Orrico
   -- Data......: 25/06/2019
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Lista_Desvios(P_Maquina         In Pd_Lote_Rastrea.Maquina_Cod%Type,
                           P_Nr_Op           In Pd_Lote_OP.Nr_Op%Type,
                           P_Data_Ini        In Pd_Lote_Rastrea.Dh_Lote%Type,
                           P_Sq_Controle_Op  In Pd_Op_Apontamento.Sq_Controle_Op%Type,
                           P_Cursor             Out G_Cursor);  --declarando o cursor

   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Atualiza Qtde da Rastreabilidade Automática
   -- Autor.....: Jaqueline Orrico
   -- Data......: 25/11/2019
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Atualiza_Rastreabilidade(P_Sq_Lote In Pd_Lote_Rastrea.Sq_Lote%Type);

   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Retornar o último apontamento para máquina
   -- Autor.....: Jaqueline Orrico
   -- Data......: 01/10/2020
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Retorna_Ultimo_Apont(P_Cod_Maquina  In Pd_Lote_Rastrea.Maquina_Cod%Type,
                                  P_Data            Out Pd_Op_Apontamento.Dh_Modificado%Type,
                                  P_Erro_Num        Out Number,
                                  P_Erro_Des        Out Varchar2);

   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Gravar Apontamento Automático da Maquina - Sintetico na tabela pd_op_apontamento_aux
   -- Autor.....: Jaqueline Orrico
   -- Data......: 26/10/2021
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   PROCEDURE Grava_Apontamento_Maquina_Aux(P_cod_maquina    IN pd_op_apontamento_aux.maquina_cod%TYPE,
                                           P_nr_op          IN pd_op_apontamento_aux.nr_op%TYPE,
                                           P_sq_controle_op IN pd_op_apontamento_aux.sq_controle_op%TYPE,
                                           P_Qt_Contador    IN pd_op_apontamento_aux.qt_maquina%TYPE,
                                           P_Erro_Num          OUT NUMBER,
                                           P_Erro_Des          OUT VARCHAR2);

END;
/
CREATE OR REPLACE PACKAGE BODY CHRISERP.chrpp_mf006_pkg IS
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Apontamento de Produção                                                                            --
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Gravar Apontamento Automático da Maquina
   -- Autor.....: Jaqueline Orrico
   -- Data......: 06/09/2018
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Grava_Apontamento_Maquina (P_Cod_Maquina   In Pd_Lote_Rastrea.Maquina_Cod%Type,
                                        P_Flag_Aponta   In  Varchar2,
                                        P_Qt_Lote       In  Number,
                                        P_Qt_Contador   In  Number,
                                        P_Qt_Acumulada  In  Number,
                                        P_Erro_Num          Out Number,
                                        P_Erro_Des          Out Varchar2)
   Is
      V_Nr_Op             Pd_Lote_Op.Nr_Op%Type;
      V_Sq_Op_Aponta      Pd_Op_Apontamento.Sq_Op_Aponta%Type;
      V_Sq_lote           Pd_Lote_Op.Sq_Lote%Type;
      V_Sq_Controle_Op    Number(5);
      V_Insere            Number(1);
      V_Flag_Aponta       Pd_Op_Apontamento.Flag_Aponta%Type;
      V_Qt_Contador       Pd_Op_Apontamento.Qt_Contador%Type;
      V_Sq_Op_Aponta_Max  Pd_Op_Apontamento.Sq_Op_Aponta%Type;
      V_Sq_Lote_Ant       Pd_Op_Apontamento.Sq_Lote%Type;
      V_Qt_Contador_Ant   Pd_Op_Apontamento.Qt_Contador%Type;
      V_Flag_Aponta_Ant   Pd_Op_Apontamento.Flag_Aponta%Type;
      V_flag_aponta_fim   Pd_Op_Apontamento.Flag_Aponta%Type;
      V_Nr_Op_Ant         Pd_Lote_Op.Nr_Op%Type;
      Begin
        -- Flag para inserir na PD_OP_APONTAMENTO 24/01/2020, somente quando o P_Qt_Contador diferente de zero
        V_Insere := 1;
        --
        V_Flag_Aponta := P_Flag_Aponta;
        V_Qt_Contador := P_Qt_Contador;
        --
        -- Busca o nro da op do sap
        Begin
          Select Lpad(b.Nr_Op,12,0),
                 a.Sq_Lote
            Into V_Nr_Op,
                 V_Sq_lote
            From Pd_Lote_Rastrea a,
                 Pd_Lote_Op b
           Where a.Vf_Encerrado = 'N'
             And a.Maquina_cod  = P_Cod_Maquina
             And a.Sq_Lote      = b.Sq_Lote;
        Exception
           When No_Data_Found Then
              -- Para quando não tiver OP
              --
              V_Nr_Op := Lpad(0,12,0);
              --
              Begin
                 Select a.Sq_Lote
                   Into V_Sq_lote
                   From Pd_Lote_Rastrea a
                  Where a.Vf_Encerrado = 'N'
                    And a.Maquina_cod  = P_Cod_Maquina;
              Exception
                 When Others Then
                    V_Sq_lote := 0;
              End;
           When Others Then
              P_Erro_Num := SqlCode;
              P_Erro_Des := 'Chrpp_Mf006_Pkg.Grava_Apontamento_Maquina - Erro ao buscar o Nro da Ordem de Produção ' || SqlErrM;
              Return;
        End;
        --

        -- Inserido em 09/01/23 por Jaqueline
        -- busca o último controle de apontamento para Máquina/OP Sq_Op_Aponta
        Begin
          Select Max(Sq_Op_Aponta)
            Into V_Sq_Op_Aponta_Max
            From Pd_Op_Apontamento
           Where Maquina_Cod = P_Cod_Maquina
             And Nr_Op       = V_Nr_Op;
        Exception
           When Others Then
              P_Erro_Num := SqlCode;
              P_Erro_Des := 'Chrpp_Mf006_Pkg.Grava_Apontamento_Maquina - Erro ao buscar o Sq_Op_Aponta' || SqlErrM;
              Return;
        End;
        --
        Begin
            Select Sq_Lote, Qt_Contador, Flag_Aponta
              Into V_Sq_Lote_Ant, V_Qt_Contador_Ant, V_Flag_Aponta_Ant
              From Pd_Op_Apontamento
             Where Maquina_Cod = P_Cod_Maquina
               And Nr_Op       = V_Nr_Op
               And sq_op_aponta = V_Sq_Op_Aponta_Max;
        Exception
             When No_Data_Found Then
                 V_Sq_Lote_Ant := 0;
                 V_Qt_Contador_Ant := 0;
             When Others Then
                 P_Erro_Num := SqlCode;
                 P_Erro_Des := 'Chrpp_Mf006_Pkg.Grava_Apontamento_Maquina - Erro ao buscar o Sq_Lote anterior' || SqlErrM;
                 Return;
        End;
        --
        dbms_output.put_line(' V_Sq_Op_Aponta_Max ' || V_Sq_Op_Aponta_Max);
        dbms_output.put_line(' V_Sq_Lote_Ant ' || V_Sq_Lote_Ant);
        dbms_output.put_line(' V_Qt_Contador_Ant ' || V_Qt_Contador_Ant);
        -- fim da inclusão 09/01/23

        If P_Flag_Aponta = 'F' Then -- Fim de Produção apontar na OP anterior
           -- Busca a ultima OP que teve apontamento
           Begin
              Select Lpad(a.Nr_Op,12,0),
                     Sq_Lote,
                     a.flag_aponta --Inserido em 17/02/2023 para não apontar 2 vezes o F em horas diferentes (possiveis problemas elipse/ihm)
                Into V_Nr_Op,
                     V_Sq_lote,
                     V_flag_aponta_fim
                From Pd_Op_Apontamento a
               Where a.Dh_Adicionado In (Select max(b.Dh_Adicionado)
                                           From Pd_Op_Apontamento b
                                          Where b.Maquina_Cod = P_Cod_Maquina
                                            And B.nr_op <> '000000000000') --inserido em 28/08 para tratar diferença entre trocas de lote
                 And a.Maquina_Cod = P_Cod_Maquina;
           Exception
              When Others Then
               P_Erro_Num := SqlCode;
               P_Erro_Des := 'Chrpp_Mf006_Pkg.Grava_Apontamento_Maquina - Erro ao buscar a ultima Ordem de Produção Finalizada ' || SqlErrM;
               Return;
           End;
        End If;

        -- Busca o controle por OP
        If P_Flag_Aponta = 'P' Then --
           dbms_output.put_line(' passei primeira peça ' || P_Flag_Aponta);
           Begin
             Select Nvl(Max(Sq_Controle_OP),0) + 1
               Into V_Sq_Controle_OP
               From Pd_Op_Apontamento
              Where Maquina_Cod = P_Cod_Maquina
                And Nr_Op       = V_Nr_Op;
           Exception
              When Others Then
                P_Erro_Num := SqlCode;
                P_Erro_Des := 'Chrpp_Mf006_Pkg.Grava_Apontamento_Maquina - Erro ao buscar o contador da tabela de apontamento. ' || SqlErrM;
                Return;
           End;
           --

           -- Inserido por Jaqueline em 09/01/23 para os casos em que o Elipse envia flag P com qtde diferente de 1 fora do fluxo (mesmo setup de maq (sq_lote))
           -- Exemplo quedas do elipse
           If V_Sq_lote = Nvl(V_Sq_Lote_Ant,0) Then
              If V_Qt_Contador <> 1 then
                 V_Insere := 0;
                 dbms_output.put_line('  V_Insere ' || V_Insere);
              End If;
           End If;
           -- Fim da alteração 09/01/23
        Else --status F e A
               dbms_output.put_line(' passei aqui ' || P_Flag_Aponta);
               Begin
                 Select Max(NVL(Sq_Controle_Op,1))
                   Into V_Sq_Controle_OP
                   From Pd_Op_Apontamento
                  Where Maquina_Cod = P_Cod_Maquina
                    And Nr_Op       = V_Nr_Op;
               Exception
                 When Others Then
                   P_Erro_Num := SqlCode;
                   P_Erro_Des := 'Chrpp_Mf006_Pkg.Grava_Apontamento_Maquina - Erro ao buscar o Sq_Controle_OP ' || SqlErrM;
                   Return;
               End;
               --

               -- tratamentos incluidos em 28/01/21 para resolver quando por algum motivo não gerar o fluxo de primeira Peça
               -- buscar o ultimo sq controle da Máquina/OP
               If P_Flag_Aponta = 'A' Then --Flag A
                  If Nvl(V_Nr_Op_Ant,0) <> V_Nr_Op Then --inserido em 30/03/2023
                      If V_Sq_lote <> Nvl(V_Sq_Lote_Ant,0) Then
                         If V_Qt_Contador < Nvl(V_Qt_Contador_Ant,0) Or
                            Nvl(V_Sq_Lote_Ant,0) = 0 Then
                            Begin
                              Select Nvl(Max(Sq_Controle_OP),0) + 1
                                Into V_Sq_Controle_OP
                                From Pd_Op_Apontamento
                                Where Maquina_Cod = P_Cod_Maquina
                                  And Nr_Op       = V_Nr_Op;
                            Exception
                               When Others Then
                                  P_Erro_Num := SqlCode;
                                  P_Erro_Des := 'Chrpp_Mf006_Pkg.Grava_Apontamento_Maquina - Erro 01 ao buscar o contador da tabela de apontamento. ' || SqlErrM;
                                  Return;
                            End;
                            --
                            V_Flag_Aponta := 'P';
                            V_Qt_Contador := 1;
                         End If;
                      End If;
                  End If;
               End If;  --fim alteração 28/01/2021
        End If;
        --

        -- Busca a Sequencia da Maquina / OP
        Begin
          Select Nvl(Max(Sq_Op_Aponta),0) + 1
            Into V_Sq_Op_Aponta
            From Pd_Op_Apontamento
           Where Maquina_Cod = P_Cod_Maquina
             And Nr_Op       = V_Nr_Op;
        Exception
           When Others Then
              P_Erro_Num := SqlCode;
              P_Erro_Des := 'Chrpp_Mf006_Pkg.Grava_Apontamento_Maquina - Erro ao buscar o contador da tabela de apontamento. ' || SqlErrM;
              Return;
        End;
        --
        -- Somente insere se o flag aponta for diferente de F e diferente de zero 24/01/2020
        If (P_Flag_Aponta = 'F' And P_Qt_Contador = 0)
           -- Inserido em 17/02/2023 para não apontar 2 vezes o F em horas diferentes (possiveis problemas elipse/ihm)
           Or (P_Flag_Aponta = 'F' And V_flag_aponta_fim = 'F')  Then
           dbms_output.put_line('  V_flag_aponta_fim ' || V_flag_aponta_fim);
           -- Fim 17/02/2023
           V_Insere := 0;
        End If;
        -- Não inserir quando não tiver lote aberto para máquina 24/01/2020
        If V_Sq_lote = 0 Then
           V_Insere := 0;
        End If;
        --
        If V_Insere = 1 Then
           Begin
             Insert Into Pd_Op_Apontamento(Maquina_Cod,
                                           Nr_Op,
                                           Sq_Op_Aponta,
                                           Flag_Aponta,
                                           Qt_Lote,
                                           Qt_Contador,
                                           Qt_Acumulada,
                                           Sq_Lote,
                                           Sq_Controle_OP)
                                   Values (P_Cod_Maquina,
                                           V_Nr_Op,
                                           V_Sq_Op_Aponta,
                                           V_Flag_Aponta,
                                           P_Qt_Lote,
                                           V_Qt_Contador,
                                           P_Qt_Acumulada,
                                           V_Sq_lote,
                                           V_Sq_Controle_OP
                                           );
           Exception
              When Others Then
                 P_Erro_Num := SqlCode;
                 P_Erro_Des := 'Chrpp_Mf006_Pkg.Grava_Apontamento_Maquina - Erro 02 ao gravar o apontamento. ' || SqlErrM;
                 --
                 Rollback;
                 --
                 Return;
           End;
           --
           If P_Erro_Num Is Null Then
              Commit;
              --
              -- Inserido em 26/10/2021 para gerar tabelas de apontamento resumido
              Begin
                 Chrpp_Mf006_Pkg.Grava_Apontamento_Maquina_Aux(P_cod_maquina,
                                                               V_Nr_Op         ,
                                                               V_Sq_Controle_OP,
                                                               V_Qt_Contador   ,
                                                               P_Erro_Num      ,
                                                               P_Erro_Des      );
              Exception
                 When Others Then
                    P_Erro_Num := SqlCode;
                    P_Erro_Des := 'Chrpp_Mf006_Pkg.Grava_Apontamento_Maquina - Erro 02 ao gravar o apontamento. ' || SqlErrM;
              End;

           End If;
        End If;
        --
        ---------------------------------------------------------------------------------------------------------------------------
        -- Processo para atualizar a qtde da rastreabilidade automática 21/11/2019 --
        ---------------------------------------------------------------------------------------------------------------------------
        If P_Cod_Maquina in ('0880','0766','0869','0734','0796','0720','1223','1287','0254','0736','0386','1232','913') Then
           If P_Flag_Aponta = 'F' And P_Qt_Contador <> 0 Then --Fim da Produção da OP
              Chrpp_Mf006_Pkg.Atualiza_Rastreabilidade(V_Sq_lote);
           End If;
        End If;
   End;

   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade..: Consulta Detalhes da Ordem de Produção
   -- Autor.......: Jaqueline Orrico
   -- Data........: 06/09/2018
   -- Data Revisão: 25/06/2019
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Lista_OP_Maquina(P_Maquina   In Pd_Lote_Rastrea.Maquina_Cod%Type,
                              P_Inicio    In Pd_Lote_Rastrea.Dh_Adicionado%Type,
                              P_Fim       In Pd_Lote_Rastrea.Dh_Adicionado%Type,
                              P_Produto   In Pd_Lote_Rastrea.Part_No%Type,
                              P_Nr_Op     In Pd_Lote_Op.Nr_Op%Type,
                              P_Cursor       Out G_Cursor)
   Is
   Begin
      Open P_Cursor For
           Select a.nro_op, a.maquina_cod maquina, part_no produto, b.maktx descricao,
                dt_setup, data_ini dt_inicio, data_fim dt_fim, qt_lote qtde_op,
               (select sum(c.qtde_etiq)
                  from pd_etiquetas_vw c
                 where c.nr_op = a.nro_op
                   and c.data = a.data
                   and c.maquina_cod = a.maquina_cod
                   and c.sq_lote in (select distinct d.sq_lote
                                       from pd_op_apontamento d
                                      where trunc(d.nr_op) = a.nro_op
                                        and trunc(d.dh_adicionado) = a.data
                                        and lpad(d.maquina_cod,5,0) = lpad(a.maquina_cod,5,0)
                                        and d.sq_controle_op = a.sq_controle_op)) qtde_registrada,
                qtde_maq qtde_realizada,
               (Select Sum(Round(((To_Date(To_Char(Ltrim(Rtrim(Hora_Final))),'HH24:MI:SS') -
                                   To_Date(To_Char(Hora_Inicial),'HH24:MI:SS'))  * 24 ) * 60,2))
                  From Ztpp_Apontamento
                 Where Trunc(Ordem) = a.nro_op
                   And Lpad(Maquina,5,0)      = Lpad(a.maquina_cod,5,0)
                   And Mandt        = '400'
                   And Data_Inicial = to_char(a.dt_setup,'YYYYMMDD')
                   --And Cod_Parada not in ('0033','0034')
                   And Sq_Lote in (select distinct d.sq_lote
                                       from pd_op_apontamento d
                                      where trunc(d.nr_op) = a.nro_op
                                        and trunc(d.dh_adicionado) = a.data
                                        and lpad(d.maquina_cod,5,0) = lpad(a.maquina_cod,5,0)
                                        and d.sq_controle_op = a.sq_controle_op)) Tempo_Parada,
               (select nvl(sum(round(to_number(dh_fim - dh_inicio) * 24  * 60,2)),0)
                   from pd_parada_reconhecida
                  where lpad(cod_maquina,5,0) = lpad(a.maquina_cod,5,0)
                    and trunc(nr_op) = a.nro_op
                    and dh_inicio  >= to_date(to_char(a.dt_setup,'dd/mm/yyyy') || ' ' || To_Char(To_Date((Dh_Inicial_Turno),'HH24MI'),'HH24:MI:SS'),'dd/mm/yyyy HH24:MI:SS')
                    and dh_fim    <= to_date(to_char(a.dt_setup,'dd/mm/yyyy') || ' ' || To_Char(To_Date((Dh_Final_Turno),'HH24MI'),'HH24:MI:SS'),'dd/mm/yyyy HH24:MI:SS')
                    and round(to_number(dh_fim - dh_inicio) * 24  * 60,2)  > 3 -- maior que 3 min
                    and sq_lote in (select distinct d.sq_lote
                                      from pd_op_apontamento d
                                     where trunc(d.nr_op) = a.nro_op
                                       and trunc(d.dh_adicionado) = a.data
                                       and lpad(d.maquina_cod,5,0) = lpad(a.maquina_cod,5,0)
                                       and d.sq_controle_op = a.sq_controle_op)) Tempo_Parada_Reconhecida,
                 (Select Max(To_Date(To_Char(udate)|| To_Char(utime),'YYYY/MM/DD HH24:MI:SS')) Data_lib
                    from jcds --tabela de status ordem de producao
                   where objnr = 'OR'||lpad(a.nro_op,12,0) --Ordem de Produção
                     and stat =  'I0002' --Status Liberado
                     and inact <> 'X' --Status diferente de inativo
                     and mandt = '400') Data_lib_OP,
                 (Select Sum(Qtde)
                    From Ztpp_Apt_Desvio e
                   Where Trunc(e.Ordem_Producao) = a.nro_op
                     And lpad(e.Maquina,5,0) = Lpad(a.maquina_cod,5,0)
                     And e.Data_Criacao = to_char(a.dt_setup,'YYYYMMDD')
                     and e.mandt = '400'
                     and e.sq_lote in (select distinct d.sq_lote
                                         from pd_op_apontamento d
                                        where trunc(d.nr_op) = a.nro_op
                                          and trunc(d.dh_adicionado) = a.data
                                          and lpad(d.maquina_cod,5,0) = lpad(a.maquina_cod,5,0)
                                          and d.sq_controle_op = a.sq_controle_op)) qtde_desvio,
               (Select distinct decode(f.cd_centro_custo,'669', 'RETRATOR', '672', 'FECHO', '674', 'FECHO', '662', 'REGULADOR DE ALTURA', '690', 'GERADOR DE GÁS')
                  From Tg_Maq_Ct_Terminal f,
                       Tg_Maquina g
                 Where f.sq_maquina = g.sq_maquina
                   and Lpad(g.cd_maquina,5,0) = Lpad(a.maquina_cod,5,0)) Setor,
                Dh_Inicial_Turno,
                Dh_Final_Turno,
                Dh_Inicial_Intervalo,
                Dh_Final_Intervalo,
                a.Sq_Controle_Op
           from pd_apontamento_vw a,
                Makt b,
                Tg_Turno_Intervalo h,
                Tg_Turno i,
                Tg_Maquina j
          where Matnr = Lpad(a.part_no,18,0)
            and a.total_hr_prod_op > 0
            -- 02/10/2020 - resolver problemas de produzir peças sem fazer setup no sistema
            and trunc(a.dt_setup) = trunc(a.data_ini)
            -- 02/10/2020
            and Lpad(a.maquina_cod,5,0) = nvl(Lpad(P_Maquina,5,0),Lpad(a.maquina_cod,5,0)) --filtro do relatório
            and trunc(a.dt_setup) between nvl(P_Inicio,trunc(a.dt_setup)) and nvl(P_Fim,trunc(a.dt_setup)) --filtro do relatório
            and a.nro_op = nvl(P_Nr_Op,a.nro_op) --filtro do relatório
            and a.part_no = nvl(P_Produto,a.part_no) --filtro do relatório
            And lpad(j.Cd_Maquina,5,0) = Lpad(a.maquina_cod,5,0)
            And h.Sq_Maquina = j.Sq_Maquina
            And h.Cd_Turno = i.Cd_Turno
            And i.Cd_Turno = 1 --turno unico 06:00 as 15:48hrs
            And b.mandt = '400'
            order by a.nro_op;


    End;

   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Lista Apontamentos de Paradas por OP
   -- Autor.....: Jaqueline Orrico
   -- Data......: 25/06/2019
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Lista_Paradas(P_Maquina         In Pd_Lote_Rastrea.Maquina_Cod%Type,
                           P_Nr_Op           In Pd_Lote_OP.Nr_Op%Type,
                           P_Data_Ini        In Pd_Lote_Rastrea.Dh_Lote%Type,
                           P_Sq_Controle_Op  In Pd_Op_Apontamento.Sq_Controle_Op%Type,
                           P_Cursor             Out G_Cursor)  --declarando o cursor
   Is
   Begin
       Open P_Cursor For
         Select Maquina, Centro,   Turno,
                To_Date(To_Char(Data_Inicial),'YYYY/MM/DD') Dt_Inicial,
                To_Char(To_Date(To_Char(Hora_Inicial),'HH24:MI:SS'),'HH24:MI:SS') Hr_Inicial,
                To_Date(To_Char(Ltrim(Rtrim(Data_Final))),'YYYY/MM/DD') Dt_Final,
                To_Char(To_Date(To_Char(Ltrim(Rtrim(Hora_Final))),'HH24:MI:SS'),'HH24:MI:SS') Hr_Final,
                Cod_Parada, Descricao, Motivo_Parada
           From Ztpp_Apontamento a,
                Ztpp_Desvio b
          Where a.Mandt = b.Mandt
            And a.Cod_Parada = b.Cod
            And a.Mandt = '400'
            And Lpad(Ordem,12,0) = Lpad(P_Nr_Op,12,0)
            And Lpad(Maquina,5,0) = Lpad(P_Maquina,5,0)
            And Data_Inicial = To_Char(P_Data_Ini,'YYYYMMDD')
            --And Cod_Parada not in ('0033','0034')
            And a.Sq_Lote in (select distinct d.sq_lote
                                from pd_op_apontamento d
                               Where trunc(d.nr_op) = trunc(Ordem)
                                 and trunc(d.dh_adicionado) = trunc(P_Data_Ini)
                                 and lpad(d.maquina_cod,5,0) = lpad(a.Maquina,5,0)
                                 and d.sq_controle_op = P_Sq_Controle_Op)
          Order By To_Date(To_Char(Data_Inicial),'YYYY/MM/DD') desc,
                   To_Char(To_Date(To_Char(Hora_Inicial),'HH24:MI:SS'),'HH24:MI:SS') desc;
   End;

   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Consulta Lotes da Ordem de Produção e Data
   -- Autor.....: Jaqueline Orrico
   -- Data......: 25/06/2018
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Lista_Lotes_OP(P_Maquina         In Pd_Lote_Rastrea.Maquina_Cod%Type,
                            P_Nr_Op           In Pd_Lote_OP.Nr_Op%Type,
                            P_Data_Ini        In Pd_Lote_Rastrea.Dh_Lote%Type,
                            P_Sq_Controle_Op  In Pd_Op_Apontamento.Sq_Controle_Op%Type,
                            P_Cursor             Out G_Cursor)  --declarando o cursor

   Is
   Begin
      Open P_Cursor For
      Select a.nr_lote, a.cd_fam Nro_Rastrea, a.dh_lote Setup, a.qt_lote Qtde_Programada,
             min(d.dh_adicionado) data_ini, max(d.dh_adicionado) data_fim,
             C.qt_lote  Qtde_Rastrea,
            (max(d.qt_contador) -
            (select nvl(max(qt_contador),0) --busca a qtde do ultimo lote da OP (sq_lote)
               from pd_op_apontamento
              where sq_op_aponta < (select min(e.sq_op_aponta)
                                      from pd_op_apontamento e
                                     where trunc(e.nr_op) = b.nr_op
                                       and trunc(e.dh_adicionado) =  trunc(a.dh_lote)
                                       and e.sq_lote = a.sq_lote)
               and sq_controle_op = d.sq_controle_op
               and trunc(nr_op) = b.nr_op
               and maquina_cod  = a.maquina_cod
               and trunc(dh_adicionado) =  trunc(a.dh_lote))) qtde_maq,
               f.qtde_etiq Qtde_Lida
        from pd_lote_rastrea a,
             pd_LOTE_OP B,
             pd_rastreabilidade c,
             pd_op_apontamento d,
             Pd_Etiquetas_Vw f
       where a.maquina_cod = P_Maquina
         and trunc(a.dh_lote) = Trunc(P_Data_Ini)
         and b.nr_op = Nvl(P_Nr_Op,b.nr_op)
         and d.sq_controle_op = P_Sq_Controle_Op
         and a.sq_lote = b.sq_lote
         and c.nr_rastrea = a.cd_fam
         and c.cd_produto = lpad(a.part_no,18,0)
         and a.sq_lote = d.sq_lote(+)
         and f.sq_lote = a.sq_lote
         and f.maquina_cod = a.maquina_cod
         and f.data = trunc(a.dh_lote)
    group by a.nr_lote, a.cd_fam, a.dh_lote, a.qt_lote ,C.qt_lote,a.sq_lote,  a.maquina_cod,  a.part_no,  b.nr_op, d.sq_controle_op,f.qtde_etiq
    order by a.dh_lote;
   End;

   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Lista Desvios por OP
   -- Autor.....: Jaqueline Orrico
   -- Data......: 25/06/2019
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Lista_Desvios(P_Maquina         In Pd_Lote_Rastrea.Maquina_Cod%Type,
                           P_Nr_Op           In Pd_Lote_OP.Nr_Op%Type,
                           P_Data_Ini        In Pd_Lote_Rastrea.Dh_Lote%Type,
                           P_Sq_Controle_Op  In Pd_Op_Apontamento.Sq_Controle_Op%Type,
                           P_Cursor             Out G_Cursor)  --declarando o cursor
   Is
   Begin
       Open P_Cursor For
         Select Maquina, a.Centro_Trabalho,
                Codigo_Defeito, b.Descricao, Sum(Qtde) Qtde, Observacao
           From Ztpp_Apt_Desvio a,
                Ztpp_Desvio b
          Where a.Mandt = b.Mandt
            And Codigo_Defeito = b.Cod
            And a.Mandt = '400'
            And Lpad(Ordem_Producao,12,0) = Lpad(P_Nr_Op,12,0)
            And Lpad(Maquina,5,0) = Lpad(P_Maquina,5,0)
            And a.Data_Criacao = To_Char(P_Data_Ini,'YYYYMMDD')
            And a.Sq_Lote in (select distinct d.sq_lote
                                from pd_op_apontamento d
                               where trunc(d.nr_op) = trunc(Ordem_Producao)
                                 and trunc(d.dh_adicionado) = trunc(P_Data_Ini)
                                 and lpad(d.maquina_cod,5,0) = lpad(a.Maquina,5,0)
                                 and d.sq_controle_op = P_Sq_Controle_Op)
            Group by Maquina, a.Centro_Trabalho,Codigo_Defeito, b.Descricao,Observacao;
   End;

   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Atualiza Qtde da Rastreabilidade Automática
   -- Autor.....: Jaqueline Orrico
   -- Data......: 25/11/2019
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Atualiza_Rastreabilidade(P_Sq_Lote In Pd_Lote_Rastrea.Sq_Lote%Type)
   Is
     V_Flag_Aponta     Pd_Op_Apontamento.Flag_Aponta%Type;
     V_Sq_Controle_Op  Pd_Op_Apontamento.sq_controle_op%Type;
     V_Qtde            Pd_Rastreabilidade.Qt_Lote%Type;
     V_Qtde_Aux        Pd_Rastreabilidade.Qt_Lote%Type;
     V_Qt_Contador     Pd_Op_Apontamento.Qt_Contador%Type;
     V_Erro1           Number(1):= 0;
     V_Cd_Fam          Pd_Lote_Rastrea.Cd_Fam%Type;
     V_Cod_Produto     Pd_Lote_Rastrea.Part_No%Type;
     --
     -- buscar todos os sq_lotes para o FAM que será fechado
     Cursor C1 Is
     Select a.Sq_Lote, Nvl(b.Nr_Op,'000000000000') Nr_OP
       From Pd_Lote_Rastrea a,
            Pd_Lote_Op b
      Where a.Cd_Fam  = V_Cd_Fam --FAM
        And a.Sq_Lote = b.Sq_Lote(+)
      Order By Sq_Lote;
     R1 C1%Rowtype;
     --

   Begin
     -- buscar o FAM para o lote que será fechado
     Begin
       Select Cd_Fam,
              Part_No
         Into V_Cd_Fam,
              V_Cod_Produto
         From Pd_Lote_Rastrea a,
              Pd_Lote_Op b
        Where a.Sq_Lote  = P_Sq_Lote
          And a.Sq_Lote  = b.Sq_Lote(+);
     Exception
         When Others Then
            V_Erro1 := 1;
     End;

     If V_Erro1 = 0 Then
           Open C1;
           Loop
           Fetch C1 Into R1;
           Exit When C1%NotFound;
             --Verifica se o minimo do sq_lote é primeira peça
             Begin
               Select Flag_Aponta,
                      Sq_Controle_Op
                 Into V_Flag_Aponta,
                      V_Sq_Controle_Op
                 From Pd_Op_Apontamento
                Where Sq_Op_Aponta = (Select Min(a.Sq_Op_Aponta)
                                        From Pd_Op_Apontamento a
                                       Where Trunc(a.Nr_Op) = r1.Nr_Op --OP
                                         And a.Sq_Lote = r1.Sq_Lote) --sq_lote
                                         And Trunc(Nr_Op) = r1.Nr_Op --OP
                                         And Sq_Lote = r1.Sq_Lote; --sq_lote
             Exception
               When No_Data_Found Then
                  V_Flag_Aponta := 'P';
               When Others Then
                  V_Erro1 := 1;
             End;
             --
             If V_Erro1 = 0 Then
                If  V_Flag_Aponta = 'P' Then --primeira peça da OP
                    V_Qt_Contador := 0;
                Else
                    --busca a qtde do ultimo lote da OP (sq_lote)
                    Begin
                      Select Nvl(Max(Qt_Contador),0)
                        Into V_Qt_Contador
                        From Pd_Op_Apontamento
                       Where Sq_Op_Aponta < (Select Min(e.Sq_Op_Aponta)
                                               From Pd_Op_Apontamento e
                                              Where Trunc(e.Nr_Op) = r1.Nr_Op
                                                And e.Sq_Lote = r1.Sq_Lote)
                         And Trunc(Nr_Op) = r1.Nr_Op
                         And Sq_Controle_Op = V_Sq_Controle_Op;
                    Exception
                       When Others Then
                          V_Qt_Contador := 0;
                    End;
                End If;
             End If;

             Begin
                --busca o max contador
                Select Nvl(Max(Qt_Contador),0)
                  Into V_Qtde_Aux
                  From Pd_Op_Apontamento
                 Where Trunc(Nr_Op) = r1.Nr_Op
                   And Sq_Lote = r1.Sq_Lote;
             Exception
                 When Others Then
                    V_Erro1 := 1;
             End;

             If V_Erro1 = 0 Then
                dbms_output.put_line(' V_Qtde_Aux ' || V_Qtde_Aux);

                V_Qtde_Aux := V_Qtde_Aux - V_Qt_Contador;
                dbms_output.put_line(' V_Qtde_Aux Resultado ' || V_Qtde_Aux);

                V_Qtde := Nvl(V_Qtde,0) + Nvl(V_Qtde_Aux,0);
                dbms_output.put_line(' V_Qtde ' || V_Qtde);
             End If;
           End Loop;
           Close C1;

           If V_Erro1 = 0 Then
              -- Qtde que será atualizada na rastreabilidade
              dbms_output.put_line(' Resultado Final ' || V_Qtde);
              If Nvl(V_Qtde,0) <> 0 Then
                 Update Pd_Rastreabilidade
                    Set Qt_Lote = V_Qtde
                  Where Nr_Rastrea = V_Cd_Fam
                    And Cd_Produto = lpad(V_Cod_Produto,18,0);

                 Commit;
              End If;
           End If;
     End If;

   End;

   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Retornar o último apontamento para máquina
   -- Autor.....: Jaqueline Orrico
   -- Data......: 01/10/2020
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Retorna_Ultimo_Apont(P_Cod_Maquina  In Pd_Lote_Rastrea.Maquina_Cod%Type,
                                  P_Data            Out Pd_Op_Apontamento.Dh_Modificado%Type,
                                  P_Erro_Num        Out Number,
                                  P_Erro_Des        Out Varchar2)

   Is
   Begin
     /*  Begin
         Select Max(Dh_Modificado) Data
           Into P_Data
           From Pd_Op_Apontamento
          where Maquina_Cod = P_Cod_Maquina;
       Exception
          When No_Data_Found Then
             P_Data := Sysdate;
          When Others Then
             P_Erro_Num := SqlCode;
             P_Erro_Des := 'Chrpp_Mf006_Pkg.Retorna_Ultimo_Apont - Erro ao buscar o último apontamento. ' || SqlErrM;
             Return;
       End;*/
       P_Data := sysdate;
       P_Erro_Num   := null;
       P_Erro_Des   := null;

   End;

   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Gravar Apontamento Automático da Maquina - Sintetico na tabela pd_op_apontamento_aux
   -- Autor.....: Jaqueline Orrico
   -- Data......: 26/10/2021
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   PROCEDURE Grava_Apontamento_Maquina_Aux(P_cod_maquina    IN pd_op_apontamento_aux.maquina_cod%TYPE,
                                           P_nr_op          IN pd_op_apontamento_aux.nr_op%TYPE,
                                           P_sq_controle_op IN pd_op_apontamento_aux.sq_controle_op%TYPE,
                                           P_Qt_Contador    IN pd_op_apontamento_aux.qt_maquina%TYPE,
                                           P_Erro_Num          OUT NUMBER,
                                           P_Erro_Des          OUT VARCHAR2)
   IS
      v_dt_setup           Pd_Op_Apontamento_Aux.dt_setup%type;
      v_cd_produto         Pd_Op_Apontamento_Aux.cd_produto%type;
      v_qt_lote            Pd_Op_Apontamento_Aux.qt_lote%type;
      v_qt_tot_desvio      Pd_Op_Apontamento_Aux.qt_tot_desvio%type;
      v_qt_tot_hr_paradas  Pd_Op_Apontamento_Aux.qt_tot_hr_paradas%type;
      v_data_ini           Pd_Op_Apontamento_Aux.data_ini%type;
      v_data_fim           Pd_Op_Apontamento_Aux.data_fim%type;
      v_qt_tot_hr_prod_op  Pd_Op_Apontamento_Aux.qt_tot_hr_prod_op%type;
      v_cont               Number(6);
      v_sq_controle_op     pd_alerta_solicitacao.sq_controle_op%type;
      V_sq_alerta          pd_alerta_solicitacao.sq_alerta%type;
      v_qtde_kit           Number(6);
      v_qtde_alerta_kit    Number(6);
   BEGIN

     --verifica se OP/Sequencia já existe na tabela
     begin
        select count(*)
          into v_cont
          from pd_op_apontamento_aux
         where maquina_cod = P_cod_maquina
           and nr_op = P_nr_op
           and SQ_CONTROLE_OP = P_sq_controle_op;
     Exception
        When Others Then
           P_Erro_Num := SqlCode;
           P_Erro_Des := 'Chrpp_Mf006_Pkg.Grava_Apontamento_Maquina_Aux - Erro ao validar Maquina/OP/sequencia ' || SqlErrM;
           Return;
     End;
     --
     -- busca qtde de desvios para OP/sequencia
     Begin
        select sum(Qtde)
          into v_qt_tot_desvio
          From Ztpp_Apt_Desvio a
         where a.mandt = '400'
           and a.Ordem_Producao = P_nr_op
           and lpad(a.Maquina,5,0) = Lpad(P_Cod_Maquina,5,0)
           --and a.Data_Criacao = to_char(dt_setup,'YYYYMMDD')
           and a.sq_lote in (select distinct b.sq_lote
                               from pd_op_apontamento b
                              where b.nr_op = a.Ordem_Producao
                              --and trunc(d.dh_adicionado) = dt_setup
                                and lpad(b.maquina_cod,5,0) = lpad(a.Maquina,5,0)
                                and b.sq_controle_op = P_sq_controle_op);
     Exception
        When Others Then
           P_Erro_Num := SqlCode;
           P_Erro_Des := 'Chrpp_Mf006_Pkg.Grava_Apontamento_Maquina_Aux - Erro ao buscar qtde de desvios ' || SqlErrM;
           Return;
     End;
     --
     -- busca qtde de horas paradas para OP/sequencia
     Begin
         Select Sum(Round(((To_Date(To_Char(Ltrim(Rtrim(Hora_Final))),'HH24:MI:SS') -
                            To_Date(To_Char(Hora_Inicial),'HH24:MI:SS'))  * 24 ) * 60,2))
           into v_qt_tot_hr_paradas
           From Ztpp_Apontamento a
          where Mandt        = '400'
            and Ordem = P_nr_op
            and Lpad(Maquina,5,0) = Lpad(P_Cod_Maquina,5,0)
            --And Data_Inicial = to_char(a.dt_setup,'YYYYMMDD')
            and Sq_Lote in (select distinct b.sq_lote
                              from pd_op_apontamento b
                             where b.nr_op = a.Ordem
                             --and trunc(d.dh_adicionado) = dt_setup
                               and lpad(b.maquina_cod,5,0) = lpad(a.Maquina,5,0)
                               and b.sq_controle_op = P_sq_controle_op);
     Exception
        When Others Then
           P_Erro_Num := SqlCode;
           P_Erro_Des := 'Chrpp_Mf006_Pkg.Grava_Apontamento_Maquina_Aux - Erro ao buscar qtde de horas paradas ' || SqlErrM;
           Return;
     End;

     --
     v_qt_tot_hr_prod_op  := 0;
     --

     -- Inserido em 25/11/21 para gerar o alerta automático de solicitação do KIT - CAALM
     -- buscar a qtde de alertas de solicitação de kits gerados
     begin
        select count(*)
          into v_qtde_alerta_kit
          from pd_alerta_solicitacao
         where nr_op = P_Nr_Op
           and cd_maquina = P_Cod_Maquina
           and tp_alerta = 2; --solicitação kit
     Exception
        When Others Then
           P_Erro_Num := SqlCode;
           P_Erro_Des := 'Chrpp_Mf006_Pkg.Grava_Apontamento_Maquina_Aux - Erro ao buscar a solicitação do KIT. ' || SqlErrM;
           Rollback;
     End;

     -- verifica se todos os kits já foram solicitados
     begin
       select nvl(max(sq_controle_op),0)
         into v_sq_controle_op
         from pd_caalm_op
        where NR_OP = P_Nr_Op
          and cd_maquina = P_Cod_Maquina
          and qt_vol_separado - nvl(v_qtde_alerta_kit,0) > 0;
     Exception
        When Others Then
           P_Erro_Num := SqlCode;
           P_Erro_Des := 'Chrpp_Mf006_Pkg.Grava_Apontamento_Maquina_Aux - Erro ao validar volume da OP ' || SqlErrM;
     End;
     --
     -- Fim alteração 25/11/21 - CAALM

     If Nvl(v_cont,0) = 0 Then
        Begin
            Select Part_No,
                   Qt_lote,
                   Dh_Lote
              Into v_cd_produto,
                   v_qt_lote,
                   v_dt_setup
              From Pd_Lote_Rastrea
             Where Vf_Encerrado = 'N'
               And Maquina_cod  = P_Cod_Maquina;
        Exception
            When Others Then
               P_Erro_Num := SqlCode;
               P_Erro_Des := 'Chrpp_Mf006_Pkg.Grava_Apontamento_Maquina_Aux - Erro ao buscar dados do lote de produção ' || SqlErrM;
               Return;
        End;
        --
        Begin
            Insert Into Pd_Op_Apontamento_Aux(maquina_cod      ,
                                              nr_op            ,
                                              sq_controle_op   ,
                                              cd_produto       ,
                                              dt_setup         ,
                                              qt_lote          ,
                                              qt_maquina       ,
                                              qt_tot_desvio    ,
                                              qt_tot_hr_paradas,
                                              data_ini         ,
                                              data_fim         ,
                                              qt_tot_hr_prod_op )
                                       Values (P_Cod_Maquina,
                                               P_nr_op,
                                               P_sq_controle_op,
                                               v_cd_produto,
                                               v_dt_setup,
                                               v_qt_lote,
                                               p_qt_contador,
                                               v_qt_tot_desvio,
                                               v_qt_tot_hr_paradas,
                                               Sysdate,
                                               Sysdate,
                                               v_qt_tot_hr_prod_op
                                               );
        Exception
           When Others Then
               P_Erro_Num := SqlCode;
               P_Erro_Des := 'Chrpp_Mf006_Pkg.Grava_Apontamento_Maquina_Aux - Erro 01 ao gravar o apontamento. ' || SqlErrM;
               Rollback;
               Return;
        End;
        --

        -- Inserido em 25/11/21 para gerar o alerta automático de solicitação do KIT - CAALM
        -- só gera alerta se volume entregue para OP for menor que volume separado pelo almoxarifado
        If v_sq_controle_op <> 0 Then
             Begin
                 chrpp_mffw_pkg.solicita_ajuda(P_Cod_Maquina,    --MAQUINA
                                               P_Nr_Op,          --OP
                                               v_sq_controle_op, --????????????? --SEQ CONTROLE OP
                                               2,                --TIPO ALERTA 2 = solicitaçao kit
                                               P_Nr_Op || ' - KIT AUTOMÁTICO', --MSG
                                               1,                --AREA SOLICITAÇÃO 1=almoxarifado
                                               'S',              --FLAG AUTOMÁTICO
                                               v_sq_alerta,      --OUT SQ ALERTA
                                               P_erro_num,       --OUT ERRO NUM,
                                               P_erro_des);      --OUT ERRO DES);
             Exception
                 When Others Then
                     P_Erro_Num := SqlCode;
                     P_Erro_Des := 'Chrpp_Mf006_Pkg.Grava_Apontamento_Maquina_Aux - Erro ao gerar a solicitação do KIT. ' || SqlErrM;
                     Rollback;
             End;
        End If;
        -- Fim alteração 25/11/21 - CAALM

     Else
        Begin
           update pd_op_apontamento_aux
              set qt_maquina = p_qt_contador,
                  qt_tot_desvio = v_qt_tot_desvio,
                  qt_tot_hr_paradas = v_qt_tot_hr_paradas,
                  data_fim = Sysdate
            where maquina_cod = P_Cod_Maquina
              and nr_op = P_nr_op
              and sq_controle_op = P_sq_controle_op;
        exception
           when others then
             P_Erro_Num := SqlCode;
             P_Erro_Des := 'Chrpp_Mf006_Pkg.Grava_Apontamento_Maquina_Aux - Erro ao atualizar a qtde da máquina ' || SqlErrM;
             Rollback;
             return;
        end;
        --

        -- Inserido em 25/11/21 para gerar o alerta automático de solicitação do KIT - CAALM
        -- só gera alerta se volume entregue para OP for menor que volume separado pelo almoxarifado
        dbms_output.put_line(' v_sq_controle_op ' || v_sq_controle_op);
        If v_sq_controle_op <> 0 Then
            dbms_output.put_line(' PASSEI AQUI ' || v_sq_controle_op);
            -- diminui o contador de 1, para solicitar um novo kit a partir de 1000, já que logo no inicio da OP já solicita 2 kits de 1000
            begin
              select (count(*) - 1) * 1000
                into v_qtde_kit
                from pd_alerta_solicitacao
               where nr_op = P_Nr_Op
                 and cd_maquina = P_Cod_Maquina
                 and tp_alerta = 2; --solicitação kit
            Exception
                 When Others Then
                     P_Erro_Num := SqlCode;
                     P_Erro_Des := 'Chrpp_Mf006_Pkg.Grava_Apontamento_Maquina_Aux - Erro ao gerar a solicitação do KIT. ' || SqlErrM;
                     Rollback;
            End;
            --
            dbms_output.put_line(' CONTADOR ' || p_qt_contador || ' V_QTDE_KIT ' || v_qtde_kit );
            If p_qt_contador >= v_qtde_kit then
            Begin
                 chrpp_mffw_pkg.solicita_ajuda(P_Cod_Maquina,    --MAQUINA
                                               P_Nr_Op,          --OP
                                               v_sq_controle_op, --????????????? --SEQ CONTROLE OP
                                               2,                --TIPO ALERTA 2 = solicitaçao kit
                                               P_Nr_Op || ' - KIT AUTOMÁTICO', --MSG
                                               1,                --AREA SOLICITAÇÃO 1=almoxarifado
                                               'S',              --FLAG AUTOMÁTICO
                                               v_sq_alerta,      --OUT SQ ALERTA
                                               P_erro_num,       --OUT ERRO NUM,
                                               P_erro_des);      --OUT ERRO DES);
            Exception
                 When Others Then
                     P_Erro_Num := SqlCode;
                     P_Erro_Des := 'Chrpp_Mf006_Pkg.Grava_Apontamento_Maquina_Aux - Erro ao gerar a solicitação do KIT. ' || SqlErrM;
                     Rollback;
            End;
            end if;
        End If;
        -- Fim alteração 25/11/21 - CAALM
     end If;
     --
     If P_Erro_Num Is Null Then
        Commit;
     End If;
   END;


END;
/
