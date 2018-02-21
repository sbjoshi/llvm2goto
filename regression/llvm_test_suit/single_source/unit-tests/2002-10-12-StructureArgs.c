// #include <stdio.h>

struct vec2 { double X, Y; };

void print(struct vec2 S, struct vec2 T) {
	// printf("%f, %f, %f, %f\n", S.X, S.Y, T.X, T.Y);
	assert((float)S.X == 0.500000);
	assert((float)S.Y == 1.200000);
	assert((float)T.X == -123.010000);
	assert((float)T.Y == 0.333333);
}

int main() {
	struct vec2 U, V;
	U.X = .5; U.Y = 1.2;
	V.X = -123.01; V.Y = 1/3.0;
	print(U, V);
	return 0;
}
