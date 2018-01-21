int main() {
	unsigned int a = 2, b = 5;
	unsigned int c = a * b;
	assert(c == 10);
	{
		unsigned int a = 3, b = 5;
		unsigned int c = a * b;
		assert(c == 15);
	}
	return 0;
}