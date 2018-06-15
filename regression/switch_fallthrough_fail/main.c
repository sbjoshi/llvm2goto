int main()
{
	switch((1+2/2*4-1)>>3)
	{
	  case 0 : assert(1);
	  case 1 : assert(1);
	  case 2 : assert(1);
	  default : assert(0);
	}

	return 0 ;
}