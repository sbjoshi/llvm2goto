#define N 3

int main()
{
	int arr1[N];
	int arr2[N];

	int x=1 ;
	for(int i=0 ; i<N ; i++)
	{
	    arr1[i]=x;
	    arr2[i]=x;
	    x++ ;
	}

	int arr3[N];	


	for(int i=0 ; i<N ; i++)
	{
		arr3[i] = arr1[i] + arr2[i];
	}


	for(int i=0; i<N; i++)
	{
		assert(arr3[i] != 2*arr1[i]);
	}
	return 0 ;

}
