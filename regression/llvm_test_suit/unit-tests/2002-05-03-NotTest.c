
// #include <stdio.h>

void testBitWiseNot(int A, int B, int C, int D) {
  // printf("Bitwise Not: %d %d %d %d\n", ~A, ~B, ~C, ~D);
  assert(~A == -2);
  assert(~B == -3);
  assert(~C == 2);
  assert(~D == -6);
}

void testBooleanNot(int A, int B, int C, int D) {
  // printf("Boolean Not: %d %d %d %d %d %d\n",
  assert(!(A > 0 && B > 0) == 0);
  assert(!(A > 0 && C > 0) == 1);
  assert(!(A > 0 && D > 0) == 0);
  assert(!(B > 0 && C > 0) == 1);
  assert(!(B > 0 && D > 0) == 0);
  assert(!(C > 0 && D > 0) == 1);
         
}

int main() {
  testBitWiseNot(1, 2, -3, 5);
  testBooleanNot(1, 2, -3, 5);
  return 0;
}
