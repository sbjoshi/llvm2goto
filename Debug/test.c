#include<assert.h>
struct akash{
    int a;
};

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
    //assert(ct == 10);    
    return 0;
}
