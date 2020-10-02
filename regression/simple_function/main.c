int f(int i)
{
	return i+1 ;
}

int f(int);

int main() {
	int y = 10;
	y = f(y);
	assert(y == 11);
	return 0;
}
