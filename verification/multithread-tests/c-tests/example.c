#include <stdint.h>
#include "utility.h"

extern volatile int flag;

int main() {
  volatile int x = 1;
  thread_one();

  return x;
}