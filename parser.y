%code top{
#include <stdio.h>
#include "scanner.h"
#include "semantic.h"

}
%code provides{
void yyerror(const char *);

extern int yynerrs;
extern int yylexerrs;
extern int erroresSemanticos;
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

todo			: programa	{if (yynerrs || yylexerrs || erroresSemanticos) YYABORT; else YYACCEPT;}
			;
programa		: {comenzar();} PROGRAMA VARIABLES listaVariables CODIGO listaSentencias FIN {terminar();}
			;
listaVariables		: listaVariables variable
			| /*epsilon*/
			;
variable		: DEFINIR IDENTIFICADOR '.' 			{if(declarar($2)) YYERROR;}
			| error '.'
			;
listaSentencias		: listaSentencias sentencia
			| sentencia
			;
sentencia		: LEER '(' listaIdentificadores ')' '.' 	
			| identificador ASIGNACION expresion '.' 	{asignar($1, $3);}
			| ESCRIBIR '(' listaExpresiones ')' '.'  	
			| error '.'
			;
listaIdentificadores 	: listaIdentificadores ',' identificador 	{leer($3);}
			| identificador					{leer($1);}
			;
listaExpresiones	: listaExpresiones ',' expresion		{escribir($3);}
			| expresion					{escribir($1);}
			;
expresion		: expresion '+' expresion  			{$$ = generarInfijo($1,'+', $3);}
			| expresion '-' expresion			{$$ = generarInfijo($1,'-', $3);}
			| expresion '*' expresion  			{$$ = generarInfijo($1,'*', $3);}
			| expresion '/' expresion  			{$$ = generarInfijo($1,'/', $3);}
			| '-' expresion %prec NEGATIVO  		{$$ = generarUnario($2, '-');}
			| '(' expresion ')'				
			| identificador
			| CONSTANTE
			;
identificador		: IDENTIFICADOR					{if(procesarID($1)) YYERROR;}
			;
%%
int yylexerrs = 0;

void yyerror(const char *s){
	printf("\nlínea #%d: %s", yylineno, s);
}


