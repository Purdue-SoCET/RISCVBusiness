#include <stdint.h>
#include "utility.h"

#define ARRAY_SIZE 5

extern volatile int flag;
extern volatile int t_count;

void thread1() {
  flag &= 0x1;
  thread_terimate(0, &t_count);
}

void interrupt_thread() {
  while(1) {
    asm volatile("nop");
  }
}

void thread2() {
  flag &= 0x1;
  thread_terimate(1, &t_count);
}

void thread3() {
  thread_terimate(2, &t_count);
}
