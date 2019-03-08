int main(){
    int a[3][3];
    
    int (*p1)[3];
    p1 = &a[1];
        
    int *p2;
    
    p2 = &(*p1)[2];
    *p2 = 100;
    assert(a[1][2] == 100);
    return 0;
}
