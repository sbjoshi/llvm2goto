// #include <assert.h>

#define N 15

struct QUEUE
{
	int data[N];
	int size; 
};

typedef struct QUEUE QUEUE ;

int main()
{
	QUEUE queue ;
	int n = nondet();



	if(n<N)
	{
		for(int i=0 ; i<n ; i++)
		{
			queue.data[i] = i ;
			++queue.size ;
		}

		int sum = 0;

		for(int i=0 ; i<n ; i++)
		{
			sum += queue.data[i] ;
		}

		assert(sum == ((n-1)*n)/2);
	}	

	return 0 ;
}
