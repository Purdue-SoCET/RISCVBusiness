
#include <stdint.h>
#include "csr.h"
#include "utility.h"

// For this test: need to subtract 0xFE from flag to make flag = 1
// Each handler should be called once. If not, flag will be wrong
void meip_handler() {
    flag -= 0xE;
    *EXT_CLEAR = 0x1; // writing anything simulates clearing interrupt
    CSRW("mie", 0x088);
}

void mtip_handler() {
    flag -= 0xE0;
    *MTIMECMPH = 0xFF; // setting mtimecmph makes a very large value
}

void msip_handler() {
    flag -= 0x10;
    *MSIP = 0x0; // writing 0 clears this
}

int main() {
    *MTIMECMPH = 0x00;
    *MTIMECMP  = 0xFF;

    setup_interrupt_m_vectored(vector_table, IE_MTIE | IE_MSIE | IE_MEIE);
    enable_interrupts_m();

    *MSIP = 1;
    *EXT_SET = 1;

    while(*MTIME < 0xFF);

    if (flag == 1) {
        test_pass("All vectored interrupts handled");
    } else {
        test_fail("Vectored interrupts not handled correctly");
    }

    return 0;
}
