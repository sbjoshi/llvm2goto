int main()
{
	int arr1[3][3];// = {{1,2,3},{4,5,6},{7,8,9}} ;
	int arr2[3][3] ;//= {{1,2,3},{4,5,6},{7,8,9}} ;

	int x=1 ;
	for(int i=0 ; i<3 ; i++)
	{
		for(int j=0 ; j<3 ; j++)
		{
			arr1[i][j]=x;
			arr2[i][j]=x;
			x++ ;
		}
	}
	assert(1);
    return 0;
}
