%code top{
#include <stdio.h>
#include "scanner.h"
}
%code provides{
void yyerror(const char *);

extern int yynerrs;
extern int yylexerrs;
}
%defines "parser.h"
%output "parser.c"
//%define noinput
//%define nounput
%define api.value.type {char *}
%define parse.error verbose

%token FDT ASIGNACION CONSTANTE PROGRAMA VARIABLES DEFINIR CODIGO LEER ESCRIBIR FIN IDENTIFICADOR
%left '+' '-'
%left '*' '/'
%precedence NEGATIVO

%%

todo			: programa	{ if (yynerrs || yylexerrs) YYABORT;}
			;
programa		: PROGRAMA VARIABLES listaVariables CODIGO listaSentencias FIN
			;
listaVariables		: listaVariables variable
			| /*epsilon*/
			;
variable		: DEFINIR IDENTIFICADOR '.' 			{printf("\ndefinir %s", $IDENTIFICADOR);}
			| error '.'
			;
listaSentencias		: listaSentencias sentencia
			| sentencia
			;
sentencia		: LEER '(' listaIdentificadores ')' '.' 	{printf("\nleer");}
			| IDENTIFICADOR ASIGNACION expresion '.' 	{printf("\nasignación");}
			| ESCRIBIR '(' listaExpresiones ')' '.'  	{printf("\nescribir");}
			| error '.'
			;
listaIdentificadores 	: listaIdentificadores ',' IDENTIFICADOR 
			| IDENTIFICADOR
			;
listaExpresiones	: listaExpresiones ',' expresion
			| expresion
			;
expresion		: expresion '+' expresion  			{printf("\nsuma");}
			| expresion '-' expresion			{printf("\nresta");}
			| expresion '*' expresion  			{printf("\nmultiplicación");}
			| expresion '/' expresion  			{printf("\ndivisión");}
			| '-' expresion %prec NEGATIVO  		{printf("\ninversión");}
			| '(' expresion ')'				{printf("\nparéntesis");}
			| IDENTIFICADOR
			| CONSTANTE
			;
%%
int yylexerrs = 0;

void yyerror(const char *s){
	printf("\nlínea #%d: %s", yylineno, s);
	//return;
}