struct s
{
	int* x ;
	int val ;
};

struct s copied(struct s temp)
{
	struct s copy ;
	copy.val = temp.val ;
	copy.x = &copy.val ;

	temp.val = 15 ;
	assert(temp.val == 15);
	return copy ;
}
int main()
{	
	struct s object ;

	object.val = 10 ;
	object.x = &object.val ;

	struct s copy = copied(object);

	assert(copy.val==10); //&& *(copy.x) == copy.val
	assert(*(object.x)==10);


   return 0 ;
}
