%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "bison.tab.h"

int count=1;	
void check_cmns();
%}
%option noyywrap 

%%
[ \t]		{ }
[\n]		{count++; }

"PROGRAM" 	{ return PROGRAM; }
"STARTMAIN" 	{ return STARTMAIN; }
"ENDMAIN" 	{ return ENDMAIN; }
"FUNCTION" 	{ return FUNCTION; }
"END_FUNCTION" { return END_FUNCTION; }
"RETURN"	{ return RETURN; }


"VARS"		{ return VARS; }
"CHAR"		{ return CHAR; }
"INTEGER"	{ return INTEGER; }


"WHILE"	{ return WHILE; }
"ENDWHILE"	{ return ENDWHILE; }


"FOR"		{ return FOR; }
"TO"		{ return TO; }
"STEP"		{ return STEP; }
"ENDFOR"	{ return ENDFOR; }


"IF"		{return IF;}
"THEN"		{ return THEN; }
"ELSE"		{return ELSE; }
"ELSEIF"	{return ELSEIF; }
"ENDIF"	{return ENDIF;}


"AND"		{ return AND; }
"OR"		{ return OR; }

"SWITCH"	{return SWITCH; }
"CASE"		{return CASE; }
"DEFAULT"	{return DEFAULT; }
"ENDSWITCH"	{return ENDSWITCH; }

"PRINT"		{return PRINT;}
"BREAK"		{return BREAK;}


"STRUCT"	{return STRUCT;}
"ENDSTRUCT"	{return ENDSTRUCT;}
"TYPEDEF"	{return TYPEDEF;}



">"		{return '>';}
"<"		{return '<';}
"="		{return '=';}
"+"		{return '+';}
"-"		{return '-';}
"/"		{return '/';}
"^"		{return '^';}
"*"		{ return '*';}
";"		{ return ';';}
"("		{ return '(';}
")"		{ return ')';}
"["		{ return '[';}
"]"		{ return ']';}
","		{return ',';}
"!"		{return '!';}
"%"		{return '%';}

"<="		{return GE;}
">="		{return LE;}
"=="		{return EQ;}
"!="		{return NE;}

\"[^\n]*\"	{return CHARS;}
[0-9]+		{return INTNUM;}

([a-zA-Z_])([a-zA-Z_]|[0-9])* {return ID_NAME;}


"/*"           { check_cmns(); }
%%



void check_cmns()
{

   char c;
   
   for (;;)
    {   
   	while((c=input())!='*' && c!=EOF)
	  {
	  if (c=='\n') count++;
	   }	 
	   
         c=input();	
     
         if (c=='/' || c==EOF) break;

    }  

}

