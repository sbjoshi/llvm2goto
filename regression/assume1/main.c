int main()
{
  int x;

  assume(x>=0);
  assert(x>=0);

  // assumptions are not retro-active
  //assert(x==1); // fails
  
  assume(x==1);
  assert(x==1); // passes
}
