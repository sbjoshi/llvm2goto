#include<assert.h>
int myfunc(int, int);

int f1(int a, int b)
{
  return a+b;
}

int f2(int a, int b)
{
  return a-b;
}

int main(){
    int a = my_func(2, 3);
    int c = 10;
    int (*f_ptr)(int, int);
    f_ptr = f1;
    c = f_ptr(c, 20);
    assert(c == 30);
    f_ptr = f2;
    c = f_ptr(c, 20);
    assert(c == 10);
    assert(a == 5);
    return 0;
}
