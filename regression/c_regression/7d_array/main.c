#define N1 1
#define N2 1
#define N3 1
#define N4 1
#define N5 1
#define N6 1
#define N7 2

int main()
{
	int arr1[N1][N2][N3][N4][N5][N6][N7];
	int arr2[N1][N2][N3][N4][N5][N6][N7];

	int x=1 ;
	for(int i=0 ; i<N1 ; i++)
	{
		for(int j=0 ; j<N2 ; j++)
		{
	        for(int k=0 ; k<N3 ; k++)
	        {
		        for(int l=0 ; l<N4 ; l++)
		        {
		            for(int m=0; m<N5; m++)
		            {
		                for(int n=0 ; n<N4 ; n++)
		                {
		                    for(int o=0; o<N5; o++)
		                    {
			                    arr1[i][j][k][l][m][n][o]=x;
			                    arr2[i][j][k][l][m][n][o]=x;
			                    x++ ;
		                    }
	                    }
                    }
	            }
            }
		}
	}

	int arr3[N1][N2][N3][N4][N5][N6][N7];
	
	for(int i=0 ; i<N1 ; i++)
	{
		for(int j=0 ; j<N2 ; j++)
		{
	        for(int k=0 ; k<N3 ; k++)
	        {
		        for(int l=0 ; l<N4 ; l++)
		        {
		            for(int m=0; m<N5; m++)
		            {
		                for(int n=0 ; n<N4 ; n++)
		                {
		                    for(int o=0; o<N5; o++)
		                    {
			                    arr3[i][j][k][l][m][n][o] = arr1[i][j][k][l][m][n][o] + arr2[i][j][k][l][m][n][o];
		                    }
	                    }
                    }
	            }
            }
		}
	}
	
	for(int i=0 ; i<N1 ; i++)
	{
		for(int j=0 ; j<N2 ; j++)
		{
	        for(int k=0 ; k<N3 ; k++)
	        {
		        for(int l=0 ; l<N4 ; l++)
		        {
		            for(int m=0; m<N5; m++)
		            {
		                for(int n=0 ; n<N4 ; n++)
		                {
		                    for(int o=0; o<N5; o++)
		                    {
			                    assert(arr3[i][j][k][l][m][n][o] == 2*arr1[i][j][k][l][m][n][o]);
			                    assert(arr3[i][j][k][l][m][n][o] == 2*arr2[i][j][k][l][m][n][o]);
			                    assert(arr1[i][j][k][l][m][n][o] == arr2[i][j][k][l][m][n][o]);
		                    }
	                    }
                    }
	            }
            }
		}
	}



	return 0 ;

}
