%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

extern FILE *yyin;
int yylex(void);
void yyerror(const char *s);

struct {
    char *name;
    double val;
} symtab[100];
int sym_count = 0;

void set_val(char *name, double val) {
    for(int i = 0; i < sym_count; i++) {
        if(strcmp(symtab[i].name, name) == 0) {
            symtab[i].val = val;
            free(name);
            return;
        }
    }
    symtab[sym_count].name = name;
    symtab[sym_count].val = val;
    sym_count++;
}

double get_val(char *name) {
    for(int i = 0; i < sym_count; i++) {
        if(strcmp(symtab[i].name, name) == 0) {
            free(name);
            return symtab[i].val;
        }
    }
    free(name);
    return 0;
}

void print_vars() {
    for(int i = 0; i < sym_count; i++) {
        printf("%s >>> %g\n", symtab[i].name, symtab[i].val);
    }
}
%}

%union {
    double val;
    char *name;
}

%token <val> NUM
%token <name> ID
%token ASSIGN PRINT_VARS POW

%type <val> expr

%right POW
%left '+' '-'
%left '*' '/'
%precedence UMINUS

%%

program:
    input
    ;

input:
    
    | input line
    ;

line:
    '\n'
    | stmt '\n'
    ;

stmt:
    ID ASSIGN expr { set_val($1, $3); }
    | expr { printf("= %g\n", $1); }
    | PRINT_VARS { print_vars(); }
    ;

expr:
    NUM { $$ = $1; }
    | ID { $$ = get_val($1); }
    | expr '+' expr { $$ = $1 + $3; }
    | expr '-' expr { $$ = $1 - $3; }
    | expr '*' expr { $$ = $1 * $3; }
    | expr '/' expr { $$ = $1 / $3; }
    | expr POW expr { $$ = pow($1, $3); }
    | '-' expr %prec UMINUS { $$ = -$2; }
    | '(' expr ')' { $$ = $2; }
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
    return 0;
}