#include<stdlib.h>
int main(){
    int *a = malloc(sizeof(int)*10);
    for(int i =0;i<=11;i++)
        a[i] = 1;

    for(int i =0;i<=11;i++)
        assert(a[i] == 1);
    return 0;
}
