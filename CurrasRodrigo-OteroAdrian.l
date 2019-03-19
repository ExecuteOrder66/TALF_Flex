%{
	#include <string.h>
	#include <stdlib.h>
	int linea=1;
	char cadena[256]="";
%}
%x CAD
%x COM

PALABRA_RESERVADA(auto|base|boolean|break|case|catch|class|char|continue|default|do|double|else|enum|extern|false|finally|float|for|goto|if|include|int|interface|long|namespace|new|override|private|protected|public|return|sealed|short|signed|sizeof|static|struct|switch|this|throw|true|typedef|union|unsigned|using|virtual|void|while)

DELIMITADORES "("|")"|"{"|"}"|"?"|":"|";"|","

OPERADORES("+"|"-"|"*"|"/"|"%"|"--"|"++"|"*="|"/="|"%="|"+="|"-="|"."|"->"|"&"|"["|"]"|"~"|"|"|"^"|"<<"|">>"|"<<="|">>="|"&="|"^="|"|="|"<"|">"|"<="|">="|"=="|"!="|"!"|"&&"|"||"|"="|"sizeof")


ENTERO	[0-9]+
ENTERO_OCT	0[0-7]*
ENTERO_HEX	?i:0x[0-9a-f]
ENTERO_PACK ({ENTERO}|{ENTERO_OCT}|{ENTERO_HEX})


DECIMAL	([0-9]*\.[0-9]+)|(0[xX][0-9a-fA-F]*\.[0-9a-fA-F]+)
MANTISA	({ENTERO}|{ENTERO_HEX}|{DECIMAL})
IDENTIFICADOR	[A-Za-z_][A-Za-z_0-9]+
EXPONENTE	({MANTISA})[Ee][+-]?{ENTERO}+


CHAR	[A-Za-z,;.:-_+*!.#$%&¬=?¿¡/0-9]	

CHAR_ESCAPADO	(\'|\"|\?|\\|\n|\r|\t|\v)	

CHAR_HEX	\\x[0-9A-Fa-f]{1,2}					
CHAR_OCT	\\[0-3]?[0-7]{1,2}	

CARACTER	({CHAR}|{CHAR_ESCAPADO}|{CHAR_HEX}|{CHAR_OCT})
		
CHAR_ESCAPADO_CAD	(\'|\?|\r|\t|\v|\\\")

CADENA	({CHAR}|{CHAR_ESCAPADO_CAD}|{CHAR_OCT}|{CHAR_HEX}|" ")*

COMENT	\/\/.*\n
COMENT_VARIAS	\/\*	
			
%%

[\n]	linea++;

\"{CADENA}	BEGIN(CAD);strcat(cadena,yytext);
<CAD>\n		linea++;strcat(cadena,yytext);
<CAD>\"		BEGIN 0;strcat(cadena,yytext);printf("\nlinea %d, cadena: %s", linea, cadena);strcpy(cadena,"");
<CAD>{CADENA}	strcat(cadena, yytext);

{PALABRA_RESERVADA}	printf("\nlinea %d, palabra reservada: %s", linea, yytext);

{IDENTIFICADOR}		printf("\nlinea %d, identificador: %s", linea, yytext);

{ENTERO_PACK}	printf("\nlinea %d, constante entera: %s", linea, yytext);
{DECIMAL}	printf("\nlinea %d, constante real: %s", linea, yytext);
{EXPONENTE}	printf("\nlinea %d, constante real: %s", linea, yytext);



'{CARACTER}'		printf("\nlinea %d, caracter: %s",linea,yytext);
{DELIMITADORES}		printf("\nlinea %d, delimitador: %s", linea, yytext);

{OPERADORES}		printf("\nlinea %d, operador: %s", linea, yytext);

{COMENT}		linea++;

{COMENT_VARIAS}	BEGIN(COM);
<COM>\n		linea++;
<COM>.		;
<COM>\*\/	BEGIN 0;
" "|\t|\n	;
.	printf("\n linea %d, error: %s",linea,yytext);
%%


int yywrap(){

	return 1;
}

int main(int argc, char *argv []){
	yyin= fopen(argv[1],"r");
	yylex();
	printf("\n\n");
	fclose(yyin);
}
