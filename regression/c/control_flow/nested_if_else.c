int main() {
	int a, b;
	if(a >= b){
		if(a>b) {
			a = b;
		} else {
			assert(a == b);
		}
		assert(a == b);
	} else {
		assert(a < b);
	}
	return 0;
}