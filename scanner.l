%option noyywrap 

%{
#include <stdio.h>
#include <string.h>
#include "parser.tab.h"

void yyerror(char *s);
int yylex();

char buffer[32];
int yylexerrs;


%}

digito                  [0-9]
letra                   [a-zA-Z]
identificador           {letra}({letra}|{digito})*
constante               ({digito})+

%%

"inicio"                return INICIO;
"fin"                   return FIN;
"leer"                  return LEER;
"escribir"              return ESCRIBIR;


{identificador}         {yylval.id = strdup(yytext); return ID;}
{constante}             {yylval.cte = atoi(yytext); return CONSTANTE;}
"("                     return PARENIZQUIERDO;
")"                     return PARENDERECHO;
";"                     return PUNTOYCOMA;
"+"                     return SUMA;
"-"                     return RESTA;
","                     return COMA;
":="                    return ASIGNACION;
[ \t\n]                 ;
.                       {yylexerrs++; sprintf(buffer," %s no es un caracter valido", yytext); yyerror(buffer);}

%%
