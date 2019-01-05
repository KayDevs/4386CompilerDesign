all: proj3b.y proj3b.l
	bison -d proj3b.y
	flex proj3b.l
	gcc proj3b.tab.c lex.yy.c
debug: proj3b.y proj3b.l
	bison -d -t proj3b.y
	flex -d proj3b.l
	gcc proj3b.tab.c lex.yy.c

