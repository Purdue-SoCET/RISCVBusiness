#include "utility.h"

void hart0_main() {
    print("hello from hart0!\n");
    flag = 1;
    return;
}

void hart1_main() {
    print("hello from hart1!\n");
    hart1_done = 1;
}

void hart2_main() {
    print("hello from hart2!\n");
    hart2_done = 1;
}
void hart3_main() {
    print("hello from hart3!\n");
    hart3_done = 1;
}
void hart4_main() {
    print("hello from hart4!\n");
    hart4_done = 1;
}
void hart5_main() {
    print("hello from hart5!\n");
    hart5_done = 1;
}
void hart6_main() {
    print("hello from hart6!\n");
    hart6_done = 1;
}
void hart7_main() {
    print("hello from hart7!\n");
    hart7_done = 1;
}