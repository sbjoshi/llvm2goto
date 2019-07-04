int main()
{
   int first, last, middle ;
   int n = 5 ;
   int search ;
   int array[10];

   int found = 0;

   first = 0;
   last = n - 1;
   middle = (first+last)/2;
 
   while (first <= last) {

      // Middle should always lie between first and last
      assert(middle >= first);
      assert(middle <= last);

      if (array[middle] < search)
         first = middle + 1; 

      else if (array[middle] == search) {
         found = found + 1;
         break;
      }
      else
         last = middle - 1;
 
      middle = (first + last)/2 ;

   }
    int cmp1 = (first > last);
    if(first > last){
        if(found == 0)
            assert(1);
        else
            assert(0);
    }         
   else{
        if(found > 0)
            assert(1);
        else
            assert(0);
    }
   //assert(((first > last) && found==0) || ((first<=last) && found>0)); 
   return 0;   
}
