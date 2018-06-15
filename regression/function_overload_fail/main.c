
int add(int x , int y)
{
  return x+y ;
}
int add(int x)
{
  return 2*x;
}

float add(float x, float y)
{
  return x+y ;
}

int main()
{ 
  int x = 2 ;
  int y = 3 ;


  assert(add(x,y) + add(x)==9);

  float f1 = 20.5;
  float f2 = 10.1 ;
  assert(add(f1,f2) == 30.6);


   return 0 ;
}