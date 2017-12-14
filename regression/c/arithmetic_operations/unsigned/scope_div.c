int main() {
	int a = 2, b = 5;
	int c = b / a;
	assert(c == 2);
	{
		int a = 5, b = 5;
		int c = b / a;
		assert(c == 1);
	}
	return 0;
}