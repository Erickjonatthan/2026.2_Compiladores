%{
#include "calc.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%option noyywrap

%%

[ \t\r]+                {}
\n                      { return '\n'; }
"printar_variaveis"     { return PRINT_VARS; }
">>>"                   { return ASSIGN; }
[0-9]+(\.[0-9]+)?       { yylval.val = atof(yytext); return NUM; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.name = strdup(yytext); return ID; }
"+"                     { return '+'; }
"-"                     { return '-'; }
"*"                     { return '*'; }
"/"                     { return '/'; }
"**"                    { return POW; }
"("                     { return '('; }
")"                     { return ')'; }
.                       {}

%%