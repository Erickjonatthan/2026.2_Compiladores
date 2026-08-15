# Atividade 1 - Analisadores Léxicos com Flex

Este repositório contém as soluções para a primeira atividade prática da disciplina de Compiladores. O objetivo foi construir analisadores léxicos utilizando a ferramenta **Flex** (Fast Lexical Analyzer Generator) em conjunto com a linguagem C.

## Estrutura do Projeto

O projeto está dividido em quatro questões iterativas. As Questões 1, 2 e 3 processam dados através da **entrada padrão** (teclado/redirecionamento), enquanto a Questão 4 introduz a **leitura direta de arquivos**.

* **q1 (Estatísticas de Texto):** Um contador no estilo `wc` do Unix. Ele lê a entrada padrão e conta linhas, palavras, caracteres totais, inteiros, números de ponto flutuante e pontuações específicas.
* **q2 (Calculadora Simples):** Um analisador que classifica tokens de uma expressão matemática, reconhecendo operadores básicos, relacionais, parênteses e números. Os operadores relacionais compostos (como `<=`) foram priorizados nas regras léxicas para evitar divisões incorretas.
* **q3 (Mini-Linguagem - Entrada Padrão):** Analisador léxico que reconhece palavras reservadas (`if`, `while`, etc.), identificadores de variáveis e números, ignorando espaços em branco e comentários de linha única (`//`).
* **q4 (Mini-Linguagem - Leitura de Arquivo):** Evolução da Q3. O analisador agora recebe um arquivo de texto via argumento de linha de comando (`argv[1]`), manipula o fluxo redirecionando a variável nativa `yyin` e possui tratamento de erros para arquivos não encontrados.

## Decisões Técnicas de Arquitetura

### O Problema da Saída Intercalada

O comportamento padrão do motor do Flex (`yylex()`) ao ler da entrada padrão é reagir token por token. Se usássemos `printf` diretamente nas regras do Flex, a saída dos tokens ficaria misturada com o texto que o usuário ainda está digitando no terminal. A atividade exigia que a saída fosse gerada em um bloco único.

### A Solução: Memória de Texto (`relatorio` e `buffer_temp`)

Para as Questões 2, 3 e 4, implementamos uma arquitetura de armazenamento em memória utilizando a biblioteca `<string.h>`.

1. **`char relatorio[65536]`:**
   Atua como um grande bloco de notas invisível. Em vez de imprimir na tela imediatamente, nós adicionamos os tokens encontrados ao final desta string.

2. **`char buffer_temp[1024]`:**
   Atua como uma variável auxiliar para formatação. Em regras onde precisamos recuperar o texto exato que o usuário digitou, acessando a variável nativa `yytext`, formatamos a string antes de anexá-la ao relatório principal.

**Como funciona na prática:**

Para tokens estáticos, como palavras reservadas, usamos `strcat` diretamente:

```c
"if"    { strcat(relatorio, "IF\n"); }
```

Para tokens dinâmicos, como identificadores ou números, formatamos primeiro o conteúdo em `buffer_temp` utilizando `sprintf` e depois adicionamos o resultado ao relatório com `strcat`:

```c
[0-9]+  { sprintf(buffer_temp, "NUMBER %s\n", yytext); strcat(relatorio, buffer_temp); }
```

A função `printf("%s", relatorio);` é executada estritamente após o término do `yylex()`, garantindo a impressão final formatada e em bloco único.

## Como Compilar e Gerar as Saídas

Certifique-se de ter o `flex` e o `gcc` instalados no seu ambiente.

As Questões 1, 2 e 3 utilizam o redirecionamento nativo do Unix (`<` e `>`) para ler e gerar os arquivos `.txt` exigidos na entrega, preservando a lógica de **entrada padrão** requisitada no documento da atividade.

### 1. Navegue até a pasta da questão

Por exemplo:

```bash
cd q3
```

### 2. Gere o código C com o Flex

```bash
flex q3.l
```

### 3. Compile o programa

```bash
gcc lex.yy.c -o q3
```

### 4. Execute e gere o arquivo de saída

#### Para Q1, Q2 e Q3 — Redirecionamento de Entrada e Saída

```bash
./q3 < entrada.txt > saida.txt
```

O arquivo `entrada.txt` é utilizado como entrada padrão do programa e a saída produzida pelo analisador é direcionada para `saida.txt`.

#### Para Q4 — Arquivo por Argumento e Redirecionamento de Saída

```bash
./q4 entrada.txt > saida.txt
```

Na Questão 4, o arquivo é informado diretamente como argumento de linha de comando, enquanto a saída continua sendo redirecionada para o arquivo `saida.txt`.
