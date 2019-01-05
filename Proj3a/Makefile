all: proj3a.y proj3a.l
	bison -d proj3a.y
	flex proj3a.l
	gcc proj3a.tab.c lex.yy.c
debug: proj3a.y proj3a.l
	bison -d -t proj3a.y
	flex -d proj3a.l
	gcc proj3a.tab.c lex.yy.c

