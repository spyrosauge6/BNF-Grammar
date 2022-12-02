%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern char* yytext();
extern int yylex();

int nerror=0;

void yyerror(const char *s);
extern int count;
FILE *yyin;

%}



%token PROGRAM STARTMAIN ENDMAIN 
%token FUNCTION END_FUNCTION RETURN

%token WHILE ENDWHILE 

%token VARS INTEGER CHAR

%token IF THEN ELSE ELSEIF ENDIF

%token SWITCH CASE ENDSWITCH DEFAULT

%token FOR TO STEP ENDFOR

%token PRINT BREAK


%token STRUCT TYPEDEF ENDSTRUCT
%token AND OR

%token LE GE EQ NE

%token ID_NAME 
%token INTNUM CHARS


%%


program_p: 		PROGRAM ID_NAME decl_program main_program ;
decl_program:		| decl_functions 
			| decl_struct 
			| struct_set decl_functions  ;

decl_functions: 	function_set | 
			decl_functions function_set;

function_set: 		FUNCTION function_name decl_variables commands_rule return_rule END_FUNCTION;
return_rule: 		RETURN expr;
function_name:		ID_NAME '(' ')' 
			| ID_NAME '(' ids_wih_comma ')' ;

ids_wih_comma: 	id_names_arr | ids_wih_comma ',' id_names_arr ;
id_names_arr:		ID_NAME | ID_NAME '[' INTNUM ']';
							
decl_variables: 	| VARS vars ;
vars: 			varm |vars varm;
varm: 	 		typos_dedomenwn ids_wih_comma ';' ;

decl_struct:		struct_set 
			| decl_struct struct_set;

struct_set: 		STRUCT ID_NAME decl_variables ENDSTRUCT ';' |
			TYPEDEF STRUCT ID_NAME decl_variables ENDSTRUCT ';' ;

typos_dedomenwn:	INTEGER | CHAR  ;
 
main_program: 		STARTMAIN decl_variables commands_rule ENDMAIN ;

commands_rule:		entoli | commands_rule entoli;

entoli:		anathesi
			| if | switch
			| while | for
			| print  
			| BREAK;


anathesi: 		ID_NAME '=' expr ';' ;


if: 			if_main ENDIF |	if_main if_else_part ENDIF;
if_else_part:		else_if_part else | else;
if_main: 		IF '(' contition ')'  THEN commands_rule;
else_if_part: 		ELSEIF '(' contition ')' commands_rule 
			| ELSEIF '(' contition ')' commands_rule else_if_part;
else:				ELSE commands_rule; 


switch: 		SWITCH '(' expr ')' case_part default ENDSWITCH ;
case_part:		case_rule | case_part case_rule; 	
default:		| DEFAULT commands_rule;
case_rule:		CASE '(' expr ')' commands_rule;


while: 		WHILE '(' contition ')' commands_rule ENDWHILE;
for: 			FOR ID_NAME ':' '=' INTNUM TO INTNUM STEP INTNUM commands_rule ENDFOR;

		
print: 		PRINT '(' CHARS ',' exprs2 ')'';' | PRINT '(' CHARS ')'';';
		





contition: 		expr contitions_oper expr 
			| contition AND contition 
			| contition OR contition ;

contitions_oper:	'>' | '<' |  EQ | NE| GE |LE;

expr: 			basic_factors | expr num_oper expr | '(' expr ')' ;
basic_factors: 	vars_consts  | ID_NAME '(' exprs2 ')';

num_oper: 		'+'|'-'|'/'|'*';

vars_consts: 		ids_wih_comma | INTNUM | CHARS ;
exprs2:		| expr | vars_consts ',' expr;


%%

void yyerror(const char *s)
{
       nerror=1;
       printf("You have an error in line %d \n", count );
       
       exit(1);
      		
}


int main(int argc, char *argv[]){
	FILE *file;
	
	file=fopen(argv[1],"r");
	
	
	yyin = file; 
	yyparse();
	fclose(file);
	
	if(nerror==0)
	{
		printf("\n\nProgram is ok  \n");
	}
	return 0;
}


