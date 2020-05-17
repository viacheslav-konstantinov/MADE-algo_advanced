#include <string>

enum compare_type
{
    eq,
    ne,
    le,
    ge,
    g,
    l
};

struct token_struct
{
    bool is_integer;
    std::string str;
    int int_value;
    float float_value;

    void set(const token_struct& lhs);
    void set_new_value  (const token_struct& lhs, const token_struct& rhs, const char oper);
    void compare_and_set(const token_struct& lhs, const token_struct& rhs, const compare_type type);
    void set_negative();
    void set_not();
};