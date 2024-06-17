CREATE OR REPLACE PACKAGE CHRISERP.chrpp_mf007_pkg IS

   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Criar o tipo REF CURSOR que será o cursor
   -- Autor.....: Jaqueline Orrico
   -- Data......: 13/02/2017
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Type G_Cursor Is Ref Cursor;   
  
   -----------------------
   -- VARIABLE TYPE TABLE:
   -----------------------
   Type_Comp                        chriserp.stg_desvio_comp%ROWTYPE;   
   Type_Afko                        Afko%Rowtype; 

   
   ---------------
   -- TYPE RECORD:
   ---------------
   
   Type Type_Ztpp_Apt_Desvio Is Record(   mandt                   Ztpp_Apt_Desvio.Mandt%Type
                                        , contador                Ztpp_Apt_Desvio.Contador%Type
                                        , ordem_producao          Ztpp_Apt_Desvio.Ordem_Producao%Type
                                        , produto                 Ztpp_Apt_Desvio.Produto%Type
                                        , centro_trabalho         Ztpp_Apt_Desvio.Centro_Trabalho%Type
                                        , maquina                 Ztpp_Apt_Desvio.Maquina%Type
                                        , turno                   Ztpp_Apt_Desvio.Turno%Type
                                        , codigo_defeito          Ztpp_Apt_Desvio.Codigo_Defeito%Type
                                        , qtde                    Ztpp_Apt_Desvio.Qtde%Type
                                        , sq_lote                 Ztpp_Apt_Desvio.Sq_Lote%Type
                                        , observacao              Ztpp_Apt_Desvio.Observacao%Type
                                        , data_criacao            Ztpp_Apt_Desvio.Data_Criacao%Type
                                        , usuario_criacao         Ztpp_Apt_Desvio.Usuario_Criacao%Type
                                        , data_alteracao          Ztpp_Apt_Desvio.Data_Alteracao%Type
                                        , usuario_alteracao       Ztpp_Apt_Desvio.Usuario_Alteracao%Type
                                        , hora_criacao            Ztpp_Apt_Desvio.Hora_Criacao%Type
                                        , hora_alteracao          Ztpp_Apt_Desvio.Hora_Alteracao%Type
                                        , componente              Ztpp_Apt_Desvio.Componente%Type
                                        , index_comp              Ztpp_Apt_Desvio.Index_comp%Type
                                        , Descricao               makt.maktx%Type
                                        --, F                       Varchar2(500)
                                        );
                                         

   T                                    Type_Ztpp_Apt_Desvio;
   
   
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Consulta Lote de Produção aberto para máquina
   -- Autor.....: Jaqueline Orrico
   -- Data......: 24/11/2018
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Consulta_Lote(P_Cod_Maquina  In Pd_Lote_Rastrea.Maquina_Cod%Type,
                           P_Sq_Lote      In Out Pd_Lote_Rastrea.Sq_Lote%Type,
                           P_Nr_Op           Out Pd_Lote_OP.Nr_Op%Type,
                           P_Cod_Produto     Out Pd_Lote_Rastrea.Part_No%Type,
                           P_Descricao       Out Makt.Maktx%Type,
                           P_Nr_Lote         Out Pd_Lote_Rastrea.Nr_Lote%Type,
                           P_Nr_Rastrea      Out Pd_Lote_Rastrea.Cd_Fam%Type,
                           P_Nr_Tipo_Rastrea Out Pd_Rastreabilidade.Nr_Tipo_Rastrea%Type,
                           P_Qt_Lote         Out Pd_Lote_Rastrea.Qt_Lote%Type,
                           P_Qt_Desvio       Out Number,   --Ztpp_Apontamento_Defeito.Qtde%Type,
                           P_Preparador      Out Pd_Lote_Rastrea.Cd_Preparador%Type,
                           P_Teste1          Out Pd_Lote_Rastrea.Cd_Teste1%Type,
                           P_Teste2          Out Pd_Lote_Rastrea.Cd_Teste2%Type,
                           P_Teste3          Out Pd_Lote_Rastrea.Cd_Teste3%Type,
                           P_Visual          Out Pd_Lote_Rastrea.Cd_Teste4%Type,
                           P_Erro_Num        Out Number,
                           P_Erro_Des        Out Varchar2);

   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Gravar Apontamento de Defeito
   -- Autor.....: Jaqueline Orrico
   -- Data......: 24/11/2018
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Grava_Apontamento_Desvio (P_Sq_Lote      In Pd_Lote_Rastrea.Sq_Lote%Type,
                                       P_Terminal     In  Varchar2,
                                       P_Cod_Desvio   In Varchar2,
                                       P_Qtde         In Number,
                                       P_Observacao   In Varchar2,
                                       P_Contador     In  Out Number, --quando precisar editar
                                       P_Erro_Num         Out Number,
                                       P_Erro_Des         Out Varchar2);


   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Efetuar Apontamento de Componentes Filho
   -- Autor.....: Adriano Lima
   -- Data......: 16/04/2024
   -- Trello....: Card-343
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Grava_Apontamento_Desvio_Comp (   P_Sq_Lote         In  Pd_Lote_Rastrea.Sq_Lote%TYPE
                                             , P_Terminal        In  Varchar2
                                             , P_Cod_Desvio      In  Varchar2
                                             , P_Qtde            In  Number
                                             , P_Observacao      In  Varchar2
                                             --, P_Contador        In  Out Number                                   -- quando precisar editar
                                             , P_Lista_Comp      In  Varchar2                        Default Null
                                             , P_index_comp      In Out Ztpp_Apt_Desvio.Index_comp%Type -- quando for apontar por agrupamento, informar o Index
                                             , P_Erro_Num        Out Number
                                             , P_Erro_Des        Out Varchar2
                                             ); 



   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Lista Códigos de Defeitos
   -- Autor.....: Jaqueline Orrico
   -- Data......: 24/11/2018
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Lista_Desvio(P_Terminal  In Tg_Maq_Ct_Terminal.Nm_Terminal%Type,
                          P_Cursor       Out G_Cursor,
                          P_Erro_Num     Out Number,
                          P_Erro_Des     Out Varchar2);

   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Lista Apontamentos de Desvio por OP / Lote (sq_lote)
   -- Autor.....: Jaqueline Orrico
   -- Data......: 24/11/2018
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Lista_Desvio_OP(P_Cod_Maquina  In Pd_Lote_Rastrea.Maquina_Cod%Type,
                             P_Nr_Op  In Pd_Lote_OP.Nr_Op%Type,
                             P_Cursor      Out G_Cursor);  --declarando o cursor

   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Gravar Apontamento de Parada - Integração Web Service SAP
   -- Autor.....: Jaqueline Orrico
   -- Data......: 08/06/2018
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Grava_Apontamento_Parada_SAP (P_Nr_Op        In  Pd_Lote_Op.Nr_Op%Type,
                                           P_Cod_Parada   In  Varchar2,
                                           P_Dt_Inicio    In  Varchar2,
                                           P_Hr_Inicio    In  Varchar2,
                                           P_Dt_Fim       In  Varchar2,
                                           P_Hr_Fim       In  Varchar2,
                                           P_Erro_Num         Out Number,
                                           P_Erro_Des         Out Varchar2);

   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Lista OP´s do dia para máquina
   -- Autor.....: Jaqueline Orrico
   -- Data......: 13/08/2019
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Lista_OP_Maquina(P_Cod_Maquina  In Pd_Lote_Rastrea.Maquina_Cod%Type,
                              P_Cursor    Out G_Cursor);  --declarando o cursor

   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Lista Lotes da OP do Dia
   -- Autor.....: Jaqueline Orrico
   -- Data......: 30/09/2019
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Lista_Lotes_OP(P_Cod_Maquina  In Pd_Lote_Rastrea.Maquina_Cod%Type,
                            P_Nr_Op   In Pd_Lote_Op.Nr_Op%Type,
                            P_Cursor     Out G_Cursor);  --declarando o cursor

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
   -- Finalidade: Gravar Apontamento de Desvio - Automático
   -- Autor.....: Jaqueline Orrico
   -- Data......: 08/10/2020
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Grava_Desvio_Automatico (P_Cod_Maquina  In Pd_Lote_Rastrea.Maquina_Cod%Type,
                                      P_Terminal     In Varchar2,
                                      P_Cod_Desvio   In Varchar2,
                                      P_Qtde         In Number,
                                      P_Observacao   In Varchar2,
                                      P_Contador     In  Out Number, --quando precisar editar
                                      P_Erro_Num         Out Number,
                                      P_Erro_Des         Out Varchar2);


   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Retornar Lista Técnica de Componentes do SAP
   -- Autor.....: Adriano Lima
   -- Data......: 16/04/2024
   -- Trello....: Card-343
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --   
   Procedure Lista_Tecnica_Comp_Filho(  P_Nr_Ordem           In  Afko.Aufnr%Type
                                      , P_Cursor             Out G_Cursor 
                                      , P_Erro_Num           Out Number
                                      , P_Erro_Des           Out Varchar2 
                                      ); 
                                      
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Retornar Lista de Apontamento Realizados Por Grupo
   -- Autor.....: Adriano Lima
   -- Data......: 16/04/2024
   -- Trello....: Card-343
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --                                      
   Procedure Lista_Apontamento_Por_Grupo (   P_Nr_Ordem            In  Afko.Aufnr%Type
                                           , P_Idex_Comp           In  Ztpp_Apt_Desvio.Index_Comp%type
                                           , P_Cursor              Out G_Cursor
                                           , P_Erro_Num            Out Number
                                           , P_Erro_Des            Out Varchar2 );                                          
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Função Genérica, Permite Novas Implementações Dentro da MF007.
   -- Autor.....: Adriano Lima
   -- Data......: 16/04/2024
   -- Trello....: Card-343
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --                                        
                                         
   Function Fun_Calc_Generico (  P_Calc                     Number
                               , P_Erro_Num                 Out Number
                               , P_Erro_Des                 Out Varchar2 ) Return varchar2;                                                                  
                                      
 
