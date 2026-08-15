%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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
    if (argc < 2) {
        printf("Erro: Nome do arquivo de entrada nao fornecido.\n");
        return 1;
    }

    FILE *arquivo = fopen(argv[1], "r");
    if (!arquivo) {
        printf("Erro: Nao foi possivel abrir o arquivo '%s'.\n", argv[1]);
        return 1;
    }

    FILE *saida = fopen("saida.txt", "w");
    if (!saida) {
        printf("Erro: Nao foi possivel criar o arquivo de saida.\n");
        fclose(arquivo);
        return 1;
    }

    yyin = arquivo;
    yylex();
    
    fprintf(saida, "%s", relatorio);
    
    fclose(arquivo);
    fclose(saida);

    return 0;
}