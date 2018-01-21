int main() {
	unsigned int a = 2, b = 5;
	unsigned int c = b / a;
	assert(c == 2);
	{
		unsigned int a = 5, b = 5;
		unsigned int c = b / a;
		assert(c == 1);
	}
	return 0;
}