// int printf(const char *, ...);
#include <stdio.h>

void test(short s1) {
  unsigned short us2 = (unsigned short) s1;     /* 0xf7ff = 64767 */
  
  // printf("s1   = %d\n",   s1);
  int i = s1;
  assert(s1 == -769);
  // printf("us2  = %u\n",   us2);
  unsigned u = us2;
  assert(u == 64767);
}

int main() {
  short s = -769;
  test(s);
  return 0;
}
