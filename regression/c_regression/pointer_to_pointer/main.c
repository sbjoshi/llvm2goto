#include <assert.h>

int main()
{
	int a[5] ;
	// {1,2,3,4,5} ;

	for(int i=0 ; i<5 ; i++)
	{
		a[i] = i+1 ;
	}
	
	int* a1 ;
	int** a2 ;

	a1 = a ;
	a2 = &a1 ;

	assert(*a1==1);

	a1++;
	a1++ ;

	assert(**a2 == 3);

	return 0 ; 
}