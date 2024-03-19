#include <stdint.h>
#include "utility.h"

#define LOOP_SIZE 10000

extern volatile int flag;
extern volatile int t_count;

void thread1() {
  volatile int result = 0; 
  for(int i = 0; i < LOOP_SIZE; i++) {
    result += 5;
  }
  flag &= 0x1;
  thread_terimate(0, &t_count);
}

void thread2() {
  volatile int result = 0;
  for(int i = 0; i < LOOP_SIZE; i++) {
    result += 10;
  }
  flag &= 0x1;
  thread_terimate(1, &t_count);
}

void thread3() {
  volatile int result = 0;
  for(int i = 0; i < LOOP_SIZE; i++) {
    result += 10;
  }
  flag &= 0x1;
  thread_terimate(2, &t_count);
}

  


