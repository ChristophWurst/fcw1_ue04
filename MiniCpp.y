/*Calc.y:                                             HDO, 2006-2015
  ------
  Yacc/Bison attributed grammar for simple calculator.
====================================================================*/

%{

  #include <stdio.h>

  extern int yylineno;
  int yylex();
  int yyerror(char *msg);

  /*int yylval; holds default lexical attribute for current token   */

%}

%token CONST
%token <string> IDENT
%token FALSE
%token TRUE
%token <i> NUMBER
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
%token ENDL
%token STRING
%token LEFTSHIFT
%token RIGHTSHIFT
%token DELETE
%token RETURN
%token LOGICOR
%token LOGICAND
%token NEW
%token CMPEQ
%token CMPNEQ
%token CMPLE
%token CMPGE

%union{
	char *string;
	int i;
}

%%

/* 1. grammatik kann kopiert werden */
/* 2. schreibweise fixen (wiederholugen…) */
/* 3. konflikte lösen */

MiniCpp:
	DeclDefList
	;
DeclDefList:
	DeclDef | DeclDef DeclDefList
	;
DeclDef:
	ConstDecl
	| VarDef
	| FuncDecl
	| FuncDef
	;
ConstDecl:
	CONST Type IDENT Init ';';
Init:
	'=' FALSE
	| '=' TRUE
	| '=' NUMBER
	;
VarDef:
	Type OptPtr IDENT OptVarInit VarDefRest ';'
	;
VarDefRest:
	/* EPS */
	| ',' OptPtr IDENT OptVarInit VarDefRest
	;
OptPtr:
	/* EPS */
	| '*'
	;
OptVarInit:
	/* EPS */
	| Init
	;
FuncDecl:
	FuncHead ';'
	;
FuncDef:
	FuncHead Block
	;
FuncHead:
	Type OptPtr IDENT '(' FormParList ')' { printf("%s\n", $3);  }
	;
FormParList:
	/* EPS */
	| VOID
	| Type OptPtr IDENT OptArr FormParListRest
	;
FormParListRest:
	/* EPS */
	| ',' Type OptPtr IDENT OptArr FormParListRest
	;
OptArr:
	/* EPS */
	| '[' ']'
	;
Type:
	VOID
	| BOOL
	| INT
	;
Block:
	'{' BlockStatList '}'
	;
BlockStatList:
	/* EPS */
	| BlockStat BlockStatList
	;
BlockStat:
	ConstDecl
	| VarDef
	| Stat
	;
Stat:
	IncStat
	| DecStat
	| AssignStat
	| CallStat
	| IfStat
	| WhileStat
	| BreakStat
	| InputStat
	| OutputStat
	| DeleteStat
	| ReturnStat
	| Block
	| ';'
	;
IncStat:
	IDENT PLUSPLUS ';'
	;
DecStat:
	IDENT MINUSMINUS ';'
	;
AssignStat:
	IDENT '[' Expr ']' '=' Expr ';'
	| IDENT '=' Expr ';'
	;
CallStat:
	IDENT '(' ActParList ')' ';'
	;
ActParList:
	/* EPS */
	| Expr ActParListRest
	;
ActParListRest:
	/* EPS */
	| ',' Expr ActParListRest
	;
IfStat:
	IF '(' Expr ')' Stat OptElse
	;
OptElse:
	/* EPS */
	| ELSE Stat
	;
WhileStat:
	WHILE '(' Expr ')' Stat
	;
BreakStat:
	BREAK ';'
	;
InputStat:
	CIN RIGHTSHIFT IDENT ';'
	;
OutputStat:
	COUT LEFTSHIFT OutputStatExpr OutputStatRest
	;
OutputStatExpr:
	Expr
	| STRING
	| ENDL
	;
OutputStatRest:
	/* EPS */
	| LEFTSHIFT OutputStatExpr OutputStatRest
	;
DeleteStat:
	DELETE '[' ']' IDENT ';'
	;
ReturnStat:
	RETURN ';'
	| RETURN Expr ';'
	;
Expr:
	OrExpr
	;
OrExpr:
	AndExpr OrExprRest
	;
OrExprRest:
	/* EPS */
	| LOGICOR AndExpr
	;
AndExpr:
	RelExpr AndExprRest
	;
AndExprRest:
	/* EPS */
	| LOGICAND RelExpr
	;
RelExpr:
	SimpleExpr
	| SimpleExpr RelCmp SimpleExpr
	;
RelCmp:
	CMPEQ
	| CMPNEQ
	| '<'
	| CMPLE
	| '>'
	| CMPGE
	;
SimpleExpr:
	OptSign Term SimpleExprRest
	;
SimpleExprRest:
	/* EPS */
	| Sign Term SimpleExprRest
	;
OptSign:
	/* EPS */
	| Sign
	;
Sign:
	'+'
	| '-'
	;
Term:
	NotFact TermRest
	;
TermRest:
	/* EPS */
	| '*' NotFact TermRest
	| '/' NotFact TermRest
	| '%' NotFact TermRest
	;
NotFact:
	'!' Fact
	| Fact
	;
Fact:
	FALSE
	| TRUE
	| NUMBER
	| IDENT
	| IDENT '[' Expr ']'
	| IDENT '(' ActParList ')'
	| NEW Type '[' Expr ']'
	| '(' Expr ')'
	;
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
