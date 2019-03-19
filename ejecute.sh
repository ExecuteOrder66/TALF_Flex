#/bin/bash
flex CurrasRodrigo-OteroAdrian.l
gcc -o prog lex.yy.c
./prog programa.c

