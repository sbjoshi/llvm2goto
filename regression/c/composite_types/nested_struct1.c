struct address{
	float colony;
	int streat_no;
};
struct person{
	float name;
	struct address addr;
};
struct student{
	struct person p;
	int roll_no;
	float cgpa;
};
int main(){
	struct student s;
	// int roll_no;
	s.roll_no = 1;
	s.cgpa = 6.5;
	// s.addr.streat_no = 15;
	s.p.addr.streat_no = 20;
	assert(s.p.addr.streat_no == 20);
	return 0;
}