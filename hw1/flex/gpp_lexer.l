%{
	int dquote_count = 0;
%}

%% 


";;"[^\n]* 	{printf("COMMENT\n");}

and			{printf("KW_AND\n");}
or			{printf("KW_OR\n");}
not			{printf("KW_NOT\n");}
equal		{printf("KW_EQUAL\n");}
less		{printf("KW_LESS\n");}
nil			{printf("KW_NIL\n");}
list		{printf("KW_LIST\n");}
append		{printf("KW_APPEND\n");}
concat		{printf("KW_CONCAT\n");}
set			{printf("KW_SET\n");}
deffun		{printf("KW_DEFFUN\n");}
for			{printf("KW_FOR\n");}
if			{printf("KW_IF\n");}
exit		{printf("KW_EXIT\n");}
load		{printf("KW_LOAD\n");}
disp		{printf("KW_DISP\n");}
true		{printf("KW_TRUE\n");}
false		{printf("KW_FALSE\n");}
"+" 		{printf("OP_PLUS\n");}
"-" 		{printf("OP_MINUS\n");}
"/" 		{printf("OP_DIV\n");}
"*" 		{printf("OP_MULT\n");}
"(" 		{printf("OP_OP\n");}
")" 		{printf("OP_CP\n");}
"**" 		{printf("OP_DBLMULT\n");}
"\"" {
	dquote_count++;
	if(dquote_count%2==1){printf("OP_OC\n");}
	else{printf("OP_CC\n");}
}

"," 		{printf("OP_COMMA\n");}

" "

0			{printf("VALUE\n");}
[1-9][0-9]*	{printf("VALUE\n");}
0*			{printf("ERROR not a value\n");}
[a-z][a-z0-9]* {printf("IDENTIFIER\n");}
. 			{printf("SYNTAX_ERROR %s cannot be tokenized\n", yytext);}

\n\n {return 0;}

%%

int yywrap(){}

int main(){
	yylex();
	return 0;
}