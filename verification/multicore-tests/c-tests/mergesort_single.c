//A single core version of mergesort (mostly just qsort)

#include "utility.h"
#include <stdio.h>
//#include <string.h>

void hart0_main();
void hart1_main();

void qsort(int lb, int ub, int *arr);
int partition(int lb, int ub, int *arr);
void swap(int ptr1, int ptr2, int *arr);
void memcpy(void* dest, void* src, size_t count);

//Number of elements in array. Used to select a pre-defined array
//Can use some Python to create an array size if more arrays are needed

#define N 20

#if N == 5
    int arr[] = {3,2,1,4,5};
    int out_arr[5];
#endif
#if N == 10
    int arr[] = {52, 178, 58, 70, 176, 183, 192, 37, 118, 239};
    int out_arr[10];
#endif
#if N == 15
    int arr[] = {122, 159, 245, 3, 97, 226, 111, 7, 231, 177, 154, 158, 239, 72, 213};
    int out_arr[15];
#endif
#if N == 20
    int arr[] = {236, 132, 177, 197, 252, 121, 236, 193, 48, 147, 145, 152, 194, 59, 90, 246, 65, 185, 15, 107};
    int out_arr[20];
#endif

int global = 0;
int compareFunc(const void* a, const void* b);

void hart0_main() {
    flag = 0;
    qsort(0, N-1, arr);
    while(!hart1_done) {}; //Wait for both cores to finish

    for(int i = 0; i < N-1; i++)
    {
        if(out_arr[i] > out_arr[i+1])
        {
            flag = 0;
            return;
        }
    }
    flag = 1;
}

void hart1_main() {
    hart1_done = 1;
}

//A custom version of memcpy, included to get around some errors
//Note this only copies by words and not by bytes to reduce latency
void memcpy(void* dest, void* src, size_t count)
{
    
    //uint32_t* word_dest = (uint32_t*) dest;
    //uint32_t* word_src = (uint32_t*) src;
    //count /= 4;
    uint8_t* byte_dest = (uint8_t*) dest;
    uint8_t* byte_src = (uint8_t*) src;
    for(int i = 0; i < count; i++)
    {
        byte_dest[i] = byte_src[i];
        //word_dest[i] = word_src[i];
    }
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

