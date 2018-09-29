/*TP3  –  2018
Trabajo práctco N° 3
Grupo  10
Cervantes Marisol, 1639201
Lodeiros Ayrton, 1646473
Nishisaka Matías, 
Rey Gastσn, 1561674*/



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