int my_func(int a)
{
    int b = a;
    return b;
}

int my_caller()
{
    int var = 5;
    int b = my_func(var);

    return b;
}


