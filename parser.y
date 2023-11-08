%{
int yylex();

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tablaSimbolos.c"
void yyerror(char *s);

extern int yynerrs;
extern int yylexerrors;
extern FILE *yyin;

%}

%token INICIO FIN LEER ESCRIBIR PUNTOYCOMA 
%token <id> ID
%token <cte> CONSTANTE
%union {
    char* id;
    int cte;
}
%left SUMA RESTA COMA
%right ASIGNACION

%type <cte> expresion primaria termino

%%

programa:
    INICIO listaSentencias FIN {if(yyners || yylexerrors) YYABORT; return -1}