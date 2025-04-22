#include "utility.h"

void hart0_main() {
    print("hello from hart0!\n");
    flag = 1;
}

void hart1_main() {
    print("hello from hart1!\n");
    hart1_done = 1;
}

void hart2_main() {}
void hart3_main() {}
void hart4_main() {}
void hart5_main() {}
void hart6_main() {}
void hart7_main() {}