typedef unsigned B[8];

void fun(B x)
{
}

int main(void)
{
  B var;
  unsigned *p = var;
  fun(p);
}
