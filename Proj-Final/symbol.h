#include <stdlib.h>
#include <stdio.h>
#include <string.h>

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
};

void add_symbol(enum types type, char *name);
int set_symbol(char *name, int value);
int symbol_exists(char *name);

struct statementSequence_t;
struct expression_t;
struct factor_t {
  int factor_type;
  union {
    char *identifier;
    int num;
    char *boollit;
    struct expression_t *expression_v;
  };
};
struct term_t {
  int term_type;
  union {
    struct factor_t *factor_v;
    struct {
      char *op2;
      struct factor_t *op2_L;
      struct factor_t *op2_R;
    };
  };
};
struct simpleExpression_t {
  int simpleExpression_type;
  union {
    struct term_t *term_v;
    struct {
      char *op3;
      struct term_t *op3_L;
      struct term_t *op3_R;
    };
  };
};
struct expression_t {
  int expression_type;
  union {
    struct simpleExpression_t *simpleExpression_v;
    struct {
      char *op4;
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
  int assignment_type;
  union {
    int readInt_v; /*to be fed via stdin*/
    struct expression_t *expression_v;
  };
};
struct statement_t {
  int statement_type;
  union {
    struct assignment_t *assignment_v;
    struct ifStatement_t *ifStatement_v;
    struct whileStatement_t *whileStatement_v;
    struct writeInt_t *writeInt_v;
  };
};
struct statementSequence_t {
  struct statement_t *statement_v;
  struct statementSequence_t *statementSequence_v; /*next ptr*/
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
