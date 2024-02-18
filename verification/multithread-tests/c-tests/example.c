#include <stdint.h>
#include "utility.h"

extern volatile int flag;
extern volatile int t_count;

void thread1() {
  volatile int x = 0;

  t_count += 1;
  asm volatile("j done");
}

void thread2() {
  volatile int x = 0;


  t_count += 1;
  asm volatile("j done");
}

void thread3() {
  volatile int x = 0;
  asm volatile("j done");
}