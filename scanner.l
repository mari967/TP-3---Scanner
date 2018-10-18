%top{
#include <stdio.h>
#include "parser.h"
}

%option outfile="scanner.c"
%option noinput
%option nounput
%option header-file="scanner.h"

D  [0-9]
L  [[:alpha:]]
LD [[:alnum:]]
OTRO  [[:^alnum:]]{-}[[:space:]]{-}[+*/().,-]
CUALQUIERA [[:^space:]]{-}[+*/().,-]
S  [[:space:]]
%%
"<-"		return ASIGNACION;
{D}+		return CONSTANTE;
"+"		return '+';
"-"		return '-';
"*"		return '*';
"/"		return '/';
"programa"	return PROGRAMA;
"variables"	return VARIABLES;
"definir"	return DEFINIR;
"codigo"	return CODIGO;
"leer"		return LEER;
"escribir"	return ESCRIBIR;
"fin"		return FIN;
"("		return '(';
")"		return ')';
"."		return '.';
","		return ',';
{L}{LD}*	return IDENTIFICADOR;
"//".*		;
{OTRO}+   	yyerror("Error Léxico:\t\t Cadena desconocida: yytext\n");
{L}{LD}*{CUALQUIERA}+	yyerror("Error Léxico:\t\t Identificador inválido: yytext\n");
{D}+{LD}+	yyerror("Error Léxico:\t\t Constante inválida: yytext\n");
{S}+    	;
%%
