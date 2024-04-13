// A dual core version of mergesort

#include "utility.h"
#include <stdlib.h>
#include <string.h>

// Number of elements in array. Used to select a pre-defined array
// Can use some Python to create an array size if more arrays are needed

#define N 20
#include "merge.h"

#if N == 5
uint32_t arr[] = {3, 2, 1, 4, 5};
uint32_t out_arr[5];
#endif
#if N == 10
uint32_t arr[] = {52, 178, 58, 70, 176, 183, 192, 37, 118, 239};
uint32_t out_arr[10];
#endif
#if N == 15
uint32_t arr[] = {122, 159, 245, 3, 97, 226, 111, 7, 231, 177, 154, 158, 239, 72, 213};
uint32_t out_arr[15];
#endif
#if N == 20
uint32_t arr[N] = {236, 132, 177, 197, 252, 121, 236, 193, 48, 147,
                   145, 152, 194, 59,  90,  246, 65,  185, 15, 107};
uint32_t out_arr[N];
#endif

#if N % 2
#error "N must be even!"
#endif

void hart0_main() {
    mergeSort(arr, N / 2);
    wait_for_hart1_done();
    merge(arr, out_arr, 0, (N / 2) - 1, N);
    flag = arrayIsSorted(out_arr, N);
}

void hart1_main() {
    mergeSort(&arr[N / 2], N / 2);
    hart1_done = 1;
}
