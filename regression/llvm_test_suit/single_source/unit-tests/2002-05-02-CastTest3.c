int printf(const char *, ...);

int main() {
  int i;
  assume(i < 3);
  short s1 = (i >= 3)? i : -769; /* 0xf7ff = -769 */

  unsigned short us2 = (unsigned short) s1;     /* 0xf7ff = 64767 */
  
  assert(s1 == -769);
  assert(us2 == 64767);
  return 0;
}
