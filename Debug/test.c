struct akash{
    int a;
};

typedef struct akash funtype;
typedef int cooltype;
int main(int argc,char**argv){
    //int zzzzzz = argc;
    union un_test{
        funtype struc;
        cooltype integer;
    };
    typedef union un_test besttype;
    
    besttype union_arr[100][50];
    
    unsigned a = -10;
    long b = 20;
    int c = a+b;
    double d;
    float f;
    struct akash s;
    funtype *p;
    cooltype ct;
    return 0;
}
