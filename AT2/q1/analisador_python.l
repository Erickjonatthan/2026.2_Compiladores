%{
#include <stdio.h>
#include <string.h>

int linha = 1;
%}

%option noyywrap

%x STRING_S
%x STRING_D
%x COMENTARIO

%%

[ \t\r]+                    { }
\n                          { linha++; }

"#"                         { BEGIN(COMENTARIO); }
<COMENTARIO>\n              { BEGIN(INITIAL); linha++; }
<COMENTARIO>.               { }

"'"                         { BEGIN(STRING_S); yymore(); }
<STRING_S>"'"               { BEGIN(INITIAL); printf("LINHA %d: STRING(%s)\n", linha, yytext); }
<STRING_S>\\.               { yymore(); }
<STRING_S>\n                { BEGIN(INITIAL); printf("LINHA %d: ERROR(%s)\n", linha, yytext); linha++; }
<STRING_S>.                 { yymore(); }

"\""                        { BEGIN(STRING_D); yymore(); }
<STRING_D>"\""              { BEGIN(INITIAL); printf("LINHA %d: STRING(%s)\n", linha, yytext); }
<STRING_D>\\.               { yymore(); }
<STRING_D>\n                { BEGIN(INITIAL); printf("LINHA %d: ERROR(%s)\n", linha, yytext); linha++; }
<STRING_D>.                 { yymore(); }

False                       { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
None                        { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
True                        { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
and                         { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
as                          { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
assert                      { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
async                       { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
await                       { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
break                       { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
class                       { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
continue                    { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
def                         { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
del                         { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
elif                        { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
else                        { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
except                      { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
finally                     { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
for                         { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
from                        { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
global                      { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
if                          { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
import                      { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
in                          { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
is                          { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
lambda                      { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
nonlocal                    { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
not                         { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
or                          { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
pass                        { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
raise                       { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
return                      { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
try                         { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
while                       { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
with                        { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }
yield                       { printf("LINHA %d: KEYWORD(%s)\n", linha, yytext); }

[a-zA-Z_][a-zA-Z0-9_]*      { printf("LINHA %d: IDENTIFIER(%s)\n", linha, yytext); }

[0-9]+\.[0-9]+              { printf("LINHA %d: REAL(%s)\n", linha, yytext); }
[0-9]+                      { printf("LINHA %d: INTEGER(%s)\n", linha, yytext); }

"is not"                    { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"not in"                    { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"=="                        { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"!="                        { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
">="                        { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"<="                        { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
">"                         { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"<"                         { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"//="                       { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"**="                       { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
">>="                       { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"<<="                       { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"+="                        { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"-="                        { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"*="                        { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"/="                        { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"%="                        { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"&="                        { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"|="                        { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"^="                        { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
":="                        { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"="                         { printf("LINHA %d: ASSIGN(%s)\n", linha, yytext); }
"//"                        { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"**"                        { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
">>"                        { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"<<"                        { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"+"                         { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"-"                         { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"*"                         { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"/"                         { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"%"                         { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"&"                         { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"|"                         { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"^"                         { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }
"~"                         { printf("LINHA %d: OPERATOR(%s)\n", linha, yytext); }

"("                         { printf("LINHA %d: DELIMITER(%s)\n", linha, yytext); }
")"                         { printf("LINHA %d: DELIMITER(%s)\n", linha, yytext); }
"["                         { printf("LINHA %d: DELIMITER(%s)\n", linha, yytext); }
"]"                         { printf("LINHA %d: DELIMITER(%s)\n", linha, yytext); }
"{"                         { printf("LINHA %d: DELIMITER(%s)\n", linha, yytext); }
"}"                         { printf("LINHA %d: DELIMITER(%s)\n", linha, yytext); }
","                         { printf("LINHA %d: DELIMITER(%s)\n", linha, yytext); }
":"                         { printf("LINHA %d: DELIMITER(%s)\n", linha, yytext); }
"."                         { printf("LINHA %d: DELIMITER(%s)\n", linha, yytext); }
";"                         { printf("LINHA %d: DELIMITER(%s)\n", linha, yytext); }

.                           { printf("LINHA %d: ERROR(%s)\n", linha, yytext); }

%%

int main() {
    yylex();
    return 0;
}
