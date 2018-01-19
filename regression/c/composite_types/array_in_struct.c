struct p{
	char c;
	float f;
	int ar[20];
};
struct s{
	int arr[10];
	int a;
	struct p pele;
};
int main(){
	struct s ele;
	ele.pele.ar[4] = 10;
}