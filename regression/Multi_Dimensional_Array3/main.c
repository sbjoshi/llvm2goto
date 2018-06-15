unsigned int nondet_uint();

typedef int *iptr;

int x, y, z;

int main()
{
  // this checks whether the alias analysis can
  // track pointers in multi-dimensional arrays

  iptr array[3][3] ; //={{&x,0,0},{&y,0,0},{&z,0,0}};

  for(int i=0 ; i<3; i++)
  {
     for(int j=0 ; j<3 ; j++)
     {
       for(int k=0 ; k<3 ; k++)
	{
           array[i][j][k] = 0 ;
        }
     }
   }

  array[1][0][0] = &x ;
  array[2][0][0] = &y ;
  array[3][0][0] = &z ;

	
  unsigned int a, b;
  a = nondet_uint();
  b = nondet_uint();
  
  assume (a < 3 && b < 3);

  array[a][b] = &z;

  iptr p;
  p=array[a][b];

  *p=1;

  assert(z==1);
}
/* end of case 2 */
