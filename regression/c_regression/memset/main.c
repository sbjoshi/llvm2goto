#include<string.h>
#include<assert.h>
//#define ARR_SIZE 2
int main(){
    int ARR_SIZE = 2;
	int array1[ARR_SIZE] ;
    memset(array1, 0, sizeof(int)*ARR_SIZE);
    for(int i = 0;i < ARR_SIZE;i++){
        assert(array1[i] == 0);
    }
    return 0;
}
