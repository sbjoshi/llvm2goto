#include <stdio.h>

void test(int A, int B, int C, int D) {
  int bxor = A ^ B ^ C ^ D;
  int bor  = A | B | C | D;
  int band = A & B & C & D;
  int bandnot = (A & ~B) ^ (C & ~D);
  int bornot  = (A | ~B) ^ (C | ~D);
  
  // printf("%d %d %d %d %d\n", bxor, bor, band, bandnot, bornot);
  assert(bxor == -15);
  assert(bor == -1);
  assert(band == 0);
  assert(bandnot == -3);
  assert(bornot == 12);
}

int main() {
  test(7, 8, -5, 5);
  return 0;
}
