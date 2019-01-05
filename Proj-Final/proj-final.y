%{
#include <stdlib.h>
#include <assert.h>
#include <stdio.h>
#include <string.h>
#include "symbol.h"
  int yylex();
  int yyerror(const char *p) {
    printf("%s", p);
  }
  const char *enumStrings[2] = {"int", "bool"};
  struct program_t *program_main;
  %}


/*TODO: create a struct for every nonterminal*/
/*t short for type, v short for value*/

/*datatypes*/
%union {
  char *sym;
  int num;
  enum types type_u;
  struct program_t *program_u;
  struct declarations_t *declarations_u;
  struct statementSequence_t *statementSequence_u;
  struct statement_t *statement_u;
  struct assignment_t *assignment_u;
  struct ifStatement_t *ifStatement_u;
  struct elseClause_t *elseClause_u;
  struct whileStatement_t *whileStatement_u;
  struct writeInt_t *writeInt_u;
  struct expression_t *expression_u;
  struct simpleExpression_t *simpleExpression_u;
  struct term_t *term_u;
  struct factor_t *factor_u;
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
  struct program_t *p = malloc(sizeof(struct program_t));
  p->declarations_v = $2;
  p->statementSequence_v = $4;
  program_main = p;
  printf("program\n");
 }
;
declarations: VAR IDENT AS type SC declarations {
  struct declarations_t *p = malloc(sizeof(struct declarations_t));
  p->identifier = strdup($2);
  p->type = $4;
  p->declarations_v = $6;
  $$ = p;
  printf("declarations: var %s as %s\n", p->identifier, enumStrings[(int)p->type]);
 }
| /*empty*/ {$$ = NULL;}
;
type: INT {$$ = INT_VAR_T;}
| BOOL {$$ = BOOL_VAR_T;}
;
statementSequence: statement SC statementSequence {
  struct statementSequence_t *p = malloc(sizeof(struct statementSequence_t));
  p->statement_v = $1;
  p->statementSequence_v = $3;
  $$ = p;
  printf("statementSequence: statement\n");
 }
| /*empty*/ {$$ = NULL;}
;
statement: assignment {
  struct statement_t *p = malloc(sizeof(struct statement_t));
  p->statement_type = 0;
  p->assignment_v = $1;
  $$ = p;
  printf("statement: assignment\n");
 }
| ifStatement {
  struct statement_t *p = malloc(sizeof(struct statement_t));
  p->statement_type = 1;
  p->ifStatement_v = $1;
  $$ = p;
  printf("statement: ifStatement\n");
  }
| whileStatement {
  struct statement_t *p = malloc(sizeof(struct statement_t));
  p->statement_type = 2;
  p->whileStatement_v = $1;
  $$ = p;
  printf("statement: whileStatement\n");
  }
| writeInt {
  struct statement_t *p = malloc(sizeof(struct statement_t));
  p->statement_type = 3;
  p->writeInt_v = $1;
  $$ = p;
  printf("statement: writeInt\n");
  }
;
assignment: IDENT ASGN expression {
  struct assignment_t *p = malloc(sizeof(struct assignment_t));
  p->assignment_type = 0;
  p->identifier = strdup($1);
  p->expression_v = $3;
  $$ = p;
  printf("assignment: expression\n");
 }
| IDENT ASGN READINT {
  struct assignment_t *p = malloc(sizeof(struct assignment_t));
  p->assignment_type = 1;
  p->identifier = $1;
  p->readInt_v = 1;
  $$ = p;
  printf("assignment: readInt\n");
 }
;
ifStatement: IF expression THEN statementSequence elseClause END {
  struct ifStatement_t *p = malloc(sizeof(struct ifStatement_t));
  p->expression_v = $2;
  p->statementSequence_v = $4;
  p->elseClause_v = $5;
  $$ = p;
  printf("ifStatement\n");
 }
;
elseClause: ELSE statementSequence {
  struct elseClause_t *p = malloc(sizeof(struct elseClause_t));
  p->statementSequence_v = $2;
  $$ = p;
  printf("elseClause: else\n");
 }
| /*empty*/ {$$ = NULL;}
;
whileStatement: WHILE expression DO statementSequence END {
  struct whileStatement_t *p = malloc(sizeof(struct whileStatement_t));
  p->expression_v = $2;
  p->statementSequence_v = $4;
  $$ = p;
  printf("whileStatement\n");
 }
