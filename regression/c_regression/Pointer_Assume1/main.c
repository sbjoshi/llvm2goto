int main()
{
  int * a;
  int b=1;
  
  assume(a == &b);
  assert(*a==1);
  return 0;
}
