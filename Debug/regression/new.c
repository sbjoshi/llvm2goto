#include"assert.h"
int main(){
    int a[2][3][4];
        
    int (*q)[2][3][4] = &a;
    (*q+1)[0][0][0] = 55555555;
    assert(a[1][0][0] == 55555555);
    return 0;
}
