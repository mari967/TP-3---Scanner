%top{
#include <stdio.h>
#include <string.h>
#include "parser.h"
}

%{
char buffer[200];
int yylexerrs;
%}

%option outfile="scanner.c"
%option noinput
%option nounput
%option header-file="scanner.h"
%option yylineno

D  [0-9]
L  [[:alpha:]]
LD [[:alnum:]]
OTRO  [[:^alnum:]]{-}[[:space:]]{-}[+*/().,-]
CUALQUIERA [[:^space:]]{-}[+*/().,-]
S  [[:space:]]
%%
"<-"		return ASIGNACION;
{D}+		{yylval = strdup(yytext); return CONSTANTE;}
"+"		return '+';
"-"		return '-';
"*"		return '*';
"/" 		return '/';
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
{L}{LD}*	{yylval = strdup(yytext); return IDENTIFICADOR;}
"//".*		;
{OTRO}+   		{yylexerrs++; sprintf(buffer,"Error Léxico:  Cadena desconocida: %s", yytext); yyerror(buffer);}
{L}{LD}*{CUALQUIERA}+	{yylexerrs++; sprintf(buffer,"Error Léxico:  Identificador inválido: %s", yytext); yyerror(buffer);}
{D}+{LD}+		{yylexerrs++; sprintf(buffer,"Error Léxico:  Constante inválida: %s",yytext); yyerror(buffer);}
{S}+    		;
%%
