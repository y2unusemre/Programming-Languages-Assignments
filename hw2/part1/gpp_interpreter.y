%{ 
#include<stdio.h> 
#include<math.h>

extern int temp;

int err_flag=0;
int exit_flag=0;
int nil_flag=0;
int print_flag=1;
int is_list=0;
int bool_flag=0;
int arr[999];
int ind1=0;
int ind2=0;
int no_res=0;

%} 

%token KW_AND
%token KW_OR
%token KW_NOT   
%token KW_EQUAL
%token KW_LESS
%token KW_NIL
%token KW_LIST
%token KW_APPEND
%token KW_CONCAT
%token KW_SET
%token KW_DEFFUN
%token KW_DEFVAR
%token KW_FOR
%token KW_WHILE
%token KW_IF
%token KW_EXIT 
%token KW_LOAD
%token KW_TRUE
%token KW_FALSE
%token OP_PLUS
%token OP_MINUS
%token OP_DIV
%token OP_MULT
%token OP_OP
%token OP_CP
%token OP_DBLMULT
%token OP_OC
%token OP_CC
%token OP_COMMA
%token OP_LIST
%token COMMENT
%token VALUE
%token IDENTIFIER
%token NEWLINE
%start START

%% 

START: | INPUT{ 
	if(err_flag == 0 && exit_flag ==0){
		printf("Syntax OK.\n");

		if(!no_res){
			int res = $$;

			if(is_list == 1){

				printf("Result: ");
			    
			    printf("(");

			    for(int i=0;i<ind1;++i){
			        if(i == (ind1-1)){
			            printf("%d", arr[i]);
			        }
			        else{
			            printf("%d ",arr[i]);
			        }
			    }
			    printf(") \n\n");

			    ind1=0;
			    
			    ind2=0;
			    is_list=0;			
			}
			else if(bool_flag == 1){
				if(nil_flag){
					printf("Result: NIL \n\n");
					nil_flag=0;
				}else{
				    if(res == 1){
					    printf("Result: T \n\n");
				    }
				    else{
				        printf("Result: NIL \n\n");
				    }
				    		
				}
				bool_flag=0;
			}
			else{
				if(print_flag){
					printf("Result: %d\n\n", res);
				}
				else{
					print_flag=1;	
					printf("\n");
				}
			}
		}
		else{
			no_res=0;
			printf("\n");
		}
	}
	return 0;};

INPUT: EXPI | EXPLISTI | EXPB{ bool_flag=1; } | EXIT;

EXPI: OP_OP OP_PLUS EXPI EXPI OP_CP { $$=$3+$4; }
	| OP_OP OP_MINUS EXPI EXPI OP_CP { $$=$3-$4; }		
	| OP_OP OP_MULT EXPI EXPI OP_CP { $$=$3*$4; } 
	| OP_OP OP_DIV EXPI EXPI OP_CP { $$=$3/$4; } 	
	| OP_OP OP_DBLMULT EXPI EXPI OP_CP { $$=pow($3,$4); } 
	| IDENTIFIER { $$=1; print_flag=0;}
	| VALUE { $$=$1; }	
	| OP_OP IDENTIFIER EXPLISTI OP_CP { is_list=1;  $$=$3; }	
	| OP_OP KW_SET IDENTIFIER EXPI OP_CP { $$=$4; }	
	| OP_OP KW_DEFFUN IDENTIFIER IDLIST EXPLISTI OP_CP{ is_list=1;  $$=$5;	}	
	| OP_OP KW_IF EXPB EXPLISTI OP_CP { is_list=1;  $$=$3; 
	    if($$ == 0){ 
	        ind1=0;
	        arr[0]=NULL;
	    }
	}	
	| OP_OP KW_IF EXPB EXPLISTI EXPLISTI OP_CP{  is_list=1;  $$=$3;
	    if($$ == 1){ 
	        ind1=ind2;
	    }
	    else{
	        ind1 -= ind2;
	        for(int i=0;i<ind1;++i){
	            arr[i]=arr[ind2+i];
	        }
	    }
	}	
	| OP_OP KW_WHILE EXPB EXPLISTI OP_CP{   is_list=1;  $$=$3; 
	    if($$ == 0){
	        ind1=0;
	        arr[0]=NULL;
	    }
	}
	| OP_OP KW_FOR OP_OP IDENTIFIER EXPI EXPI OP_CP EXPLISTI OP_CP{  is_list=1; }
	| OP_OP KW_DEFVAR IDENTIFIER EXPI OP_CP { $$=$4; } 	
	| OP_OP KW_LIST VALUES OP_CP{ is_list=1;  $$=1; }
	| OP_OP KW_LOAD OP_OC IDENTIFIER OP_CC OP_CP { $$=1; print_flag=0; } 
	| COMMENT {   printf("COMMENT\n");  no_res=1;}
	| OP_OP KW_EXIT OP_CP {	no_res=1; }
;

EXPLISTI: OP_OP KW_CONCAT EXPLISTI EXPLISTI OP_CP{  is_list=1;   $$=1; }
	| OP_OP KW_APPEND EXPI EXPLISTI OP_CP{   $$=1;

	    for(int i=ind1-1; i>-1; --i)
	    	arr[i+1] = arr[i];
	    arr[0] = $3;
	
	    is_list=1;
	    ++ind1;
	}
	| LISTVALUE{$$=1;}
;

EXPB: OP_OP KW_AND EXPB EXPB OP_CP { $$=$3&&$4; } 
	| OP_OP KW_OR EXPB EXPB OP_CP { $$=$3||$4; } 
	| OP_OP KW_NOT EXPB OP_CP { $$=!$3; } 
	| OP_OP KW_EQUAL EXPB EXPB OP_CP { $$=($3==$4); } 
	| OP_OP KW_EQUAL EXPI EXPI OP_CP { $$=($3==$4); } 
	| BinaryValue{$$=$1;};
	| OP_OP KW_LESS EXPI EXPI OP_CP { $$=($3<$4); } 
;

LISTVALUE: OP_LIST VALUES OP_CP{   is_list=1;
	    if(ind2==0)
	        ind2=ind1;
	}
	| OP_LIST OP_CP {  is_list=1;   $$ = ind1 = 0;
	}
	| KW_NIL{$$=0; bool_flag=1; nil_flag=1; };
;

VALUES: VALUES VALUE  {  arr[ind1++]=$2; }
	| VALUE {    arr[ind1++]=$1; }
;

BinaryValue: KW_TRUE { $$=1; }
	| KW_FALSE { $$=0; }
;

IDLIST: OP_OP IDENT_LIST OP_CP;

IDENT_LIST: IDENT_LIST IDENTIFIER | IDENTIFIER;

EXIT: NEWLINE { no_res=1; exit_flag=1; return 0; };

%%

int main(int argc, char *argv[]){ 

        
		while(exit_flag == 0)	
			yyparse();        
    
    return 0;
}

int yyerror(const char * ch) 
{ 
    err_flag=1;
    exit_flag=1; 
	printf("\nSYNTAX_ERROR Expression not recognized\n"); 	
}
