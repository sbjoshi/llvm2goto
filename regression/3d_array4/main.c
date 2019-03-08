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

			while(k<2)
			{
			    array[i][j][k] = 2;
				product = array[i][j][k] * product ;
				k++ ;
			}

			j++ ;
		}
	}

	assert(product == array[0][0][0]*array[0][0][0]*array[0][0][0]*array[0][0][0]*array[0][0][0]*array[0][0][0]*array[0][0][0]*array[0][0][0]);

}
