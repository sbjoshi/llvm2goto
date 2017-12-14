int main() {
	int a = 2, b = 5;
	int c = a * b;
	assert(c == 10);
	{
		int a = 3, b = 5;
		int c = a * b;
		assert(c == 15);
	}
	return 0;
}