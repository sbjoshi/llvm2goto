#include<assert.h>
int main(){
    int a[5], n;
    for(int i = 1; i<5; i++){
        int k = i;
        while(a[k] < a[k-1] && k >= 1){
            int t = a[k];
            a[k] = a[k-1];
            a[k-1] = t;
            k--;
        }
    }
    for(int i = 1; i<5;i++)
        assert(a[i] >= a[i-1]);
}
