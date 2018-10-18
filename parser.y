%code top{
#include <stdio.h>
#include "scanner.h"
}
%code provides{
void yyerror(const char *);
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
programa		: PROGRAMA VARIABLES listaVariables CODIGO listaSentencias FIN
			;
listaVariables		: listaVariables variable
			| /*epsilon*/
			;
variable		: DEFINIR IDENTIFICADOR '.' {printf("definir %s", $IDENTIFICADOR);}
			;
listaSentencias		: listaSentencias sentencia
			| sentencia
			;
sentencia		: LEER '(' listaIdentificadores ')' '.' 
			| IDENTIFICADOR ASIGNACION expresion '.' 
			| ESCRIBIR '(' listaExpresiones ')' '.' 
			;
listaIdentificadores 	: listaIdentificadores ',' IDENTIFICADOR 
			| IDENTIFICADOR
			;
listaExpresiones	: listaExpresiones ',' expresion
			| expresion
			;
expresion		: expresion '+' expresion
			| expresion '-' expresion
			: expresion '*' expresion
			| expresion '/' expresion 
			| expresion
			| '-' expresion %prec NEGATIVO
			| '(' expresion ')'
			| IDENTIFICADOR
			| CONSTANTE
			;

%%

void yyerror(const char *s){
	printf("línea #%d: %s\n", yylineno, s);
	return;
}