int f(int i)
{
	return i+1 ;
}

int f(int);


int a[1];
int main() {
	int y = 10;

	a[0] = y;
	a[0] = f(a[0]);

	assert(a[0] == y+1);
}
