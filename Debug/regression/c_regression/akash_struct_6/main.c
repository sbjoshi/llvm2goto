struct S1
{
	int x,y,z ;

	struct S2
	{
		int* x_ptr;
		int* y_ptr ;
		int* z_ptr ;
	}s2; 
};

int main()
{
	struct S1 s1 ;

	s1.x = 5 ;
	s1.y = 10 ;
	s1.z = 10 ;

	s1.s2.x_ptr = &(s1.x) ;
	s1.s2.y_ptr = &(s1.y) ;
	s1.s2.z_ptr = &(s1.z) ;

	assert(*(s1.s2.x_ptr) == s1.x);
	assert(*(s1.s2.y_ptr) = s1.y);
	assert(*(s1.s2.z_ptr) = s1.z);

	s1.x += 5 ;

	assert((*s1.s2.x_ptr + *s1.s2.y_ptr + *s1.s2.z_ptr) == 30);


	return 0 ;
}
