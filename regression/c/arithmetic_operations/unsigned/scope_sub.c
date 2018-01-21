int main() {
	unsigned int a = 2, b = 5;
	unsigned int c = b - a;
	assert(c == 3);
	{
		unsigned int a = 3, b = 5;
		unsigned int c = b - a;
		assert(c == 2);
	}
	return 0;
}