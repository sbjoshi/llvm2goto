extern int printf(const char *str, ...);
// void test(double X) {
//   printf("%f %f\n", -0.0 - X, -X);
// }
int main() {
  // test(+0.0);
	assert((-0.0 - 0.0) == -0.000000);
	assert(-(0.0) == -0.000000);

  // test(-0.0);
	assert((-0.0 - (-0.0)) == 0.000000);
	assert(-(-0.0) == 0.000000);
	
  // printf("negzero = %f  poszero = %f\n", -0.0, +0.0);
  assert(0.0 == 0.000000);
  assert(-0.0 == -0.000000);
  return 0;
}
