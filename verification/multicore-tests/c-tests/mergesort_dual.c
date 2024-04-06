//A dual core version of mergesort

#include "utility.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

void hart0_main();
void hart1_main();


//Number of elements in array. Used to select a pre-defined array
//Can use some Python to create an array size if more arrays are needed

#define N 5

#if N == 5
    int arr[] = {1,2,3,4,5};
#endif

int global = 0;
int compareFunc(const void* a, const void* b);

void hart0_main() {
    flag = 0;
    print("Hello from hart0 - Starting the left array sort\n");

    //Copy bottom half of array
    int left_half[N/2];
    memcpy(left_half, arr, sizeof(int)*N/2);
    flag = 1;
}

void hart1_main() {
    hart1_done = 0;
    print("Hello from hart1 - Starting the right array sort\n");
   
    //If N is odd
    #if N % 2
    int right_half[N/2 + 1];
    memcpy(right_half, &arr[N/2], sizeof(int)*(N/2 + 1));
    //qsort(right_half, N/2, sizeof(int), compareFunc);
    #else
    int right_half[N/2];
    memcpy(right_half, &arr[N/2], sizeof(int)*N/2);
    //qsort(right_half, N/2 + 1, sizeof(int), compareFunc);    
    #endif 

    
    hart1_done = 1;
}

int compareFunc(const void* a, const void* b)
{
    return (*(int*)a - *(int*)b);
}
