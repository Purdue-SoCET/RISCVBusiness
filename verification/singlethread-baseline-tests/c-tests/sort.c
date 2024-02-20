#include <stdint.h>
#include "utility.h"

extern volatile int flag;

int main() {
  int arr[] = {64, 34, 25, 12, 22, 11, 90, 2};
  int size = 8;
  bubble_sort(arr, size);
  flag &= check_sort(arr, size);

  int arr2[] = {45, 12, 78, 34, 91, 27, 63, 50};
  int size2 = 8;
  bubble_sort(arr2, size2);
  flag &= check_sort(arr2, size2);

  int arr3[] = {88, 17, 42, 56, 29, 71, 95, 10};
  int size3 = 8;
  bubble_sort(arr3, size3);
  flag &= check_sort(arr3, size3);
}