int main() {
	int a = 2, b = 5;
	int c = b - a;
	assert(c == 3);
	{
		int a = 3, b = 5;
		int c = b - a;
		assert(c == 2);
	}
	return 0;
}