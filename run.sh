lex scan.l
yacc -d grammer.y
gcc lex.yy.c y.tab.c