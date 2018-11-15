%code top{
#include <stdio.h>
#include "scanner.h"
#include "semantic.h"

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

todo			: programa	{ if (yynerrs || yylexerrs) YYABORT; else YYACCEPT; terminar();}
			;
programa		: PROGRAMA VARIABLES listaVariables CODIGO listaSentencias FIN {comenzar();}
			;
listaVariables		: listaVariables variable
			| /*epsilon*/
			;
variable		: DEFINIR IDENTIFICADOR '.' 			{declarar();}
			| error '.'
			;
listaSentencias		: listaSentencias sentencia
			| sentencia
			;
sentencia		: LEER '(' listaIdentificadores ')' '.' 	{leer();}
			| identificador ASIGNACION expresion '.' 	{asignar($1, $3);}
			| ESCRIBIR '(' listaExpresiones ')' '.'  	{escribir();}
			| error '.'
			;
listaIdentificadores 	: listaIdentificadores ',' identificador 
			| identificador
			;
listaExpresiones	: listaExpresiones ',' expresion
			| expresion
			;
expresion		: expresion '+' expresion  			{$$ = generarInfijo($1,'+', $3);}
			| expresion '-' expresion			{$$ = generarInfijo($1,'-', $3);}
			| expresion '*' expresion  			{$$ = generarInfijo($1,'*', $3);}
			| expresion '/' expresion  			{$$ = generarInfijo($1,'/', $3);}
			| '-' expresion %prec NEGATIVO  		{$$ = generarUnario($1, '-');}
			| '(' expresion ')'				
			| identificador
			| CONSTANTE
			;
identificador		: IDENTIFICADOR					{procesarId();}
			;
%%
int yylexerrs = 0;

void yyerror(const char *s){
	printf("\nlínea #%d: %s", yylineno, s);
	//return;
}


