%{
	#include<stdio.h>
	#include"y.tab.h"
	#include"st.h"
	extern int line ;
	int yylex();
	int yyerror(char *) ;
	int temp ;
	int t ;
	install (char *sym_name){
		sr *s ;
		s = getsym(sym_name) ;
		if(s == 0)
		s = putsym(sym_name, temp) ; //here
		else{
		//errors++ ;
		printf("%s is already defined, redefined @ line %d\n", sym_name, line) ;
		}
	}

	context_check(char *sym_name){
		if(getsym(sym_name) == 0)
		printf("%s is an undeclared identifier @ line %d\n", sym_name, line) ;
	}

	type_check(char *type, int type_2){
		int type_1 ;
		if(strcmp(type, "int") == 0)
			type_1 =  3 ;
		else if(strcmp(type, "float" == 0)
			type_1 = 4 ;
		else type_1 = 2 ;
		if(type_1 != type_2)
			printf("type mismatch @ line %d\n", line) ;
	}

%}
%union{
	/*SEMANTIC RECORD FOR RETURNING IDENTIFIERS*/
	int ival ;
	char *id ;
	float fval ;

}
%token INT FLOAT CHAR VOID FOR IF ELSE 
%token PRINTF NUM STRING FNUM
%token <id> IDENTIFIER
%token INCLUDE INCR DECR
%token GE EE LE NE
%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE



%start start

%%
start:
      INCLUDE start | function start | 
      ;

function:
	  type IDENTIFIER '(' arg ')'  compound_statement | 
	  type IDENTIFIER '(' type ')' ';' 
	  ;

arg:
	type IDENTIFIER | 
	;

compound_statement:
	  '{' statement_list '}' |
	  '{' '}'
	  ;

statement_list:
		statement | 
		statement statement_list 
		;

statement:
		declaration |
		assignment |
		for |
		if_else|
		function_call |
		print |
		array 
		;

declaration:
		type identifier_list ';' ;

identifier_list:
		IDENTIFIER ',' identifier_list {install($1) ;} | 
		IDENTIFIER {install($1) ;}
		;

assignment:
		IDENTIFIER '=' expression ';' {context_check($1) ; sr *ss = getsym($1) ;  type_check(ss->type, t);}
		;

expression:
		term expression_1
		;

expression_1:
		'+' term expression_1 |
		'-' term expression_1 |
		;

term:
		factor term_1 
		;

term_1:
		'*' factor term_1 |
		'/' factor term_1 |
		;

factor:
		IDENTIFIER {context_check($1) ;sr *ss = getsym($1); if(!strcmp(ss->type, "int")) t = 3; else t = 4 ;}|
		'(' expression ')' | 
		NUM {t = 3;} | FNUM {t = 4;} | STRING {t = 2;}
		;

rel_expression:
		factor_rel rel_expression_1 ;

rel_expression_1:
		'<' factor_rel rel_expression_1 |
		'>' factor_rel rel_expression_1 |		
		LE  factor_rel rel_expression_1 |
		GE  factor_rel rel_expression_1 |
		EE  factor_rel rel_expression_1 |
		NE  factor_rel rel_expression_1 |
		;

factor_rel:
		IDENTIFIER {context_check($1) ;} | NUM
		;

for:
		FOR '(' assignment  rel_expression  ';' update ')' compound_statement |

		FOR '(' assignment  rel_expression  ';' update ')' statement 
		;

if_else:
		IF '(' rel_expression ')' compound_statement %prec LOWER_THAN_ELSE |
		IF '(' rel_expression ')' compound_statement ELSE
		compound_statement 
		;

array:
		type IDENTIFIER '[' NUM ']' ';' {install($2) ;}      |
		type IDENTIFIER '[' NUM ']' '=' STRING ';' {install($2) ;}      |
		IDENTIFIER '[' NUM ']' '=' STRING ';' {context_check($1) ;}|
		type IDENTIFIER '[' NUM ']' '=' NUM ';' {install($2) ;}      |
		IDENTIFIER '[' NUM ']' '=' NUM ';' {context_check($1) ;} 
		;

function_call:
		IDENTIFIER '(' IDENTIFIER ')' ';'
		;

print:
		PRINTF'(' STRING ',' identifier_list ')' ';' |
		PRINTF '(' STRING ')' ';' 
		;

update:
		IDENTIFIER INCR {context_check($1) ;} | IDENTIFIER DECR {context_check($1) ;} 
		;

type:
 		INT {temp = 3 ;}  | 
 		VOID {temp = 1 ;} | 
 		CHAR {temp = 2 ;} | 
 		FLOAT {temp = 4 ;}
 		;

%%

int main(int argc, char *argv[]){ 

	extern FILE *yyin;
	yyin = fopen( "test_cases/semantic/test2.c", "r" ); //change depending on test cases
	yyparse ();
	return 0 ;
}
/* Called by yyparse on error */

int yyerror(char *s){
	printf("%s @ line %d\n", s, line);
	return 0 ;
}