int main() {
	int a = -2, b = 5;
	int c = a % b;
	assert(c == -1);
	{
		int a = -3, b = 5;
		int c = a % b;
		assert(c == -2);
	}
	return 0;
}