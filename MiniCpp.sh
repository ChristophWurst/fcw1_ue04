#!/bin/bash

flex -d -o MiniCpp.lex.c --yylineno MiniCpp.l
bison -v -o MiniCpp.tab.c -gMiniCpp.gv -d MiniCpp.y
cc MiniCpp.tab.c MiniCpp.lex.c -o MiniCpp -DYYDEBUG=1
