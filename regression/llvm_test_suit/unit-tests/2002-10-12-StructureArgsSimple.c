// #include <stdio.h>

struct vec2 { double X, Y; };

void print(struct vec2 S) {
	// printf("%f, %f\n", S.X, S.Y);
	assert((float)S.X == 0.500000);
	assert((float)S.y == 1.200000);
}

int main() {
	struct vec2 U;
	U.X = .5; U.Y = 1.2;
	print(U);
	return 0;
}
