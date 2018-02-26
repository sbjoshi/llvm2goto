
#ifndef __STDC_LIMIT_MACROS
#define __STDC_LIMIT_MACROS 1
#endif
#include <inttypes.h>

// extern int printf(const char *, ...);

void testL(int64_t Arg) {
  // printf("%d\n", (int) (Arg / ((int64_t)1 << 4)));
  assert((int) (Arg / ((int64_t)1 << 4)) == 4);
  // printf("%d\n", (int) (Arg / ((int64_t)1 << 46)));
  assert((int) (Arg / ((int64_t)1 << 46)) == -127);
}

void test(int Arg) {
  // printf("%d\n", Arg / (1 << 0));
  assert(Arg / (1 << 0) == -1048544);
  // printf("%d\n", Arg / (1 << 4));
  assert(Arg / (1 << 4) == -65534);
  // printf("%d\n", Arg / (1 << 18));
  assert(Arg / (1 << 18) == -3);
  // printf("%d\n", Arg / (1 << 30));
  assert(Arg / (1 << 30) == 0);
}

int main() {
  int B20 = - (1 << 20);
  int64_t B53 = - ((int64_t)1 << 53);

  test(B20 + 32);
  // test(B20 + 33);

  testL(B53 + 64);
  // testL(B53 + 65);

  return 0;
}
