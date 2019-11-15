#include<assert.h>
void init(int a[100], int n){
    for(int i = 0; i<n;i++)
        a[i] = i+1;
}

int main(){
    int a[100];
    init(a, 100);
    for(int i = 0; i<100; i++)assert(a[i] == i+1);
    return 0;
}
