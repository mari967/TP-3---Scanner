/*TP3  –  2018
Trabajo práctco N° 3
Grupo  10
Cervantes Marisol, 1639201
Lodeiros Ayrton, 1646473
Nishizaka Matías, 1634483
Rey Gastσn, 1561674*/



#include <stdio.h>
#include "parser.h"
#include "semantic.h"

int main () {
printf("\n--------------------------------");
switch( yyparse() ) {
		case 0: printf("\n\nCompilación terminada con éxito");
			break;		
		case 1: printf("\n\nErrores de compilación");
			break;
		case 2: printf("\n\nNo hay memoria suficiente");
			break;		
		}
printf("\nErrores semánticos;  %i\t - Errores sintácticos:  %i\t - Errores lexicos:  %i\n",erroresSemanticos, yynerrs, yylexerrs);
printf("--------------------------------\n\n");
return 0;
}