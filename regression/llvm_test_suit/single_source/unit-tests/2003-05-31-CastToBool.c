// #include <stdio.h>

void testCastOps(int y) {
  assert((y == 2 || y == 0) == 1);
  assert((y > 2 || y < 5) == 0);
  assert((y ^ 2 ^ ~y) == 1);
  // printf("y = %d, (y == 2 || y == 0) == %d\n",
  //        y, ((_Bool) (y == 2)) || ((_Bool) (y == 0)));
  // printf("y = %d, (y > 2 || y < 5) == %d\n",
  //        y, ((_Bool) (y < 2)) && ((_Bool) (y > -10)));
  // printf("y = %d, (y ^ 2 ^ ~y) == %d\n",
  //        y, (_Bool) (y ^ 2 ^ ~5));
}

int testBool(_Bool X) {
  // printf("%d\n", X);
  return X;
}

int testByte(char X) {
  // printf("%d ", X);
  return testBool(X != 0);
}

int testShort(short X) {
  printf("%d ", X);
  return testBool(X != 0);
}

int testInt(int X) {
  // printf("%d ", X);
  return testBool(X != 0);
}

int  testLong(long long X) {
  // printf("%lld ", X);
  return testBool(X != 0);
}

int main() {
  assert(testByte(0) == 0);
  assert(testByte(123) == 1);
  assert(testShort(0) == 0);
  assert(testShort(1234) == 1);
  assert(testInt(0) == 0);
  assert(testInt(1234) == 1);
  assert(testLong(0) == 0);
  assert(testLong(123121231231231LL) == 1);
  assert(testLong(0x1112300000000000LL) == 1);
  assert(testLong(0x11120LL) == 1);
  testCastOps(2);
  return 0;
}
