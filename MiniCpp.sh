#!/bin/bash

flex -o MiniCpp.lex.c --yylineno MiniCpp.l
bison -o MiniCpp.tab.c -gMiniCpp.gv -d MiniCpp.y
cc MiniCpp.tab.c MiniCpp.lex.c -o MiniCpp -DYYDEBUG=1
