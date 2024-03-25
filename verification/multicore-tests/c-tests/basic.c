#include "utility.h"

extern int32_t flag;
void hart0_main() {
    print("hello from hart0!\n");
    flag = 1;
}

extern int32_t hart1_done;
void hart1_main() {
    print("hello from hart1!\n");
    hart1_done = 1;
}
