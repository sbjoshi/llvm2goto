int nondet();

int main()
{
  int x = nondet();

  __CPROVER_assume(x>=0);
  assert(x>=0);

  // assumptions are not retro-active
  //assert(x==1); // fails
  
  __CPROVER_assume(x==1);
  assert(x==1); // passes
}
