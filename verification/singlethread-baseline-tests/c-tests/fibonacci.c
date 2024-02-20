#include <stdint.h>
#include "utility.h"

extern volatile int flag;

int main() {
  int size1 = 150;
  int result1 = fibonacci(size1);

  int size2 = 150;
  int result2 = fibonacci(size2);

  int size3 = 150;
  int result3 = fibonacci(size3);

  if((result1 == result2) && (result2 == result3)) {
    flag = 1;
  } else {
    flag = 0;
  }
}