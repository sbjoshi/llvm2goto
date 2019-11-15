#include<assert.h>
#include<limits.h>
struct akash{
    int a;
};

struct strct1{
    double c;
    int a[50];
};

struct strct2{
    int a;
    struct strct1 my_ar[50];
};

int foo(int x){
    if(x<0)return -x;
    return x;
}

void no_ret(unsigned a, int b){
    int c = a+b;
    unsigned d = a+b;
    assert(a+b == c);
    assert(c == d);
}

unsigned test_func(){
    return UINT_MAX;
}

typedef struct akash funtype;
typedef int cooltype;
int main(){
    union un_test{
        funtype struc;
        cooltype integer;
    };
    typedef union un_test besttype;
    
    besttype union_arr[100][50];
    
    unsigned a = -10;
    long b = 20;
    double d;
    float f;
    struct akash s;
    funtype *p;
    cooltype ct = a + b;
    assert(ct == 10);
    int x;
    assert(foo(x) >=0);
    assert(test_func() == UINT_MAX);
    assert((foo(x)*foo(x)) >=0);
    int a1 = -100;
    int a2 = 20;
    assert(a1/a2 == -5);
    unsigned a3 = 100;
    assert(a3/a2 == 5);
    assert(a1/a3 == -1);
    assert(a3/a1 == -1);
    assert(a2/a3 == 0);
    unsigned a4 = UINT_MAX;
    a4 = a4 / 2u;
    assert(a4 == 2147483647);
    struct strct2 new_arr[25];
    
    for(int i = 0; i<5; i++)
        for(int j = 0; j<5;j++)
            new_arr[5].my_ar[i].a[j] = i+j;
            
    for(int i = 0; i<5; i++)
        for(int j = 0; j<5;j++)
            assert(new_arr[5].my_ar[i].a[j] == i+j);
    return 0;
}
