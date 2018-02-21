// #include <stdio.h>

struct rtx_def {
  unsigned int jump : 1;
  unsigned int call : 1;
};

void i2(struct rtx_def *d) {
  d->jump = 0;
}

int main() {
  struct rtx_def D;
  D.call = 1;
  i2(&D);
  // printf("%d %d\n", D.jump, D.call);
  assert(D.jump == 0);
  assert(D.call == 1);
  return 0;
}


