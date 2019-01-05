%{
#include <stdio.h>
int yylex();
int yyerror(const char *p) {
    printf("%s", p);
}
%}

/*the only two datatypes we need*/
%union {
  int num;
  char *sym;
}

%token <num> NUM;
%token <sym> BOOLLIT IDENT LP RP ASGN SC OP2 OP3 OP4 IF THEN ELSE BEGN END WHILE DO PROGRAM VAR AS INT BOOL WRITEINT READINT;

%type <num> numtoken;
%type <sym> symtoken;
%start start;

%% /*grammar*/
start: /*empty*/ | numtoken start | symtoken start;
numtoken: NUM {printf("number: %d\n", $1); $$ = $1;}
symtoken: BOOLLIT {printf("symbol: %s\n", $1); $$ = $1;}
| IDENT {printf("symbol: %s\n", $1); $$ = $1;}
| LP {printf("symbol: %s\n", $1); $$ = $1;}
| RP {printf("symbol: %s\n", $1); $$ = $1;}
| ASGN {printf("symbol: %s\n", $1); $$ = $1;}
| SC {printf("symbol: %s\n", $1); $$ = $1;}
| OP2 {printf("symbol: %s\n", $1); $$ = $1;}
| OP3 {printf("symbol: %s\n", $1); $$ = $1;}
| OP4 {printf("symbol: %s\n", $1); $$ = $1;}
| IF {printf("symbol: %s\n", $1); $$ = $1;}
| THEN {printf("symbol: %s\n", $1); $$ = $1;}
| ELSE {printf("symbol: %s\n", $1); $$ = $1;}
| BEGN {printf("symbol: %s\n", $1); $$ = $1;}
| END {printf("symbol: %s\n", $1); $$ = $1;}
| WHILE {printf("symbol: %s\n", $1); $$ = $1;}
| DO {printf("symbol: %s\n", $1); $$ = $1;}
| PROGRAM {printf("symbol: %s\n", $1); $$ = $1;}
| VAR {printf("symbol: %s\n", $1); $$ = $1;}
| AS {printf("symbol: %s\n", $1); $$ = $1;}
| INT {printf("symbol: %s\n", $1); $$ = $1;}
| BOOL {printf("symbol: %s\n", $1); $$ = $1;}
| WRITEINT {printf("symbol: %s\n", $1); $$ = $1;}
| READINT {printf("symbol: %s\n", $1); $$ = $1;}


%% /*program*/
int main() {
    yyparse();
    return 0;
}
