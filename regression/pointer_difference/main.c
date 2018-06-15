int main()
{
  unsigned int arrayOfInt [2];

  int diff1 = &arrayOfInt[1] - arrayOfInt;
  assert(diff1==1);

  unsigned int diff2 = &arrayOfInt [2] - arrayOfInt;
  assert(diff2==2);

  return 0;
}
