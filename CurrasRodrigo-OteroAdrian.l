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
