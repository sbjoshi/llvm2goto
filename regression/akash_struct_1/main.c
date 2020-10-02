struct test2{
    int c;
    unsigned d;
};
struct test1{
    int a;
    unsigned b;
};

int main()
{
    struct test1 x1;
    struct test2 x2;
    x1.a = -10;
    x1.b = 20;
    x2.c = -30;
    x2.d = 40;
    assert(x1.a == -10);
    assert(x1.b ==  20);
    assert(x2.c == -30);
    assert(x2.d ==  40);
	return 0 ;
}
