
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

int check_sort(volatile int* arr, volatile int size) {
    for (volatile int i = 0; i < size - 1; i++) {
        if (arr[i] > arr[i + 1]) {
            return 0;
        }
    }
    return 1;
}

int fibonacci(int n) {
    int a = 0, b = 1, next;
    if (n == 0)
        return a;
    for (int i = 2; i <= n; i++) {
        next = a + b;
        a = b;
        b = next;
    }
    return b;
}
