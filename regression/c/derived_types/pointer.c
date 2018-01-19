int main() {
	int i;
	int *ptr;
	ptr = &i;
	*ptr = 10;
	assert(i==10);
	return 0;
}