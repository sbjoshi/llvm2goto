#define N 2

int main()
{
	int array[N][N][N];
	

	int product = 1 ;

	for(int i=0 ; i<N ; i++)
	{
		int j=0 ;
		while(j<N)
		{
			int k=0 ;

			do
			{
				array[i][j][k] = k;
				k++ ;
			}while(k<2);

			j++ ;
		}
	}


	assert(array[0][0][0] == 0 && array[0][1][1] == 1);
	return 0;

}
