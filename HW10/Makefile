CC=g++

all: parser test

run: parser
	./parser

compile: parser

parser: lex.yy.c grammar.tab.c
	$(CC) lex.yy.c grammar.tab.c token_struct.cpp token_struct.hpp -o parser

lex.yy.c: lexer.l
	lex lexer.l

grammar.tab.c:
	bison -dt grammar.y
								
test: parser
	-./parser < ./tests/test_1_int.txt
	-./parser < ./tests/test_2_float.txt
	-./parser < ./tests/test_3_mixed.txt
	-./parser < ./tests/test_4_bad_syntax.txt
	-./parser < ./tests/test_5_bad_syntax.txt
	-./parser < ./tests/test_6_zero_div.txt
	-./parser < ./tests/test_7_zero_div.txt
	-./parser < ./tests/test_8_out_of_range.txt
	-./parser < ./tests/test_9_comparasion.txt
	-./parser < ./tests/test_10_wrong_var.txt
clear:
	rm -rf *.tab.c *.tab.h *yy.c parser
