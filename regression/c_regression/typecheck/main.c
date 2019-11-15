// CHECKING FOR SIMPLE DATA TYPES and TYPE CONVERSION
#include <assert.h>

int main()
{
	//Checking char
	char a1 = 'a' ;
 	a1 = a1+1 ;

 	assert(a1 == 'b');

 	//Checking unsigned int
 	unsigned int unsign = 0 ;
 	unsign-- ;

 	assert(unsign>0);	

 	//Checking float to double implicit conversion
 	double a =  8394223.6; 
 	float b = 100.04 ;
 	double c ; 
 	c = a+b ;

 	assert(c >= 8394223.64);

 	//Checking for float explicit conversion
 	long b2 = 100 ;
 	long d = b2 - (int)(0xf00000000);

 	assert(d == b2);

 	return  0;


}