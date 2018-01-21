int main() {
	unsigned int a = 2, b = 5;
	unsigned int c = b + a;
	assert(c == 7);
	{
		unsigned int a = 5, b = 5;
		unsigned int c = b + a;
		assert(c == 10);
	}
	return 0;
}