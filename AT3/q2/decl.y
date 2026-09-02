%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern FILE *yyin;
int yylex(void);
void yyerror(const char *s);

char *declared_vars[100];
int var_count = 0;
char current_type[20];

void declare_var(char *name) {
    for(int i = 0; i < var_count; i++) {
        if(strcmp(declared_vars[i], name) == 0) {
            printf("erro: %s já foi declarada\n", name);
            free(name);
            return;
        }
    }
    declared_vars[var_count++] = name;
    printf("%s %s\n", current_type, name);
}
%}

%union {
    char *str;
}

%token <str> TYPE ID

%%

program:
    decl_list
    ;

decl_list:
    
    | decl_list decl
    ;

decl:
    TYPE { strcpy(current_type, $1); free($1); } id_list ';'
    ;

id_list:
    ID { declare_var($1); }
    | id_list ',' ID { declare_var($3); }
    ;

%%

void yyerror(const char *s) {
}

int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
    }
    yyparse();
    if (yyin) fclose(yyin);
    printf("+++++ %d variáveis declaradas\n", var_count);
    return 0;
}