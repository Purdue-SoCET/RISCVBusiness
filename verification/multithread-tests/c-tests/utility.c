
#include "utility.h"

void print(char *string) {
    volatile char *magic = (volatile char *)MAGIC_ADDR;

    for(int i = 0; string[i]; i++) {
        (*magic) = string[i];
    }
}

void put_uint32_hex(uint32_t x) {
    char buf[10] = {0};

    for(int i = 0; i < 8; i++) {
        uint8_t value = (x & 0xF);
        if(value >= 10) {
            buf[7-i] = ((value-10) + 'A');
        } else {
            buf[7-i] = (value + '0');
        }
        x >>= 4;
    }
    print(buf);
}

void bubble_sort(volatile int* arr, volatile int size){ 
    volatile int i, j;
    for (i = 0; i < size-1; i++) {
        for (j = 0; j < size-i-1; j++) {
            if (*(arr + j) > *(arr + j + 1)) {
                // Swap
                volatile int temp = *(arr + j);
                *(arr + j) = *(arr + j + 1);
                *(arr + j + 1) = temp;
            }
        }
    }
}

void thread1() {
    int arr[] = {64, 34, 25, 12, 22, 11, 90, 2};
    bubble_sort(arr, 8);
    return;
}

void thread2() {
    int arr[] = {45, 12, 78, 34, 91, 27, 63, 50};
    bubble_sort(arr, 8);
    return;
};


void thread3() {
    int arr[] = {88, 17, 42, 56, 29, 71, 95, 10};
    bubble_sort(arr, 8);
    return;
}
