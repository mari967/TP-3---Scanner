#ifndef SEMANTIC_H_INCLUDED
#define SEMANTIC_H_INCLUDED


const int dim = 100;
char* TS [dim];
int i = 0;
int erroresSemanticos = 0;
char buffer2[200];
char temporal[50];
int cantTemporales = 1;

char* generarInfijo (char* a, char operador, char* b);
char* generarUnario (char* a, char operador);
void procesarId ();
void comenzar();
void leer();
void escribir();
void declarar();
void asignar(char* a, char* b);
void terminar();


#endif // SEMANTIC_H_INCLUDED
