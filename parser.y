%{
int yylex();

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "tablaSimbolos.h"

void yyerror(char *s);

extern int yynerrs;
extern int yylexerrs;
extern FILE *yyin;

%}

%token INICIO FIN LEER ESCRIBIR PUNTOYCOMA PARENIZQUIERDO PARENDERECHO
%token <id> ID
%token <cte> CONSTANTE
%union {
    char* id;
    int cte;
}
%left SUMA RESTA COMA
%right ASIGNACION

%type <cte> expresion termino

%%

programa:
    INICIO listaSentencias FIN {if(yynerrs || yylexerrs) YYABORT; return -1}
;
listaSentencias:
    sentencia
    |listaSentencias sentencia
;
sentencia:
    ID ASIGNACION expresion PUNTOYCOMA                                 {escribirEnTabla($1,$3);}
    |LEER PARENIZQUIERDO listaIdentificadores PARENDERECHO PUNTOYCOMA
    |ESCRIBIR PARENIZQUIERDO listaExpresiones PARENDERECHO PUNTOYCOMA
;
listaIdentificadores:
    ID                               {llenarTabla($1);}
    |listaIdentificadores COMA ID    {llenarTabla($3);}
;
listaExpresiones:
    expresion                         {printf("%d\n", $1);}
    |listaExpresiones COMA expresion  {printf("%d\n", $3);}
;
expresion:
    termino                           {$$ = $1;}
    |expresion SUMA termino           {$$ = $1 + $3;}
    |expresion RESTA termino          {$$ = $1 - $3;}
;
termino:
    ID                                      {$$ = valorSimbolo($1);}
    |CONSTANTE                              {$$ = $1;}
    |PARENIZQUIERDO expresion PARENDERECHO  {$$ = $2;}
;

%%
int yylexerrs = 0;
void yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(int argc, char** argv){
    if (argc == 2){
        char nombreArchivo[40];
        sprintf(nombreArchivo, "%s", argv[1]);
        int longitud = strlen(nombreArchivo);
        if (argv[1][longitud - 1] != 'm' || argv[1][longitud - 2]!= '.'){
            printf("el archivo debe ser .m");
            return EXIT_FAILURE;
        }
        yyin = fopen(nombreArchivo, "r");
    }
    else
        yyin = stdin;

    inicializarTabla();
    int a = yyparse();
    if (a == 0){
        printf ("compilacion exitosa");
    }
    else if (a == 1){
        printf ("error compilacion");
    }

    printf("\nerrores sintacticos: %i\terrores lexicos: %i\n", yynerrs, yylexerrs);
    
    return 0;
}
