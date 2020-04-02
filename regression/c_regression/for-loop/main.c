#define lb 1000

int main()
{
  int i,x = nondet(),y=0,z=0;
  for(i=0;i<lb;++i)
  {
    if(x)
     y++;
    else
     z++;
  }
  assert((x!=0 && y==lb) || (x==0 && z==lb));
}
