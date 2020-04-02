int main()
{
  int i = nondet();
  
  if(i==1)
    assert(i==1);
  else
    assert(i!=1);
}
