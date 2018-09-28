#include <stdio.h>
#include "scanner.h"

char *token_names[] = {"", "Asignación", "Constante", "Programa", "Variable", "Definir", "Código", "Leer", "Escribir", "Fin", "Identificador", "", "", "", "", "", "", "", "",};


int main () {

enum tokens t;
while ( (t = yylex()) ) { 
if (t == IDENTIFICADOR || t == CONSTANTE)
printf("Token: %s\tlexema: %s\n", token_names[t], yytext);
else printf("Token: %s\n", yytext);
	}
}