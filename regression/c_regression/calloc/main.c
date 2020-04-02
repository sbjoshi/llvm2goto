#include<stdlib.h>
#include<assert.h>

int main(){
    int *a = calloc(10, sizeof(int));

    for(int i =0;i<10;i++)
        assert(a[i] == 0);
    return 0;
}
