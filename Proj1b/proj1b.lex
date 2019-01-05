%{
#include <stdio.h>
#include <stdlib.h>
  /*symbol table*/
#define NUM 0
#define BOOLLIT 1
#define IDENT 2
#define LP 3
#define RP 4
#define ASGN 5
#define SC 6
#define OP2 7
#define OP3 8
#define OP4 9
#define IF 10
#define THEN 11
#define ELSE 12
#define BEGN 13
#define END 14
#define WHILE 15
#define DO 16
#define PROGRAM 17
#define VAR 18
#define AS 19
#define INT 20
#define BOOL 21
#define READINT 22
#define WRITEINT 23
  float yylval;
  char *yytext;
%}

num [1-9][0-9]*|0
boollit false|true
ident [A-Z][A-Z0-9]*

%%
num {return NUM;}
boollit {return BOOLLIT;}
ident {return IDENT;}
"(" {return LP;}
")" {return RP;}
":=" {return ASGN;}
";" {return SC;}
"*"|"div"|"mod" {return OP2;}
"+"|"-" {return OP3;}
"="|"!="|"<"|">"|"<="|">=" {return OP4;}
"if" {return IF;}
"then" {return THEN;}
"else" {return ELSE;}
"begin" {return BEGN;}
"end" {return END;}
"while" {return WHILE;}
"do" {return DO;}
"program" {return PROGRAM;}
"var" {return VAR;}
"as" {return AS;}
"int" {return INT;}
"bool" {return BOOL;}
"writeInt" {return WRITEINT;}
"readInt" {return READINT;}

%%
/*user code*/
int yywrap() {
  return 1;
}
int main(int argc, char **argv) {
  int ret = 1;
  while(ret != 0) {
    ret = yylex();
    printf("ret = %d, yylval = %f\n", ret, yylval);
  }
  return 0;
}
