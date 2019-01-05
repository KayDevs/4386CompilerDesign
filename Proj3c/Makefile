all: proj3c.y proj3c.l
	bison -d proj3c.y
	flex proj3c.l
	gcc proj3c.tab.c lex.yy.c
debug: proj3c.y proj3c.l
	bison -d -t proj3c.y
	flex -d proj3c.l
	gcc proj3c.tab.c lex.yy.c

