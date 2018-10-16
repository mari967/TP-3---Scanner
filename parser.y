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
%define noinput
%option nounput
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
variable		: DEFINIR identificador '.'
			;
listaSentencias		: listaSentencias sentencia
			| sentencia
			;
sentencia		: LEER '(' listaIdentificadores ')' '.' 
			| identificador ASIGNACION expresion '.' 
			| ESCRIBIR '(' listaExpresiones ')' '.' 
			;
listaIdentificadores 	: listaIdentificadores ',' identificador 
			| identificador
			;
listaExpresiones	: listaExpresiones ',' expresion
			| expresion
			;
expresion		: expresion '+' expresion
			| expresion '-' expresion
			: expresion '*' expresion
			| expresion '/' expresion 
			| primaria
			;
			| '-' primaria %prec NEGATIVO
primaria		| IDENTIFICADOR
			| CONSTANTE
			| '(' expresion ')'
			; 
%%

void yyerror(const char *s){
	printf("línea #%d: %s\n", yylineno, s);
	return;
}