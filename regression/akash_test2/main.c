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

  assume(0 <= x);
  assume(x < LIMIT);
  assume(0 <= y);
  assume(y < LIMIT);
  assume((x + y) < LIMIT);

  assert(a[x] + a[y] == x + y);

  return 1;
}
