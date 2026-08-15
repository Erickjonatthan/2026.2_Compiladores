%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char relatorio[65536] = "";
char buffer_temp[1024];
%}

%option noyywrap

%%

"if"                    { strcat(relatorio, "IF\n"); }
"else"                  { strcat(relatorio, "ELSE\n"); }
"while"                 { strcat(relatorio, "WHILE\n"); }
"return"                { strcat(relatorio, "RETURN\n"); }

[a-zA-Z_][a-zA-Z0-9_]*  { sprintf(buffer_temp, "ID %s\n", yytext); strcat(relatorio, buffer_temp); }

[0-9]+\.[0-9]+          { sprintf(buffer_temp, "NUMBER %s\n", yytext); strcat(relatorio, buffer_temp); }
[0-9]+                  { sprintf(buffer_temp, "NUMBER %s\n", yytext); strcat(relatorio, buffer_temp); }

"//".*                  {}

[ \t\n]+                {}

.                       { sprintf(buffer_temp, "SIMBOLO %s\n", yytext); strcat(relatorio, buffer_temp); }

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
    
    fprintf(saida, "%s", relatorio);
    
    fclose(yyin);
    fclose(saida);
    
    return 0;
}