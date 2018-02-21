// extern int printf(const char *str, ...);

int main(int argc, char **argv) {
  // printf("%lld\n", (argc-100LL) >> 38);
	assert(((argc-100LL) >> 38) == -1);

  return 0;
}
