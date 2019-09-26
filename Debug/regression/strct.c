#include<assert.h>
struct strct1{
    double c;
    int a[50];
};

struct strct2{
    int a;
    struct strct1 my_ar[50];
};

int main(){
    struct strct2 new_arr[25];
    return 0;
}

