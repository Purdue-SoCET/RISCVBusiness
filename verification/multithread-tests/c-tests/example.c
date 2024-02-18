#include <stdint.h>
#include "utility.h"

extern volatile int flag;

void thread_one() {
  volatile int x = 0;
  asm volatile("j done");
}

void thread_two() {
  volatile int x = 0;
  asm volatile("j done");
}

void thread_three() {
  volatile int x = 0;
  asm volatile("j done");
}