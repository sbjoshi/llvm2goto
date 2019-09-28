// #include <assert.h>

int f1(int a, int b)
{
  return a+b;
}

int f2(int a, int b)
{
  return a-b;
}

int main()
{
    int c = 10;
    int (*f_ptr)(int, int);
    f_ptr = f1;
    c = f_ptr(c, 20);
    assert(c == 30);
    f_ptr = f2;
    c = f_ptr(c, 20);
    assert(c == 10);
    return 0;
}
