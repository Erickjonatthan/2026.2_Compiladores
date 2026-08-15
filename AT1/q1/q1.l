%{
#include <stdio.h>
#include <stdlib.h>

int linhas = 1;
int palavras = 0;
int caracteres = 1;
int inteiros = 0;
int floats = 0;
int pontuacoes = 0;
%}

%option noyywrap

%%

[0-9]+\.[0-9]+  { floats++; caracteres += yyleng; }
[0-9]+          { inteiros++; caracteres += yyleng; }
[a-zA-Z]+       { palavras++; caracteres += yyleng; }
[.,;:!?]        { pontuacoes++; caracteres += yyleng; }
\n              { linhas++; caracteres++; }
.               { caracteres++; }

%%

int main(int argc, char **argv)
{
    yyin = fopen("entrada.txt", "r");
    if (!yyin) {
        return 1;
    }

    FILE *saida = fopen("saida.txt", "w");
    if (!saida) {
        fclose(yyin);
        return 1;
    }

    yylex();
    
    fprintf(saida, "linhas: %d\n", linhas);
    fprintf(saida, "palavras: %d\n", palavras);
    fprintf(saida, "caracteres: %d\n", caracteres);
    fprintf(saida, "inteiros: %d\n", inteiros);
    fprintf(saida, "floats: %d\n", floats);
    fprintf(saida, "pontuacoes: %d\n", pontuacoes);
    
    fclose(yyin);
    fclose(saida);
    
    return 0;
}