int main()
{
	int array[3][3] ;

	array[1][2] = 10 ;

	int x = *(*(array+1)+2);
	assert(x==10);

	return 0 ;
}
