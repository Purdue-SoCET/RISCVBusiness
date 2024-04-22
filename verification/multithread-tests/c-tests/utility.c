
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

int check_sort(int* arr, int size) {
    for (int i = 0; i < size - 1; i++) {
        if (arr[i] > arr[i + 1]) {
            return 0;
        }
    }
    return 1;
}

void thread_terimate(int tid, volatile int* t_count) {
    // set thread to done (1)
    t_count[tid] = 1;
    
    // check if all threads are done
    int total = 0;
    for (int i = 0; i < NUM_THREADS - INTERRUPT_THREADS; i++) {
      total += t_count[i];
    }
    if (total == NUM_THREADS - INTERRUPT_THREADS) {
      asm volatile("j done");
    } else {
      asm volatile("j thread_wait_loop");
    }
}

void merge(int* arr, int left, int mid, int right) {
    int n1 = mid - left + 1;
    int n2 = right - mid;
    
    int L[n1], R[n2];
    
    for (int i = 0; i < n1; i++)
        L[i] = arr[left + i];
    for (int j = 0; j < n2; j++)
        R[j] = arr[mid + 1 + j];
    
    int i = 0, j = 0, k = left;
    
    while (i < n1 && j < n2) {
        if (L[i] <= R[j]) {
            arr[k] = L[i];
            i++;
        } else {
            arr[k] = R[j];
            j++;
        }
        k++;
    }
    
    while (i < n1) {
        arr[k] = L[i];
        i++;
        k++;
    }
    
    while (j < n2) {
        arr[k] = R[j];
        j++;
        k++;
    }
}

void merge_sort(int* arr, int left, int right) {
    if (left < right) {
        int mid = left + (right - left) / 2;
        
        merge_sort(arr, left, mid);
        merge_sort(arr, mid + 1, right);
        
        merge(arr, left, mid, right);
    }
}
