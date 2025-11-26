
#include <stdint.h>
#include <stddef.h>
#include "csr.h"
#include "utility.h"

void *resume_addr = NULL;

void exception_handler() {
    exception_context_t exc;
    read_exception_context(&exc);
    print_exception_context(&exc);
    set_mepc(resume_addr);
    flag -= 2;
}

void mtip_handler() {
    exception_context_t exc;
    read_exception_context(&exc);
    print_exception_context(&exc);
    flag -= 1;
    (*MTIMECMPH) = 0xFF; // setting mtimecmph makes a very large value
}

/*
*    This test case attempts an exception after an interrupt occurs.
*    This was to verify an issue with the previous interrupt/exception handler
*    where an exception after an interrupt while in VECTORED mode would
*    incorrectly jump to the wrong handler for the exception.
*    While that issue is most likely resolved, this case is included for verification.
*/
int main() {
    *MTIMECMPH = 0x00;
    *MTIMECMP = 0xFF;
    flag = 4;
    resume_addr = &&there;

    setup_interrupt_m_vectored(vector_table, IE_MTIE);
    enable_interrupts_m();

    while((*MTIME) < 0xFF);

there:
    ecall();

    if (flag == 1) {
        test_pass("Exception after interrupt handled");
    } else {
        test_fail("Exception after interrupt not handled correctly");
    }

    return 0;
}
