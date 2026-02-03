#include <stdint.h>
#include <stddef.h>
#include "csr.h"
#include "format.h"
#include "utility.h"

void *return_addr = NULL;

/*
*  Triggers a store fault on the bus.
*/

void exception_handler() {
    print("Made it to handler!\n");
    exception_context_t exc;
    read_exception_context(&exc);
    flag &= ~(1 << exc.cause);
    set_mepc(return_addr);
}

void __attribute__((naked)) __attribute__((noinline))
trigger_fault(unsigned round __attribute__((unused))) {
    __asm__ volatile(
        // Save return address
        "la t0, return_addr\n"
        "sw ra, 0(t0)\n"
        
        // Check round value (passed in a0)
        "li t1, 0\n"
        "beq a0, t1, 1f\n"
        "li t1, 1\n"
        "beq a0, t1, 2f\n"
        "j 3f\n"
        
        // round == 0: load fault
        "1:\n"
        "lw x0, 0(x0)\n"
        "ret\n"
        
        // round == 1: store fault
        "2:\n"
        "sw x0, 0(x0)\n"
        "ret\n"
        
        // round == 2: instruction fault
        "3:\n"
        "jr x0, 0x0\n"
        "ret\n"
    );
}

int main() {
    flag = 0x1 | (1 << EX_FAULT_INSN) | (1 << EX_FAULT_LOAD) | (1 << EX_FAULT_STORE);
    setup_interrupts_m(exception_handler, 0);

    for(int i = 0; i < 3; i++) {
        trigger_fault(i);
    }

    if(flag == 1) {
        test_pass("Bus fault handled");
    } else {
        test_fail("Unhandled bus faults");
        print("Bus faults not handled: %s %s %s\n",
            BIT_TEST(flag, EX_FAULT_LOAD) ? "load" : "",
            BIT_TEST(flag, EX_FAULT_STORE) ? "store" : "",
            BIT_TEST(flag, EX_FAULT_INSN) ? "fetch" : ""
        );
    }

    return 0;
}
