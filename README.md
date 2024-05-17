
<center><h1>1º FASE DO PROJETO</h1></center>
<center><h2>card-343</h2></center>

<center><h2>PP007 Implementação do Apontamento de Componente Filho</h2></center>




### Item 1
```sh
ALTERAR TABELA Z DO SAP
    Criado os campo "componente e  Index_Comp"na tabela Ztpp_Apt_Desvio
```

### Item 2
```sh
CRIAR PROCEDURE LISTA_TECNICA_COMP_FILHO
 Criação de Procedure que recebe uma ordem do SAP como parâmetro de entrada e retorna um cursor como parâmetro de saída com o código e a descrição do componente.
 ```

### Item 3
```sh
IMPLEMENTAR PROCEDURE LISTA_DESVIO_OP     
    Implementação da procedure (Lista_Desvio_OP) já existente. 
    Efetuado a união do SQL que retorna a lista do componente(Pai) com a lista do componente(Filho) de forma sintetizada.
    Obs.: No momente de Editar é chamado essa procedure
```

### Item 4
```sh
CRIAR PROCEDURE GRAVA_APONTAMENTO_DESVIO_COMP
    Criação de Procedure que contempla o apontamento de defeito de componente conforme especificação.
```

### Item 5
```sh
CRIAR PROCEDURE LISTA_APONTAMENTO_POR_GRUPO
    Após persistência dos dados, deve ser chamado esse objeto para exibir a lista dos componentes apontados.
    Quando produto  o cursor não retornará dados!
    Quando Componente o cursor retornará dados conforme o index_Comp passado como parâmetro de entrada.
```

### Item 6
```sh
CRIAR FUNCTION FUN_CALC_GENERICO
    Criado função chriserp.chrpp_mf007_pkg.fun_calc_generico para gerenciar o "contador e o index_comp" da tabela Ztpp_Apt_Desvio no processo de apontamento de componente(Filho).
```


<center><h1>2º FASE DO PROJETO</h1></center>

