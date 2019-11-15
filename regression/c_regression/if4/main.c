int main()
{	
	int num1, num2,num3 ;
	int max ;
	
    if(num1 > num2)
    {
        if(num1 > num3)
        {
            /* If num1 > num2 and num1 > num3 */
            max = num1;
        }
        else
        {
            /* If num1 > num2 but num1 > num3 is not true */
            max = num3;
        }
    }
    else
    {
        if(num2 > num3)
        {
            /* If num1 is not > num2 and num2 > num3 */
            max = num2;
        }
        else
        {
            /* If num1 is not > num2 and num2 > num3 */
            max = num3;
        }
    }
   
   assert((max>=num1 && max>=num2) || (max>=num2 && max>=num3) || (max>=num1 && max>=num3));
   assert(max == num1 || max == num2 || max==num3);

   return 0 ;
}