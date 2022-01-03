%{
#include<stdio.h> 
#include "y.tab.h"
int dquote_count = 0;   
int temp = 0;   
%}

%%

";;"[^\n]*  { temp=0; return COMMENT; }

and         { temp=0; return KW_AND; }
or          { temp=0; return KW_OR; }
not         { temp=0; return KW_NOT; }   
equal       { temp=0; return KW_EQUAL; }
less        { temp=0; return KW_LESS; }
nil         { temp=0; return KW_NIL; }
list        { temp=0; return KW_LIST; }
append      { temp=0; return KW_APPEND; }
concat      { temp=0; return KW_CONCAT; }
set         { temp=0; return KW_SET; }
deffun      { temp=0; return KW_DEFFUN; }
defvar      { temp=0; return KW_DEFVAR; }
for         { temp=0; return KW_FOR; }
if          { temp=0; return KW_IF; }
exit        { temp=0; return KW_EXIT; } 
load        { temp=0; return KW_LOAD; }
true        { temp=0; return KW_TRUE; }
false       { temp=0; return KW_FALSE; }
while       { temp=0; return KW_WHILE; }
"+"         { temp=0; return OP_PLUS; }
"-"         { temp=0; return OP_MINUS; }
"/"         { temp=0; return OP_DIV; }
"*"         { temp=0; return OP_MULT; }
"("         { temp=0; return OP_OP; }
")"         { temp=0; return OP_CP; }
"**"        { temp=0; return OP_DBLMULT; }
"\""        { temp=0;
    dquote_count++;
    if(dquote_count%2==1){return OP_OC;}
    else{return OP_CC;}
            }
","         { temp=0; return OP_COMMA; }
"'("        { temp=0; return OP_LIST; }

0                   { temp=0;
    yylval=atoi(yytext); return VALUE; }

[1-9][0-9]*         { temp=0;
    yylval=atoi(yytext); return VALUE; }

[a-zA-Z_][a-z.A-Z0-9_]* { temp=0; 
    return IDENTIFIER; }

[\t]|[ ]    { } 
[\n]        { 
                if(temp == 0) 
                    temp = 1;
                else
                    return NEWLINE;
            } 
.           { printf("SYNTAX ERROR %s IS NOT RECOGNIZED\n",yytext); return 1; }   
%%

int yywrap() {
 return 1; 
}