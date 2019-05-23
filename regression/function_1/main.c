//Simple Function . Undefined nondet_int()

int nondet_int();

double d = 0.0;

void f1()
{
  d = 1.0;
}

int main()
{
  int x = 2;

  if(nondet_int())
    x = 4;

  (void) f1();

  if(x==2)
  	d+= 1;

  if(x>3)
  	d+=1;
  double test = 2.0;
  assert(d == test);
  assert(d == 2.0);
  return 0;
}
