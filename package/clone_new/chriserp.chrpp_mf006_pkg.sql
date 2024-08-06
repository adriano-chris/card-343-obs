CREATE OR REPLACE PACKAGE CHRISERP.chrpp_mf006_pkg IS

   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Criar o tipo REF CURSOR que será o cursor
   -- Autor.....: Jaqueline Orrico
   -- Data......: 13/02/2017
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Type G_Cursor Is Ref Cursor;

   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade..: Melhoria de Performance 
   -- Autor.......: Adriano Lima
   -- Data........: 24/05/2024 
   -- Trello......: Card-509 
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   ---------------
   -- TYPE RECORD:
   ---------------   
   Type Typ IS RECORD (   
        Descricao                         VARCHAR2(50) 
      , Setor                             VARCHAR2(50)                        
      , Sq_Maquina                        VARCHAR2(50)
      , Dh_Inicial_Turno                  VARCHAR2(50)
      , Dh_Final_Turno                    VARCHAR2(50)
      , Dh_Inicial_Intervalo              VARCHAR2(50)
      , Dh_Final_Intervalo                VARCHAR2(50)
      , Data_Lib_Op                       VARCHAR2(50)
      , Tempo_Parada_Reconhecida          NUMBER(5,2) 
      , Qtde_registrada                   NUMBER                        
      , Tempo_Parada                      NUMBER
      , Qtde_Desvio                       NUMBER
      , Check_Maquina                     NUMBER      
      , Check_Integracao_SAP              NUMBER               
      , Ww_Env_1                          Clob
      , Ww_Env_2                          Clob
      , Ww_Env_Resp_1                     Clob
      , Ww_Env_Resp_2                     Clob
      , Ww_Itens                          Clob 
      , Qt_Contador                       pd_op_apontamento.qt_contador%Type
      , Processo                          pd_apontamento_log_xml.processo%Type
      , Sq_Op_Aponta                      Pd_Op_Apontamento.Sq_Op_Aponta%Type
      , Sq_Lote                           Pd_Op_Apontamento.Sq_Lote%Type 
      , Nr_Lote_Plr                       Pd_Lote_Rastrea.Nr_Lote%Type   
      , Index_Comp                        Ztpp_Apt_Desvio.Index_comp%Type
      , Componente                        Ztpp_Apt_Desvio.Componente%Type 
      , Data_Fim                          pd_op_apontamento.dh_adicionado%Type
      );
      
   T    Typ;

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
   Procedure Lista_OP_Maquina(P_Maquina      In Pd_Lote_Rastrea.Maquina_Cod%Type,
                              P_Inicio       In Pd_Lote_Rastrea.Dh_Adicionado%Type,
                              P_Fim          In Pd_Lote_Rastrea.Dh_Adicionado%Type,
                              P_Produto      In Pd_Lote_Rastrea.Part_No%Type,
                              P_Nr_Op        In Pd_Lote_Op.Nr_Op%Type,
                              P_Cursor       Out G_Cursor
                              );                                                               
                               
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade..: Melhoria de Performance 
   -- Autor.......: Adriano Lima
   -- Data........: 24/05/2024 
   -- Trello......: Card-509 
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   PROCEDURE Subprocesso_Lom(   P_Maquina   In Pd_Lote_Rastrea.Maquina_Cod%Type
                              , P_Inicio    In Pd_Lote_Rastrea.Dh_Adicionado%Type
                              , P_Fim       In Pd_Lote_Rastrea.Dh_Adicionado%Type
                              , P_Produto   In Pd_Lote_Rastrea.Part_No%Type
                              , P_Nr_Op     In Pd_Lote_Op.Nr_Op%Type);
                                                                                   
                              


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
   -- Finalidade..: Apontamento de Defeito M.E.S Componente
   -- Autor.......: Adriano Lima
   -- Data........: 19/06/2024
   -- Trello......: Card-343
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --                           
   Procedure Lista_Desvios_Comp(   P_Maquina            In Pd_Lote_Rastrea.Maquina_Cod%Type
                                 , P_Nr_Op              In Pd_Lote_OP.Nr_Op%Type
                                 , P_Data_Ini           In Pd_Lote_Rastrea.Dh_Lote%Type
                                 , P_Sq_Controle_Op     In Pd_Op_Apontamento.Sq_Controle_Op%Type
                                 , P_Cursor             Out G_Cursor 
                                 , P_Erro_Num           Out Number
                                 , P_Erro_Des           Out Varchar2 );                             

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
                                           
                                                                                        
   
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade..: Melhoria de Performance 
   -- Autor.......: Adriano Lima
   -- Data........: 24/05/2024 
   -- Trello......: Card-509 
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Function Fun_Calc_Generico (   P_Calc            Number       
                                , P_Nr_Op           Pd_Lote_Op.Nr_Op%Type                 Default Null
                                , P_Data            Date                                  Default Null
                                , P_Maquina_Cod     Pd_Lote_Rastrea.Maquina_Cod%Type      Default Null
                                , P_produto         Number                                Default Null
                                , P_Sq_Controle_Op  Number                                Default Null
                                ) Return Varchar;                               
    
    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Finalidade..: Apontamento de Defeito M.E.S Componente
    -- Autor.......: Adriano Lima
    -- Data........: 19/06/2024
    -- Trello......: Card-343
    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --     
    Procedure Lista_Apontamento_Por_Grupo(   P_Nr_Ordem              In  Afko.Aufnr%Type
                                           , P_Idex_Comp             In  Ztpp_Apt_Desvio.Index_Comp%Type
                                           , P_Cursor                Out G_Cursor
                                           , P_Erro_Num              Out Number
                                           , P_Erro_Des              Out Varchar2 );
                                          

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
      --
      --

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
        /*
        dbms_output.put_line(' V_Sq_Op_Aponta_Max ' || V_Sq_Op_Aponta_Max);
        dbms_output.put_line(' V_Sq_Lote_Ant ' || V_Sq_Lote_Ant);
        dbms_output.put_line(' V_Qt_Contador_Ant ' || V_Qt_Contador_Ant);
        */
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
   --
   --
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade..: Melhoria de Performance
   -- Autor.......: Adriano Lima
   -- Data........: 24/05/2024
   -- Trello......: Card-509
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  FUNCTION Fun_Calc_Generico (
        P_Calc            NUMBER
      , P_Nr_Op           Pd_Lote_Op.Nr_Op%TYPE                 DEFAULT NULL
      , P_Data            DATE                                  DEFAULT NULL
      , P_Maquina_Cod     Pd_Lote_Rastrea.Maquina_Cod%TYPE      DEFAULT NULL
      , P_produto         NUMBER                                DEFAULT NULL
      , P_Sq_Controle_Op  NUMBER                                DEFAULT NULL
      ) RETURN VARCHAR

      IS

       V_Dt_Setup                        VARCHAR2(100);
       V_Dt_Formatada                    VARCHAR2(100);

    Begin

      If ( P_Calc = 1 ) Then

        Begin
            Select b.maktx    -- descricao
              Into T.Descricao
             From  Makt b
            Where 0=0
            And b.Matnr = Lpad(P_Produto, 18, 0);

            If ( T.Descricao Is Not Null ) Then
               Return T.Descricao;
            End If;
        Exception
          When No_Data_Found Then
           dbms_output.put_line('P_Calc: '   ||P_Calc      ||
                                'Descricao: '||T.Descricao ||
                                'Produto: '  ||P_Produto   ||
                                'Linha: '    ||dbms_utility.format_error_backtrace);

          When Others Then
           dbms_output.put_line('Código do Erro: ' || Sqlcode || ' MSG: ' ||Sqlerrm);
           dbms_output.put_line('Linha: ' || dbms_utility.format_error_backtrace);

        End;
      --
      --
      Elsif ( P_Calc = 2 ) Then

        Begin
            select sum(c.qtde_etiq) As qtde_registrada
                Into T.Qtde_registrada
                  from pd_etiquetas_vw c
                 where c.nr_op       = P_Nr_Op
                   and c.data        = to_date(P_Data, 'dd/mm/rrrr')
                   and c.maquina_cod = P_Maquina_Cod
                   and c.sq_lote In ( Select distinct d.sq_lote
                                       From pd_op_apontamento d
                                      Where trunc(d.nr_op)          = To_Char(P_Nr_Op)
                                        And trunc(d.dh_adicionado)  = to_date(P_Data, 'dd/mm/rrrr')
                                        And lpad(d.maquina_cod,5,0) = Lpad(P_Maquina_Cod, 5, 0)
                                        And d.sq_controle_op        = P_Sq_Controle_Op
                                        );

            If (Nvl( T.Qtde_registrada, 0 ) Is Not Null ) Then
                 Return Nvl(T.Qtde_registrada, 0);
             Else
                 Return Nvl(T.Qtde_registrada, 0);
            End If;
        Exception
          When No_Data_Found Then
           dbms_output.put_line('Calc: '             ||P_Calc            ||
                                'Qtde_registrada: '  ||T.Qtde_registrada ||
                                'Nr_Op: '            ||P_Nr_Op           ||
                                'Data: '             ||P_Data            ||
                                'Maquina_Cod: '      ||P_Maquina_Cod     ||
                                'Sq_Controle_Op: '   ||P_Sq_Controle_Op  ||
                                'Linha: '            ||dbms_utility.format_error_backtrace);

          When Others Then
           dbms_output.put_line('Código do Erro: ' || Sqlcode || ' MSG: ' ||Sqlerrm);
           dbms_output.put_line('Linha: ' || dbms_utility.format_error_backtrace);

        End;
        --
        --
      Elsif ( P_Calc = 3 ) Then  --Tempo_Parada

        Begin

           V_Dt_Setup           := to_char(P_Data, 'dd/mm/rrrr');
           V_Dt_Formatada       := substr(V_Dt_Setup, - 4)  ||
                                   substr(V_Dt_Setup, 4 , 2)||
                                   substr(V_Dt_Setup, 0 , 2);


            Select Nvl(Sum(Round(((To_Date(To_Char(Ltrim(Rtrim(Hora_Final))),'HH24:MI:SS') -
                               To_Date(To_Char(Hora_Inicial),'HH24:MI:SS'))  * 24 ) * 60,2)), 0 ) As Tempo_Parada
                Into T.Tempo_Parada
                  From Ztpp_Apontamento z
                 Where z.Ordem              = To_Char(Lpad(P_Nr_Op, 12, 0))
                   And Lpad(z.Maquina,5,0)  = Lpad(P_Maquina_Cod,5,0)
                   And z.Mandt              = '400'
                   And z.Data_Inicial       = V_Dt_Formatada
                   And z.Sq_lote            In  ( Select Distinct d.sq_lote
                                                     From pd_op_apontamento d
                                                    Where 0=0
                                                     And trunc(d.nr_op)          = To_Char(P_Nr_Op)
                                                     And trunc(d.dh_adicionado)  = to_date(P_Data)
                                                     And lpad(d.maquina_cod,5,0) = lpad(P_Maquina_Cod,5,0)
                                                     And d.sq_controle_op        = P_Sq_Controle_Op );


            If ( T.Tempo_Parada Is Not Null ) Then
                 Return T.Tempo_Parada;
              Else
                 Return NVL(T.Tempo_Parada, ' ');
            End If;

        Exception
          When No_Data_Found Then
           dbms_output.put_line('P_Calc: '           ||P_Calc         ||
                                'Tempo_Parada: '     ||T.Tempo_Parada ||
                                'P_Nr_Op: '          ||P_Nr_Op        ||
                                'P_Maquina_Cod: '    ||P_Maquina_Cod  ||
                                'Data_Inicial: '     ||V_Dt_Formatada ||
                                'Linha: '            ||dbms_utility.format_error_backtrace);

          When Others Then
           dbms_output.put_line('Código do Erro: ' || Sqlcode || ' MSG: ' ||Sqlerrm);
           dbms_output.put_line('Linha: ' || dbms_utility.format_error_backtrace);

        End;
      --
      --
      Elsif ( P_Calc = 4 ) Then  --Data_lib_OP

         Begin
           ---------------------------------------------------------------------------------------------------------
           -- JCDS: utilizada para armazenar o status dos documentos de controle de custos.                       --
           -- Utilize a transacao BS23 para visualizar os status do sistema.                                      --
           -- Na tabela TJ02T (Tabela de Status), voce pode encontrar descrices e detalhes dos codigos de status. --
           ---------------------------------------------------------------------------------------------------------
               Select
                  TO_Char(
                   Max(To_Date(
                       Substr(j.udate, -2) || '/'   ||
                       Substr(j.udate, 5, 2) || '/' ||
                       Substr(j.udate, 1, 4) || ' ' ||       -- Data da Ultima Modificacao
                       Substr(j.utime, 0, 2) || ':' ||       -- Hora da Ultima Modificacao
                       Substr(j.utime, 3, 2) || ':' ||
                       Substr(j.utime, 5, 2), 'dd/mm/yyyy hh24:mi:ss')),
                   'dd/mm/yyyy hh24:mi:ss') AS Max_Data_lib_Op
                  Into T.Data_Lib_Op
              From jcds j                                    -- Tabela de Status Ordem de Producao
              Where 0=0
                And j.objnr = 'OR' || lpad(P_Nr_Op, 12, '0') -- Ordem de Producao/(Numero do Objeto)
                And j.stat  = 'I0002'                        -- Codigo de Status
                And j.inact <> 'X'                           -- Indicador de Status Inativo
                And j.mandt = '400';                         -- Define a Particao Logica Dentro do Sist.
                --
                --
                If ( T.Data_Lib_Op Is Not Null ) Then
                 Return T.Data_Lib_Op;
                 dbms_output.put_line('T.Data_Lib_Op'||' '||T.Data_Lib_Op);
                End If;

        Exception
          When No_Data_found Then
           dbms_output.put_line('P_Calc: '      ||P_Calc       ||' '||
                                'Data_Lib_Op: ' ||T.Data_Lib_Op||' '||
                                'Nr_Op: '       ||P_Nr_Op      ||' '||
                                'Linha: '       ||dbms_utility.format_error_backtrace);
          When Others Then
           dbms_output.put_line('Código do Erro: ' || Sqlcode || ' MSG: ' ||Sqlerrm);
           dbms_output.put_line('Linha: ' || dbms_utility.format_error_backtrace);
         End;
      --
      --
      Elsif ( P_Calc = 5 ) THEN  -- Disponivel p/ novas implementacoes...
       Null;
      --
      --
      Elsif ( P_Calc = 6 ) Then --qtde_desvio

         Begin

               V_Dt_Setup           := to_char(P_Data, 'dd/mm/rrrr');
               V_Dt_Formatada       := substr(V_Dt_Setup, - 4)  ||
                                       substr(V_Dt_Setup, 4 , 2)||
                                       substr(V_Dt_Setup, 0 , 2);

            Select Nvl(Sum(Qtde), 0) As Qtde
              Into T.Qtde_Desvio
            From Ztpp_Apt_Desvio e
           Where Trunc(e.Ordem_Producao) = Lpad(P_Nr_Op, 12, '0')
             And lpad(e.Maquina,5,0)     = Lpad(P_Maquina_Cod, 5, 0)
             And e.Data_Criacao          = V_Dt_Formatada
             And e.mandt                 = '400'
             And e.Index_Comp            = 0
             and e.sq_lote in ( select distinct d.sq_lote
                                  from pd_op_apontamento d
                                 where trunc(d.nr_op)          = Lpad(P_Nr_Op, 12, '0')
                                   and trunc(d.dh_adicionado)  = to_date(P_Data, 'dd/mm/rrrr')
                                   and lpad(d.maquina_cod,5,0) = Lpad(P_Maquina_Cod, 5, 0)
                                   and d.Sq_Controle_Op        = P_Sq_Controle_Op);

            If ( T.Qtde_Desvio Is Not Null ) Then
                 Return T.Qtde_Desvio;
             Else
                 Return NVL(T.Qtde_Desvio, ' ');
            End If;

         Exception
           When No_Data_Found Then
            dbms_output.put_line('P_Calc: '      ||P_Calc        ||
                                 'Qtde_Desvio: ' ||T.Qtde_Desvio ||
                                 'Nr_Op: '       ||P_Nr_Op       ||
                                 'Maquina_Cod: ' ||P_Maquina_Cod ||
                                 'Data_Criacao: '||V_Dt_Formatada||
                                 'Linha: '       ||dbms_utility.format_error_backtrace);
           When Others Then
            dbms_output.put_line('Código do Erro: ' || Sqlcode || ' MSG: ' ||Sqlerrm);
            dbms_output.put_line('Linha: ' || dbms_utility.format_error_backtrace);

         End;
      --
      --
      Elsif ( P_Calc = 7 ) Then --Setor

         Begin
            With Cte_Setor As
              ( Select f.cd_centro_custo
                     , g.cd_maquina
                From Tg_Maq_Ct_Terminal f
                Inner Join Tg_Maquina   g
                  On f.sq_maquina = g.sq_maquina
               ) Select distinct decode( cs.cd_centro_custo, '669', 'RETRATOR'
                                                           , '672', 'FECHO'
                                                           , '674', 'FECHO'
                                                           , '662', 'REGULADOR DE ALTURA'
                                                           , '690', 'GERADOR DE GÁS' ) As Setor
               Into T.Setor
              From Cte_Setor cs
              Where cs.cd_maquina = P_Maquina_Cod;

            If ( T.Setor Is Not Null ) Then
                Return T.Setor;
            End If;

         Exception
           When No_Data_Found Then
            dbms_output.put_line('P_Calc: '     ||P_Calc       ||
                                 'Setor: '      ||T.Setor      ||
                                 'Maquina_Cod ' ||P_Maquina_Cod||
                                 'Linha: '      ||dbms_utility.format_error_backtrace);
           When Others Then
            dbms_output.put_line('Código do Erro: ' || Sqlcode || ' MSG: ' ||Sqlerrm);
            dbms_output.put_line('Linha: ' || dbms_utility.format_error_backtrace);

         End;
      --
      --
      Elsif ( P_Calc = 8 ) Then --Dh_inicial_Turno

         Begin

            Select j.sq_maquina
               Into T.sq_maquina
             from Tg_Maquina j
            where j.cd_maquina = P_Maquina_Cod;
         Exception
           when No_Data_Found Then
            dbms_output.put_line('P_Calc: '               ||P_Calc        ||
                                 'Sq_maquina: '           ||T.sq_maquina  ||
                                 'Maquina_Cod: '          ||P_Maquina_Cod ||
                                 'Linha: '                ||dbms_utility.format_error_backtrace);

         End;
         --
         --
         Begin

            Select i.Dh_inicial_Turno
              Into T.Dh_Inicial_Turno
             From Tg_Turno_Intervalo h
            Inner Join Tg_Turno     i
               On h.cd_turno   = i.cd_turno
             Where h.cd_turno  = 1
            And h.sq_maquina   = T.sq_maquina;
            --
            --
            If ( T.Dh_Inicial_Turno Is Not Null ) THEN
                 Return T.Dh_Inicial_Turno;
            End If;

         Exception
           When No_Data_Found Then
            dbms_output.put_line('P_Calc: '      ||P_Calc       ||
                                 'Setor: '       ||T.Setor      ||
                                 'Maquina_Cod: ' ||P_Maquina_Cod||
                                 'Sq_maquina: '  ||T.sq_maquina ||
                                 'Linha: '      ||dbms_utility.format_error_backtrace);

           When Others Then
            dbms_output.put_line('Código do Erro: ' || Sqlcode || ' MSG: ' ||Sqlerrm);
            dbms_output.put_line('Linha: ' || dbms_utility.format_error_backtrace);

         End;
      --
      --
      ELSIF ( P_Calc = 9 ) THEN --Dh_final_Turno

       Begin
          Select j.sq_maquina
             Into T.sq_maquina
             from Tg_Maquina j
            where j.cd_maquina = P_Maquina_Cod;
       Exception
         when No_Data_Found Then
          dbms_output.put_line('P_Calc: '               ||P_Calc                 ||
                               'Sq_maquina: '           ||T.sq_maquina           ||
                               'Maquina_Cod: '          ||P_Maquina_Cod          ||
                               'Linha: '                ||dbms_utility.format_error_backtrace);

       End;
       --
       --
       Begin
          Select i.Dh_final_Turno
            Into T.Dh_Final_Turno
          From Tg_Turno_Intervalo h
          Inner Join Tg_Turno     i
             On h.cd_turno   = i.cd_turno
           Where h.cd_turno  = 1
          And h.sq_maquina    = T.sq_maquina;
          --
          --
          If ( T.Dh_Final_Turno Is Not Null ) Then
               Return T.Dh_Final_Turno;
          End If;

        Exception
          When No_Data_Found Then
            dbms_output.put_line('P_Calc: '         ||P_Calc           ||
                                 'Dh_Final_Turno: ' ||T.Dh_Final_Turno ||
                                 'Maquina_Cod: '    ||P_Maquina_Cod    ||
                                 'Sq_maquina: '     ||T.sq_maquina     ||
                                 'Linha: '          ||dbms_utility.format_error_backtrace);

           When Others Then
            dbms_output.put_line('Código do Erro: ' || Sqlcode || ' MSG: ' ||Sqlerrm);
            dbms_output.put_line('Linha: ' || dbms_utility.format_error_backtrace);

       End;
      --
      --
      ELSIF ( P_Calc = 10 ) THEN --T.Dh_Inicial_Intervalo

        Begin
          Select j.sq_maquina
             Into T.sq_maquina
             from Tg_Maquina j
            where j.cd_maquina = P_Maquina_Cod;
        Exception
         when No_Data_Found Then
            dbms_output.put_line('P_Calc: '               ||P_Calc                 ||
                                 'Sq_maquina: '           ||T.sq_maquina           ||
                                 'Maquina_Cod: '          ||P_Maquina_Cod          ||
                                 'Linha: '                ||dbms_utility.format_error_backtrace);

        End;
        --
        --
        Begin
          Select h.dh_inicial_intervalo
            Into T.Dh_Inicial_Intervalo
          From Tg_Turno_Intervalo h
          Inner Join Tg_Turno     i
             On h.cd_turno   = i.cd_turno
           Where h.cd_turno  = 1
          And h.sq_maquina    = T.sq_maquina;
          --
          --
          If ( T.Dh_Inicial_Intervalo Is Not Null ) Then
               Return T.Dh_Inicial_Intervalo;
          End If;

        Exception
          When No_Data_Found Then
            dbms_output.put_line('P_Calc: '               ||P_Calc                 ||
                                 'Dh_Inicial_Intervalo: ' ||T.Dh_Inicial_Intervalo ||
                                 'Maquina_Cod: '          ||P_Maquina_Cod          ||
                                 'Sq_maquina: '           ||T.sq_maquina           ||
                                 'Linha: '                ||dbms_utility.format_error_backtrace);

           When Others Then
            dbms_output.put_line('Código do Erro: ' || Sqlcode || ' MSG: ' ||Sqlerrm);
            dbms_output.put_line('Linha: ' || dbms_utility.format_error_backtrace);

        End;
      --
      --
      Elsif ( P_Calc = 11 ) Then --T.Dh_Final_Intervalo

        Begin
            Select j.sq_maquina
               Into T.sq_maquina
               from Tg_Maquina j
              where j.cd_maquina = P_Maquina_Cod;
        Exception
         when No_Data_Found Then
            dbms_output.put_line('P_Calc: '               ||P_Calc                 ||
                                 'Sq_maquina: '           ||T.sq_maquina           ||
                                 'Maquina_Cod: '          ||P_Maquina_Cod          ||
                                 'Linha: '                ||dbms_utility.format_error_backtrace);

        End;
        --
        --
        Begin
          Select h.Dh_Final_Intervalo
            Into T.Dh_Final_Intervalo
          From Tg_Turno_Intervalo h
          Inner Join Tg_Turno     i
             On h.cd_turno   = i.cd_turno
           Where h.cd_turno  = 1
          And h.sq_maquina   = T.sq_maquina;
          --
          --
          If ( T.Dh_Final_Intervalo Is Not Null ) Then
            Return T.Dh_Final_Intervalo;
          End If;

        Exception
         when No_Data_Found then
            dbms_output.put_line('P_Calc: '               ||P_Calc                 ||
                                 'Sq_maquina: '           ||T.sq_maquina           ||
                                 'Dh_Final_Intervalo: '   ||T.Dh_Final_Intervalo   ||
                                 'Linha: '                ||dbms_utility.format_error_backtrace);
         When Others Then
            dbms_output.put_line('Código do Erro: ' || Sqlcode || ' MSG: ' ||Sqlerrm);
            dbms_output.put_line('Linha: ' || dbms_utility.format_error_backtrace);
        End;
        --
        --
      Else
          dbms_output.put_line('------------------');
          T.Qtde_registrada  := Null;
      End If;
      Return T.Qtde_registrada;

    Exception
      When Others Then
        dbms_output.put_line('Código do Erro: ' || Sqlcode || ' MSG: ' ||Sqlerrm);
        dbms_output.put_line('Linha: ' || dbms_utility.format_error_backtrace);
      Return T.Qtde_registrada;

    End Fun_Calc_Generico;

   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade..: Melhoria da performance no processo de consulta dos detalhes da ordem de produção.
   -- Autor.......: Adriano Lima
   -- Data........: 24/05/2024
   -- Trello......: Card-509
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Subprocesso_Lom(  P_Maquina   In Pd_Lote_Rastrea.Maquina_Cod%Type
                             , P_Inicio    In Pd_Lote_Rastrea.Dh_Adicionado%Type
                             , P_Fim       In Pd_Lote_Rastrea.Dh_Adicionado%Type
                             , P_Produto   In Pd_Lote_Rastrea.Part_No%Type
                             , P_Nr_Op     In Pd_Lote_Op.Nr_Op%Type )

   Is

    C_DDL                 Constant Varchar2(100):= 'Truncate table chriserp.Lista_Op_Maq';
    C_Maquina_Cod         Constant Varchar2(100):= '2196'; --maquina de solda nao entra no MES


   Begin

     ----------------
     -- Limpa Tabela:
     ----------------
     Begin
       Execute Immediate C_DDL;
     End;
     --
     --
     T.Tempo_Parada_Reconhecida            := 0.00;   --Nao esta sendo utilizado no momento 22/05/2024.

     For Reg In ( Select Nro_Op            As Nro_Op
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
                    --And trunc(poa.dh_adicionado) between To_Date('03/02/2022','dd/mm/rrrr') And To_Date('03/02/2022', 'dd/mm/rrrr')
                    --And poa.nr_op       = Lpad('1758754', 12, 0)
                    --And Poa.maquina_cod = '0880'
                    --And poa.nr_op       = Lpad('1759743', 12, 0)
                    --And Plr.Part_No     = '6081120010'
                                            -----------------------
                                            -- FILTRO DO RELATORIO:
                                            -----------------------

                     And Trunc(Poa.dh_adicionado) Between To_Date(P_Inicio, 'dd/mm/rrrr')
                                                      And To_Date(P_Fim, 'dd/mm/rrrr')
                     And Lpad(Poa.maquina_cod,5,0) = nvl(Lpad(P_Maquina, 5, 0),Lpad(Poa.maquina_cod, 5, 0))
                     And Trunc(Poa.nr_op)          = nvl(Lpad(P_Nr_Op, 12, 0), Poa.nr_op)
                     And Plr.Part_No               = nvl(P_Produto, Plr.Part_No)
                     --
                    Group By poa.maquina_cod
                           , poa.Nr_Op
                           , trunc(poa.Dh_Adicionado)
                           , poa.Sq_Controle_Op
                           , plr.Part_No
                   ) Result_View_Poa
                   Where Total_Hr_Prod_OP > 0
                   And maquina_cod        <> C_Maquina_Cod --maquina de solda não entra no MES
                   --And Rownum <= 2
                  Order By Nro_Op


     ) Loop
        -- FUNCTION:
        If ( Reg.Nro_Op = 0 ) Then -- prototipo nao tem ordem no M.E.S

            T.Descricao               := Fun_Calc_Generico(P_Calc => 1,  P_Nr_Op => Reg.Nro_Op, P_Data => to_date(Reg.dt_setup, 'dd/mm/rrrr hh24:mi:ss'), P_Maquina_Cod => Reg.Maquina, P_Produto => Reg.Part_No);
            T.Qtde_registrada         := Fun_Calc_Generico(P_Calc => 2,  P_Nr_Op => Reg.Nro_Op, P_Data => to_date(Reg.dt_setup, 'dd/mm/rrrr hh24:mi:ss'), P_Maquina_Cod => Reg.maquina, P_Produto => Reg.part_no, P_Sq_Controle_Op => Reg.Sq_Controle_Op );
            T.Tempo_Parada            := Fun_Calc_Generico(P_Calc => 3,  P_Nr_Op => Reg.Nro_Op, P_Data => to_date(Reg.dt_setup, 'dd/mm/rrrr hh24:mi:ss'), P_Maquina_Cod => Reg.maquina, P_Produto => Reg.part_no, P_Sq_Controle_Op => Reg.Sq_Controle_Op);
            T.Qtde_Desvio             := Fun_Calc_Generico(P_Calc => 6,  P_Nr_Op => Reg.Nro_Op, P_Data => to_date(Reg.dt_setup, 'dd/mm/rrrr hh24:mi:ss'), P_Maquina_Cod => Reg.maquina, P_Produto => Null, P_Sq_Controle_Op => Reg.Sq_Controle_Op);
            T.Setor                   := Fun_Calc_Generico(P_Calc => 7,  P_Maquina_Cod => Reg.maquina);
            T.Dh_Inicial_Turno        := Fun_Calc_Generico(P_Calc => 8,  P_Maquina_Cod => Reg.maquina);
            T.Dh_Final_Turno          := Fun_Calc_Generico(P_Calc => 9,  P_Maquina_Cod => Reg.maquina);
            T.Dh_Inicial_Intervalo    := Fun_Calc_Generico(P_Calc => 10, P_Maquina_Cod => Reg.maquina);
            T.Dh_Final_Intervalo      := Fun_Calc_Generico(P_Calc => 11, P_Maquina_Cod => Reg.maquina);

         Elsif ( Reg.Nro_Op > 0 ) Then

            T.Descricao               := Fun_Calc_Generico(P_Calc => 1,  P_Nr_Op => Reg.Nro_Op, P_Data => to_date(Reg.dt_setup, 'dd/mm/rrrr hh24:mi:ss'), P_Maquina_Cod => Reg.Maquina, P_Produto => Reg.Part_No);
            T.Qtde_registrada         := Fun_Calc_Generico(P_Calc => 2,  P_Nr_Op => Reg.Nro_Op, P_Data => to_date(Reg.dt_setup, 'dd/mm/rrrr hh24:mi:ss'), P_Maquina_Cod => Reg.maquina, P_Produto => Reg.part_no, P_Sq_Controle_Op => Reg.Sq_Controle_Op );
            T.Tempo_Parada            := Fun_Calc_Generico(P_Calc => 3,  P_Nr_Op => Reg.Nro_Op, P_Data => to_date(Reg.dt_setup, 'dd/mm/rrrr hh24:mi:ss'), P_Maquina_Cod => Reg.maquina, P_Produto => Reg.part_no, P_Sq_Controle_Op => Reg.Sq_Controle_Op);
            T.Data_Lib_Op             := Fun_Calc_Generico(P_Calc => 4,  P_Nr_Op => Reg.Nro_Op);
            T.Qtde_Desvio             := Fun_Calc_Generico(P_Calc => 6,  P_Nr_Op => Reg.Nro_Op, P_Data => to_date(Reg.dt_setup, 'dd/mm/rrrr hh24:mi:ss'), P_Maquina_Cod => Reg.maquina, P_Produto => Null, P_Sq_Controle_Op => Reg.Sq_Controle_Op);
            T.Setor                   := Fun_Calc_Generico(P_Calc => 7,  P_Maquina_Cod => Reg.maquina);
            T.Dh_Inicial_Turno        := Fun_Calc_Generico(P_Calc => 8,  P_Maquina_Cod => Reg.maquina);
            T.Dh_Final_Turno          := Fun_Calc_Generico(P_Calc => 9,  P_Maquina_Cod => Reg.maquina);
            T.Dh_Inicial_Intervalo    := Fun_Calc_Generico(P_Calc => 10, P_Maquina_Cod => Reg.maquina);
            T.Dh_Final_Intervalo      := Fun_Calc_Generico(P_Calc => 11, P_Maquina_Cod => Reg.maquina);

         Else
          Null;
        End If;
        --
        --
        /*
        DBMS_OUTPUT.PUT_LINE('P_Inicio: '              ||P_Inicio                ||CHR(13)||
                             'P_Fim: '                 ||P_Fim                   ||CHR(13)||
                             'T.Descricao: '           ||T.Descricao             ||CHR(13)||
                             'T.Qtde_registrada: '     || T.Qtde_registrada      ||CHR(13)||
                             'T.Tempo_Parada: '        || T.Tempo_Parada         ||CHR(13)||
                             'T.Data_Lib_Op: '         || T.Data_Lib_Op          ||CHR(13)||
                             'T.Qtde_Desvio: '         || T.Qtde_Desvio          ||CHR(13)||
                             'T.Setor: '               || T.Setor                ||CHR(13)||
                             'T.Dh_Inicial_Turno: '    || T.Dh_Inicial_Turno     ||CHR(13)||
                             'T.Dh_Final_Turno: '      || T.Dh_Final_Turno       ||CHR(13)||
                             'T.Dh_Inicial_Intervalo: '|| T.Dh_Inicial_Intervalo ||CHR(13)||
                             'T.Dh_Final_Intervalo: '  || T.Dh_Final_Intervalo   ||CHR(13)||
                             'T.Data_Lib_Op : '        || T.Data_Lib_Op          ||CHR(13) );
        */
        Insert Into chriserp.Lista_Op_Maq (   nro_op
                                            , maquina
                                            , produto
                                            , descricao
                                            , dt_setup
                                            , dt_ini
                                            , dt_fim
                                            , qtde_op
                                            , qtde_registrada
                                            , qtde_realizada
                                            , tempo_parada
                                            , tempo_parada_reconhecida
                                            , data_lib_op
                                            , qtde_desvio
                                            , setor
                                            , dh_inicial_turno
                                            , dh_final_turno
                                            , dh_inicial_intervalo
                                            , dh_final_intervalo
                                            , sq_controle_op
                                            )
                                    Values (  To_Number(Reg.nro_op)
                                            , To_Char(Reg.maquina)
                                            , To_Char(Reg.part_no)
                                            , To_Char(T.Descricao)
                                            , To_Date(To_Char(Reg.dt_setup, 'DD/MM/RRRR HH24:MI:SS'), 'DD/MM/RRRR HH24:MI:SS')
                                            , To_Date(To_Char(Reg.Dt_Ini, 'DD/MM/RRRR HH24:MI:SS'), 'DD/MM/RRRR HH24:MI:SS')
                                            , To_Date(To_Char(Reg.Dt_Fim, 'DD/MM/RRRR HH24:MI:SS'), 'DD/MM/RRRR HH24:MI:SS')
                                            , To_Number(reg.qtde_op)
                                            , To_number(Nvl(T.Qtde_registrada, 0))
                                            , To_Number(Reg.Qtde_Realizada)
                                            , To_Number(T.Tempo_Parada)
                                            , To_Number(T.Tempo_Parada_Reconhecida)
                                            , To_Date(T.Data_Lib_Op, 'DD/MM/RRRR HH24:MI:SS')
                                            , To_Number(T.Qtde_Desvio)
                                            , To_Char(T.Setor)
                                            , To_Char(T.Dh_Inicial_Turno)
                                            , To_Char(T.Dh_Final_Turno)
                                            , To_Char(T.Dh_Inicial_Intervalo)
                                            , To_Char(T.Dh_Final_Intervalo)
                                            , To_Number(reg.sq_controle_op)
                                            );

         --Null;
       End Loop;

    Exception
      When Others Then
        dbms_output.put_line('código do erro: ' || Sqlcode || ' Msg: ' ||Sqlerrm);
        dbms_output.put_line('Linha: ' || dbms_utility.format_error_backtrace);
    End;
    --
    --
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade..: Consulta Detalhes da Ordem de Produção
   -- Autor.......: Jaqueline Orrico
   -- Data........: 06/09/2018
   -- Data Revisão: 25/06/2019
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
/*Procedure Lista_OP_Maquina(P_Maquina   In Pd_Lote_Rastrea.Maquina_Cod%Type,
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


    End;*/

    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Finalidade..: Melhoria de Performance
    -- Autor.......: Adriano Lima
    -- Data........: 24/05/2024
    -- Trello......: Card-509
    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    Procedure Lista_OP_Maquina(   P_Maquina     In Pd_Lote_Rastrea.Maquina_Cod%Type
                                , P_Inicio      In Pd_Lote_Rastrea.Dh_Adicionado%Type
                                , P_Fim         In Pd_Lote_Rastrea.Dh_Adicionado%Type
                                , P_Produto     In Pd_Lote_Rastrea.Part_No%Type
                                , P_Nr_Op       In Pd_Lote_Op.Nr_Op%Type
                                , P_Cursor      Out G_Cursor )

       Is

       Begin

        Subprocesso_Lom(   p_maquina  => P_Maquina
                         , p_inicio   => p_inicio
                         , p_fim      => p_fim
                         , p_produto  => P_Produto
                         , P_Nr_Op    => P_Nr_Op );

         Open P_Cursor For
           Select l.Nro_Op
                , l.Maquina
                , l.produto
                , l.Descricao
                , l.Dt_Setup
                , l.dt_ini
                , l.Dt_Fim
                , l.Qtde_OP
                , l.Qtde_Registrada
                , l.Qtde_Realizada
                , l.Tempo_Parada
                , l.Tempo_Parada_Reconhecida
                , l.Data_Lib_Op
                , l.Qtde_Desvio
                , l.Setor
                , l.Dh_Inicial_Turno
                , l.Dh_Final_Turno
                , l.Dh_Inicial_Intervalo
                , l.Dh_Final_Intervalo
                , l.Sq_Controle_Op
            From Lista_Op_Maq l;

         Exception
          When Others Then
            dbms_output.put_line('código do erro: ' || Sqlcode || ' Msg: ' ||Sqlerrm);
            dbms_output.put_line('Linha: ' || dbms_utility.format_error_backtrace);
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
   /*
   Procedure Lista_Lotes_OP(
             P_Maquina         In Pd_Lote_Rastrea.Maquina_Cod%Type
           , P_Nr_Op           In Pd_Lote_OP.Nr_Op%Type
           , P_Data_Ini        In Pd_Lote_Rastrea.Dh_Lote%Type
           , P_Sq_Controle_Op  In Pd_Op_Apontamento.Sq_Controle_Op%Type
           , P_Cursor          Out G_Cursor )

   Is
   Begin
      Open P_Cursor For
        With cte_lote_rastrea As (
            Select
                a.Sq_Lote
              , a.Nr_Lote
              , a.Dh_Lote
              , a.Maquina_Cod
              , a.Dh_Adicionado
              , a.Cd_Fam
              , Trunc(a.Qt_Lote) As Qt_Lote
              , a.Part_No
            From
                Pd_Lote_Rastrea a
            Where
                a.Maquina_cod NOT IN ('1443A', '1443B')
        ),
        cte_pd_lote_op As (
            Select
                c.Nr_Op
              , c.Sq_Lote
            From
                pd_lote_op c
        ),
        cte_lote_serie As (
            Select
                Count(b.Nr_Serial_Barra) As Qtde_Etiq
              , b.Sq_Lote
            From
                Pd_Lote_Serie b
            Group By
                b.Sq_Lote
        ),
        Cte_Pd_Op_Apontamento As (
            Select
                Poa.Nr_Op
              , Poa.dh_adicionado
              , Poa.sq_controle_op
              , Poa.qt_contador
            From
                Pd_Op_Apontamento Poa
        ),
        Cte_Pd_Rastreabilidade As (
            Select
                Pr.Nr_Rastrea
              , Pr.Cd_Produto
              , Trunc(Pr.Qt_Lote) As Qt_Lote
            From
                Pd_Rastreabilidade Pr
        )
        Select
             Cte_Lote_Rastrea.Nr_Lote                 As Nr_Lote
           , Cte_Lote_Rastrea.Cd_Fam                  As Nro_Rastrea
           , Cte_Lote_Rastrea.Dh_Lote                 As Setup
           , Cte_Lote_Rastrea.Qt_Lote                 As Qtde_Programada
           , Min(Cte_Pd_Op_Apontamento.Dh_Adicionado) As Data_Ini
           , Max(Cte_Pd_Op_Apontamento.Dh_Adicionado) As Data_Fim
           , Cte_Pd_Rastreabilidade.qt_lote           As Qtde_Rastrea
           , Max(Cte_Pd_Op_Apontamento.qt_contador)   As Qtde_Maq
           , Nvl(Cte_Lote_Serie.Qtde_Etiq, 0)         As Qtde_Lida
        From
            cte_lote_rastrea
        Left Join
            cte_pd_lote_op On cte_lote_rastrea.sq_lote = cte_pd_lote_op.sq_lote
        Left Join
            cte_lote_serie On cte_lote_rastrea.sq_lote = cte_lote_serie.sq_lote
        Left Join
            Cte_Pd_Op_Apontamento On Cte_Pd_Op_Apontamento.Nr_Op = LPAD(cte_pd_lote_op.Nr_Op, 12, '0')
        Left Join
            Cte_Pd_Rastreabilidade On Cte_Pd_Rastreabilidade.nr_rastrea = cte_lote_rastrea.Cd_Fam
            And LPAD(Cte_Pd_Rastreabilidade.cd_produto, 18, '0') = LPAD(cte_lote_rastrea.Part_No, 18, '0')
        Where 0=0
            --
            --
            And Trunc(cte_lote_rastrea.dh_lote)      = Trunc(P_Data_Ini)
            And cte_lote_rastrea.Maquina_Cod         = P_Maquina
            And cte_pd_lote_op.Nr_Op                 = Nvl(P_Sq_Controle_Op,cte_pd_lote_op.Nr_Op )
            And Cte_Pd_Op_Apontamento.sq_controle_op = P_Sq_Controle_Op

            --
            --
        Group By
            Cte_Lote_Rastrea.Nr_Lote
          , Cte_Lote_Rastrea.Cd_Fam
          , Cte_Lote_Rastrea.Dh_Lote
          , Cte_Lote_Rastrea.Qt_Lote
          , Cte_Pd_Rastreabilidade.qt_lote
          , Cte_Lote_Serie.Qtde_Etiq;

   End;
   */

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
         Select Maquina
              , a.Centro_Trabalho
              , Codigo_Defeito
              , b.Descricao
              , Sum(Qtde) Qtde
              , Observacao
              , a.Index_Comp
           From Ztpp_Apt_Desvio a,
                Ztpp_Desvio b
          Where a.Mandt = b.Mandt
            And Codigo_Defeito = b.Cod
            And a.Mandt = '400'
            And Lpad(Ordem_Producao,12,0) = Lpad(P_Nr_Op,12,0)
            And Lpad(Maquina,5,0) = Lpad(P_Maquina,5,0)
            And a.Data_Criacao = To_Char(P_Data_Ini,'YYYYMMDD')
            And a.index_Comp   = 0
            And a.Sq_Lote in (select distinct d.sq_lote
                                from pd_op_apontamento d
                               where trunc(d.nr_op) = trunc(Ordem_Producao)
                                 and trunc(d.dh_adicionado) = trunc(P_Data_Ini)
                                 and lpad(d.maquina_cod,5,0) = lpad(a.Maquina,5,0)
                                 and d.sq_controle_op = P_Sq_Controle_Op)

            Group by Maquina
                   , a.Centro_Trabalho
                   , Codigo_Defeito
                   , b.Descricao
                   , Observacao
                   , a.Index_Comp;
   End;
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  -- Finalidade..: Apontamento de Defeito M.E.S Componente
  -- Autor.......: Adriano Lima
  -- Data........: 19/06/2024
  -- Trello......: Card-343
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  Procedure Lista_Desvios_Comp(   P_Maquina            In Pd_Lote_Rastrea.Maquina_Cod%Type
                                , P_Nr_Op              In Pd_Lote_OP.Nr_Op%Type
                                , P_Data_Ini           In Pd_Lote_Rastrea.Dh_Lote%Type
                                , P_Sq_Controle_Op     In Pd_Op_Apontamento.Sq_Controle_Op%Type
                                , P_Cursor             Out G_Cursor
                                , P_Erro_Num           Out Number
                                , P_Erro_Des           Out Varchar2 )
  Is

   V_Dt_Setup                   Varchar(100);
   V_Dt_Formatada               Varchar2(100);

  Begin

   V_Dt_Setup           := to_char(P_Data_Ini, 'dd/mm/rrrr');
   V_Dt_Formatada       := substr(V_Dt_Setup, - 4)||substr(V_Dt_Setup, 4 , 2)||substr(V_Dt_Setup, 0 , 2);

    Open P_Cursor For
     Select a.Maquina
          , a.Centro_Trabalho
          , a.Codigo_Defeito
          , b.Descricao
          , Sum(a.Qtde) As Qtde
          , a.Observacao
          , a.index_Comp
       From Ztpp_Apt_Desvio       a
       Inner Join Ztpp_Desvio     b
        On Codigo_Defeito = b.Cod
        And  a.Mandt      = b.Mandt
        --
        --
        And a.index_Comp              > 0
        And a.Mandt                   = '400'
        And Lpad(Ordem_Producao,12,0) = Lpad(P_Nr_Op, 12, 0)
        And a.Data_Criacao            = V_Dt_Formatada
        And a.Sq_Lote In (select distinct d.sq_lote
                    from pd_op_apontamento d
                   where trunc(d.nr_op)          = trunc(Ordem_Producao)
                     and trunc(d.dh_adicionado)  = trunc(P_Data_Ini)
                     and lpad(d.maquina_cod,5,0) = lpad(a.Maquina,5,0)
                     and d.sq_controle_op        = P_Sq_Controle_Op)

       Group by Maquina
              , a.Centro_Trabalho
              , a.Codigo_Defeito
              , b.Descricao
              , a.Observacao
              , a.index_Comp;
      Exception
        When No_Data_Found Then
          --
         dbms_output.put_line('P_Nr_Op: '      ||P_Nr_Op        ||
                              'Descricao: '    ||T.Descricao    ||
                              'Maquina: '      ||P_Maquina      ||
                              'Data_Criacao: ' ||V_Dt_Formatada ||
                              'P_Erro_Num: '   ||P_Erro_Num     ||
                              'P_Erro_Des: '   ||P_Erro_Des     ||
                              'Linha: '        ||dbms_utility.format_error_backtrace);

        When Others Then
          dbms_output.put_line('código do erro: ' || Sqlcode || ' Msg: ' ||Sqlerrm);
          dbms_output.put_line('Linha: ' || dbms_utility.format_error_backtrace);

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
     V_Table_Plr       Pd_Lote_Rastrea%RowType;
     v_Qt_Apontada     Pd_Op_Apontamento.Qt_Contador%Type;
     V_Qt_Baixa        Pd_Op_Apontamento.Qt_Contador%Type;
     V_Apontamento     Varchar2(50);
     V_Erro_Num        Number;
     V_Erro_Desc       Varchar2(100);
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
   Begin
     -- buscar o FAM para o lote que será fechado
     Begin
       Select   a.Cd_Fam
              , a.Part_No
              , a.maquina_cod
              , a.nr_lote
         Into   V_Cd_Fam
              , V_Cod_Produto
              , V_Table_Plr.Maquina_Cod
              , T.Nr_Lote_Plr
         From Pd_Lote_Rastrea a,
              Pd_Lote_Op b
        Where a.Sq_Lote  = P_Sq_Lote
          And a.Sq_Lote  = b.Sq_Lote(+);
          --
          /*
          dbms_output.new_line;
          dbms_output.put_line('V_Cd_Fam: '               ||V_Cd_Fam               ||chr(13)||
                               'V_Cod_Produto: '          ||V_Cod_Produto          ||chr(13)||
                               'V_Table_Plr.Maquina_Cod: '||V_Table_Plr.Maquina_Cod||chr(13)||
                                'T.Nr_Lote_Plr: '          ||T.Nr_Lote_Plr          ||chr(13) );
          */
          --
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
               Select Flag_Aponta
                    , Sq_Controle_Op
                    , Sq_Op_Aponta
                    , Sq_Lote
                 Into V_Flag_Aponta
                     , V_Sq_Controle_Op
                     , T.Sq_Op_Aponta
                     , T.Sq_Lote
                 From Pd_Op_Apontamento
                Where Sq_Op_Aponta = (Select Min(a.Sq_Op_Aponta)
                                        From Pd_Op_Apontamento a
                                       Where Trunc(a.Nr_Op) = r1.Nr_Op    --OP
                                         And a.Sq_Lote      = r1.Sq_Lote) --sq_lote
                                         And Trunc(Nr_Op)   = r1.Nr_Op    --OP
                                         And Sq_Lote        = r1.Sq_Lote; --sq_lote
             --
             --
             /*
             dbms_output.put_line('Open C1: '         ||chr(13)||
                                  'V_Flag_Aponta: '   ||V_Flag_Aponta   ||chr(13)||
                                  'V_Sq_Controle_Op: '||V_Sq_Controle_Op||chr(13)||
                                  'T.Sq_Op_Aponta: '  ||T.Sq_Op_Aponta  ||chr(13)||
                                  'T.Sq_Lote: '       ||T.Sq_Lote||chr(13) );
             */
             --
             --
             Exception
               When No_Data_Found Then
                  V_Flag_Aponta := 'P';
               When Others Then
                  V_Erro1 := 1;
             End;
             --
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
                --
                --
                /*
                dbms_output.put_line('Busca a qtde do ultimo lote da OP (sq_lote)'||chr(13)||
                                     'V_Qt_Contador: '||V_Qt_Contador);
                dbms_output.new_line;
                */
                --
                --
             End If;

             Begin
                --busca o max contador
                Select Nvl(Max(Qt_Contador),0)
                  Into V_Qtde_Aux
                  From Pd_Op_Apontamento
                 Where Trunc(Nr_Op) = r1.Nr_Op
                   And Sq_Lote = r1.Sq_Lote;
                   --
                   --
                   /*
                   dbms_output.put_line('Busca o max contador'||chr(13)||
                                        'V_Qtde_Aux');
                   */
                   --
                   --
             Exception
                 When Others Then
                    V_Erro1 := 1;
             End;

             If V_Erro1 = 0 Then
                --dbms_output.put_line(' V_Qtde_Aux ' || V_Qtde_Aux);

                V_Qtde_Aux := V_Qtde_Aux - V_Qt_Contador;

                --dbms_output.put_line(' V_Qtde_Aux Resultado ' || V_Qtde_Aux);

                V_Qtde := Nvl(V_Qtde,0) + Nvl(V_Qtde_Aux,0);
                --dbms_output.put_line(' V_Qtde ' || V_Qtde);
             End If;
           End Loop;
           Close C1;

           If V_Erro1 = 0 Then
              -- Qtde que será atualizada na rastreabilidade
              --dbms_output.put_line(' Resultado Final ' || V_Qtde);
              If Nvl(V_Qtde,0) <> 0 Then
                 Update Pd_Rastreabilidade
                    Set Qt_Lote = V_Qtde
                  Where Nr_Rastrea = V_Cd_Fam
                    And Cd_Produto = lpad(V_Cod_Produto,18,0);

                 Commit;
              End If;
           End If;
     -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
     -- Finalidade: Apontamento Automático no SAP Via Web Service
     -- Autor.....: Jaqueline Orrico/Adriano Lima
     -- Data......: 03/07/2024
     -- Trello....: 248
     -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

       Begin

          Select Count(*)
            Into T.Check_Integracao_SAP
          From chriserp.integracao_mes_sap Ims
          Where 0=0
          And Ims.Produto = V_Cod_Produto
          And Ims.Qtde    = V_Qtde_Aux
          And Ims.Nr_Op   = Lpad(r1.Nr_Op, 12, 0)
          And Ims.Nr_Lote =  T.Nr_Lote_Plr;

       Exception
           When No_Data_Found Then
                   Dbms_output.put_line('Verificar a tabela - chriserp.integracao_mes_sap'||CHR(13)||
                                        'Produto: '||V_Cod_Produto           ||chr(13)||
                                        'Qtde: '   ||V_Qtde_Aux              ||chr(13)||
                                        'Nr_Op: '  || Lpad(r1.Nr_Op, 12, 0)  ||chr(13)||
                                        'Linha: '  ||dbms_utility.format_error_backtrace );

       End;
       --
       --
       If ( T.Check_Integracao_SAP = 0 ) Then

          Begin
               /*
               Begin

                 Select qt_contador
                     Into v_Qt_Apontada
                    From (
                      Select Poa.Sq_Op_Aponta
                           , Poa.qt_contador
                           , ROW_NUMBER() OVER ( Order By Poa.Sq_Op_Aponta Desc ) As rnum
                      From pd_op_Apontamento Poa
                      Where Poa.nr_op = LPAD(r1.Nr_Op, 12, '0')
                      And Poa.Sq_Lote = r1.Sq_Lote
                      Group By Poa.Sq_Op_Aponta
                             , Poa.qt_contador
                    )
                    Where rnum = 1;


                    --V_Qt_Baixa := ( v_Qt_Apontada - V_Qt_Contador );
                    --dbms_output.put_line('V_Qt_Contador: '||chr(13||'v_Qt_Apontada: '||chr(13)||'V_Qt_Baixa: '   ||chr(13)) );

               Exception
                 When No_Data_Found Then
                   Dbms_output.put_line('Verificar a tabela - pd_op_Apontamento'||CHR(13)||
                                        'qt_contador: '||v_Qt_Apontada          ||chr(13)||
                                        'nr_op: '      ||LPAD(r1.Nr_Op, 12, '0')||chr(13)||
                                        'Sq_Lote: '    ||r1.Sq_Lote             ||chr(13)||
                                        'Linha: '      ||dbms_utility.format_error_backtrace );
                 When Others Then
                   dbms_output.put_line('Código do Erro: ' || Sqlcode ||chr(13)||
                                        ' MSG: '           || Sqlerrm ||chr(13)||
                                        'Linha: '          || dbms_utility.format_error_backtrace );

               End;
               */
               --
               --
               V_Apontamento      := T.Sq_Op_Aponta;
                  
               Begin
                 Select Count(*)  As Check_Maquina
                   Into T.Check_Maquina
                  From Chriserp.Pd_Parametro pp
                   Where 0=0
                   And pp.ds_valor2 = 'WEB SERVICE'
                   And pp.Ds_Valor3 = 'SOAP'
                   And pp.Ds_Valor1 = V_Table_Plr.Maquina_Cod;
               End;
               ---------------------------------------------------------------
               -- SE A MAQUINA ESTIVER CADASTRADA SERA EFETUADO O APONTAMENTO!
               ---------------------------------------------------------------

               If ( T.Check_Maquina > 0 ) Then

                   -----------------------------------------------------------------------------------
                   --                          TABELA DE PARAMETRIZACAO                             --
                   -- DEVE SER UTILIZADADO PARA ADICIONAR NOVAS MAQUINAS NO PROCESSO DE APONTAMENTO --
                   -----------------------------------------------------------------------------------

                   For Reg In
                     ( Select pp.Ds_Valor1 As Maquina_cod
                        From Chriserp.Pd_Parametro pp
                          Where 0=0
                         And pp.ds_valor2 = 'WEB SERVICE'
                         And pp.Ds_Valor3 = 'SOAP'
                         And pp.Ds_Valor1 = V_Table_Plr.Maquina_Cod
                       ) Loop


                          chriserp.pd_apontamento_prd_pkg.exec_apontamento_prd01(
                                  P_Nr_Op        => r1.Nr_Op
                                , P_Produto      => V_Cod_Produto
                                , P_Nr_Lote      => V_Cd_Fam
                                , P_Qtde         => V_Qtde_Aux
                                , P_Nr_Lote_Plr  => T.Nr_Lote_Plr
                                , P_Apontamento  => V_Apontamento
                                , P_Erro_Num     => V_Erro_Num
                                , P_Erro_Des     => V_Erro_Desc );


                          dbms_output.put_line('Integração SAP Teste.');
                         End Loop;

               Else
                 Null;
               End If;


          End;

       Else
         Null;
       End If;

          --
          --
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
       --
       --
       Begin
         -------------------------
         -- Qt_Contador Analítico:
         -------------------------
         Select
            Nvl(Max(Poa.Qt_Contador), 0) As Qt_Contador
            Into T.Qt_Contador
        From Pd_Op_Apontamento Poa --(PK: MAQUINA_COD, NR_OP, SQ_OP_APONTA)
        Where 0=0
          And Poa.Maquina_Cod          = P_Cod_Maquina
          And Poa.Nr_Op                = LPAD(P_Nr_Op, 12, '0')
          And Poa.Sq_Controle_Op       = P_sq_controle_op
          --And Poa.Sq_Lote              = --219588
          And Poa.Flag_Aponta          = 'A';

       Exception
         When No_Data_Found Then
           dbms_output.put_line(
              'Linha: '           || dbms_utility.format_error_backtrace||chr(13)||
              'Codigo Erro: '     || Sqlcode               ||chr(13)||
              'Mensagem de Erro: '|| Sqlerrm               ||chr(13)||
              'P_Cod_Maquina: '   || P_Cod_Maquina         ||chr(13)||
              'P_Nr_Op: '         || LPAD(P_Nr_Op, 12, '0')||chr(13)||
              'P_sq_controle_op: '|| P_sq_controle_op      ||chr(13)||
              'Procurar por (Qt_Contador Analítico)'  );
       End;
       --
       --
       Begin
         ----------------------
         -- Data_Fim Sintético:
         ----------------------
        Select
            Trunc(Poa.Dh_Adicionado) As Data_Fim
            Into T.Data_Fim
        From Pd_Op_Apontamento Poa -- (PK: MAQUINA_COD, NR_OP, SQ_OP_APONTA)
        Where 0=0
            And Poa.Maquina_Cod          = P_Cod_Maquina
            And Poa.Nr_Op                = LPAD(P_Nr_Op, 12, '0')
            And Poa.Sq_Controle_Op       = P_sq_controle_op
            And Poa.Flag_Aponta          = 'F';
       Exception
         When No_Data_Found Then
           T.Data_Fim := Sysdate;
       End;
       -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
       -- Finalidade.: Solucao de contorno p/ nao gerar inconsistencia no apontamento consolidado
       -- Motivo.....: Em alguns casos pontuais o (Elipse) gera Outliers(dados que se diferenciam drasticamente de todos os outros).
       -- Autor......: Adriano Lima
       -- Data.......: 01/08/2024
       -- Solicitante: Alanis Valentim (Business Intelligence)
       -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
       If ( T.Qt_Contador     < p_qt_contador And
            Trunc(T.Data_Fim) = Trunc(Sysdate) ) Then

          Begin
             update pd_op_apontamento_aux
                set qt_maquina        = p_qt_contador,
                    qt_tot_desvio     = v_qt_tot_desvio,
                    qt_tot_hr_paradas = v_qt_tot_hr_paradas,
                    data_fim          = Sysdate
              where maquina_cod       = P_Cod_Maquina
                and nr_op             = P_nr_op
                and sq_controle_op    = P_sq_controle_op;
          exception
             when others then
               P_Erro_Num := SqlCode;
               P_Erro_Des := 'Chrpp_Mf006_Pkg.Grava_Apontamento_Maquina_Aux - Erro ao atualizar a qtde da máquina ' || SqlErrM;
               Rollback;
               return;
          end;
        --
        --
        Else
           Null;
        End If;

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
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
   -- Finalidade..: Apontamento de Defeito M.E.S Componente
   -- Autor.......: Adriano Lima
   -- Data........: 19/06/2024
   -- Trello......: Card-343
   -- Obs.........: A pedido do Marcos Paulo em: 11/07/2024 P/ Implementar a segunda fase do projeto de apontamento de refugo.
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

   Procedure Lista_Apontamento_Por_Grupo(    P_Nr_Ordem              In  Afko.Aufnr%Type
                                           , P_Idex_Comp             In  Ztpp_Apt_Desvio.Index_Comp%Type
                                           , P_Cursor                Out G_Cursor
                                           , P_Erro_Num              Out Number
                                           , P_Erro_Des              Out Varchar2 )
    Is

      v_Count                    Number;

    Begin

        Select Count(*)
          Into v_Count
        from Ztpp_Apt_Desvio s
        Left Join makt m
             On Trim(s.componente) = Trim(m.matnr)
        Where s.ordem_producao     = Lpad(P_Nr_Ordem, 12, 0);


        If (v_Count = 0 ) Then

           P_Erro_Num   := 2;
           P_Erro_Des   := 'Não existe apontamento de componente (Filho) cadastrado no sistema para a ordem '|| P_Nr_Ordem|| '.'
           ;
        End If;

        Begin

            Open P_Cursor For
              Select z.Index_Comp      As Index_Comp
                   , m.matnr           As Componente
                   , m.maktx           As Descricao
                Into T.Index_Comp
                   , T.componente
                   , T.Descricao
              from Mara                  m
              Right Join ztpp_Apt_desvio z
                On m.matnr = z.componente
              Where 0=0
              And m.mandt          = '400'
              And z.Data_Criacao   = To_Char(Sysdate,'YYYYMMDD')     -- filtrar apenas apontamentos do dia
              And z.Data_Criacao   = To_Char(Sysdate,'YYYYMMDD')     -- filtrar apenas apontamentos do dia para OP
              And m.matnr          = Lpad(Trim(z.componente), 18, 0) 
              --
              --
              And z.ordem_Producao = Lpad(P_Nr_Ordem, 12, 0)
              And  z.Index_Comp    = P_Idex_Comp
              Order By 1;

        Exception
          When Others Then
              P_Erro_Num := SQLCODE;
              P_Erro_Des := 'Erro: ' || SQLERRM;
              dbms_output.put_line('Código de Erro: ' || SQLCODE || ' - ' || 'Msg: ' || SQLERRM);
              dbms_output.put_line('Linha: ' || dbms_utility.format_error_backtrace);

        End;
        --
        --
    End;


END;
/