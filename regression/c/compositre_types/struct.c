struct student{
	char *name;
	int roll_no;
	float cgpa;
};
int main(){
	struct student s;
	int roll_no;
	s.roll_no = 1;
	s.cgpa = 6.5;
	return 0;
}