// int printf(const char *, ...);

int main()
{
  signed char c0  = -1;
  unsigned char c1 = 255;
  int i = c0;
  assert(i == -1);
  i = c1;
  assert(i == 255);
  return 0;
}
