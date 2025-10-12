#include "mutex.h"

void atomic_set(void *ptr) {
    __asm__ volatile("li t0, 1\n"
                     "1:\n"
                     "lr.w t1, (%[addr])\n"
                     "bnez t1, 1b\n"
                     "sc.w t2, t0, (%[addr])\n"
                     "bnez t2, 1b\n"
                     :
                     : [addr] "r"(ptr)
                     : "t0", "t1", "t2");
}

void atomic_unset(void *ptr) {
    __asm__ volatile("1:\n"
                     "lr.w t0, (%[addr])\n"
                     "sc.w t0, zero, (%[addr])\n"
                     "bnez t0, 1b\n"
                     :
                     : [addr] "r"(ptr)
                     : "t0");
}

void mutex_lock(volatile mutex *m) {
    atomic_set(&m->lock);
}

void mutex_unlock(volatile mutex *m) {
    atomic_unset(&m->lock);
}
