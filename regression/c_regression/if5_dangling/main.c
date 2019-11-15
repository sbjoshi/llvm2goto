int main()
{	
	int testscore = 55 ;
	int fail = 0 ;

	if(testscore >= 50)
		if ( testscore > 90 )
			fail = 0;
	else 
		fail = 1;
	  	

	assert(fail==1);
   return 0 ;
}