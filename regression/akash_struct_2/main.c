// #include <assert.h>
//#include <stdio.h>
struct test2{
    int c;
};
struct test{
    int a;
    int b[20][30];
    char c;
};

int main()
{
    //struct test a;
    struct test2 new;
    struct test var;
    new.c = 35;
    var.b[10][5] = 35;
    assert(var.b[10][5] == new.c);
	return 0 ;
}
