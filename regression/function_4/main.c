int f(int i)
{
	return i+1 ;
}

int f(int);

int a[13][13];

int main() {
	int x, y;
	a[10][5] = 5;
	//a[0] = f(a[0]);

	assert(a[10][5] == 5);
}
