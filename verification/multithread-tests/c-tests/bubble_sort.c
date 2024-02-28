#include <stdint.h>
#include "utility.h"

#define ARRAY_SIZE 25

extern volatile int flag;
extern volatile int t_count;

void thread1() {
    int arr[ARRAY_SIZE];
    for (int i = 0; i < ARRAY_SIZE; i++) {
        arr[i] = ARRAY_SIZE - i;
    }
    int size = ARRAY_SIZE;
    bubble_sort(arr, ARRAY_SIZE);
    flag &= check_sort(arr, size);
    thread_terimate(0, &t_count);
}

void thread2() {
    int arr[ARRAY_SIZE];
    for (int i = 0; i < ARRAY_SIZE; i++) {
        arr[i] = ARRAY_SIZE - i;
    }
    int size = ARRAY_SIZE;
    bubble_sort(arr, size);
    flag &= check_sort(arr, size);
    thread_terimate(1, &t_count);
};


void thread3() {
    int arr[ARRAY_SIZE];
    for (int i = 0; i < ARRAY_SIZE; i++) {
        arr[i] = ARRAY_SIZE - i;
    }
    int size = ARRAY_SIZE;
    bubble_sort(arr, size);
    flag &= check_sort(arr, size);
    thread_terimate(2, &t_count);
}