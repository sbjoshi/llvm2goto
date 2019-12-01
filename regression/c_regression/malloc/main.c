int main(){
    int *a = malloc(40);
    for(int i =0;i<10;i++)
        a[i] = 1;

    for(int i =0;i<10;i++)
        assert(a[i] == 1);
    return 0;
}
