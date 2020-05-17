#include <string>
#include "token_struct.hpp"


void token_struct::set(const token_struct& lhs)
{
    is_integer = lhs.is_integer;
    int_value = lhs.int_value;
    float_value = lhs.float_value;
}


void token_struct::set_negative()
{
    int_value = -int_value;
    float_value = -float_value;
}


void token_struct::set_not()
{
    if(is_integer)
    {
        if(int_value)
        {
            int_value = 1;
        }
        else
        {
            int_value = 0;
        }
    }
    else
    {
        is_integer = true;
        if(float_value)
        {
            int_value = 1;
        }
        else
        {
            int_value = 0;
        }        
    }
}


void token_struct::compare_and_set(const token_struct& lhs, const token_struct& rhs, const compare_type oper)
{
    is_integer = true;
    if(lhs.is_integer && rhs.is_integer)
    {
        switch(oper)
        {
            case compare_type::eq:
                int_value = static_cast<int>(lhs.int_value == rhs.int_value);
                break;
            case compare_type::ne:
                int_value = static_cast<int>(lhs.int_value != rhs.int_value);
                break;
            case compare_type::g:
                int_value = static_cast<int>(lhs.int_value >  rhs.int_value);
                break;
            case compare_type::l:
                int_value = static_cast<int>(lhs.int_value <  rhs.int_value);
                break;
            case compare_type::ge:
                int_value = static_cast<int>(lhs.int_value >= rhs.int_value);
                break;
            case compare_type::le:
                int_value = static_cast<int>(lhs.int_value <= rhs.int_value);
                break;
        }
        
    }
    else if (!lhs.is_integer && !rhs.is_integer)
    {
        switch(oper)
        {
            case compare_type::eq:
                int_value = static_cast<int>(lhs.float_value == rhs.float_value);
                break;
            case compare_type::ne:
                int_value = static_cast<int>(lhs.float_value != rhs.float_value);
                break;
            case compare_type::g:
                int_value = static_cast<int>(lhs.float_value >  rhs.float_value);
                break;
            case compare_type::l:
                int_value = static_cast<int>(lhs.float_value <  rhs.float_value);
                break;
            case compare_type::ge:
                int_value = static_cast<int>(lhs.float_value >= rhs.float_value);
                break;
            case compare_type::le:
                int_value = static_cast<int>(lhs.float_value <= rhs.float_value);
                break;
        }
        
    }
    else if(!lhs.is_integer)
    {
        switch(oper)
        {
            case compare_type::eq:
                int_value = static_cast<int>(lhs.float_value == static_cast<float>(rhs.int_value));
                break;
            case compare_type::ne:
                int_value = static_cast<int>(lhs.float_value != static_cast<float>(rhs.int_value));
                break;
            case compare_type::g:
                int_value = static_cast<int>(lhs.float_value >  static_cast<float>(rhs.int_value));
                break;
            case compare_type::l:
                int_value = static_cast<int>(lhs.float_value <  static_cast<float>(rhs.int_value));
                break;
            case compare_type::ge:
                int_value = static_cast<int>(lhs.float_value >= static_cast<float>(rhs.int_value));
                break;
            case compare_type::le:
                int_value = static_cast<int>(lhs.float_value <= static_cast<float>(rhs.int_value));
                break;
        }
        
    }
    else
    {
        switch(oper)
        {
            case compare_type::eq:
                int_value = static_cast<int>(static_cast<float>(lhs.int_value) == rhs.float_value);
                break;
            case compare_type::ne:
                int_value = static_cast<int>(static_cast<float>(lhs.int_value) != rhs.float_value);
                break;
            case compare_type::g:
                int_value = static_cast<int>(static_cast<float>(lhs.int_value) >  rhs.float_value);
                break;
            case compare_type::l:
                int_value = static_cast<int>(static_cast<float>(lhs.int_value) <  rhs.float_value);
                break;
            case compare_type::ge:
                int_value = static_cast<int>(static_cast<float>(lhs.int_value) >= rhs.float_value);
                break;
            case compare_type::le:
                int_value = static_cast<int>(static_cast<float>(lhs.int_value) <= rhs.float_value);
                break;
        }    
    }
}


void token_struct::set_new_value(const token_struct& lhs, const token_struct& rhs, const char oper)
{
    is_integer = (lhs.is_integer && rhs.is_integer);

    if(is_integer)
    {
        switch(oper)
        {
            case '+':
                int_value = lhs.int_value + rhs.int_value;
                break;
            case '-':
                int_value = lhs.int_value - rhs.int_value;
                break;
            case '*':
                int_value = lhs.int_value * rhs.int_value;
                break;
            case '/':
                int_value = lhs.int_value / rhs.int_value;
                break;
        }
        
    }
    else if (!lhs.is_integer && !rhs.is_integer)
    {
        switch(oper)
        {
            case '+':
                float_value = lhs.float_value + rhs.float_value;
                break;
            case '-':
                float_value = lhs.float_value - rhs.float_value;
                break;
            case '*':
                float_value = lhs.float_value * rhs.float_value;
                break;
            case '/':
                float_value = lhs.float_value / rhs.float_value;
                break;
        }
        
    }
    else if(!lhs.is_integer)
    {
        switch(oper)
        {
            case '+':
                float_value = lhs.float_value + static_cast<float>(rhs.int_value);
                break;
            case '-':
                float_value = lhs.float_value - static_cast<float>(rhs.int_value);
                break;
            case '*':
                float_value = lhs.float_value * static_cast<float>(rhs.int_value);
                break;
            case '/':
                float_value = lhs.float_value / static_cast<float>(rhs.int_value);
                break;
        }
        
    }
    else
    {
        switch(oper)
        {
            case '+':
                float_value = static_cast<float>(lhs.int_value) + rhs.float_value;
                break;
            case '-':
                float_value = static_cast<float>(lhs.int_value) - rhs.float_value;
                break;
            case '*':
                float_value = static_cast<float>(lhs.int_value) * rhs.float_value;
                break;
            case '/':
                float_value = static_cast<float>(lhs.int_value) / rhs.float_value;
                break;
        }
        
    }
}