#ifndef TABLA_SIMBOLOS
#define TABLA_SIMBOLOS

#define TAM_TABLASIMBOLOS 100

typedef struct{
    char id[32];
    int val;
} SIMBOLO;

void inicializarTabla(void);
int buscarIndice(char *s);
int valorSimbolo(char *s);
void escribirEnTabla(char *s, int a);
int cadenaANumero(char *s);
void llenarTabla(char *a);

#endif