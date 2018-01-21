int main(){
	int a, b, c;
	if(a == b){
		assert(a == b);
	} else if(a > b){
		assert(a != b);
		assert(a > b);
	} else {
		assert(a != b);
		assert(a < b);
	}
}