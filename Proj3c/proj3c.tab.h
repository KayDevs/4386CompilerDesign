/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_PROJ3C_TAB_H_INCLUDED
# define YY_YY_PROJ3C_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    NUM = 258,
    BOOLLIT = 259,
    IDENT = 260,
    LP = 261,
    RP = 262,
    ASGN = 263,
    SC = 264,
    OP2 = 265,
    OP3 = 266,
    OP4 = 267,
    IF = 268,
    THEN = 269,
    ELSE = 270,
    BEGN = 271,
    END = 272,
    WHILE = 273,
    DO = 274,
    PROGRAM = 275,
    VAR = 276,
    AS = 277,
    INT = 278,
    BOOL = 279,
    WRITEINT = 280,
    READINT = 281
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 19 "proj3c.y" /* yacc.c:1909  */

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

#line 100 "proj3c.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PROJ3C_TAB_H_INCLUDED  */
