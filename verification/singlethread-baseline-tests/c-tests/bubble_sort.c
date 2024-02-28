#include <stdint.h>
#include "utility.h"
#define ARRAY_SIZE 100

extern volatile int flag;

int main() {
  int arr[ARRAY_SIZE];
  int size = ARRAY_SIZE;
  for (int i = 0; i < size; i++) {
    arr[i] = size - i;
  }
  bubble_sort(arr, size);
  flag &= check_sort(arr, size);

  int arr2[ARRAY_SIZE];
  int size2 = ARRAY_SIZE;
  for (int i = 0; i < size2; i++) {
    arr2[i] = i;
  }
  bubble_sort(arr2, size2);
  flag &= check_sort(arr2, size2);

  int arr3[ARRAY_SIZE];
  int size3 = ARRAY_SIZE;
  for (int i = 0; i < size3; i++) {
    arr3[i] = 0;
  }
  bubble_sort(arr3, size3);
  flag &= check_sort(arr3, size3);
}


