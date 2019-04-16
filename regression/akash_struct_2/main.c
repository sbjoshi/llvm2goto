// #include <assert.h>

struct test{
    int a;
    int b;
    char c;
};

int main()
{
    struct test a;
    a.a = 10;
    a.b = 20;
    a.c = 'a';
    assert(a.a == 10);
    assert(a.b == a.a*2);
    assert(a.c == 'a');    
	return 0 ;
}
