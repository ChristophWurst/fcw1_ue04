/*Calc.y:                                             HDO, 2006-2015
  ------
  Yacc/Bison attributed grammar for simple calculator.
====================================================================*/

%{

  #include <stdio.h>

  extern int yylineno;

  /*int yylval; holds default lexical attribute for current token   */

%}

%token CONST
%token IDENT
%token FALSE
%token TRUE
%token NUMBER
%token VOID
%token BOOL
%token INT
%token PLUSPLUS
%token MINUSMINUS
%token IF
%token ELSE
%token WHILE
%token BREAK
%token CIN
%token COUT
%token LEFTSHIFT
%token RIGHTSHIFT
%token DELETE
%token RETURN


%%

/* 1. grammatik kann kopiert werden */
/* 2. schreibweise fixen (wiederholugen…) */
/* 3. konflikte lösen */


%%

int yyerror(char *msg) {
  printf("syntac error in line %i: %s\n", yylineno, msg);
  return 0;
} /*yyerror*/

int main(int argc, char *argv[]) {
  //yydebug = 1;
  if (yyparse() == 0) {
    printf("successfully parsed %i lines\n", yylineno);
    return 0;
  } else {
    return 1;
  }
} /*main*/


/* End of Calc.y
====================================================================*/
