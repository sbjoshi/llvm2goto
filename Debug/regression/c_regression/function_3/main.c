//Function definition inside function definition followed by call

int global;

void f()
{
  void g();

  g();
}

void g()
{
  global=123;
}

int main()
{
  f();
  assert(global==123);
  return 0;
}
