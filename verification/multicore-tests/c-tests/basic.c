#include "utility.h"

void hart0_main() {
    print("hello from hart0!\n");
    flag = 1;
}

void hart1_main() {
    print("hello from hart1!\n");
    hart1_done = 1;
}
