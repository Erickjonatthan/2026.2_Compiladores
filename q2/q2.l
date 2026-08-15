%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char relatorio[65536] = "";
char buffer_temp[1024];
%}

%option noyywrap

%%

"<="      { strcat(relatorio, "REL_OP <=\n"); }
">="      { strcat(relatorio, "REL_OP >=\n"); }
"=="      { strcat(relatorio, "REL_OP ==\n"); }
"!="      { strcat(relatorio, "REL_OP !=\n"); }
"<"       { strcat(relatorio, "REL_OP <\n"); }
">"       { strcat(relatorio, "REL_OP >\n"); }

"+"       { strcat(relatorio, "PLUS\n"); }
"-"       { strcat(relatorio, "MINUS\n"); }
"*"       { strcat(relatorio, "TIMES\n"); }
"/"       { strcat(relatorio, "DIVIDE\n"); }
"|"       { strcat(relatorio, "ABS\n"); }
"%"       { strcat(relatorio, "MOD\n"); }
"^"       { strcat(relatorio, "POWER\n"); }

"("       { strcat(relatorio, "LPAREN\n"); }
")"       { strcat(relatorio, "RPAREN\n"); }

[0-9]+    { sprintf(buffer_temp, "NUMBER %s\n", yytext); strcat(relatorio, buffer_temp); }

\n        { strcat(relatorio, "NEWLINE\n"); }

[ \t]+    {}

.         { sprintf(buffer_temp, "Mystery character %s\n", yytext); strcat(relatorio, buffer_temp); }

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