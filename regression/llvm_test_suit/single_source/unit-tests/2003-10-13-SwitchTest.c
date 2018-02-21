// #include <stdio.h>

int test() {
  int i;
   switch (i) {
   default:
     // printf("GOOD\n");
     return 0;
   case 100: 
   case 101:
   case 1023:
     // printf("BAD\n");
     return 1;
   }
}

int main() {
  assert(test() == 1);
  return 0;
}
