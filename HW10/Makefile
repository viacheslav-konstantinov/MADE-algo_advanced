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

save_test: parser
	-./parser < ./tests/test_1_int.txt > ./test_results/test1_out.txt
	-./parser < ./tests/test_2_float.txt > ./test_results/test2_out.txt
	-./parser < ./tests/test_3_mixed.txt > ./test_results/test3_out.txt
	-./parser < ./tests/test_4_bad_syntax.txt > ./test_results/test4_out.txt
	-./parser < ./tests/test_5_bad_syntax.txt > ./test_results/test5_out.txt
	-./parser < ./tests/test_6_zero_div.txt > ./test_results/test6_out.txt
	-./parser < ./tests/test_7_zero_div.txt > ./test_results/test7_out.txt
	-./parser < ./tests/test_8_out_of_range.txt > ./test_results/test8_out.txt
	-./parser < ./tests/test_9_comparasion.txt > ./test_results/test9_out.txt
	-./parser < ./tests/test_10_wrong_var.txt > ./test_results/test10_out.txt
clear:
	rm -rf *.tab.c *.tab.h *yy.c parser
