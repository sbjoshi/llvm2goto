#define N1 2
#define N2 3
#define N3 4
int main()
{
	unsigned arr1[N1][N2][N3];// = {{1,2,3},{4,5,6},{7,8,9}} ;
	unsigned arr2[N1][N2][N3] ;//= {{1,2,3},{4,5,6},{7,8,9}} ;

	unsigned x=1 ;
	for(int i=0 ; i<N1 ; i++)
	{
		for(int j=0 ; j<N2 ; j++)
		{
		    for(int k = 0; k < N3; k++)
		    {
			    arr1[i][j][k]=x;
			    arr2[i][j][k]=x;
			    x++ ;
		    }
		}
	}

	unsigned arr3[N1][N2][N3];	


	
	for(int i=0 ; i<N1 ; i++)
	{
		for(int j=0 ; j<N2 ; j++)
		{
		    for(int k = 0; k < N3; k++)
		    {
			    arr3[i][j][k] = arr1[i][j][k] + arr2[i][j][k];
		    }
		}
	}


	for(int i=0; i<N1; i++)
	{
		for(int j=0 ; j<N2 ; j++)
		{
		    for(int k = 0; k < N3; k++)
		    {
		        assert(arr1[i][j][k] == arr2[i][j][k]);
			    assert(arr3[i][j][k] == 2*arr1[i][j][k]);
			    assert(arr3[i][j][k] == 2*arr2[i][j][k]);
		    }
		}
	}

	return 0 ;

}
