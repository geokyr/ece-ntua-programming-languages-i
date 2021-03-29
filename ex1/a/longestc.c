#include <stdio.h>
#include <stdlib.h>


int max(int x, int y)
{
    return x > y ? x : y;
}
 
int min(int x, int y)
{
    return x < y ? x : y;
}
 
/* For a given array arr[], returns the maximum j – i such that
    arr[j] > arr[i] */
int maxIndexDiff(int arr[], int n)
{
    int maxDiff;
    int i, j;
 
    int* LMin = (int*)malloc(sizeof(int) * n);
    int* RMax = (int*)malloc(sizeof(int) * n);
 
    /* Construct LMin[] such that LMin[i] stores the minimum value
       from (arr[0], arr[1], ... arr[i]) */
    LMin[0] = arr[0];
    printf("%i ", LMin[0]);
    for (i = 1; i < n; ++i){
        LMin[i] = min(arr[i], LMin[i - 1]);
        printf("%i ", LMin[i]);
    }
    
    printf("\n");
 
    /* Construct RMax[] such that RMax[j] stores the maximum value
       from (arr[j], arr[j+1], ..arr[n-1]) */
    RMax[n - 1] = arr[n - 1];
    printf("%i ", RMax[n - 1]);
    for (j = n - 2; j >= 0; --j){
        RMax[j] = max(arr[j], RMax[j + 1]);
        printf("%i ", RMax[j]);
    }
    
    printf("\n");

 
    /* Traverse both arrays from left to right to find optimum j - i
        This process is similar to merge() of MergeSort */
    i = 0, j = 0, maxDiff = -1;
    while (j < n && i < n) {
       // printf("i = %i j = %i LMin[%i] =  %i RMax[%i] = %i ", i, j, i, LMin[i], j, RMax[j] );
        if (LMin[i] <= RMax[j]) {
            maxDiff = max(maxDiff, j - i );
            j = j + 1;
        }
        else if(j > i)
            i = i + 1;
        else 
            j = j + 1;     

        //printf("maxDiff = %i \n", maxDiff);    
    }
 
    return maxDiff;
}


int main() {
    
    int K = 3;

    // int D = 11;
    // int arr[11] = { 42, -10, 8, 1, 11, -6, -12, 16, -15, -11, 13 };
    
    int D = 6;
    int arr[6] = { 10, -4, -3 ,-2, 3, 8 };

    for(int i = 0; i < D; i++) {
        arr[i] = -arr[i];
        arr[i] -= K;
    }

    int prefixArr[D+1];
    prefixArr[0] = 0;

    for(int i = 1; i<D+1; i++) {
        prefixArr[i] = prefixArr[i-1] + arr[i-1];
    }
    

    printf("Num %i \n", maxIndexDiff(prefixArr, D + 1));
    
    //for(int i = 0; i <D; i++) printf("%i\n", arr[i]);
    //for(int i = 0; i <D; i++) printf("%i\n", prefixArr[i]);


    return 0;
}
