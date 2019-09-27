#include<assert.h>
int main(){
    int a = 10;
    int b = 2;
    switch(b){
        case 1:{
            a+=10;
            break;
        }
        case 2:{
            a*=10;
        }
        case 3:{
            a-=5;
            break;
        }
        default :{
            a/=2;
        }
    }
    assert(a == 95);
    return 0;
}

