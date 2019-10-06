struct node{
    int a;
    struct node* next;
};

int main(){
    struct node root;
    root.next = &root;
    root.next->a = 5;
    assert(root.a == 5);
    return 0;
}
