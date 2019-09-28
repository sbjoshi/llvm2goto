
void increment(int &x)
{
  x++ ;

  void increment_by_2(int* y) ;

  increment_by_2(&x);
}
void increment_by_2(int* y)
 { 
  y= y+ 2 ;
 }

int main()
{ 
  int x = 1;


  increment(x);

  assert(x==4);

   return 0 ;
}