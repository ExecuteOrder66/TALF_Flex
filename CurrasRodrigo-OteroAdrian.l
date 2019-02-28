
//Declaraciones

%{
int linea=1;
string aux;

PALABRA_RESERVADA {"auto", "base", "boolean", "break", "case", "catch", "class", "char",
	"continue", "default", "do", "double", "else", "enum", "extern", "false", "finally",
	"float", "for", "goto", "if", "include", "int", "interface", "long", "namespace",
	"new", "override", "private", "protected", "public", "return", "sealed", "short",
	"signed", "sizeof", "static", "struct", "switch", "this", "throw", "true", "typedef",
	"union", "unsigned", "using", "virtual", "void", "while"}

DELIMITADORES {"(", ")", "{", "}", "?", ":", ";", ","}

OPERADORES {"+", "-", "*", "/", "%", "--", "++", "*=", "/=", "%=", "+=", "-=", ".", 
	"->", "&", "[", "]", "~", "|", "^", "<<", ">>", "<<=", ">>=", "&=", "^=", "|=",
	"<", ">", "<=", ">=", "==", "!=", "!", "&&", "||", "=", "sizeof"} //este sizeof no se si dara problemas con el de arriba

ENTERO	[+-]?[0-9]+
DECIMAL	[+-]?[0-9]*\.[0-9]+
IDENTIFICADOR	[A-Za-z_][A-Za-z_0-9]+	//El id tiene como 1er char una letra o una _, REVISAR
EXPONENTE ({ENTERO}|{DECIMAL})[Ee][+-]?{ENTERO}



CHAR	[A-Za-z,;.:-_+*!.#$%&¬=?¿¡/]	//Caracter, iran dentro de comillas simples al reconocerlos

CHAR_ESCAPADO	(\\'|\\?|\\\\|\\a|\\b|\\f|\\n|\\r|\\t|\\v)	//Caracter escapado REVISAR no estoy seguro de los \a \b \f y \¨

CHAR_DEC	([0-1]?[0-9]{1,2}|2[0-4][0-9]|25[0-5])	//Caracter ASCII formato decimal

CHAR_HEX	\\x[0-9a-f]{1,2}	//Caracter ASCII formato hexadecimal (\x<num><num>) REVISAR

CHAR_OCT	\\[0-3]?[0-7]{1,2}	//Caracter ASCII formato octal (0-377)
CARACTER	({CHAR}|{CHAR_ESCAPADO}|{CHAR_DEC}|{CHAR_HEX}|{CHAR_OCT})		

/*palabra reservada, identificador, delimitador, operador, constante real, cadena*/

%}

%%

//Reglas

[\n] linea++; //incrementar el numero de linea "provisional"

//Identificadores

//Constantes

//Caracteres

//Cadenas

//Delimitadores

//Operadores


%%

//Routinas User

int yywrap(){

	return 1;
}

main(){



}
