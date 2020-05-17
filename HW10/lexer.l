%{
      #include <iostream>
      #include <string>
      #include <climits>
      #include <cfloat>
      #include <math.h>
      #include "token_struct.hpp"
      /*struct token_struct
      {
         bool is_integer;
         std::string str;
         int int_value;
         float float_value;
      };*/
      
      #define YYSTYPE token_struct

      #include "grammar.tab.h"
      extern int yylineno;

%}

%option yylineno
%option noyywrap

%%

==              return EQ;
[<]=            return LE;
>=              return GE;
!=              return NE;
[0-9]+                           {
                                    yylval.str = yytext;
                                    int64_t value =  std::stol(yytext);
                                    if(value >= INT_MIN && value <= INT_MAX )
                                    {
                                       yylval.is_integer = true;
                                       yylval.int_value = value;
                                       return NUM;
                                    }
                                    else
                                    {
                                       std::cerr << "While parsing, an error occured in the line "  << yylineno << ": "; 
                                       std::cerr << value << " is out of the allowed range\n";
                                       std::cerr << "Allowed range of integers: [" << INT_MIN << ", "  << INT_MAX << "]\n";
                                       yyterminate();
                                       exit(1);
                                    }
                                 }; //new integer

[0-9]+([.][0-9]*)?|[.][0-9]+     {
                                    yylval.str = yytext;
                                    double value =  std::stof(yytext);
                                    double frac_part = std::abs(value) - std::abs(static_cast<int>(value));
                                    if(value >= -FLT_MAX && value <= FLT_MAX )
                                    {
                                       if(frac_part > FLT_MIN || !(frac_part))
                                       {
                                          yylval.is_integer = false;
                                          yylval.float_value = value;
                                          return FLOAT;
                                       }
                                       else
                                       {
                                          std::cerr << "While parsing, an error occured in the line "  << yylineno << ": "; 
                                          std::cerr << "Float-type cannot handle the precision of " << value << "\n";
                                          std::cerr << "Max number of allowed digits after point: " << std::floor(std::log10(FLT_MIN)) << "\n";
                                          yyterminate();
                                          exit(1);                           
                                       }
                                    }
                                    else
                                    {
                                       std::cerr << "While parsing, an error occured in the line "  << yylineno << ": "; 
                                       std::cerr << value << " is out of the allowed range\n";
                                       std::cerr << "Allowed range of floats: [" << -FLT_MAX << ", "  << FLT_MAX << "]\n";
                                       yyterminate();
                                       exit(1);
                                    }
                                 };  //new float

[a-zA-Z_][a-zA-Z0-9_]*           { 
                                    yylval.str = yytext;
                                    return VAR;
                                 }; //new var
[ \t\r]                          ; // ignore tabs and whitespaces
[\n-{};()=<>+*/!,]               { return *yytext; }; //special symbols
.                                {
                                       yylval.str = yytext;
                                       std::cerr << "While parsing, an error occured in the line "  << yylineno << ": ";
                                       std::cerr << "Invalid character\n";
                                       yyterminate();
                                       exit(1);
                                 };

%%