/*TP3  –  2018
Trabajo práctco N° 3
Grupo  10
Cervantes Marisol, 1639201
Lodeiros Ayrton, 1646473
Nishizaka Matías, 1634483
Rey Gastσn, 1561674*/



#include <stdio.h>
#include <ctype.h>
#include "scanner.h"
#include "parser.h"

char *token_names[] = {"Fin de archivo", "Asignación", "Constante", "Programa", "Variables", "Definir", "Código", "Leer", "Escribir", "Fin", "Identificador"};


int main () {

enum tokens t;
while ( (t = yylex()) ) { 
if (t == IDENTIFICADOR || t == CONSTANTE)
printf("Token: %s\tlexema: %s\n", token_names[t], yytext);
else if (t >= '(')
	printf("Token:  '%c'\n",t);
else printf("Token: %s\n", token_names[t]);
	}
printf("Token: %s", token_names[t]);
}
