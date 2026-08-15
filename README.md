# Atividade 1 - Analisadores Léxicos com Flex

Este repositório contém as soluções para a primeira atividade prática da disciplina de Compiladores. O objetivo foi construir analisadores léxicos utilizando a ferramenta **Flex** (Fast Lexical Analyzer Generator) em conjunto com a linguagem C.

## Estrutura do Projeto

O projeto está dividido em quatro questões iterativas:

* **q1 (Estatísticas de Texto):** Um contador no estilo `wc` do Unix. Ele lê a entrada padrão e conta linhas, palavras, caracteres totais, inteiros, números de ponto flutuante e pontuações específicas.
* **q2 (Calculadora Simples):** Um analisador que classifica tokens de uma expressão matemática, reconhecendo operadores básicos, relacionais, parênteses e números. Os operadores relacionais compostos (como `<=`) foram priorizados nas regras léxicas para evitar divisões incorretas.
* **q3 (Mini-Linguagem - Entrada Padrão):** Analisador léxico que reconhece palavras reservadas (`if`, `while`, etc.), identificadores de variáveis e números, ignorando espaços em branco e comentários de linha única (`//`).
* **q4 (Mini-Linguagem - Leitura de Arquivo):** Evolução da Q3. O analisador agora recebe um arquivo de texto via argumento de linha de comando (`argv[1]`), manipula o fluxo redirecionando a variável nativa `yyin` e possui tratamento de erros para arquivos não encontrados.

## Decisões Técnicas de Arquitetura

### O Problema da Saída Intercalada
O comportamento padrão do motor do Flex (`yylex()`) ao ler da entrada padrão é reagir linha por linha (a cada `Enter`). Se usássemos `printf` diretamente nas regras do Flex, a saída dos tokens ficaria misturada com o texto que o usuário ainda está digitando no terminal. A atividade exigia que a saída fosse gerada em um bloco único após o término da entrada.

### A Solução: Memória de Texto (`relatorio` e `buffer_temp`)
Para garantir uma validação silenciosa e uma impressão em bloco apenas ao receber o sinal de Fim de Arquivo (`Ctrl+D`), implementamos uma arquitetura de armazenamento em memória utilizando a biblioteca `<string.h>` nas questões 2, 3 e 4.

1. **`char relatorio[65536]`:** 
   Atua como um grande bloco de notas invisível. Em vez de imprimir na tela, nós adicionamos os tokens encontrados no final desta string.
2. **`char buffer_temp[1024]`:** 
   Atua como uma variável auxiliar para formatação. Em regras onde precisamos recuperar o texto exato que o usuário digitou (acessando a variável nativa `yytext`), não podemos colar diretamente no relatório. 

**Como funciona na prática:**
Para tokens estáticos (como palavras reservadas), usamos o `strcat` direto:
```c
"if"    { strcat(relatorio, "IF\n"); }