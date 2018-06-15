// #include <assert.h>
#define N 3

int main()
{
	int arr1[N][N];// = {{1,2,3},{4,5,6},{7,8,9}} ;
	int arr2[N][N] ;//= {{1,2,3},{4,5,6},{7,8,9}} ;

	int x=1 ;
	for(int i=0 ; i<N ; i++)
	{
		for(int j=0 ; j<N ; j++)
		{
			arr1[i][j]=x ;
			arr2[i][j]=x;
			x++ ;
		}
	}

	int arr3[N][N];	


	for(int i=0 ; i<N ; i++)
	{
		for(int j=0 ; j<N ; j++)
		{
			arr3[i][j] = arr1[i][j] + arr2[i][j];
		}
	}


	for(int i=0; i<N; i++)
	{
		for(int j=0 ; j<N ; j++)
		{
			assert(arr3[i][j] != 2*arr1[i][j]);
		}
	}



	return 0 ;

}