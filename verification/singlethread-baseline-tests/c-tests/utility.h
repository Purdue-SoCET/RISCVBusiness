#ifndef __UTILITY_H__
#define __UTILITY_H__

    #include <stdint.h>

    #define MTIME_ADDR      0xFFFFFFE0
    #define MTIMEH_ADDR     0xFFFFFFE4
    #define MTIMECMP_ADDR   0xFFFFFFE8
    #define MTIMECMPH_ADDR  0xFFFFFFEC
    #define MSIP_ADDR       0xFFFFFFF0
    #define EXT_ADDR_SET    0xFFFFFFF4
    #define EXT_ADDR_CLEAR  0xFFFFFFF8
    #define MAGIC_ADDR      0xFFFFFFFC
    

    void print(char *string);
    void put_uint32_hex(uint32_t hex);

    // benchmarking functions
    int fibonacci(int n);
    void bubble_sort(volatile int* arr, volatile int size);
    void merge_sort(int* arr, int left, int right);
    int check_sort(volatile int* arr, volatile int size);

#endif