all: proj-final.y proj-final.l
	bison -d proj-final.y
	flex proj-final.l
	gcc proj-final.tab.c lex.yy.c symbol.c
debug: proj-final.y proj-final.l
	bison -d -t proj-final.y
	flex -d proj-final.l
	gcc -g proj-final.tab.c lex.yy.c symbol.c

