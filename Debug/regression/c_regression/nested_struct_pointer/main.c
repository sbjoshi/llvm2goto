struct S1
{
	int x,y,z ;

	struct S2
	{
		int* x_ptr;
		int* y_ptr ;
		int* z_ptr ;
	}*s2; 
}s1;

int main()
{
	struct S1* s1_ptr ;
	struct S1::S2 s2 ;


	s1_ptr = &s1 ;
	s1_ptr->s2 = &s2 ;

	s1_ptr->x = 5 ;
	s1_ptr->y = 10 ;
	s1_ptr->z = 10 ;

	s1_ptr->s2->x_ptr = &(s1.x) ;
	s1_ptr->s2->y_ptr = &(s1.y) ;
	s1_ptr->s2->z_ptr = &(s1.z) ;

	assert((*(s1_ptr->s2->x_ptr) == s1.x) && (*(s1_ptr->s2->y_ptr) = s1.y) && (*(s1_ptr->s2->z_ptr) = s1.z));

	s1.x += 5 ;

	assert((*s1_ptr->s2->x_ptr + *s1_ptr->s2->y_ptr + *s1_ptr->s2->z_ptr) == 30);


	return 0 ;
}