;
writeInt: WRITEINT expression {
  struct writeInt_t *p = malloc(sizeof(struct writeInt_t));
  p->expression_v = $2;
  $$ = p;
  printf("writeInt\n");
 }
;
expression: simpleExpression {
  struct expression_t *p = malloc(sizeof(struct expression_t));
  p->expression_type = 0;
  p->simpleExpression_v = $1;
  $$ = p;
  printf("expression: simpleExpression\n");
 }
| simpleExpression OP4 simpleExpression {
  struct expression_t *p = malloc(sizeof(struct expression_t));
  p->expression_type = 1;
  p->op4 = strdup($2);
  p->op4_L = $1;
  p->op4_R = $3;
  $$ = p;
  printf("expression: OP4\n");
 }
;
simpleExpression: term OP3 term {
  struct simpleExpression_t *p = malloc(sizeof(struct simpleExpression_t));
  p->simpleExpression_type = 1;
  p->op3 = strdup($2);
  p->op3_L = $1;
  p->op3_R = $3;
  $$ = p;
  printf("simpleExpression: OP3\n");
 }
| term {
  struct simpleExpression_t *p = malloc(sizeof(struct simpleExpression_t));
  p->simpleExpression_type = 0;
  p->term_v = $1;
  $$ = p;
  printf("simpleExpression: term\n");
  }
;
term: factor OP2 factor {
  struct term_t *p = malloc(sizeof(struct term_t));
  p->term_type = 1;
  p->op2 = strdup($2);
  p->op2_L = $1;
  p->op2_R = $3;
  $$ = p;
  printf("term: OP2\n");
 }
| factor {
  struct term_t *p = malloc(sizeof(struct term_t));
  p->term_type = 0;
  p->factor_v = $1;
  $$ = p;
  printf("term: factor\n");
  }
;
factor: IDENT {
  printf("factor: IDENT: %s\n", $1);
  struct factor_t *p = malloc(sizeof(struct factor_t));
  p->factor_type = 0;
  p->identifier = strdup($1);
  $$ = p;
 }
| NUM {
  printf("factor: NUM: %d\n", $1);
  struct factor_t *p = malloc(sizeof(struct factor_t));
  p->factor_type = 1;
  p->num = $1;
  $$ = p;
  }
| BOOLLIT {
  printf("factor: BOOLLIT: %s\n", $1);
  struct factor_t *p = malloc(sizeof(struct factor_t));
  p->factor_type = 2;
  p->boollit = strdup($1);
  $$ = p;
  }
| LP expression RP {
  printf("factor: expression\n");
  struct factor_t *p = malloc(sizeof(struct factor_t));
  p->factor_type = 3;
  p->expression_v = $2;
  $$ = p;
 }
;

%% /*program*/

void fprintExpression(FILE *yyout, struct expression_t *expr);
void fprintFactor(FILE *yyout, struct factor_t *fct) {
  if(fct->factor_type == 0) {
    fprintf(yyout, "%s", fct->identifier);
  } else if(fct->factor_type == 1) {
    fprintf(yyout, "%d", fct->num);
  } else if(fct->factor_type == 2) {
    fprintf(yyout, "%s", fct->boollit);
  } else if(fct->factor_type == 3) {
    fprintf(yyout, "(");
    fprintExpression(yyout, fct->expression_v);
    fprintf(yyout, ")");
  }
}
void fprintTerm(FILE *yyout, struct term_t *trm) {
  if(trm->term_type == 0) {
    //factor
    fprintFactor(yyout, trm->factor_v);
  } else {
    //op2
    fprintFactor(yyout, trm->op2_L);
    fprintf(yyout, "%s", trm->op2);
    fprintFactor(yyout, trm->op2_R);
  }
}
void fprintSimpleExpression(FILE *yyout, struct simpleExpression_t *sexp) {
  if(sexp->simpleExpression_type == 0) {
    //term
    fprintTerm(yyout, sexp->term_v);
  } else {
    //op3
    fprintTerm(yyout, sexp->op3_L);
    fprintf(yyout, "%s", sexp->op3);
    fprintTerm(yyout, sexp->op3_R);
  }
}
void fprintExpression(FILE *yyout, struct expression_t *expr) {
  if(expr->expression_type == 0) {
    //simpleExpression
    fprintSimpleExpression(yyout, expr->simpleExpression_v);
  } else if (expr->expression_type == 1) {
    //op4
    fprintSimpleExpression(yyout, expr->op4_L);
    fprintf(yyout, "%s", expr->op4);
    fprintSimpleExpression(yyout, expr->op4_R);
  }
}

