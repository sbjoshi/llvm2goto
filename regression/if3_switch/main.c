// #include <assert.h>

int main()
{
	int i,j ;

	if(i>0)
	{
		if(j>0)
		{
			j= j+1 ;
		}
		else if(j==0)
		{
			j = j+1 ;
		}
		else
		{
			j = 0 ;
		}

		assert(j>=0);
	}
	else
	{
		switch(j)
		{
			case 0 : j = -1; break ;
			case -1 : j = -2 ; break ;
			default : j = j ; break ;
		}

		assert(j<0);
	}


	assert((!(i>0) || (j>=0)) && (!(i<=0) ||  (j<0)));
}