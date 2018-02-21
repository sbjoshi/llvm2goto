/*
 * This test checks conversions from floating point values to small
 * unsigned integer values.  Conversions to uint32_t need special handling
 * on Sparc V9, which only has FP-to-int32_t and FP-to-int64_t instructions.
 */

#include <stdlib.h>
#include <stdio.h>

static double getDC(), getDS(), getDI();

int
main(int argc, char** argv) {
  double DC = getDC();
  double DS = getDS();
  double DI = getDI();
  unsigned char  uc = (unsigned char ) DC;
  unsigned short us = (unsigned short) DS;
  unsigned int   ui = (unsigned int  ) DI;
  // printf("DC = %lf, DS = %lf, DI = %lf\n", DC, DS, DI);
  // printf("uc = %u, us = %u, ui = %u\n", uc, us, ui);
  assert(DC == 240.000000);
  assert(DS == 65520.000000);
  assert(DI == 4294967280.000000);
  assert(uc == 240);
  assert(us == 65520);
  assert(ui == 4294967280);
  return 0;
}

static double getDC() { return (double) ((1L  <<  8) - 16L ); }
static double getDS() { return (double) ((1LL << 16) - 16L ); }
static double getDI() { return (double) ((1LL << 32) - 16LL); }