END;
/
CREATE OR REPLACE PACKAGE BODY CHRISERP.chrpp_mf007_pkg IS
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Apontamento de Defeito                                                                             --
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Consulta Lote de Produção aberto para máquina
   -- Autor.....: Jaqueline Orrico
   -- Data......: 24/11/2018
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Consulta_Lote(P_Cod_Maquina  In Pd_Lote_Rastrea.Maquina_Cod%Type,
                           P_Sq_Lote      In Out Pd_Lote_Rastrea.Sq_Lote%Type,
                           P_Nr_Op           Out Pd_Lote_OP.Nr_Op%Type,
                           P_Cod_Produto     Out Pd_Lote_Rastrea.Part_No%Type,
                           P_Descricao       Out Makt.Maktx%Type,
                           P_Nr_Lote         Out Pd_Lote_Rastrea.Nr_Lote%Type,
                           P_Nr_Rastrea      Out Pd_Lote_Rastrea.Cd_Fam%Type,
                           P_Nr_Tipo_Rastrea Out Pd_Rastreabilidade.Nr_Tipo_Rastrea%Type,
                           P_Qt_Lote         Out Pd_Lote_Rastrea.Qt_Lote%Type,
                           P_Qt_Desvio       Out Number,
                           P_Preparador      Out Pd_Lote_Rastrea.Cd_Preparador%Type,
                           P_Teste1          Out Pd_Lote_Rastrea.Cd_Teste1%Type,
                           P_Teste2          Out Pd_Lote_Rastrea.Cd_Teste2%Type,
                           P_Teste3          Out Pd_Lote_Rastrea.Cd_Teste3%Type,
                           P_Visual          Out Pd_Lote_Rastrea.Cd_Teste4%Type,
                           P_Erro_Num        Out Number,
                           P_Erro_Des        Out Varchar2)

   Is
   Begin
      If P_Sq_Lote = 0 Then --busca o lote ativo na máquina
          Begin
            Select Part_No,
                   Sq_Lote,
                   Nr_Lote,
                   Cd_Fam,
                   Qt_Lote,
                   Cd_Preparador,
                   Cd_Teste1,
                   Cd_Teste2,
                   Cd_Teste3,
                   Cd_Teste4
              Into P_Cod_Produto,
                   P_Sq_Lote,
                   P_Nr_Lote,
                   P_Nr_Rastrea,
                   P_Qt_Lote,
                   P_Preparador,
                   P_Teste1,
                   P_Teste2,
                   P_Teste3,
                   P_Visual
              From Pd_Lote_Rastrea
             Where Maquina_Cod  = P_Cod_Maquina
               And Vf_Encerrado = 'N';
           Exception
             When No_Data_Found Then
               P_Erro_Num := Null;
               P_Erro_Des := Null;
             When Others Then
               P_Erro_Num := SqlCode;
               P_Erro_Des := 'Chrpp_Mf007_Pkg.Consulta_Lote - Erro 01 ao buscar os dados do Lote de Produção' || SqlErrM;
               Return;
          End;
      Else -- busca o lote da OP com o SQ_LOTE (consulta de OP's do dia)
          Begin
            Select Part_No,
                   Nr_Lote,
                   Cd_Fam,
                   Qt_Lote,
                   Cd_Preparador,
                   Cd_Teste1,
                   Cd_Teste2,
                   Cd_Teste3,
                   Cd_Teste4
              Into P_Cod_Produto,
                   P_Nr_Lote,
                   P_Nr_Rastrea,
                   P_Qt_Lote,
                   P_Preparador,
                   P_Teste1,
                   P_Teste2,
                   P_Teste3,
                   P_Visual
              From Pd_Lote_Rastrea
             Where Sq_Lote = P_Sq_Lote;
           Exception
             When No_Data_Found Then
               P_Erro_Num := Null;
               P_Erro_Des := Null;
             When Others Then
               P_Erro_Num := SqlCode;
               P_Erro_Des := 'Chrpp_Mf007_Pkg.Consulta_Lote - Erro 02 ao buscar os dados do Lote de Produção' || SqlErrM;
               Return;
          End;
          --
      End If;
      --
      Begin
        Select Nr_Op
          Into P_Nr_Op
          From Pd_Lote_Op
         Where Sq_Lote = P_Sq_Lote;
      Exception
         When Others Then
           P_Erro_Num := SqlCode;
           P_Erro_Des := 'Chrpp_Mf007_Pkg.Consulta_Lote - Erro ao buscar o Nro da Ordem de Produção ' || SqlErrM;
           Return;
      End;
      --
      Begin
        Select Maktx
          Into P_Descricao
          From Makt
         Where Mandt = '400'
           And Matnr = Lpad(P_Cod_Produto,18,0);
      Exception
         When No_Data_Found Then
           P_Descricao := 'Código Produto Não Cadastrado';
           P_Erro_Num  := 1;
           P_Erro_Des  := 'Código do Produto Não Cadastrado';
         When Others Then
           P_Erro_Num := SqlCode;
           P_Erro_Des := 'Chrpp_Mf007_Pkg.Consulta_Lote - Erro ao buscar a descrição do produto' || SqlErrM;
           Return;
      End;
      --
      Begin
        Select Nr_Tipo_Rastrea
          Into P_Nr_Tipo_Rastrea
          From Pd_Rastreabilidade
         Where Nr_Rastrea   = P_Nr_Rastrea
           And Trunc(Cd_Produto)  = Trunc(P_Cod_Produto)
           And St_Rastrea  <> 'C';
      Exception
         When Others Then
            -- Inserido em 13/08/2019 devido a mudança de FAM/FAC automático
            Begin
              Select Nr_Tipo_Rastrea
                Into P_Nr_Tipo_Rastrea
                From Pd_Rastreabilidade
               Where Nr_Rastrea   = P_Nr_Rastrea
                 And Trunc(Cd_Produto)  = Trunc(P_Cod_Produto)
                 And St_Rastrea  <> 'C'
                 And (to_char(dh_adicionado,'YYYY') = to_char(sysdate,'YYYY') or
                      to_char(dh_adicionado,'YYYY') = to_char(sysdate,'YYYY') - 1);
            Exception
                When Others Then
                  P_Erro_Num := SqlCode;
                  P_Erro_Des := 'Chrpp_Mf007_Pkg.Consulta_Lote - Erro ao buscar o Tipo da Rastreabilidade ' || SqlErrM;
                  Return;
            End;
      End;

      --

      -- Busca Qtde de apontamento de desvio da OP
      Begin
        Select Sum(Qtde)
          Into P_Qt_Desvio
          From Ztpp_Apt_Desvio
         Where Mandt = '400'
           And Lpad(Ordem_Producao,12,0) = Lpad(P_Nr_Op,12,0)
           And Data_Criacao = To_Char(Sysdate,'YYYYMMDD') -- filtrar apenas apontamentos do dia
           And Maquina = P_Cod_Maquina; --incluido em 13/09/22 por Jaqueline devido apontamentos gerador de gás
      Exception
         When Others Then
           P_Erro_Num := SqlCode;
           P_Erro_Des := 'Chrpp_Mf007_Pkg.Consulta_Lote - Erro ao buscar a Qtde de Desvio da Ordem de Produção ' || SqlErrM;
           Return;
      End;

   Exception
      When Others Then
        P_Erro_Num := SqlCode;
        P_Erro_Des := 'Chrpp_Mf007_Pkg.Consulta_Lote - Erro Geral. ' || SqlErrM;
   End;
   --

   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Gravar Apontamento de Defeito
   -- Autor.....: Jaqueline Orrico
   -- Data......: 24/11/2018
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Grava_Apontamento_Desvio (P_Sq_Lote      In Pd_Lote_Rastrea.Sq_Lote%Type,
                                       P_Terminal     In Varchar2,
                                       P_Cod_Desvio   In Varchar2,
                                       P_Qtde         In Number,
                                       P_Observacao   In Varchar2,
                                       P_Contador     In  Out Number, --quando precisar editar
                                       P_Erro_Num         Out Number,
                                       P_Erro_Des         Out Varchar2)
   Is
      --
      V_Mandante       Varchar2(3)   := '400';
      --
      V_Contador       Ztpp_Apontamento.Contador%Type;
      V_Produto        Ztpp_Apontamento.Matnr%Type;
      V_Centro         Ztpp_Apontamento.Centro%Type;
      V_Cod_Maquina    Pd_Lote_Rastrea.Maquina_Cod%Type;
      V_Nr_Op          Pd_Lote_Op.Sq_Lote%Type;
      V_Cont           Number(5);
      V_sq_controle_op Pd_op_apontamento.sq_controle_op%type;
      v_qt_tot_desvio  Ztpp_Apt_Desvio.qtde%type;
      v_cursor                    SYS_REFCURSOR;


      --
      Begin
        If P_Observacao Is Null Then
           P_Erro_Num := 1;
           P_Erro_Des := ' Campo Observação (motivo do defeito) é campo obrigatório. Verifique! ';
           Return;
        End If;

        If P_Qtde < 0 Then
           P_Erro_Num := 1;
           P_Erro_Des := 'Quantidade Inválida. Verifique!';
           Return;
        End If;

        Begin
          Select Count(*)
            Into V_Cont
            From Ztpp_Desvio
           Where Tipo  = '3' --Apontamento de Defeito
             And Mandt = '400'
             And Cod = P_Cod_Desvio;
        Exception
           When Others Then
              P_Erro_Num := SqlCode;
              P_Erro_Des := 'Chrpp_Mf007_Pkg.Grava_Apontamento_Desvio - Erro ao validar o Código do Desvio ' || SqlErrM;
              Return;
        End;
        --
        If V_Cont = 0 Then
           P_Erro_Num := 1;
           P_Erro_Des := ' Código do Desvio Inválido ('||P_Cod_Desvio||') . Verifique! ';
           Return;
        End If;

        -- Busca o Produto da OP
        Begin
          Select Lpad(Part_No,18,0),
                 Maquina_Cod
            Into V_Produto,
                 V_Cod_Maquina
            From Pd_Lote_Rastrea
           Where Sq_Lote = P_Sq_Lote;
        Exception
           When Others Then
              P_Erro_Num := SqlCode;
              P_Erro_Des := 'Chrpp_Mf007_Pkg.Grava_Apontamento_Desvio - Erro ao buscar o Código do Produto do Lote ' || SqlErrM;
              Return;
        End;


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

        -- Busca o centro de trabalho para máquina
        Begin
           Select Max(a.Cd_Centro_Custo)
             Into V_Centro
             From Tg_Maq_Ct_Terminal a,
                  Tg_Maquina b
            Where a.Sq_Maquina  = b.Sq_Maquina
              And b.Cd_Maquina  = V_Cod_Maquina --'0880'
              And Upper(a.Nm_Terminal) = Nvl(Upper(P_Terminal),a.Nm_Terminal);
        Exception
           When No_Data_Found Then
              V_Centro := null;
           When Others Then
              P_Erro_Num := SqlCode;
              P_Erro_Des := 'Chrpp_Mf007_Pkg.Grava_Apontamento_Desvio - Erro ao buscar o Centro de Trabalho' || SqlErrM;
              Return;
        End;

        -- Hard Code necessário devido sistema da folha de processo (Fecho), para poder consultar varios produtos na folha de processo e
        -- não ficar fixo no produto especifico em produção na máquina
        If Upper(P_Terminal) = 'TMONTA03' Then
               V_Centro := '672'; -- centro de trabalho
        Elsif Upper(P_Terminal) = 'TMONTA31' Then
            V_Centro := '674'; -- centro de trabalho
        Elsif Upper(P_Terminal) = 'TMONTA50' Then
            V_Centro := '674'; -- centro de trabalho
        Elsif Upper(P_Terminal) = 'TMONTA11' Then
            V_Centro := '672';    -- centro de trabalho
        Elsif Upper(P_Terminal) = 'TMONTA20' Then
            V_Centro := '672';     -- centro de trabalho
          End If;

        -- Quando for Insert
        If P_Contador Is Null Then

           If P_Qtde = 0 Then
              P_Erro_Num := 1;
              P_Erro_Des := 'Quantidade Inválida. Verifique!';
              Return;
           End If;

           Begin
              Select Nvl(Max(To_Number(Contador)),0) + 1
                Into V_Contador
                From Ztpp_Apt_Desvio;
           Exception
              When Others Then
                 P_Erro_Num := SqlCode;
                 P_Erro_Des := 'Chrpp_Mf007_Pkg.Grava_Apontamento_Desvio - Erro ao buscar o contador da tabela de apontamento. ' || SqlErrM;
                 Return;
           End;
           --
           P_Contador := V_Contador;
           --
           Begin
              Insert Into Ztpp_Apt_Desvio(Mandt          ,
                                          Contador       ,
                                          Ordem_Producao ,
                                          Produto        ,
                                          Centro_Trabalho,
                                          Maquina        ,
                                          Turno          ,
                                          Codigo_Defeito ,
                                          Qtde           ,
                                          Sq_Lote        ,
                                          Observacao     ,
                                          Data_Criacao   ,
                                          Usuario_Criacao,
                                          Data_Alteracao ,
                                          Usuario_Alteracao,
                                          Hora_Criacao,
                                          Hora_Alteracao,
                                          Componente,
                                          Index_Comp
                                          )
                                  Values (V_Mandante,
                                          V_Contador,
                                          Lpad(V_Nr_Op,12,0),
                                          V_Produto,
                                          V_Centro,
                                          --Lpad(V_Cod_Maquina,4,0),
                                          V_Cod_Maquina,
                                          '1', --Turno????
                                          P_Cod_Desvio,
                                          P_Qtde,
                                          P_Sq_Lote,
                                          Nvl(P_Observacao,' '),
                                          To_char(Sysdate,'YYYYMMDD'),
                                          User,
                                          To_char(Sysdate,'YYYYMMDD'),
                                          User,
                                          To_Char(Sysdate,'HH24MISS'),
                                          To_Char(Sysdate,'HH24MISS'),
                                          ' ',
                                          0
                                         );
           Exception
              When Others Then
                  P_Erro_Num := SqlCode;
                  P_Erro_Des := 'Chrpp_Mf007_Pkg.Grava_Apontamento_Desvio - Erro ao gravar o apontamento do desvio. ' || SqlErrM;
                  --
                  Rollback;
                  --
                  Return;
           End;
           --
        Else --Quando for Update
           Begin
             Update Ztpp_Apt_Desvio
                Set Codigo_Defeito = Lpad(Nvl(P_Cod_Desvio,Codigo_Defeito),4,0),
                    Observacao = Nvl(P_Observacao,Observacao),
                    Qtde = P_Qtde,
                    Sq_Lote = P_Sq_Lote,
                    Data_Alteracao = To_char(Sysdate,'YYYYMMDD'),
                    Hora_Alteracao = To_Char(Sysdate,'HH24MISS')
              Where Mandt    = V_Mandante
                And Contador = P_Contador;
            Exception
              When Others Then
                  P_Erro_Num := SqlCode;
                  P_Erro_Des := 'Chrpp_Mf007_Pkg.Grava_Apontamento_Desvio - Erro ao alterar o apontamento de desvio. ' || SqlErrM;
                  --
                  Rollback;
                  --
                  Return;
            End;
        --
        End If;
        If P_Erro_Num Is Null Then
           --
           Commit;
           --
           -- Inserido em 28/10/2021 para atualizar os desvios da tabela de apontamento resumido (pd_op_apontamento_aux)
           begin
             select distinct sq_controle_op
               into V_sq_controle_op
               from pd_op_apontamento
              where sq_lote = P_Sq_Lote;
           exception
             when others then
               V_sq_controle_op := 0;
           end;
           --
           -- busca qtde de desvios para OP/sequencia
           Begin
              select sum(Qtde)
                into v_qt_tot_desvio
                From Ztpp_Apt_Desvio a
               where a.mandt = '400'
                and a.Ordem_Producao = Lpad(V_Nr_Op,12,0)
                and lpad(a.Maquina,5,0) = Lpad(V_Cod_Maquina,5,0)
                and a.sq_lote in (select distinct b.sq_lote
                                    from pd_op_apontamento b
                                   where b.nr_op = a.Ordem_Producao
                                     and lpad(b.maquina_cod,5,0) = lpad(a.Maquina,5,0)
                                     and b.sq_controle_op = V_sq_controle_op);
           Exception
              When Others Then
                v_qt_tot_desvio := 0;
           End;
           --
           Begin
              update pd_op_apontamento_aux
                 set qt_tot_desvio = v_qt_tot_desvio
               where maquina_cod = V_Cod_Maquina
                 and nr_op = Lpad(V_Nr_Op,12,0)
                 and sq_controle_op = V_sq_controle_op;
           exception
              when others then
                 P_Erro_Num := SqlCode;
                 P_Erro_Des := 'Chrpp_Mf007_Pkg.Grava_Apontamento_Desvio - Erro ao atualizar a tabela de resumo de apontamento ' || SqlErrM;
                 Rollback;
                 return;
           end;
           If P_Erro_Num Is Null Then
              Commit;
           Else
              rollback;
           End If;
           -- Fim da alteração 28/10/2021
        End If;
        --

      Exception
         When Others Then
           P_Erro_Num := SqlCode;
           P_Erro_Des := 'Chrpp_Mf007_Pkg.Grava_Apontamento_Desvio - Erro Geral. ' || SqlErrM;
      End;


   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Efetuar Apontamento de Componentes
   -- Autor.....: Adriano Lima
   -- Data......: 16/04/2024
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Grava_Apontamento_Desvio_Comp (   P_Sq_Lote         In  Pd_Lote_Rastrea.Sq_Lote%TYPE
                                             , P_Terminal        In  Varchar2
                                             , P_Cod_Desvio      In  Varchar2
                                             , P_Qtde            In  Number
                                             , P_Observacao      In  Varchar2
                                             --, P_Contador        In  Out Number                                   -- quando precisar editar
                                             , P_Lista_Comp      In Varchar2                        Default Null
                                             , P_index_comp      In Out Ztpp_Apt_Desvio.Index_comp%Type-- quando for apontar por agrupamento, informar o Index
                                             , P_Erro_Num        Out Number
                                             , P_Erro_Des        Out Varchar2
                                             )

   Is

   V_sq_controle_op                          Pd_op_apontamento.sq_controle_op%Type;
   v_qt_tot_desvio                           Ztpp_Apt_Desvio.qtde%type;
   V_Cont                                    Number;
   V_Token                                   Clob;
   V_Check_Apont                             Number;
   --
   V_Max_Index_Comp                          ztpp_apt_desvio.index_comp%Type;
   V_Min_Index_Comp                          ztpp_apt_desvio.index_comp%Type;


   Begin

     ---------------------
     -- QUANDO FOR INSERT:
     ---------------------
     If ( P_Index_Comp Is Null ) Then

         IF P_Observacao Is Null Then
           P_Erro_Num := 1;
           P_Erro_Des := ' Campo Observação (motivo do defeito) do campo obrigatório. Verifique! ';
           Return;
         End If;

         --
         --
         If P_Qtde < 0 Then
            P_Erro_Num := 1;
            P_Erro_Des := 'Quantidade Inválida. Verifique!';
            Return;
         End If;
         --
         --
         Begin
           Select Count(*)
             Into V_Cont
             From Ztpp_Desvio
            Where Tipo  = '3' --Apontamento de Defeito
              And Mandt = '400'
              And Cod = P_Cod_Desvio;
         Exception
            When Others Then
               P_Erro_Num := Sqlcode;
               P_Erro_Des := 'Chrpp_Mf007_Pkg.Grava_Apontamento_Desvio - Erro ao validar o C?digo do Desvio ' || SqlErrM;
               Return;
         End;
         If V_Cont = 0 Then
            P_Erro_Num := 1;
            P_Erro_Des := ' C?digo do Desvio Inv?lido ('||P_Cod_Desvio||') . Verifique! ';
            Return;
         End If;
         --
         --
         -- Busca o Produto da OP
         Begin
           Select Lpad(Part_No,18,0),
                  Maquina_Cod
           Into T.Produto
              , T.Maquina
            From Pd_Lote_Rastrea
            Where Sq_Lote = P_Sq_Lote;
            --dbms_output.put_line('V_Produto '||' '||Type_Comp.Produto||chr(13)||'V_Cod_Maquina '||Type_Comp.Maquina);
         Exception
             When Others Then
              P_Erro_Num := Sqlcode;
              P_Erro_Des := 'Chrpp_Mf007_Pkg.Grava_Apontamento_Desvio - Erro ao buscar o Código do Produto do Lote ' || SqlErrM;
              Return;
         End;
         --
         --
         Begin
           Select Lpad(Nr_Op,12,0)
             Into T.Ordem_Producao
           From Pd_Lote_Op
            Where Sq_Lote = P_Sq_Lote;
             --dbms_output.put_line(Type_Comp.Ordem_Producao);
         Exception
            When Others Then
              P_Erro_Num := Sqlcode;
              P_Erro_Des := 'Chrpp_Mf007_Pkg.Grava_Apontamento_Desvio - Erro ao buscar o Nro da Ordem de Produ??o ' || SqlErrM;
              Return;
         End;
         --
         --
         -- Busca o centro de trabalho para máquina
         BEGIN
            Select Max(a.Cd_Centro_Custo)
            Into T.Centro_Trabalho
            From Tg_Maq_Ct_Terminal a,
               Tg_Maquina           b
           Where a.Sq_Maquina         = b.Sq_Maquina
             And b.Cd_Maquina         = T.Maquina -- 0880
             And Upper(a.Nm_Terminal) = Nvl(Upper(P_Terminal),a.Nm_Terminal);
             --dbms_output.put_line('Centro_Trabalho '||' '||T.Centro_Trabalho);
         Exception
            When No_Data_Found Then
             T.Centro_Trabalho := Null;
            When Others Then
             P_Erro_Num := Sqlcode;
             P_Erro_Des := 'Chrpp_Mf007_Pkg.Grava_Apontamento_Desvio - Erro ao buscar o Centro de Trabalho' || SqlErrM;
             Return;
         End;
         --
         --
         -- Hard Code necessário devido sistema da folha de processo (Fecho), para poder consultar varios produtos na folha de processo e
         -- não ficar fixo no produto especifico em produção na máquina.
         If Upper(P_Terminal)    = 'TMONTA03' Then
           T.Centro_Trabalho := '672'; -- centro de trabalho
         Elsif Upper(P_Terminal) = 'TMONTA31' Then
           T.Centro_Trabalho := '674'; -- centro de trabalho
         Elsif Upper(P_Terminal) = 'TMONTA50' Then
           T.Centro_Trabalho := '674'; -- centro de trabalho
         Elsif Upper(P_Terminal) = 'TMONTA11' Then
           T.Centro_Trabalho := '672'; -- centro de trabalho
         Elsif Upper(P_Terminal) = 'TMONTA20' Then
           T.Centro_Trabalho := '672'; -- centro de trabalho
         End If;
         --
         --
         If P_Qtde = 0 Then
          P_Erro_Num := 1;
          P_Erro_Des := 'Quantidade Inválida. Verifique!';
          Return;
         End If;
         --
         --
          T.Mandt                    := '400';
          T.Contador                 := 0;
          T.Turno                    := '1'; --Turno
          T.Codigo_Defeito           := P_Cod_Desvio;
          T.Qtde                     := P_Qtde;
          T.Sq_Lote                  := P_Sq_Lote;
          T.Observacao               := P_Observacao;
          T.Data_Criacao             := To_char(Sysdate,'YYYYMMDD');
          T.Usuario_Criacao          := User;
          T.Data_Alteracao           := To_char(Sysdate,'YYYYMMDD');
          T.Usuario_Alteracao        := User;
          T.Hora_Criacao             := To_Char(Sysdate,'HH24MISS');
          T.Hora_Alteracao           := To_Char(Sysdate,'HH24MISS');
          T.Componente               := V_Token;
          T.Index_Comp               := 1;
          --

                 If P_Qtde = 0 Then
                    P_Erro_Num := 1;
                    P_Erro_Des := 'Quantidade Inválida. Verifique!';
                    Return;
                 End If;

                 -----------------------------------------------------
                 -- FATIAR LISTA DE COMPONENTE E PERSISTENCIA DO DADO:
                 -----------------------------------------------------
                 Begin

                    Begin
                        /*
                        Begin
                          Select Nvl(Max(To_Number(Contador)),0)
                            Into T.Contador
                            --From Ztpp_Apt_Desvio;
                            From chriserp.stg_desvio_comp
                            Where Index_Comp <> 0
                            And Sq_Lote     = P_Sq_Lote;
                       Exception
                          When Others Then
                             P_Erro_Num := SqlCode;
                             P_Erro_Des := 'Chrpp_Mf007_Pkg.Grava_Apontamento_Desvio - Erro ao buscar o contador da tabela de apontamento. ' || SqlErrM;
                             Return;
                       End;
                       */

                      T.Index_Comp                := fun_calc_generico ( P_Calc => 2, P_Erro_Num => P_Erro_Num, P_Erro_Des => P_Erro_Des );                      
                                            
                      For Reg In
                        (
                          Select
                            Replace(Substr(P_Lista_Comp, (Level - 1) * 19 + 1, 19), ';', ' ') As Componente
                          From Dual
                          Connect By
                        ( level - 1 ) * 19 + 1 <= Length( P_Lista_Comp )
                      ) Loop
                      
                        T.Contador                  := fun_calc_generico ( P_Calc => 1, P_Erro_Num => P_Erro_Num, P_Erro_Des => P_Erro_Des );                        
                        --P_Contador                  := T.Contador; 
                        
                        If Reg.Componente Is Not Null Then

                        Insert Into Ztpp_Apt_Desvio (    Mandt
                                                       , Contador
                                                       , Ordem_Producao
                                                       , Produto
                                                       , Centro_Trabalho
                                                       , Maquina
                                                       , Turno
                                                       , Codigo_Defeito
                                                       , Qtde
                                                       , Sq_Lote
                                                       , Observacao
                                                       , Data_Criacao
                                                       , Usuario_Criacao
                                                       , Data_Alteracao
                                                       , Usuario_Alteracao
                                                       , Hora_Criacao
                                                       , Hora_Alteracao
                                                       , Componente
                                                       , index_comp
                                                      )
                                              Values (
                                                         T.Mandt
                                                       , T.Contador --P_Contador 
                                                       , Lpad(T.Ordem_Producao,12,0)
                                                       , T.Produto
                                                       , T.Centro_Trabalho
                                                       , T.Maquina
                                                       , T.Turno
                                                       , T.Codigo_Defeito
                                                       , T.Qtde
                                                       , T.Sq_Lote
                                                       , Nvl(T.Observacao ,' ')
                                                       , T.Data_Criacao
                                                       , T.Usuario_Criacao
                                                       , T.Data_Alteracao
                                                       , T.Usuario_Alteracao
                                                       , T.Hora_Criacao
                                                       , T.Hora_Alteracao
                                                       , Reg.Componente
                                                       , T.Index_Comp
                                                      );
                                               Commit;

                          --dbms_output.put_line('Componente: ' || token_rec.token);                                                  
                        END IF;                                               
                      END LOOP;                                            
                                           
                      
                      --dbms_output.put_line('Componente: ' || T.Index_Comp);                       
                      P_Index_Comp      := T.Index_Comp;
                    END;
                      
                 Exception
                    When Others Then
                        P_Erro_Num := SqlCode;
                        P_Erro_Des := 'Chrpp_Mf007_Pkg.Grava_Apontamento_Desvio - Erro ao gravar o apontamento do desvio. ' || SqlErrM;
                        --
                        Rollback;
                        --
                        Return;
                 End;
                 --
                 --
     -----------------
     -- QUANDO UPDATE:
     -----------------

     Elsif ( P_Index_Comp Is Not Null And P_Index_Comp > 0 ) Then
       --dbms_output.put_line('Entrou no update');

            T.Mandt                    := '400';

            Begin
             Update Ztpp_Apt_Desvio
                Set Codigo_Defeito = Lpad(Nvl(P_Cod_Desvio,Codigo_Defeito),4,0),
                    Observacao     = Nvl(P_Observacao,Observacao),
                    Qtde           = P_Qtde,
                    Sq_Lote        = P_Sq_Lote,
                    Data_Alteracao = To_char(Sysdate,'YYYYMMDD'),
                    Hora_Alteracao = To_Char(Sysdate,'HH24MISS')
              Where Mandt          = T.Mandt
                --And Contador       = P_Contador
                And Sq_Lote        = P_Sq_Lote
                And Index_Comp     = P_Index_Comp;
               Commit;

            End;

     
       Else
         Null;
     --
     --
     End If;
     
   --
   --
   END;


   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Lista Códigos de Defeitos
   -- Autor.....: Jaqueline Orrico
   -- Data......: 24/11/2018
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Lista_Desvio(P_Terminal  In Tg_Maq_Ct_Terminal.Nm_Terminal%Type,
                          P_Cursor       Out G_Cursor,
                          P_Erro_Num     Out Number,
                          P_Erro_Des     Out Varchar2)

   Is
     V_Centro_Trabalho  Tg_Maq_Ct_Terminal.Cd_Centro_Custo%Type;
   Begin
       -- Busca Centro de Trabalho
       Begin
          Select Cd_Centro_Custo
            Into V_Centro_Trabalho
            From Tg_Maq_Ct_Terminal
           Where Upper(Nm_Terminal) = Upper(P_Terminal);
       Exception
              When Others Then
                 P_Erro_Num := SqlCode;
                 P_Erro_Des := 'Chrpp_Mf007_Pkg.Lista_Desvio - Erro ao buscar o Centro de Trabalho. ' || SqlErrM;
                 Return;
       End;

       If V_Centro_Trabalho In ('662','690') Then --Regulador de Altura e Gerador de Gás
          V_Centro_Trabalho := '669'; -- Desvios do Retrator
       Elsif V_Centro_Trabalho In ('650','674') Then -- Fecho duplo e bancada
          V_Centro_Trabalho := '672'; -- Desvios do Fecho em geral
       End If;

       -- Abrindo o cursor para retornar a lista de códigos de paradas
       Open P_Cursor For
         Select Cod, Descricao
           From Ztpp_Desvio
          Where Tipo   = '3' --Apontamento de Defeito
            And Centro_Trabalho = V_Centro_Trabalho
          Order By Cod;
   End;

   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Lista Apontamentos de Desvio por OP / Lote (sq_lote)
   -- Autor.....: Jaqueline Orrico
   -- Data......: 24/11/2018
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Lista_Desvio_OP(P_Cod_Maquina  In Pd_Lote_Rastrea.Maquina_Cod%Type,
                             P_Nr_Op        In Pd_Lote_OP.Nr_Op%Type,
                             P_Cursor       Out G_Cursor)  --declarando o cursor
   Is
   Begin        
       
      -- Abrindo o cursor para retornar a lista de desvios da OP por Lote
       Open P_Cursor For       
          Select Maquina
             , a.Centro_Trabalho
             , To_Char(Contador) Contador
             , a.Codigo_Defeito
             , b.Descricao
             , a.Qtde
             , a.Observacao
             , a.sq_lote
             , c.Cd_Fam Nr_Rastrea
        From Ztpp_Apt_Desvio  a
           , Ztpp_Desvio      b
           , Pd_Lote_Rastrea  c
        Where a.Mandt      = b.Mandt
        And Codigo_Defeito = b.Cod
        And a.Data_Criacao = To_Char(Sysdate,'YYYYMMDD') -- filtrar apenas apontamentos do dia
        And a.Data_Criacao = To_Char(Sysdate,'YYYYMMDD') -- filtrar apenas apontamentos do dia para OP
        And a.Sq_Lote      = c.Sq_Lote
        And Index_Comp     = 0
        And Lpad(Ordem_Producao,12,0) = Lpad(P_Nr_Op,12,0)
        And Maquina                   = P_Cod_Maquina
        
        
        Union All
  
        ------------------------------------------
        -- VISAO SINTETIZADA DO COMPONENTE(FILHO):
        ------------------------------------------
        Select Distinct(a.Maquina)
                , a.Centro_Trabalho
                , Replace(To_Char(Contador), To_Char(Contador), Index_Comp) Contador
                , a.Codigo_Defeito
                , b.Descricao
                , a.Qtde
                , a.Observacao
                , a.sq_lote
                , c.Cd_Fam Nr_Rastrea        
          From Ztpp_Apt_Desvio a
             , Ztpp_Desvio     b
             , Pd_Lote_Rastrea c
          Where a.Mandt      = b.Mandt
          And Codigo_Defeito = b.Cod
          And a.Data_Criacao = To_Char(Sysdate,'YYYYMMDD') -- filtrar apenas apontamentos do dia
          And a.Data_Criacao = To_Char(Sysdate,'YYYYMMDD') -- filtrar apenas apontamentos do dia para OP
          And a.Sq_Lote      = c.Sq_Lote
          And Index_Comp     > 0
          And Lpad(Ordem_Producao,12,0) = Lpad(P_Nr_Op,12,0)
          And Maquina                   = P_Cod_Maquina;
           
            
   End;




   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Gravar Apontamento de Parada - Integração Web Service SAP
   -- Autor.....: Jaqueline Orrico
   -- Data......: 08/06/2018
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Grava_Apontamento_Parada_SAP (P_Nr_Op        In Pd_Lote_Op.Nr_Op%Type,
                                           P_Cod_Parada   In  Varchar2,
                                           P_Dt_Inicio    In  Varchar2,
                                           P_Hr_Inicio    In  Varchar2,
                                           P_Dt_Fim       In  Varchar2,
                                           P_Hr_Fim       In  Varchar2,
                                           P_Erro_Num         Out Number,
                                           P_Erro_Des         Out Varchar2)
   Is

      --
      V_Xml          Xmltype;
      --
      Ww_Env         Varchar2(30000);
      Ww_Env_Resp    Varchar2(30000);
      --
      Http_Req       Utl_Http.Req;
      Http_Resp      Utl_Http.Resp;
      --
      V_Message      Varchar2(30000);
      V_NroMessage   Number(5);
      --
      V_Cont         Number(3);
      --
      V_Dt_Inicio    Varchar2(10);
      V_Hr_Inicio    Varchar2(10);
      V_Dt_Fim       Varchar2(10);
      V_Hr_Fim       Varchar2(10);
      --
      -- Endereço para acesso do Web Service, com informações do servidor, Nome da Web Service Criada, Ambiente e Serviço criado
      -- Ambiente Produção
      /*V_Mandante  Varchar2(3)   := '400';
      V_ServSap   Varchar2(15)  := 'chrsapapp';
      V_PortSap   Varchar2(4)   := '8012';*/

      -- Ambiente Qualidade
      /*V_Mandante  Varchar2(3)   := '400';
      V_ServSap   Varchar2(15)  := 'chrsapq01';
      V_PortSap   Varchar2(4)   := '8004';*/

      -- Ambiente Produção CLOUD
      V_Mandante  Varchar2(3)   := '400';
      V_ServSap   Varchar2(15)  := 'CHRSAPECCP-C';
      V_PortSap   Varchar2(4)   := '8012';


      Ww_Url      Varchar2(300) := 'http://'||V_ServSap||'.local.chriscintos.com.br:'||V_PortSap||'/sap/bc/srt/rfc/sap/ZWS_APONTAMENTO_MAQUINA/'||V_Mandante||'/ZWS_APONTAMENTO_MAQUINA';

      -- Parâmetros do XML que deverá ser enviado, considerando entrada e saida da função RFC
      Ww_Xml      Varchar2(30000);
      --
      Begin
         -- Converte as datas no padrão SAP
         V_Dt_Inicio := To_Char(To_Date(P_Dt_Inicio,'YYYY-MM-DD'),'YYYY-MM-DD');
         V_Hr_Inicio := To_Char(TO_Date(P_Hr_Inicio,'HH24:MI:SS'),'HH24:MI:SS');
         V_Dt_Fim    := To_Char(To_Date(P_Dt_Fim,'YYYY-MM-DD'),'YYYY-MM-DD');
         V_Hr_Fim    := To_Char(To_Date(P_Hr_Fim,'HH24:MI:SS'),'HH24:MI:SS');
         --
         -- Parâmetros do XML que deverá ser enviado, considerando entrada e saida da função RFC
         Ww_Xml   := ' <VIDevReason>'||P_Cod_Parada||'</VIDevReason>
                       <VIExecFinDate>'||V_Dt_Fim||'</VIExecFinDate>
                       <VIExecFinTime>'||V_Hr_Fim||'</VIExecFinTime>
                       <VIExecStartDate>'||V_Dt_Inicio||'</VIExecStartDate>
                       <VIExecStartTime>'||V_Hr_Inicio||'</VIExecStartTime>
                       <VIOrderid>'||P_Nr_Op||'</VIOrderid>
                       <VEMessage></VEMessage>
                       <VENumeroMsg></VENumeroMsg>
                     ';

         dbms_output.put_line(Ww_Xml);
         dbms_output.put_line(Ww_Url);
         -- Estrutura do XML que será enviado ao Web Service (msg SOAP completa)
         Ww_Env:='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:sap-com:document:sap:soap:functions:mc-style">
                  <soapenv:Header/>
                  <soapenv:Body>
                  <urn:ZrfcApontamentoMaquina>'||Ww_Xml||'</urn:ZrfcApontamentoMaquina>
                  </soapenv:Body>
                  </soapenv:Envelope>';
         dbms_output.put_line(Ww_Env);
         -- http_req -> possui o chamado do web service, onde /pp_lista_tecnica é o metodo criado
         Http_Req := Utl_Http.Begin_Request(Ww_Url || '/ZWS_APONTAMENTO_MAQUINA', 'POST','HTTP/1.1');
         dbms_output.put_line(Ww_Url || '/ZWS_APONTAMENTO_MAQUINA');

         -- Uusário de acesso do Web SErvice - SAP
         Utl_Http.Set_Authentication(Http_Req, 'PALM_USER','#palm*', 'Basic', false );

         -- Formatação padrão do XML
         Utl_Http.Set_Body_Charset(Http_Req, 'UTF-8');
         Utl_Http.Set_Header(Http_Req, 'Content-Type', 'text/xml');
         Utl_Http.Set_Header(Http_Req, 'Content-Length', Length(Ww_Env));
         Utl_Http.Write_Text(Http_Req,Ww_Env);
         dbms_output.put_line(Length(Ww_Env));
         -- Recebe o valor de resposta do Web Service
         Http_Resp := Utl_Http.Get_Response(Http_Req);

         If (Http_Resp.Status_Code =Utl_Http.Http_Ok ) Then
             Utl_Http.Read_Text(Http_Resp, Ww_Env_Resp);
         Else
             Utl_Http.Read_Text(Http_Resp, Ww_Env_Resp);
             dbms_output.put_line(http_resp.status_code || '-' || http_resp.reason_phrase);
             dbms_output.put_line(Ww_Env_Resp);
         End If;

         -- Transforma a reposta do Web SErvice em XML
         dbms_output.put_line(' xml ' || Ww_Env_Resp);
         V_Xml := Xmltype(Ww_Env_Resp);

         --Finaliza a conexão do Web SErvice
         Utl_Http.End_Response(Http_Resp);

         V_Cont := 0;
         -- Carrega o XML em tabela, para encontrar a tags VENumeroMsg e VEMessage
         For Rec In (Select value(x) txt
                       From table(XMLSequence(extract(v_xml, '//*'))) x
            )
            Loop
               V_Cont := V_Cont + 1;

               --Mostra o retorno da tag xml
               dbms_output.put_line('xml_snippet: ' || rec.txt.getStringVal());

               If V_Cont = 5 Then -- apenas para passar pela msg apenas uma vez e não limpar a variável V_Message
                  --Extrai o valor da tag xml VEMessage
                  Select Extractvalue(Rec.txt, 'VEMessage')
                    Into V_Message
                    From Dual;
               End If;

               --Extrai o valor da tag xml VENumeroMsg
               Select Extractvalue(Rec.txt, 'VENumeroMsg')
                 Into V_NroMessage
                 From Dual;
         End Loop;

         --Mostra somente os valores da tag VENumeroMsg e VEMessage
         dbms_output.put_line('Mensagens: ' || V_NroMessage || ' - ' || V_Message);

         If V_NroMessage <> 100 Then
            P_Erro_Num  := 1;
            P_Erro_Des  := V_Message;
         Else
            P_Erro_Num  := null;
            P_Erro_Des  := null;
         End If;

      Exception
         When Others Then
           Utl_Http.End_Response(Http_Resp);
           dbms_output.put_line(sys.utl_http.GET_DETAILED_SQLERRM());
      End;

      -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
      -- Finalidade: Lista OP´s do dia para máquina
      -- Autor.....: Jaqueline Orrico
      -- Data......: 13/08/2019
      -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
      Procedure Lista_OP_Maquina(P_Cod_Maquina  In Pd_Lote_Rastrea.Maquina_Cod%Type,
                                 P_Cursor    Out G_Cursor)  --declarando o cursor
      Is
      Begin
         -- Abrindo o cursor para retornar a lista de desvios da OP por Lote
         Open P_Cursor For
         Select b.Nr_Op, a.Part_No, min(a.Dh_Lote) Dh_Lote, Max(b.Sq_Lote) Sq_Lote
           From Pd_Lote_Rastrea a,
                Pd_Lote_Op b
          Where a.Sq_Lote = b.Sq_Lote
            And trunc(a.Dh_lote) = Trunc(Sysdate)
            And a.Maquina_Cod    = P_Cod_Maquina
       Group by b.Nr_Op, a.Part_No;
      End;

      -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
      -- Finalidade: Lista Lotes da OP do Dia
      -- Autor.....: Jaqueline Orrico
      -- Data......: 30/09/2019
      -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
      Procedure Lista_Lotes_OP(P_Cod_Maquina  In Pd_Lote_Rastrea.Maquina_Cod%Type,
                               P_Nr_Op   In Pd_Lote_Op.Nr_Op%Type,
                               P_Cursor     Out G_Cursor)  --declarando o cursor
      Is
      Begin
         -- Abrindo o cursor para retornar a lista de desvios da OP por Lote
         Open P_Cursor For
         Select a.Cd_Fam Nr_Rastrea,  Max(a.Sq_Lote) Sq_Lote
           From Pd_Lote_Rastrea a,
                Pd_Lote_Op b
          Where a.Sq_Lote = b.Sq_Lote
            And trunc(a.Dh_lote)   = Trunc(Sysdate)
            And a.Maquina_Cod      = P_Cod_Maquina
            And Lpad(b.nr_op,12,0) = Lpad(P_Nr_Op,12,0)
       Group by a.Cd_Fam;

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
     V_Contador         Ztpp_Apontamento.Contador%Type;
   Begin
       Begin
         Select Max(Contador)
           Into V_Contador
           From Ztpp_Apt_Desvio
          Where Maquina = P_Cod_Maquina;
       Exception
          When No_Data_Found Then
             V_Contador := 0;
          When Others Then
             P_Erro_Num := SqlCode;
             P_Erro_Des := 'Chrpp_Mf006_Pkg.Retorna_Ultimo_Apont - Erro 01 ao buscar o último apontamento. ' || SqlErrM;
             Return;
       End;

       Begin
         Select To_Date(To_Char(Data_Alteracao) || Hora_Alteracao, 'YYYY/MM/DD HH24:MI:SS')
           Into P_Data
           From Ztpp_Apt_Desvio
          Where Contador = V_Contador;
       Exception
          When No_Data_Found Then
             P_Data := null;
          When Others Then
             P_Erro_Num := SqlCode;
             P_Erro_Des := 'Chrpp_Mf006_Pkg.Retorna_Ultimo_Apont - Erro 02 ao buscar o último apontamento. ' || SqlErrM;
             Return;
       End;
   End;

   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Gravar Apontamento de Desvio - Automático
   -- Autor.....: Jaqueline Orrico
   -- Data......: 08/10/2020
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   Procedure Grava_Desvio_Automatico (P_Cod_Maquina  In Pd_Lote_Rastrea.Maquina_Cod%Type,
                                      P_Terminal     In Varchar2,
                                      P_Cod_Desvio   In Varchar2,
                                      P_Qtde         In Number,
                                      P_Observacao   In Varchar2,
                                      P_Contador     In  Out Number, --quando precisar editar
                                      P_Erro_Num         Out Number,
                                      P_Erro_Des         Out Varchar2)
   Is
      --
      V_Sq_Lote   Pd_Lote_Rastrea.Sq_Lote%Type;
      --
   Begin
        -- Busca Sq_Lote
        Begin
          Select Sq_Lote
            Into V_Sq_Lote
            From Pd_Lote_Rastrea
           Where Vf_Encerrado = 'N'
             And Maquina_cod  = P_Cod_Maquina
             And Trunc(Dh_lote) = Trunc(Sysdate); --apontar somente se existir setup da OP no dia atual - 15/05/2020
        Exception
           When No_Data_Found Then
              V_Sq_Lote := null;
           When Others Then
              P_Erro_Num := SqlCode;
              P_Erro_Des := 'Chrpp_Mf007_Pkg.Grava_Desvio_Automatico - Erro ao buscar a Sequencia do Lote ' || SqlErrM;
              Return;
        End;
        --
        If V_Sq_Lote Is Not Null Then
           Begin
              Chrpp_Mf007_Pkg.Grava_Apontamento_Desvio(V_Sq_Lote,
                                                       P_Terminal,
                                                       P_Cod_Desvio,
                                                       P_Qtde,
                                                       P_Observacao,
                                                       P_Contador ,
                                                       P_Erro_Num ,
                                                       P_Erro_Des );
           Exception
              When Others Then
                 P_Erro_Num := SqlCode;
                 P_Erro_Des := 'Chrpp_Mf005_Pkg.Grava_Desvio_Automatico - Erro ao inserir apontamento ' || SqlErrM;
                 Return;
           End;
        End If;
   Exception
       When Others Then
          P_Erro_Num := SqlCode;
          P_Erro_Des := 'Chrpp_Mf005_Pkg.Grava_Desvio_Automatico - Erro Geral. ' || SqlErrM;
   End;
   --
   --
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
   -- Finalidade: Retornar Lista Técnica de Componentes do SAP
   -- Autor.....: Adriano Lima
   -- Data......: 16/04/2024
   -- Trello....: Card-343
   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --   
   Procedure Lista_Tecnica_Comp_Filho(   P_Nr_Ordem                  In  Afko.Aufnr%Type
                                       , P_Cursor                    Out G_Cursor
                                       , P_Erro_Num                  Out Number
                                       , P_Erro_Des                  Out Varchar2 
                                       )
   Is

    C_Ordem_Sap                        Constant Varchar2(50):= 'Ordem Inválida! Não existe no SAP, verificar.';
    C_Mandt                            Constant Afko.Mandt%Type:= '400';
    
    
    Begin

        Begin
          Select a.rsnum             -- Numero de Reserva(Sequencial do SAP)
               , a.aufnr             -- Ordem SAP
            Into Type_Afko.Rsnum
               , Type_Afko.Aufnr
           From Afko a
          Where a.Mandt = C_Mandt
            And a.Aufnr = lpad(P_Nr_Ordem,12,0);
            --dbms_output.put_line(Type_Afko.Rsnum||CHR(13)|| Type_Afko.aufnr);

          Exception
            When No_Data_Found Then
              P_Erro_Num       := SqlCode;
              P_Erro_Des       := C_Ordem_Sap;
              Return;

        End;
      --
      --
      Open P_Cursor For
          Select a.matnr          As Cod_SubComponente
               , c.maktx          As Desc_Subcomponente
          From resb a
             , Mara b           -- Somente itens rastreados
             , makt c
          Where  0=0
          AND a.matnr   = b.matnr
          And a.matnr   = c.matnr
          And rsnum     = Type_Afko.Rsnum  --'0033464090'
          And a.Aufnr   = Lpad(Type_Afko.Aufnr,12,0)
          And a.Mandt   = C_Mandt
          AND Ltrim(Rtrim(b.Normt)) Is Null
          Order By a.baugr;

      Exception
          When others then
              dbms_output.put_line('Codigo Erro: ' || Sqlcode || ' - ' || 'Msg: ' || Sqlerrm);
              dbms_output.put_line('Linha: ' || dbms_utility.format_error_backtrace);

    End;
    --
    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Finalidade: Retornar Lista de Apontamento Realizados Por Grupo
    -- Autor.....: Adriano Lima
    -- Data......: 16/04/2024
    -- Trello....: Card-343
    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --                                          
    Procedure Lista_Apontamento_Por_Grupo(   P_Nr_Ordem              In  Afko.Aufnr%Type
                                           , P_Idex_Comp             In  Ztpp_Apt_Desvio.Index_Comp%type           
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
   
          If ( P_Idex_Comp > 0 ) Then
             
              Open P_Cursor For
               Select  a.Index_Comp 
                     , a.Componente
                     , b.Descricao 
                  Into T.Index_Comp
                     , T.componente      
                     , T.Descricao                                                                                  
                 From Ztpp_Apt_Desvio a,
                      Ztpp_Desvio b,
                      Pd_Lote_Rastrea c
                Where a.Mandt = b.Mandt
                  And Codigo_Defeito = b.Cod
                  And a.Data_Criacao = To_Char(Sysdate,'YYYYMMDD') -- filtrar apenas apontamentos do dia
                  And a.Data_Criacao = To_Char(Sysdate,'YYYYMMDD') -- filtrar apenas apontamentos do dia para OP
                  And a.Sq_Lote = c.Sq_Lote  
                  --
                  And Lpad(Ordem_Producao,12,0) = Lpad(P_Nr_Ordem,12,0)
                  And a.Index_Comp              = P_Idex_Comp                      
                  Order By 1;  
                  
                  --P_Erro_Des                    := 'Para Componente Cursor Retorna Dados!';                  
          --             
          --             
          Elsif (P_Idex_Comp = 0 ) Then
                                      
              Open P_Cursor For
               Select  a.Index_Comp 
                     , a.Componente
                     , b.Descricao 
                  Into T.Index_Comp
                     , T.componente      
                     , T.Descricao                                                                                  
                 From Ztpp_Apt_Desvio a,
                      Ztpp_Desvio b,
                      Pd_Lote_Rastrea c
                Where a.Mandt = b.Mandt
                  And Codigo_Defeito = b.Cod
                  And a.Data_Criacao = To_Char(Sysdate,'YYYYMMDD') -- filtrar apenas apontamentos do dia
                  And a.Data_Criacao = To_Char(Sysdate,'YYYYMMDD') -- filtrar apenas apontamentos do dia para OP
                  And a.Sq_Lote = c.Sq_Lote  
                  --
                  And Lpad(Ordem_Producao,12,0) = Lpad(P_Nr_Ordem,12,0)
                  And a.Index_Comp              = P_Idex_Comp 
                  And Rownum = 0                     
                  Order By 1;
                  
                  --P_Erro_Des                         := 'Para Produto Cursor não Retorna Dados!'; 

          Else
            Null;
          
          End If;              
          --
          Exception
            When Others Then
                P_Erro_Num := SQLCODE;
                P_Erro_Des := 'Erro: ' || SQLERRM;
                dbms_output.put_line('Código de Erro: ' || SQLCODE || ' - ' || 'Msg: ' || SQLERRM);
                dbms_output.put_line('Linha: ' || dbms_utility.format_error_backtrace);
                Return;                        
            
        End;
        --
        --

    End;
    
    --
    --
    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Finalidade: Função Genérica, Permite Novas Implementações Dentro da MF007.
    -- Autor.....: Adriano Lima
    -- Data......: 16/04/2024
    -- Trello....: Card-343
    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --                                        
    Function Fun_Calc_Generico (   P_Calc                Number
                                 , P_Erro_Num            Out Number
                                 , P_Erro_Des            Out Varchar2 )
                                 
      Return varchar2
      
      Is

    Begin

       If ( P_Calc  = 1 ) Then

         Begin
            Select Nvl(Max(To_Number(Contador)),0) + 1
              Into T.contador
             From Ztpp_Apt_Desvio;

         Exception
            When Others Then
              Return T.contador;
               P_Erro_Num := SqlCode;
               P_Erro_Des := 'Chrpp_Mf007_Pkg.Grava_Apontamento_Desvio - Erro ao buscar o contador da tabela de apontamento. ' || SqlErrM;
               --dbms_output.put_line('T.contador:  '||T.contador);
         End;

       Elsif ( P_Calc = 2 ) Then
         --dbms_output.put_line('Teste 2!');

         Begin

            Select Nvl(Max(To_Number(Index_Comp)), 0) + 1
              Into T.Index_Comp
             From Ztpp_Apt_Desvio
            Where Index_Comp > 0;
            Return T.Index_Comp;

            Exception
              When Others Then
                 P_Erro_Num := SqlCode;
                 P_Erro_Des := 'Chrpp_Mf007_Pkg.Grava_Apontamento_Desvio - Erro ao buscar índice do agrupamento da tabela de apontamento. ' || SqlErrM;
         End;



       Else
         Null;


       End If;
           Return T.contador;

     Exception
        When Others Then
          Return Null;
          dbms_output.put_line('Código Erro: ' || sqlcode || ' Msg: ' ||sqlerrm);
          dbms_output.put_line('Linha: ' || dbms_utility.format_error_backtrace);

    End;

END;
/