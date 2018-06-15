// #include <assert.h>

int main()
{
	switch((1+2/2*4-1))
	{
		case 5: assert(1); break;
		default : assert(0); break;
	}

	return 0 ;
}