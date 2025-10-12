#ifndef MUTEX_H
#define MUTEX_H

typedef struct {
    int lock;
} mutex;

void __attribute__((noinline)) mutex_lock(volatile mutex *m);
void __attribute__((noinline)) mutex_unlock(volatile mutex *m);

#endif
