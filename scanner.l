%top{
#include <stdio.h>
#include "tokens.h"
}

%option outfile="scanner.c"
%option noinput
%option nounput
%option header-file="scanner.h"

D  [0-9]
L  [[:alpha:]]
LD [[:alnum:]]
OTRO  [[:^alnum:]]{-}[[:space:]]{-}[\+\-\*\/\(\)\.\,]
CUALQUIERA [[:^space:]]{-}[\+\-\*\/\(\)\.\,]
S  [[:space:]]
CONSERR [[:^digit:]]{-}[[:space:]]
%%
"<-"		return ASIGNACION;
{D}+		return CONSTANTE;
'+'		return '+';
'-'		return '-';
'*'		return '*';
'\/'		return '/';
"programa"	return PROGRAMA;
"variables"	return VARIABLE;
"definir"	return DEFINIR;
"codigo"	return CODIGO;
"leer"		return LEER;
"escribir"	return ESCRIBIR;
"fin"		return FIN;
'\('		return '(';
'\)'		return ')';
'\.'		return '.';
'\,'		return ',';
{L}{LD}*	return IDENTIFICADOR;
"//".*		;
{OTRO}+{CUALQUIERA}*   	printf("Error Léxico:\t Cadena desconocida: %s\n", yytext);
{L}{LD}*{OTRO}+{CUALQUIERA}*	printf("Error Léxico:\t Identificador inválido: %s\n", yytext);
{D}+{CONSERR}+{CUALQUIERA}*	printf("Error Léxico:\tconstante inválida: %s\n", yytext);
{S}+    	;
%%
