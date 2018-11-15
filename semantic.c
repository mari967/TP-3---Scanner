#include <stdio.h>
#include <string.h>
#include "semantic.h"
#include "scanner.h"
#include "parser.h"
#include "symbol.h"



void procesarID() {
	if (!buscar(yytext)) {
		sprintf(buffer2,"Error semantico: identificador %s no declarado", yytext);
		erroresSemanticos++;
		yyerror(buffer2);
		YYERROR;
		}	
}


char* generarInfijo (char* a, char operador, char* b) {
	switch (operador) {
	sprintf(temporal, "temp#%d",cantTemporales);
	case '+': generar("ADD", a, b, temporal); cantTemporales++; break;
	case '*': generar("MULT", a, b, temporal); cantTemporales++; break;
	case '-': generar("SUBS", a, b, temporal); cantTemporales++; break;
	case '/': generar("DIV", a, b, temporal); cantTemporales++; break;
	}
	return temporal;
}

char* generarUnario (char* a, char operador) {
	sprintf(temporal, "temp#%d",cantTemporales);
	generar("INV", a, "", temporal); 
	cantTemporales++;
	return temporal;
}

void comenzar(void) {
	generar("Load","rtlib","","");
}

void leer() {
	generar("READ", yytext, "","Integer");
}

void escribir () {
	generar("WRITE", yytext, "", "Integer");
}

void declarar (void) {//Es necesria la palabra struct?
	if(chequear(yytext))						//Revisar si está en la TS
		generar("Declare",yytext, ", Integer", " ");
		
	else {	
		sprintf(buffer2,"Error semantico: identificador %s ya declarado", yytext);
		erroresSemanticos++;
		yyerror(buffer2);
		YYERROR;
		}
}


void asignar(char* a, char* b) {
	generar("STORE", a, b, "Integer");
}


void terminar() {
	generar("STOP","","","");
}



