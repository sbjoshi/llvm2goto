struct S
{
	int* ptrs[3];
}s_arr[3];

int main()
{
	int array[3][3] ; //= {{11,12,13},{14,15,16},{17,18,19}};
	int temp = 11;

	for(int i=0 ; i<3 ; i++)
	{
	  for(int j=0 ; j<3 ; j++)
	  {
               array[i][j] = temp ;
               temp++ ;
          }
        }

	struct S * s_ptr ;
	s_ptr = s_arr ;

	for(int i=0 ; i<3 ; i++)
	{
		for(int j=0 ; j<3 ;j++)
		{
			s_arr[i].ptrs[j] = (*(array+i)+j);
		}
	}

	int x=11 ;
	for(int i=0 ; i<3 ; i++)
	{
		for(int j=0 ; j<3 ; j++)
		{
			assert(*((*(s_ptr+i)).ptrs[j]) == x);
			x++ ;
		}
	}

	return 0 ;
}
