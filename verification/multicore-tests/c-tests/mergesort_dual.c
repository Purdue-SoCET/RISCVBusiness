//A dual core version of mergesort

#include "utility.h"
//#include <stdlib.h>
#include <stdio.h>
#include <string.h>

void hart0_main();
void hart1_main();

void qsort(int lb, int ub, int *arr);
int partition(int lb, int ub, int *arr);
void swap(int ptr1, int ptr2, int *arr);

//Number of elements in array. Used to select a pre-defined array
//Can use some Python to create an array size if more arrays are needed

#define N 5

#if N == 5
    int arr[] = {3,2,1,4,5};
    int out_arr[N] = {0};
#endif


//Arrays for each half
int left_half[N/2];

int buffer[N];

//If N is odd
#if N % 2
    int right_half[N/2 + 1];
#else
    int right_half[N/2];
#endif 

int global = 0;
int compareFunc(const void* a, const void* b);

void hart0_main() {
    flag = 0;
    print("Hello from hart0 - Starting the left array sort\n");

    //Copy bottom half of array
    memcpy(left_half, arr, sizeof(int)*(N/2));
    //memcpy(left_half, arr, sizeof(int)*2);
    qsort(0, (N/2)-1, left_half);
    //qsort(0, 1, left_half);
    while(!hart1_done) {}; //Wait for both cores to finish

    //Merge the two arrays
   
    //print("Left Half: %d %d %d\n", left_half[0], left_half[1], left_half[2]);
    //print("Left Half: %d %d\n", left_half[0], left_half[1]);
    //print("Right Half: %d %d %d\n", right_half[0], right_half[1], right_half[2]);
 
    //Ensure the array is actually sorted
    for(int i = 0; i < N/2-1; i++)
    {
        if(right_half[i] > right_half[i+1])
        {
            flag = 0;
            return;
        }
    }
    flag = 1;
}

void hart1_main() {
    hart1_done = 0;
    //print("Hello from hart1 - Starting the right array sort\n");
   
    //If N is odd
    #if N % 2
        memcpy(right_half, &arr[N/2], sizeof(int)*(N/2 + 1));
        qsort(0, N/2, right_half); //Need end to be index, not length
        //qsort(0, 2, right_half);
    #else
        memcpy(right_half, &arr[N/2], sizeof(int)*N/2);
        qsort(0, N/2 - 1, right_half);
    #endif 

    
    hart1_done = 1;
}

int compareFunc(const void* a, const void* b)
{
    return (*(int*)a - *(int*)b);
}


  //run quicksort
/*  qsort(0, ARR_LENGTH-1, data);

  //evaluate correctness
  for(i = 1; i < ARR_LENGTH;i++) {
    if(data[i-1] > data[i])
      TEST_FINISH_FAIL(1)
  }
  TEST_FINISH_SUCCESS
}*/


//qsort function from c-tests/RV32I/quicksort.c
//Written by John Skubic
void qsort(int lb, int ub, int *arr) {
  int q;
  if(lb < ub) {
    q = partition(lb, ub, arr);
    qsort(lb, q-1, arr);
    qsort(q+1, ub, arr);
  }
}

int partition(int lb, int ub, int *arr) {
  int pivot;
  int currPtr = lb;
  int smallPtr = lb-1;
  int mid = (lb + ub) >> 1; // divide by 2
  
  //choose the median of three pivots
  if(arr[lb] < arr[ub]){
    if(arr[lb] > arr[mid]){
      swap(lb, ub, arr);
    }
    else if (arr[ub] > arr[mid]) {
      swap(ub, mid, arr);
    }
  }
  else{ 
    if(arr[ub] < arr[mid]){
      swap(ub, mid, arr);
    }
    else if (arr[lb] < arr[mid]){
      swap(lb, ub, arr);
    }
  }
  
  pivot = arr[ub];
  
  for(currPtr = lb; currPtr < ub; currPtr++){
    if(arr[currPtr] <= pivot){
      smallPtr++;
      swap(smallPtr, currPtr, arr);
    }
  }
  smallPtr++;
  swap(smallPtr, ub, arr);

  return smallPtr; // holds the value of q 
}

void swap(int ptr1, int ptr2, int *arr) {
  int temp = arr[ptr1];
  arr[ptr1] = arr[ptr2];
  arr[ptr2] = temp;
}

