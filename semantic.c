#include <stdio.h>
#include <string.h>
#include "semantic.h"
#include "scanner.h"
#include "parser.h"
#include "symbol.h"

int erroresSemanticos = 0;
char buffer2[200];
char temporal[50];
int cantTemporales = 1;


int procesarID(char * id) {
	if (!buscar(id)) {
		sprintf(buffer2,"Error semantico: identificador %s no declarado", id);
		erroresSemanticos++;
		yyerror(buffer2);
		return 1;
		}	
	return 0;
}


char* generarInfijo (char* a, char operador, char* b) {
	char * temp;
	sprintf(temporal, "temp#%d",cantTemporales);
	cantTemporales++;
	temp = strdup(temporal);
	declarar(temp);
	
	switch (operador) {	
	case '+': generar("ADD", a, b, temporal); break;
	case '*': generar("MULT", a, b, temporal); break;
	case '-': generar("SUBS", a, b, temporal); break;
	case '/': generar("DIV", a, b, temporal); break;
	}
	return temp;
}

char* generarUnario (char* a, char operador) {
	char * temp;
	sprintf(temporal, "temp#%d",cantTemporales); 
	cantTemporales++;
	temp = strdup(temporal);
	declarar(temp);
	generar("INV", a, "", temporal);
	return temp;
}

void comenzar(void) {
	generar("Load","rtlib","","");
}

void leer(char* a) {
	generar("READ", a, "","Integer");
}

void escribir (char* a) {
	generar("WRITE", a, "", "Integer");
}

int declarar (char * id) {
	if(chequear(id)) { //Chequear devuelve 1 si no estaba y tuvo que agregarlo						//Revisar si está en la TS
		generar("Declare",id, "", "Integer");
		return 0;
		}
	else {	
		sprintf(buffer2,"Error semantico: identificador %s ya declarado", id);
		erroresSemanticos++;
		yyerror(buffer2);
		return 1;
		}
}


void asignar(char* a, char* b) {
	generar("STORE", a, b, "Integer");
}


void terminar() {
	generar("STOP","","","");
}



