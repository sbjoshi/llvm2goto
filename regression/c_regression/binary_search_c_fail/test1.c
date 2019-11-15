int main()
{
   int first, last, middle ;
   int n = 2 ;
   int search ;
   int a[2];

   int found = 0;

   first = 0;
   last = n - 1;
   middle = (first+last)/2;
   int cmp, cmp1, cmp5, cmp8, cmp9, cmp10, cmp11, lor;
   X1:
   cmp = first<last;
   if (!(first<last))goto X4;
   cmp1 = a[middle] < search;
   if (!(a[middle] < search))goto X2;
   first = middle + 1;
   goto X3;
   
   X2:
   cmp5 = a[middle] == search;
   if (!(a[middle] == search))goto X3;
   found = 2;
   goto X4;
   
   X3:
   goto X1;
   
   X4:
   cmp8 = first > last;
   if (!(first > last))goto X5;
   cmp9 = found == 0;
   if (!(found == 0))goto X5;
   goto X6;
   
   X5:
   cmp10 = first <= last;
   if (!(first <= last))goto X6;
   cmp11 = found >0;
   
   X6:
   lor = cmp9 ? 1 : (cmp10 ? cmp11 : 0);
   assert(lor);
   return 0;   
}
