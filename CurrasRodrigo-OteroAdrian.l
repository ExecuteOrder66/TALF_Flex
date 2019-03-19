%{
	int linea=1;
	string aux;
%}
%x COM

PALABRA_RESERVADA ("auto" | "base" | "boolean" | "break" | "case"|  "catch" | "class" | "char" |
	"continue" | "default" | "do" | "double" | "else" | "enum" | "extern" | "false" | "finally"|
	"float" | "for" | "goto" | "if" | "include" | "int" | "interface" | "long" | "namespace" |
	"new" | "override" | "private" | "protected" | "public" | "return" | "sealed" | "short" |
	"signed" | "sizeof" | "static" | "struct" | "switch" | "this" | "throw" | "true" |
	"typedef" | "union" | "unsigned" | "using" | "virtual" | "void" | "while")

DELIMITADORES ("(" | ")" | "{" | "}" | "?" | ":" | ";" | ",")

OPERADORES ("+" | "-" | "*" | "/" | "%" | "--" | "++" | "*=" | "/=" | "%=" | "+=" | "-=" | "." | 
	"->" | "&" | "[" | "]" | "~" | "|" | "^" | "<<" | ">>" | "<<=" | ">>=" | "&=" | "^=" | "|=" |
	"<" | ">" | "<=" | ">=" | "==" | "!=" | "!" | "&&" | "||" | "=" | "sizeof")
	//este sizeof no se si dara problemas con el de arriba

ENTERO	[+-]?[0-9]+
REAL	[+-]?[0]?[Xx]?\.*[0-9]+ //con esto necesitamos que los caracteres tengan mas prioridad
DECIMAL	[+-]?[0-9]*\.[0-9]+
IDENTIFICADOR	[A-Za-z_][A-Za-z_0-9]+	//El id tiene como 1er char una letra o una _, PROBLEMA!!
EXPONENTE ({ENTERO}|{DECIMAL}|{REAL})[Ee][+-]?{ENTERO}



CHAR	[A-Za-z,;.:-_+*!.#$%&¬=?¿¡/]	//Caracter, iran dentro de comillas simples al reconocerlos

CHAR_ESCAPADO	(\\'|\\"|\\?|\\\\|\\n|\\r|\\t|\\v)	//Caracter escapado REVISAR 

CHAR_DEC	([0-1]?[0-9]{1,2}|2[0-4][0-9]|25[0-5])	//Caracter ASCII formato decimal

CHAR_HEX	[0-9][Xx][0-9A-Fa-f]{1,3}	//Caracter ASCII formato hexadecimal
						//le quite los \\

CHAR_OCT	\\[0-3]?[0-7]{1,2}	//Caracter ASCII formato octal (0-377)
CARACTER	({CHAR}|{CHAR_ESCAPADO}|{CHAR_DEC}|{CHAR_HEX}|{CHAR_OCT})
		//no hay que poner las comillas simples?

COMENT	\/\/.*\n
COMENT_VARIAS	\/\*	//Comentario de varias lineas  REVISAR
			// Comentario con "// o más" o un Comentario de este estilo /*hola*/
			//  o un Comentario entre comillas en donde sea
			//cualquier cosa 0 o mas veces seguido de 0 o varios saltos de linea
			//seguido de cualquier cosa 0 o mas veces 
/*pala*/


%%

[\n] linea++; //incrementar el numero de linea "provisional"

{PALABRA_RESERVADA} printf("\nlinea %d, palabra reservada: %s", linea, yytext);

{IDENTIFICADOR}	printf("\nlinea %d, identificador: %s", linea, yytext);

{ENTERO}	printf("\nlinea %d, constante entera: %s", linea, yytext);
{DECIMAL}	printf("\nlinea %d, constante real: %s", linea, yytext);
{EXPONENTE}	printf("\nlinea %d, constante real: %s", linea, yytext);

'{CARACTER}'	printf("\nlinea %d, caracter: %s",linea,yytext);

{DELIMITADORES}	printf("\nlinea %d, delimitador: %s", linea, yytext);

{OPERADORES}	printf("\nlinea %d, operador: %s", linea, yytext);

{COMENT}	linea++;

{COMENT_VARIAS}	BEGIN(COM);
<COM>\n		linea++;
<COM>.		;
<COM>\*\/	BEGIN 0;
%%

//Routinas User

int yywrap(){

	return 1;
}

main(){
	yyin= fopen(argv[1],"r");
	yylex();
	printf("\n\n");
	fclose(yyin);
}
