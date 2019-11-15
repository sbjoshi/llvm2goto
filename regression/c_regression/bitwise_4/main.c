int main()
{
	int x = 35 ;
	x = ~x ;
	assert(x == -36);

    int y = ~-12 ;
    assert(y==11);

	assert(x ^ y == (~x & y) | (x & ~y) );	
	return 0 ;
}