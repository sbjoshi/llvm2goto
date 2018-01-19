struct address{
	char colony;
	int road_no;
};
struct student{
	char *name;
	int roll_no;
	float cgpa;
	struct address addr;
};
int main(){
	struct student s;
	int roll_no;
	s.roll_no = 1;
	s.cgpa = 6.5;
	s.addr.road_no = 15;
	return 0;
}