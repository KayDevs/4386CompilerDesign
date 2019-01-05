#include <stdlib.h>
#include <stdio.h>

#ifndef SYMBOL_H
#define SYMBOL_H

enum types {
  INT_VAR_T,
  BOOL_VAR_T,
};


struct symrec
{
  char *name;
  enum types type; /*0 = int; 1 = bool;*/
  union {
    int integer;
    int boolean;
  } value;
  struct symrec *next; /*pointer to the next symrec*/
} *sym_table; /*standard says that file scope = 0*/

void add_symbol(enum types type, char *name, int value);

struct statementSequence_t;
struct expression_t;
struct factor_t {
  union {
    char *identifier;
    int num;
    char *boollit;
    struct expression_t *expression_v;
  };
};
struct term_t {
  union {
    struct factor_t *factor_v;
    struct {
      struct factor_t *op2_L;
      struct factor_t *op2_R;
    };
  };
};
struct simpleExpression_t {
  union {
    struct term_t *term_v;
    struct {
      struct term_t *op3_L;
      struct term_t *op3_R;
    };
  };
};
struct expression_t {
  union {
    struct simpleExpression_t *simpleExpression_v;
    struct {
      struct simpleExpression_t *op4_L;
      struct simpleExpression_t *op4_R;
    };
  };  
};
struct writeInt_t {
  struct expression_t *expression_v;
};
struct whileStatement_t {
  struct expression_t *expression_v;
  struct statementSequence_t *statementSequence_v;
};
struct elseClause_t {
  struct statementSequence_t *statementSequence_v;
};
struct ifStatement_t {
  struct expression_t *expression_v;
  struct statementSequence_t *statementSequence_v;
  struct elseClause_t *elseClause_v;
};
struct assignment_t {
  char *identifier;
  union {
    int readInt_v; /*to be fed via stdin*/
    struct expression_t *expression_v;
  };
};
struct statement_t {
  union {
    struct assignment_t *assignment_v;
    struct ifStatement_t *ifStatement_v;
    struct whileStatement_t *whileStatement_v;
    struct writeInt_t *writeInt_v;
  };
};
struct statementSequence_t {
  struct statement_t *statement_v;
  struct statementSequence_t *satementSequence_v; /*next ptr*/
};
struct declarations_t {
  char *identifier;
  enum types type;
  struct declarations_t *declarations_v; /*next ptr*/
};
struct program_t {
  struct declarations_t *declarations_v;
  struct statementSequence_t *statementSequence_v;
};

#endif
