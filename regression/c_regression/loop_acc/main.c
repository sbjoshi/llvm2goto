#include <assert.h>
int main(){
    int i = 0;
    int n;
    while(i < n){
        i+=2;
    }
    while(i > 0){
        i-=2;
    }
    assert(i == 0);
    return 0;
}

