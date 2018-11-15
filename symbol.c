#include <stdio.h>
#include "semantic.h"
#include "scanner.h"
#include "parser.h"
#include "symbol.h"


int chequear(char* cadena) {	//Suponiendo que la tabla se símbolos almacena structs
	if(!buscar(cadena)) {
		colocar(cadena);
		return 1;
	}
	else return 0;
}

int buscar(char * cadena)
{
	for (int i = 0; i < dim; i++)
		if (TS[i] == cadena)
			return 1;
	return 0;
}


void colocar (char* cadena) {
	if (i < 100) {
	TS[i] = cadena;
	i++;
	}	
	else printf("Se acabó la memoria");
}



void generar (char * codigo, char * a, char * b, char * c) {
	printf("%s %s, %s, %s\n", codigo, a, b, c);
}
