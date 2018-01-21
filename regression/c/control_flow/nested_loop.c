int main(){
	int i, j;
	int no;
	for (i = 0; i < 10; ++i)
	{
		no = 0;
		for (j = 0; j < 10; ++j)
		{
			no++;
		}
	}
	assert(no == 10);
	return 0;
}