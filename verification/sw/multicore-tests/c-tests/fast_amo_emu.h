#ifndef FAST_AMO_H
#define FAST_AMO_H

#include <stdint.h>

// Atomically increments `ptr` by `val`. Returns previous value.
uint32_t atomic_add(uint32_t *ptr, uint32_t val);

#endif
