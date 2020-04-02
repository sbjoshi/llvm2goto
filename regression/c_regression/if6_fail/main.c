int main()
{ 
  int x = nondet() ;
  int x_prev = x ;

  if(x>=0)
  {
    x++ ;
    if(x>=1)
    {
      x++ ;
      if(x>=2)
      {
        x++ ;

        if(x>=3)
          x++ ;
      }
    }
  }

   assert((x_prev>=0 && x>=4)|| (x_prev<0 && x_prev==x));

   return 0 ;
}
