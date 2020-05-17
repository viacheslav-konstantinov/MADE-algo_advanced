%{
    #include <iostream>
    #include <map>
    #include "token_struct.hpp"
    /*struct token_struct
    {
        bool is_integer;
        std::string str;
        int int_value;
        float float_value;
    };*/

    #define YYSTYPE token_struct
    extern int yylineno;
    extern int yydebug;
    extern int yylex();

    void yyerror(const char *s) 
    {
      std::cerr << "While calculating/parsing, an error occured in the line "  << yylineno << ": ";
      std::cerr << s << '\n';
      exit(1);
    }

    std::map<std::string, int>   int_vars;
    std::map<std::string, float> float_vars;

%}

%token EQ LE GE NE
%token NUM FLOAT VAR

%%

PROGRAM: OPS { if(yylex() == 0) std::cout << "File was parsed successfully!\n";}
;

OPS:    OP
|       OPS OP
;


OP:     '\n'
|       EXPR '\n'
;


EXPR:   EXPR1
|       VAR '=' EXPR { 
                        if($3.is_integer)
                        {
                          float_vars.erase($1.str);
                          int_vars[$1.str] = $3.int_value; 
                          std::cout << "Line: " << yylineno - 1 << ", " << $1.str << " = " << $3.int_value << ", type = int\n";
                        }
                        else
                        {
                          int_vars.erase($1.str);
                          float_vars[$1.str] = $3.float_value; 
                          std::cout << "Line: " << yylineno - 1 << ", " << $1.str << " = " << $3.float_value << ", type = float\n";                          
                        }
                      }

EXPR1:  EXPR2
|       EXPR1 EQ EXPR2  {$$.compare_and_set($1, $3, compare_type::eq);}
|       EXPR1 LE EXPR2  {$$.compare_and_set($1, $3, compare_type::le);}
|       EXPR1 GE EXPR2  {$$.compare_and_set($1, $3, compare_type::ge);}
|       EXPR1 NE EXPR2  {$$.compare_and_set($1, $3, compare_type::ne);}
|       EXPR1 '>' EXPR2 {$$.compare_and_set($1, $3, compare_type::g);}
|       EXPR1 '<' EXPR2 {$$.compare_and_set($1, $3, compare_type::l);}
;

EXPR2: TERM
|       EXPR2 '+' TERM {$$.set_new_value($1, $3, '+');}
|       EXPR2 '-' TERM {$$.set_new_value($1, $3, '-');}
;

TERM:   VAL
|       TERM '*' VAL {$$.set_new_value($1, $3, '*');}
|       TERM '/' VAL {
                        if(($3.is_integer && $3.int_value) || (!$3.is_integer && $3.float_value) ) 
                        {
                          $$.set_new_value($1, $3, '/');
                        } 
                        else 
                        {
                          std::cerr << "While calculating, an error occured in the line "  << yylineno << ": ";
                          std::cerr << "division by zero\n"; 
                          exit(1);
                        }
                      }
;

VAL:    NUM
|       FLOAT
|       '-' VAL {$$.set($2); $$.set_negative();}
|       '!' VAL {$$.set($2); $$.set_not();}
|       '(' EXPR ')' {$$.set($2);}
|       VAR {
              if(int_vars.count($1.str)) 
              {
                $$.is_integer = true;
                $$.int_value = int_vars[$1.str];
              } 
              else if(float_vars.count($1.str)) 
              {
                $$.is_integer = false;
                $$.float_value = float_vars[$1.str];
              }
              else
              {
                std::cerr << "While calculating, an error occured in the line "  << yylineno << ": "; 
                std::cerr << "\'" << $1.str << "\' has not been declared\n";
                exit(1);
              }
            }
;
%%

int main() 
{ 
  return yyparse(); 
}