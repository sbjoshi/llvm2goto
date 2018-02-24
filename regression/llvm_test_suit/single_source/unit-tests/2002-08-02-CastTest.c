// #include <stdio.h>

unsigned test(unsigned X) {
  return (unsigned char)X;
}

int main() {
	// printf("%d\n", test(123456));
	assert((int)(test(123456)) == 64);
        return 0;
}

