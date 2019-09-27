#include"assert.h"
int main(){
    int a[2][3][4][2][2];
        
    int (*q)[2][3][4] = &a;
    (*q+1)[0][0][0] = 55555555;
    assert(a[0][0][3][0][0] == 55555555);
    return 0;
}
