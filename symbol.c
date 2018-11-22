#include <stdio.h>
#include "semantic.h"
#include "scanner.h"
#include "parser.h"
#include "symbol.h"

char * TS [dim];
int proximoLugarLibre = 0;


int chequear(char* cadena) {	//Suponiendo que la tabla se símbolos almacena structs
	if(!buscar(cadena)) {
		colocar(cadena);
		return 1;
	}
	else return 0;
}

int buscar(char * cadena)
{
	for (int i = 0; i < proximoLugarLibre; i++)
		if (!strcmp(TS[i], cadena)) //Devuelve 0 si son iguales
			return 1;
	return 0;
}


void colocar (char* cadena) {
	if (proximoLugarLibre < 100) {
	TS[proximoLugarLibre] = cadena;
	proximoLugarLibre++;
	}	
	else printf("Se acabó la memoria");
}



void generar (char * codigo, char * a, char * b, char * c) {
	if (!strcmp(codigo,"STOP"))
		printf("\n%s ", codigo);
	else if (!strcmp(b,""))
		printf("\n%s %s, %s", codigo, a, c);
		else printf("\n%s %s, %s, %s", codigo, a, b, c);
	
}
