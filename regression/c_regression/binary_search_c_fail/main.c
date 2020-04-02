int nondet();
int main()
{
   int first = nondet(), last = nondet(), middle = nondet();
   int n = 2 ;
   int search = nondet();
   int array[2];
   array[0] = nondet();
   array[1] = nondet();

   int found = 0;

   first = 0;
   last = n - 1;
   middle = (first+last)/2;
 
   while (first < last) {

      if (array[middle] < search)
         first = middle + 1; 

      else if (array[middle] == search) {
         found = 2;
         break;
      }

   }
   assert(((first > last) && found==0) || ((first<=last) && found>0));   
   return 0;   
}
