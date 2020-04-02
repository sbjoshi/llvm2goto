#define LIMIT 10

int nondet();
void fill_array (int *a, int length)
{
  for (int i = 0; i < length; ++i) {
    a[i] = i;
  }

  return;
}

int main ()
{
  int a[LIMIT];

  fill_array(a,LIMIT);

  int x = nondet();
  int y = nondet();

  __CPROVER_assume(0 <= x || x < LIMIT);
  __CPROVER_assume(0 <= y && y < LIMIT);
  __CPROVER_assume(x + y < LIMIT);

  assert(a[x] + a[y] != x + y);

  return 1;
}
