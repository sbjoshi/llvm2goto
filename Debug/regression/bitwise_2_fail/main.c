int fun(int arr[], int n)
{
    int x = arr[0];
    for (int i = 1; i < n; i++)
        x = x ^ ~arr[i];
    return x;
}
int main()
{
	int arr[13];
          // = {9, 12, 2, 11, 2, 2, 10, 9, 12, 10, 9, 11, 2} ;
	arr[0] = 9 ;
	arr[1] = 12 ;
	arr[2] = 2 ;
	arr[3] = 11 ;
	arr[4] = 2 ;
	arr[5] = 2 ;
	arr[6] = 10 ;
	arr[7] = 9 ;
	arr[8] = 12 ;
	arr[9] = 10 ;
	arr[10] = 9 ;
	arr[11] = 11 ;
	arr[12] = 2;
	int x = fun(arr,13);

	assert(x== ~9);

	return 0 ;
}
