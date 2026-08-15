%{
#include <stdio.h>

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
    yylex();
    
    printf("linhas: %d\n", linhas);
    printf("palavras: %d\n", palavras);
    printf("caracteres: %d\n", caracteres);
    printf("inteiros: %d\n", inteiros);
    printf("floats: %d\n", floats);
    printf("pontuacoes: %d\n", pontuacoes);
    
    return 0;
}