/*void fprintStatementSequence(FILE *yyout, struct statementSequence_t *stmtseq);*/
void fprintStatementSequence(FILE *yyout, struct statementSequence_t *stmtseq) {
  while(stmtseq != NULL) {
    if(stmtseq->statement_v->statement_type == 0) {
      //assignment
      struct assignment_t *assign = stmtseq->statement_v->assignment_v;
      printf("assigning to %s\n", assign->identifier);
      if(assign->assignment_type == 1) {
	//readInt
	fprintf(yyout, "{int i; scanf(\"%%d\", &i);");
	fprintf(yyout, "%s = i;}\n", assign->identifier);
      } else {
	//expression
	fprintf(yyout, "%s = ", assign->identifier);
	fprintExpression(yyout, assign->expression_v);
	fprintf(yyout, ";\n");
      }
    } else if(stmtseq->statement_v->statement_type == 1) {
      //ifStatement
      struct ifStatement_t *ifst = stmtseq->statement_v->ifStatement_v;
      fprintf(yyout, "if(");
      fprintExpression(yyout, ifst->expression_v);
      fprintf(yyout, ") {\n");
      fprintStatementSequence(yyout, ifst->statementSequence_v);
      fprintf(yyout, "} else {\n");
      if(ifst->elseClause_v) {
	fprintStatementSequence(yyout, ifst->elseClause_v->statementSequence_v);
      }
      fprintf(yyout, "}\n");
    } else if(stmtseq->statement_v->statement_type == 2) {
      //whileStatement
      struct whileStatement_t *whst = stmtseq->statement_v->whileStatement_v;
      fprintf(yyout, "while(");
      fprintExpression(yyout, whst->expression_v);
      fprintf(yyout, ") {\n");
      fprintStatementSequence(yyout, whst->statementSequence_v);
      fprintf(yyout, "}\n");
    } else if(stmtseq->statement_v->statement_type == 3) {
      //writeInt
      struct writeInt_t *wrt = stmtseq->statement_v->writeInt_v;
      fprintf(yyout, "printf(\"%%d\\n\", ");
      fprintExpression(yyout, wrt->expression_v);
      fprintf(yyout, ");\n");
    }
    stmtseq = stmtseq->statementSequence_v;
  }
}

int main(int argc, char **argv) {
  /*a.out in-file out-file*/
  if(argc < 3) {
    printf("Please specify input and output file.\n");
    return 1;
  }
  if (argc < 2) {
    printf("Please specify output file.\n");
    return 1;
  }
  FILE *yyout = fopen(argv[2], "w");
  extern FILE *yyin;
  yyin = fopen(argv[1], "r");
  yyparse();
  /*do something with program_main*/
  fprintf(yyout, "#include <stdio.h>\n");
  fprintf(yyout, "#include <stdbool.h>\n");
  fprintf(yyout, "int main() {\n");
  /*step through declarations*/
  printf("walking declarations...\n");
  struct declarations_t *decl = program_main->declarations_v;
  while(decl != NULL) {
    if(symbol_exists(decl->identifier)) {
      /* ERROR 1 */
      printf("syntax error! duplicate variable: %s\n", decl->identifier);
      return 1;
    } else {
      add_symbol(decl->type, decl->identifier);
      if(decl->type == INT_VAR_T) {
	fprintf(yyout, "int %s;\n", decl->identifier);
      } else {
	fprintf(yyout, "bool %s;\n", decl->identifier);
      }
    }
    decl = decl->declarations_v;
  }
  /*step through statementSequence*/
  printf("walking statementSequence...\n");
  struct statementSequence_t *stmtseq = program_main->statementSequence_v;
  fprintStatementSequence(yyout, stmtseq);
  fprintf(yyout, "return 0;\n");
  fprintf(yyout, "}\n");
  fclose(yyin);
  fclose(yyout);
  return 0;
}
