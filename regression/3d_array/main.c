#define N 2

int main()
{
	int array[N][N][N] = {2,2,2,2,2,2,2,2};

	int product = 1 ;

	for(int i=0 ; i<N ; i++)
	{
		int j=0 ;
		while(j<N)
		{
			int k=0 ;

			do
			{
				product = array[i][j][k] * product ;
				k++ ;
			}while(k<2);

			j++ ;
		}
	}


	assert(product == array[0][0][0]*array[0][0][0]*array[0][0][0]*array[0][0][0]*array[0][0][0]*array[0][0][0]*array[0][0][0]*array[0][0][0]);

}
