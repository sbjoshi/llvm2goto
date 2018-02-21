// #include <stdio.h>
#include <math.h>
#ifdef NAN

union { unsigned __l; float __d; } GlobalUnion = { 0x70c00000U };

int main() {
  union { unsigned __l; float __d; } LocalUnion = { 0x7fc00000U };

  // printf("%f %f\n", GlobalUnion.__d, LocalUnion.__d);
  assert(GlobalUnion.__d == 475368975085586025561263702016.000000);
  assert(LocalUnion.__d == NAN);

  return 0;
}

#endif

