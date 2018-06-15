#include <assert.h>
int glob = 10 ;

int main()
{
	int x = 5 ;

	{
		int x = 10 ;

		assert(x==10);
	}

	assert(x==5);

	int glob = 5 ;

	assert(glob ==5);

	{
		int y=10 ;
		assert(x+y == 15);
	}

	return  0;
}