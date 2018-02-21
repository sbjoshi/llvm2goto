// #include <stdio.h>

struct T {
  unsigned X : 5;
  unsigned Y : 6;
  unsigned Z : 5;
};

struct T GV = { 1, 5, 1 };

int main() {
  // printf("%d %d %d\n", GV.X, GV.Y, GV.Z);
	assert(GV.X == 1);
	assert(GV.Y == 5);
	assert(GV.Z == 1);
  return 0;
}
