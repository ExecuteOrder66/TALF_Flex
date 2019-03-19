%{
	#include <string.h>
	#include <stdlib.h>
	int linea=1;
	char cadena[256]="";
%}
%x CAD
%x COM

PALABRA_RESERVADA(auto|base|boolean|break|case|catch|class|char|continue|default|do|double|else|enum|extern|false|finally|float|for|goto|if|include|int|interface|long|namespace|new|override|private|protected|public|return|sealed|short|signed|sizeof|static|struct|switch|this|throw|true|typedef|union|unsigned|using|virtual|void|while)

DELIMITADORES("("|")"|"{"|"}"|"?"|":"|";"|",")

OPERADORES("+"|"-"|"*"|"/"|"%"|"--"|"++"|"*="|"/="|"%="|"+="|"-="|"."|"->"|"&"|"["|"]"|"~"|"|"|"^"|"<<"|">>"|"<<="|">>="|"&="|"^="|"|="|"<"|">"|"<="|">="|"=="|"!="|"!"|"&&"|"||"|"="|"sizeof")



ENTERO	[+-]?[0-9]+
REAL	[+-]?[0]?[Xx]?\.*[0-9]+
DECIMAL	[+-]?[0-9]*\.[0-9]+
IDENTIFICADOR	[A-Za-z_][A-Za-z_0-9]+
EXPONENTE	({ENTERO}|{DECIMAL}|{REAL})[Ee][+-]?{ENTERO}


CHAR	[A-Za-z,;.:-_+*!.#$%&¬=?¿¡/]	

CHAR_ESCAPADO	(\'|\"|\?|\\|\n|\r|\t|\v)	

CHAR_DEC	([0-1]?[0-9]{1,2}|2[0-4][0-9]|25[0-5])	

CHAR_HEX	[0-9][Xx][0-9A-Fa-f]{1,3}	
						

CHAR_OCT	\\[0-3]?[0-7]{1,2}	
CARACTER	({CHAR}|{CHAR_ESCAPADO}|{CHAR_DEC}|{CHAR_HEX}|{CHAR_OCT})
		
CHAR_ESCAPADO_CAD	(\'|\?|\r|\t|\v)

CADENA	({CHAR}|{CHAR_ESCAPADO_CAD}|{CHAR_OCT}|{CHAR_HEX})+

COMENT	\/\/.*\n
COMENT_VARIAS	\/\*	
			
%%

[\n]	linea++;

{PALABRA_RESERVADA}	printf("\nlinea %d, palabra reservada: %s", linea, yytext);

{IDENTIFICADOR}		printf("\nlinea %d, identificador: %s", linea, yytext);

{ENTERO}	printf("\nlinea %d, constante entera: %s", linea, yytext);
{DECIMAL}	printf("\nlinea %d, constante real: %s", linea, yytext);
{EXPONENTE}	printf("\nlinea %d, constante real: %s", linea, yytext);



'{CARACTER}'		printf("\nlinea %d, caracter: %s",linea,yytext);
{DELIMITADORES}	printf("\nlinea %d, delimitador: %s", linea, yytext);

{OPERADORES}		printf("\nlinea %d, operador: %s", linea, yytext);

{COMENT}		linea++;

["]{CADENA}	BEGIN(CAD);strcat(cadena,yytext);
<CAD>\n		linea++;strcat(cadena,yytext);
<CAD>["]	BEGIN 0;strcat(cadena,yytext);printf("\nlinea %d, cadena: %s", linea, yytext);
<CAD>{CADENA}	strcat(cadena, yytext);

{COMENT_VARIAS}	BEGIN(COM);
<COM>\n		linea++;
<COM>.		;
<COM>\*\/	BEGIN 0;
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
