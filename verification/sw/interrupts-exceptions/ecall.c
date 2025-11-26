#include <stdint.h>
#include "csr.h"
#include "format.h"
#include "utility.h"

void exception_handler() {
    advance_mepc(4);
    print("Made it to handler!\n");
    flag = 1;
}

int main() {
    setup_interrupts_m(exception_handler, 0);

    print("Jumping to handler...\n");
    ecall();

    if (flag == 1) {
        test_pass("Ecall handled");
    } else {
        test_fail("Ecall not handled");
    }

    return 0;
}
