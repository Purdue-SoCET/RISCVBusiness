#include <stdint.h>
#include "utility.h"

#define LOOP_SIZE 1000

extern volatile int flag;

int main() {
  //volatile int value = 5;
  volatile int result = 0;
  for(int i = 0; i < LOOP_SIZE; i++) {
    result += 5;
  }

  for(int i = 0; i < LOOP_SIZE; i++) {
    result += 10;
  }

  for(int i = 0; i < LOOP_SIZE; i++) {
    result += 15;
  }

  flag = 1;
}


