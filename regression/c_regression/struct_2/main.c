// #include <assert.h>
#define N 3

struct S1
{
	int s1_a ;
	int s1_b ;	
};

struct S2
{
	char s2_a ;
	char s2_b ;

	struct S1 s2_s1 ;
}objects[N];

int main()
{
	int v1, v2 ;
	v1 = 48 ;
	v2 = 49;

	int i=0 ;
	while(i<N)
	{
		objects[i].s2_s1.s1_a = v1 ; //= (struct S1){v1,v2};
		objects[i].s2_s1.s1_b = v2 ;
		v1++ ;
		v2++ ;

		assert(objects[i].s2_s1.s1_a == (v1-1) && objects[i].s2_s1.s1_b == (v2-1));
		i++ ;
	}

	i=0 ;
	char c1 = '0';
	char c2 = '1';

	while(i<N)
	{
		objects[i].s2_a = (char) objects[i].s2_s1.s1_a ;
		objects[i].s2_b = (char) objects[i].s2_s1.s1_b ;

		assert(objects[i].s2_a == c1 && objects[i].s2_b == c2);

		c1++ ;
		c2++;
		i++ ;
	}


	return 0 ;
}
