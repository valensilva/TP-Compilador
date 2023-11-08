#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define TAM_TABLASIMBOLOS 100

typedef struct{
    char id[32];
    int val;
} SIMBOLO;

SIMBOLO TS[TAM_TABLASIMBOLOS];

void iniciarlizarTabla(void){
    for (int i=0;i<TAM_TABLASIMBOLOS;i++){
        TS[i].val = -1;
    }
}

int valorSimbolo(char *s){
    int indice = buscarIndice(s);
    if (indice < 0){
        printf("no hay valor de '%s'\n",s);
        exit(EXIT_FAILURE);
    }
    return TS[indice].val;
}

int buscarIndice(char *s){
    for(int i=0; i<TAM_TABLASIMBOLOS; i++){
        if(!strcmp(TS[i].id, s)) {
            return i;
        }
    }
    return -1;
}

void escribirEnTabla(char *s, int a){
    int indice = buscarIndice(s);
    int i=0;
    if ( indice == -1){
        for (i;(i<TAM_TABLASIMBOLOS && TS[i].val != -1); i++); /*busco primer espacio vacio*/
    if ( i > TAM_TABLASIMBOLOS - 1){
        printf("Tabla llena\n");
        return;
    }
    TS[i].val = a;
    sprintf(TS[i].id, s);
    }
    else {
        TS[indice].val = a;
    }
}
int cadenaANumero(char *s){
    for (int i = 0; i<strlen(s); i++)
        if(!isdigit(s[i])) return -1;
    return atoi(s); /*atoi es ascii to integer (ascii a entero)*/
}

void llenarTabla(char *a){
    int valor;
    char b[15];
    printf("ingrese valor de %s: ", a);
    fscanf(stdin, "%s", b);

    if((valor = cadenaANumero(b)) == -1){
        printf("%s no es un numero\n", b);
        exit (EXIT_FAILURE);
    }
    escribirEnTabla(a,valor);
}