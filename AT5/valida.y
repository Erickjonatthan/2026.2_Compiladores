%{
#include <stdio.h>
#include <stdlib.h>

extern FILE *yyin;
int yylex(void);
void yyerror(const char *s);
%}

%token STRING NUMBER TRUE FALSE NULL_TOK

%%

program:
    value
    ;

value:
    STRING
    | NUMBER
    | TRUE
    | FALSE
    | NULL_TOK
    | object
    | array
    ;

object:
    '{' '}'
    | '{' pairs '}'
    ;

pairs:
    pair
    | pairs ',' pair
    ;

pair:
    STRING ':' value
    ;

array:
    '[' ']'
    | '[' elements ']'
    ;

elements:
    value
    | elements ',' value
    ;

%%

void yyerror(const char *s) {
}

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            printf("JSON COM ERRO\n");
            return 1;
        }
        yyin = file;
    } else {
        printf("JSON COM ERRO\n");
        return 1;
    }

    if (yyparse() == 0) {
        printf("JSON OK\n");
    } else {
        printf("JSON COM ERRO\n");
    }

    if (yyin) {
        fclose(yyin);
    }
    
    return 0;
}