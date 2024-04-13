#ifndef MERGE_H
#define MERGE_H

#ifndef N
#error "N must be defined!"
#endif

#if N % 2
#error "N must be even!"
#endif

#include "utility.h"
#include <stdbool.h>
#include <stdint.h>

#define min(a, b) ((a) < (b) ? (a) : (b))

void merge(uint32_t *src, uint32_t *dest, uint32_t lb, uint32_t mid, uint32_t ub) {
    if ((lb >= ub) || (mid < lb) || (mid + 1) > ub)
        return;

    uint32_t k = lb;
    uint32_t i = lb;
    uint32_t j = mid + 1;
    for (k = lb; k <= ub; k++) {
        if (i > mid)
            dest[k] = src[j++];
        else if (j > ub)
            dest[k] = src[i++];
        else if (src[i] > src[j])
            dest[k] = src[j++];
        else
            dest[k] = src[i++];
    }
}

void mergeSort(uint32_t *src, uint32_t size) {
    uint32_t aux[N];

    for (uint32_t n = 1; n < size; n *= 2) {
        for (uint32_t i = 0; i < size - n; i += 2 * n) {
            uint32_t ridx = min(i + (2 * n), size) - 1;
            uint32_t mid = i + n - 1;
            merge(src, aux, i, mid, ridx);
            memcpy(&src[i], &aux[i], (ridx - i + 1) * sizeof(*src));
        }
    }
}

bool arrayIsSorted(uint32_t *src, uint32_t size) {
    for (uint32_t i = 0; i < size - 1; i++) {
        if (src[i] > src[i + 1]) {
            return false;
        }
    }
    return true;
}

#endif
