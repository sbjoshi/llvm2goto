int nondet_int(){
  int x;
  return x;
}

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

  /*(void)*/ f1();

  if(x==2)
  	d+= 1;

  if(x>3)
  	d+=1;

  assert(d != 2.0);
}