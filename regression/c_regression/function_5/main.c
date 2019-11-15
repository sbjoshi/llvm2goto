//Function definition inside function definition followed by call

int global;

void f()
{
  unsigned g();

  global = g();
}

unsigned g()
{
  return 123;
}

int main()
{
  f();
  assert(global==123);
  return 0;
}
