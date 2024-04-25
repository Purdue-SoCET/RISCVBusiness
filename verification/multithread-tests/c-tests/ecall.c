
#include <stdint.h>
#include "utility.h"

extern volatile int flag;

void interrupt_thread() {
  uint32_t mepc_value;
  asm volatile("csrr %0, mepc" : "=r"(mepc_value));
  mepc_value += 4;
  asm volatile("csrw mepc, %0" : : "r"(mepc_value));
  flag = 1;
  thread_terimate();
}

void thread1() {
  flag = 0;
  uint32_t mtvec_value = (uint32_t)interrupt_thread;
  uint32_t mstatus_value = 0x8;

  asm volatile("csrw mstatus, %0" : : "r" (mstatus_value));
  asm volatile("csrw mtvec, %0" : : "r" (mtvec_value));

  asm volatile("ecall");
  asm volatile("nop"); // to avoid missed next inst
  thread_terimate();
}

// void thread1() {
// }

// void __attribute__((interrupt)) __attribute__((aligned(4))) handler() {
//     uint32_t mepc_value;
//     asm volatile("csrr %0, mepc" : "=r"(mepc_value));
//     mepc_value += 4;
//     asm volatile("csrw mepc, %0" : : "r"(mepc_value));
//     /*
//     asm volatile(
//         "mv t0, zero; csrrs t0, mepc, t0; addi t0, t0, 4; csrw mepc, t0;"
//         :
//         :
//         : "t0"
//     );*/
//     print("Made it to handler!\n");
//     flag = 1;
// }


// int main() {
    
//     uint32_t mtvec_value = (uint32_t)handler;
//     uint32_t mstatus_value = 0x8;

//     asm volatile("csrw mstatus, %0" : : "r" (mstatus_value));
//     asm volatile("csrw mtvec, %0" : : "r" (mtvec_value));

//     print("Jumping to handler...\n");
//     asm volatile("ecall");

//     print("Flag is 0x");
//     put_uint32_hex(flag);
//     print("\n");

//     return 0;
// }
