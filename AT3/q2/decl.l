%{
#include "decl.tab.h"
#include <string.h>
%}

%option noyywrap

%%

[ \t\r\n]+              {}
"int"|"double"|"char"   { yylval.str = strdup(yytext); return TYPE; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.str = strdup(yytext); return ID; }
","                     { return ','; }
";"                     { return ';'; }
.                       {}

%%