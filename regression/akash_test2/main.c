#define LIMIT 10

void fill_array (int *a, int length)
{
  for (int i = 0; i < length; ++i) {
    a[i] = i;
  }
}

int main ()
{
  int a[LIMIT];

  fill_array(a,LIMIT);
  
  int x;
  int y;

  __CPROVER_assume(x >= 0);
  __CPROVER_assume(x < LIMIT);
  __CPROVER_assume(0 <= y);
  __CPROVER_assume(y < LIMIT);
  __CPROVER_assume((x + y) < LIMIT);

  assert(a[x] + a[y] == x + y);

  return 1;
}
