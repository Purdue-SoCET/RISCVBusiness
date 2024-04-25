#include <stdint.h>
#include "utility.h"

#define LOOP_SIZE 10000

extern volatile int flag;

int main() {
  //volatile int value = 5;
  volatile int result = 0;
  for(int i = 0; i < LOOP_SIZE; i++) {
    result += 5;
  }

  flag &= result == (LOOP_SIZE * 5);
  result = 0;

  for(int i = 0; i < LOOP_SIZE; i++) {
    result += 10;
  }

  flag &= result == (LOOP_SIZE * 10);
}


