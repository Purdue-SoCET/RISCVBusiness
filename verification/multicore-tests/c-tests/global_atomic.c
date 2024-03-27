#include "utility.h"

_Atomic int global = 0;

void hart0_main() {
    for (int i = 0; i < 10; i++) {
        global++;
    }
    while (hart1_done == 0) {}
    flag = global == 20;
}

void hart1_main() {
    for (int i = 0; i < 10; i++) {
        global++;
    }
    hart1_done = 1;
}
