%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int linha = 1;
%}

%option noyywrap

%x STRING_S
%x STRING_D
%x COMENTARIO
%x COMENTARIO_BLOCO

%%

[ \t\r]+                    { }
\n                          { linha++; }

"{---"                      { BEGIN(COMENTARIO_BLOCO); }
<COMENTARIO_BLOCO>"---}"    { BEGIN(INITIAL); }
<COMENTARIO_BLOCO>\n        { linha++; }
<COMENTARIO_BLOCO>.         { }

"#"                         { BEGIN(COMENTARIO); }
<COMENTARIO>\n              { BEGIN(INITIAL); linha++; }
<COMENTARIO>.               { }

"’"                         { BEGIN(STRING_S); yymore(); }
"'"                         { BEGIN(STRING_S); yymore(); }
<STRING_S>"’"               { BEGIN(INITIAL); printf("LINHA %d: STRING(%s)\n", linha, yytext); }
<STRING_S>"'"               { BEGIN(INITIAL); printf("LINHA %d: STRING(%s)\n", linha, yytext); }
<STRING_S>\\.               { yymore(); }
<STRING_S>\n                { BEGIN(INITIAL); printf("LINHA %d: ERROR(%s)\n", linha, yytext); linha++; }
<STRING_S>.                 { yymore(); }

"\""                        { BEGIN(STRING_D); yymore(); }
<STRING_D>"\""              { BEGIN(INITIAL); printf("LINHA %d: STRING(%s)\n", linha, yytext); }
<STRING_D>\\.               { yymore(); }
<STRING_D>\n                { BEGIN(INITIAL); printf("LINHA %d: ERROR(%s)\n", linha, yytext); linha++; }
<STRING_D>.                 { yymore(); }

"inicio"                    { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
"fim"                       { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
"inteiro"                   { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
"real"                      { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
"texto"                     { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
"booleano"                  { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
"se"                        { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
"faz"                       { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
"senao"                     { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
"repita_enquanto"           { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
"repita"                    { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
"enquanto"                  { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
"para"                      { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
"de"                        { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
"ate"                       { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
"faca"                      { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
"leia"                      { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
"mostre"                    { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
"sim"                       { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
"nao"                       { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
"retorne"                   { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
"funcao"                    { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }

[a-zA-Z_][a-zA-Z0-9_]*      { printf("LINHA %d: IDENTIFIER(%s)\n", linha, yytext); }

[0-9]+,[0-9]+               { printf("LINHA %d: REAL(%s)\n", linha, yytext); }
[0-9]+                      { printf("LINHA %d: INTEGER(%s)\n", linha, yytext); }

"=="                        { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"!="                        { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"<="                        { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
">="                        { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"&&"                        { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"||"                        { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"<"                         { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
">"                         { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"!"                         { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"+"                         { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"-"                         { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"*"                         { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"/"                         { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"%"                         { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"="                         { printf("LINHA %d: ASSIGN(%s)\n", linha, yytext); }

"("                         { printf("LINHA %d: DELIMITER(%s)\n", linha, yytext); }
")"                         { printf("LINHA %d: DELIMITER(%s)\n", linha, yytext); }
"["                         { printf("LINHA %d: DELIMITER(%s)\n", linha, yytext); }
"]"                         { printf("LINHA %d: DELIMITER(%s)\n", linha, yytext); }
"{"                         { printf("LINHA %d: DELIMITER(%s)\n", linha, yytext); }
"}"                         { printf("LINHA %d: DELIMITER(%s)\n", linha, yytext); }
";"                         { printf("LINHA %d: DELIMITER(%s)\n", linha, yytext); }
"$"                         { printf("LINHA %d: DELIMITER(%s)\n", linha, yytext); }

.                           { printf("LINHA %d: ERROR(%s)\n", linha, yytext); }

%%

int main() {
    char entrada[20];
    char saida[20];

    for (int i = 1; i <= 5; i++) {
        // para pegar o 5 exemplos personalizados, bastas tirar o -atv
        sprintf(entrada, "entrada%d-atv.txt", i);
        sprintf(saida, "saida-atv%d.txt", i);

        FILE *arquivo_entrada = fopen(entrada, "r");
        FILE *arquivo_saida = fopen(saida, "w");

        if (arquivo_entrada == NULL) {
            printf("Erro ao abrir %s\n", entrada);
            continue;
        }

        if (arquivo_saida == NULL) {
            printf("Erro ao criar %s\n", saida);
            fclose(arquivo_entrada);
            continue;
        }

        linha = 1;

        yyin = arquivo_entrada;
        stdout = arquivo_saida;

        yylex();

        fclose(arquivo_entrada);
        fclose(arquivo_saida);
    }

    return 0;
}
