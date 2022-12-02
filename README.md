# BNF-Grammar
purpose of this project was to built a bnf grammar and if there are errors compiler show us the line of the first error this project was tested with Cygwin

to test it you need to run the following commands

bison -d bison.y flex lex.l gcc bison.tab.c lex.yy.c -o parser ./ parser test1.c
