#ifndef SEMANTIC_H_INCLUDED
#define SEMANTIC_H_INCLUDED

char* generarInfijo (char* a, char operador, char* b);
char* generarUnario (char* a, char operador);
int procesarID (char * id);
void comenzar();
void leer(char* a);
void escribir(char* a);
int declarar(char * id);
void asignar(char* a, char* b);
void terminar();


#endif // SEMANTIC_H_INCLUDED
