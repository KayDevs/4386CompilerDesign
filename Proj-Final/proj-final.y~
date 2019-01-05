%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "symbol.h"
  int yylex();
  int yyerror(const char *p) {
    printf("%s", p);
  }
  const char *enumStrings[2] = {"int", "bool"};
  struct program_t program_main;
  %}


/*TODO: create a struct for every nonterminal*/
/*t short for type, v short for value*/

/*datatypes*/
%union {
  char *sym;
  int num;
  enum types type_u;
  struct program_t program_u;
  struct declarations_t declarations_u;
  struct statementSequence_t statementSequence_u;
  struct statement_t statement_u;
  struct assignment_t assignment_u;
  struct ifStatement_t ifStatement_u;
  struct elseClause_t elseClause_u;
  struct whileStatement_t whileStatement_u;
  struct writeInt_t writeInt_u;
  struct expression_t expression_u;
  struct simpleExpression_t simpleExpression_u;
  struct term_t term_u;
  struct factor_t factor_u;
};
			
%token <num> NUM;
%token <sym> BOOLLIT;
%token <sym> IDENT;
%token <sym> LP RP ASGN SC OP2 OP3 OP4 IF THEN ELSE BEGN END WHILE DO PROGRAM VAR AS INT BOOL WRITEINT READINT;

%type <program_u> program;
%type <declarations_u> declarations;
%type <type_u> type;
%type <statementSequence_u> statementSequence;
%type <statement_u> statement;
%type <assignment_u> assignment;
%type <ifStatement_u> ifStatement;
%type <elseClause_u> elseClause;
%type <whileStatement_u> whileStatement;
%type <writeInt_u> writeInt;
%type <expression_u> expression;
%type <simpleExpression_u> simpleExpression;
%type <term_u> term;
%type <factor_u> factor;

%start program

%% /*grammar*/
program: PROGRAM declarations BEGN statementSequence END {
  struct program_t p = {&$2, &$4};
  program_main = p;
  printf("program\n");
 }
;
declarations: VAR IDENT AS type SC declarations {
  struct declarations_t p = {$2, $4, &$6};
  $$ = p;
  printf("declarations: var %s as %s\n", $2, enumStrings[(int)$4]);
 }
| /*empty*/ {}
;
type: INT {$$ = INT_VAR_T;}
| BOOL {$$ = BOOL_VAR_T;}
;
statementSequence: statement SC statementSequence {
  struct statementSequence_t p = {&$1, &$3};
  $$ = p;
  printf("statementSequence: statement\n");
 }
| /*empty*/ {}
;
statement: assignment {
  struct statement_t p;
  p.assignment_v = &$1;
  $$ = p;
  printf("statement: assignment\n");
 }
| ifStatement {
  struct statement_t p;
  p.ifStatement_v = &$1;
  $$ = p;
  printf("statement: ifStatement\n");
  }
| whileStatement {
  struct statement_t p;
  p.whileStatement_v = &$1;
  $$ = p;
  printf("statement: whileStatement\n");
  }
| writeInt {
  struct statement_t p;
  p.writeInt_v = &$1;
  $$ = p;
  printf("statement: writeInt\n");
  }
;
assignment: IDENT ASGN expression {
  struct assignment_t p;
  p.identifier = $1;
  p.expression_v = &$3;
  printf("assignment: expression\n");
 }
| IDENT ASGN READINT {
  struct assignment_t p;
  p.identifier = $1;
  p.readInt_v = 1;
  printf("assignment: readInt\n");
 }
;
ifStatement: IF expression THEN statementSequence elseClause END {
  struct ifStatement_t p = {&$2, &$4, &$5};
  $$ = p; printf("ifStatement\n");
 }
;
elseClause: ELSE statementSequence {
  struct elseClause_t p = {&$2};
  $$ = p;
  printf("elseClause: else\n");
 }
| /*empty*/ {}
;
whileStatement: WHILE expression DO statementSequence END {
  struct whileStatement_t p = {&$2, &$4};
  $$ = p;
  printf("whileStatement\n");
 }
;
writeInt: WRITEINT expression {
  struct writeInt_t p = {&$2};
  $$ = p;
  printf("writeInt\n");
 }
;
expression: simpleExpression {
  struct expression_t p;
  p.simpleExpression_v = &$1;
  $$ = p;
  printf("expression: simpleExpression\n");
 }
| simpleExpression OP4 simpleExpression {
  struct expression_t p;
  p.op4_L = &$1;
  p.op4_R = &$3;
  $$ = p;
  printf("expression: OP4\n");
 }
;
simpleExpression: term OP3 term {
  struct simpleExpression_t p;
  p.op3_L = &$1;
  p.op3_R = &$3;
  $$ = p;
  printf("simpleExpression: OP3\n");
 }
| term {
  struct simpleExpression_t p;
  p.term_v = &$1;
  $$ = p;
  printf("simpleExpression: term\n");
  }
;
term: factor OP2 factor {
  struct term_t p;
  p.op2_L = &$1;
  p.op2_R = &$3;
  $$ = p;
  printf("term: OP2\n");
 }
| factor {
  struct term_t p;
  p.factor_v = &$1;
  $$ = p;
  printf("term: factor\n");
  }
;
factor: IDENT {
  printf("factor: IDENT: %s\n", $1);
  struct factor_t p;
  p.identifier = $1;
  $$ = p;
 }
| NUM {
  printf("factor: NUM: %d\n", $1);
  struct factor_t p;
  p.num = $1;
  $$ = p;
  }
| BOOLLIT {
  printf("factor: BOOLLIT: %s\n", $1);
  struct factor_t p;
  p.boollit = $1;
  $$ = p;
  }
| LP expression RP {
  printf("factor: expression\n");
  struct factor_t p;
  p.expression_v = &$2;
  $$ = p;
 }
;

%% /*program*/
int main() {
  yyparse();
  /*do something with program_main*/
  return 0;
}
