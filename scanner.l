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
OTRO  [[:^alnum:]]{-}[[:space:]]{-}[+*/().,-]
CUALQUIERA [[:^space:]]{-}[+*/().,-]
S  [[:space:]]
CONSERR [[:^digit:]]{-}[[:space:]]{-}[+*/().,-]
%%
"<-"		return ASIGNACION;
{D}+		return CONSTANTE;
"+"		printf("Token: %s\n", yytext);
"-"		printf("Token: %s\n", yytext);
"*"		printf("Token: %s\n", yytext);
"/"		printf("Token: %s\n", yytext);
"programa"	return PROGRAMA;
"variables"	return VARIABLE;
"definir"	return DEFINIR;
"codigo"	return CODIGO;
"leer"		return LEER;
"escribir"	return ESCRIBIR;
"fin"		return FIN;
"("		printf("Token: %s\n", yytext);
")"		printf("Token: %s\n", yytext);
"."		printf("Token: %s\n", yytext);
","		printf("Token: %s\n", yytext);
{L}{LD}*	return IDENTIFICADOR;
"//".*		;
{OTRO}+   	printf("Error Léxico:\t\t Cadena desconocida: %s\n", yytext);
{L}{LD}*{OTRO}+{CUALQUIERA}*	printf("Error Léxico:\t\t Identificador inválido: %s\n", yytext);
{D}+{LD}+	printf("Error Léxico:\t\t Constante inválida: %s\n", yytext);
{S}+    	;
%%
