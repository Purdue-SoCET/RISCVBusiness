
#include <stdint.h>
#include "csr.h"
#include "format.h"
#include "utility.h"

void exception_handler() {
    advance_mepc(4);
    print("Made it to handler!");
    flag = 1;
}

int main() {
    setup_interrupts_m(exception_handler, 0);

    print("Executing illegal instruction\n");
    asm volatile(".word 0xFFFFFFFF");

    if (flag == 1) {
        test_pass("Illegal instruction handled");
    } else {
        test_fail("Illegal instruction not handled");
    }

    return 0;
}
