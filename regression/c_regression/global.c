#include<assert.h>
int a[][3] = {{1,2,3}, {4,5,6}};
int global = 20;
int main(){
    assert(global == 20);
    int x = 1;
    for(int i = 0; i<2; i++)
        for(int j = 0; j<3; j++,x++)
            assert(a[i][j] == x);
    return 0;
}
