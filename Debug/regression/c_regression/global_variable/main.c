// from CSmith

// #include <assert.h>

int a = 1;
int *b = &a;
int c[2][2][2] = {0, 1, 2, 3, 4, 5, 6, 7};

int main ()
{
    assert(a == 1);
    assert(*b == 1);
    int x = 0;
    for(int i = 0; i < 2; i++)
        for(int j = 0; j <2; j++)
            for(int k = 0; k < 2; k++){
                assert(c[i][j][k] == x);
                x++;
            }
    return 0;
}
