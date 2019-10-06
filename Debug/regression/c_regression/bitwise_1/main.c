int main()
{
	unsigned int a = 0b00010;
	unsigned int b = 0B00011;

	int res1 = a&b ;
	assert(res1 == 2);

	a = a << 1;
	assert(a==4);

	int res2 = a^b ;
	assert(res2 == 7);

	b = b>>1;
	a = a<<1;
	assert(b==1 && a==8);

	int res3 = a|b ;
	assert(res3 == 9);

	int res4 = ~b ;
	assert(res4 == 0xffffffff-1);

	return 0 ;
}