// #include <assert.h>
#define N 5
void insertionSort(int arr[], int n)
{
   int i, key, j;
   for (i = 1; i < n; i++)
   {
       key = arr[i];
       j = i-1;

       while (j >= 0 && arr[j] > key)
       {
           arr[j+1] = arr[j];
           j = j-1;
       }
       arr[j+1] = key;
   }
}

int main()
{
  int arr[N];

  insertionSort(arr, N);

  //Should Pass
  for(int i=1 ; i<N ; i++)
  {
    assert(arr[i] >= arr[i-1]);
  }
}
