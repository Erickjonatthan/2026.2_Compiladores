%{
#include "valida.tab.h"
%}

%option noyywrap

%%

[ \t\r\n]+                   {}
"true"                       { return TRUE; }
"false"                      { return FALSE; }
"null"                       { return NULL_TOK; }
-?(0|[1-9][0-9]*)(\.[0-9]+)? { return NUMBER; }
\"[^\"\n]*\"                 { return STRING; }
"{"                          { return '{'; }
"}"                          { return '}'; }
"["                          { return '['; }
"]"                          { return ']'; }
":"                          { return ':'; }
","                          { return ','; }
.                            { return yytext[0]; }

%%