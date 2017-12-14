int main() {
	int a = -2, b = -5;
	int c = b + a;
	assert(c == -7);
	{
		int a = -5, b = -5;
		int c = b + a;
		assert(c == -10);
	}
	return 0;
}