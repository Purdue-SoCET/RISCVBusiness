#include <stdint.h>
#include "utility.h"

extern volatile int flag;
extern volatile int t_count;

void thread1() {
    int arr[] = {64, 34, 25, 12, 22, 11, 90, 2};
    int size = 8;
    merge_sort(arr, 0, size - 1);
    flag &= check_sort(arr, size);
    thread_terimate(0, &t_count);
}

void thread2() {
    int arr[] = {45, 12, 78, 34, 91, 27, 63, 50};
    int size = 8;
    merge_sort(arr, 0, size - 1);
    flag &= check_sort(arr, size);
    thread_terimate(1, &t_count);
};


void thread3() {
    int arr[] = {88, 17, 42, 56, 29, 71, 95, 10};
    int size = 8;
    merge_sort(arr, 0, size - 1);
    flag &= check_sort(arr, size);
    thread_terimate(2, &t_count);
}