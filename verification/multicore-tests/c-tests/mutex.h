#ifndef MUTEX_H
#define MUTEX_H

typedef struct {
    _Atomic int lock;
} mutex;

void mutex_lock(volatile mutex *m);
void mutex_unlock(volatile mutex *m);

#endif
