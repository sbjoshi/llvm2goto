int main() {
	unsigned int e;
	switch(e){
		case 0: assert(e == 0); break;
		case 1: assert(e == 1); break;
		case 2: assert(e == 2); break;
		default: assert(e != 0);
	}
	return 0;
}