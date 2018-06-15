int main()
{
	int x = 16 ;

	//Associativity
	int res1 = x>>1<<1>>3<<2;
	assert(res1==8);

	unsigned int y = 0xfffff ;
	int res2 = y&y ;

	assert(res2<0); //Will be -1

	//Associativity
	int arr[5] ; //= {2,1,3,5,7};
	arr[0] = 1 ; arr[1] = 1; arr[2] = 3 ; arr[3] = 5 ; arr[4] = 7 ;

	int res3 = arr[0] & arr[1] & arr[2] & arr[3] & arr[4];
	assert(res3==0);

	//Precedence
	int res4 = 4 & (5 | 8);
	assert(res4 == 12);
	return 0 ;
}

