// Check that signed divide by a power of two works for small types
// #include <stdio.h>
int main() {
  int i;
  for (i = 0; i != 258;) {
  	int j = ((signed char)i) / (signed char)2;
  	i++;
  	assert(j == ((signed char)i) / (signed char)2);
  	i++;
    // printf("%d\n", ((signed char)i) / (signed char)2);
  }
  return 0;
}
