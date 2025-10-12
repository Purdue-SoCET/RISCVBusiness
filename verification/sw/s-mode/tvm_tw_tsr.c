#include <stdint.h>
#include "utility.h"

extern volatile int flag;
extern volatile int done;

void __attribute__((interrupt)) __attribute__((aligned(4))) handler() {
  uint32_t mepc, mtval;
  mcause_t mcause;
  uint32_t satp;
  asm volatile("csrr %0, mepc" : "=r"(mepc));
  asm volatile("csrr %0, mtval" : "=r"(mtval));
  asm volatile("csrr %0, mcause" : "=r"((mcause_t) mcause));
  asm volatile("csrr %0, satp" : "=r"(satp));

  print("mepc: ");
  put_uint32_hex(mepc);
  print("\n");

  print("mtval: ");
  put_uint32_hex(mtval);
  print("\n");

  print("mcause: ");
  put_uint32_hex(mcause.interrupt & 0x1);
  print(" ");
  put_uint32_hex(mcause.ex_code);
  print("\n");

  print("satp: ");
  put_uint32_hex(satp);
  print("\n");
  print("-----\n");

  if (~mcause.interrupt && mcause.ex_code == 9){ // 9 == ENV_CALL_S
    uint32_t mstatus = 0x1800; // set mpp back to M_MODE
    asm volatile("csrs mstatus, %0" : : "r"(mstatus));
    mepc = (uint32_t) &done;
  }
  else
  {
    mepc += 4;
    flag -= 1;
  }
  asm volatile("csrw mepc, %0" : : "r"(mepc));
  asm volatile("mret");
}

void __attribute__((noreturn)) __attribute__((aligned(4))) supervisor_main(void) {

  // TVM tests
  asm volatile("csrw satp, %0" : : "r"(0x8000FFFF)); // cannot write to satp

  asm volatile("csrr t0, satp"); // cannot read from satp

  asm volatile("sfence.vma"); // cannot do sfence.vma

  // TW tests
  asm volatile("wfi");   // wfi doesn't work in unprivileged mode

  // TSR tests
  asm volatile("sret");  // sret raises illegal instruction
  
  // Finished!
  asm volatile("ecall"); // ends supervisor_main

  __builtin_unreachable();

}

int main(void) {
  // check to see if s-mode is enabled
  // easiest way is to set mstatus.mpp to S-mode and
  // read it to see if its the expected value for S-mode
  // S_MODE = 2'b01, mpp is bits [12:11]
  uint32_t mstatus_value = 0b01 << 11;
  asm volatile("csrs mstatus, %0" : : "r"(mstatus_value));
  asm volatile("csrr %0, mstatus" : "=r"(mstatus_value));

  // If S-mode is not enabled
  if ((mstatus_value & 0x1800) == 0) {
      print("Enable the Supervisor to run this testbench!\n");
      mstatus_value = 0x1800; // set mpp back to M_MODE
      asm volatile("csrs mstatus, %0" : : "r"(mstatus_value));
      asm volatile("csrw mepc, %0" : : "r"((uint32_t) &done));
      asm volatile("mret");
  }
  // set mstatus value back to default
  mstatus_value &= ~0x1800;
  asm volatile("csrw mstatus, %0" : : "r"(mstatus_value));

  // Setup exceptions
  uint32_t mtvec_value = (uint32_t) handler;
  mstatus_value = (1 << 3) | (1 << 11) | (1 << 20) | (1 << 21) | (1 << 22); // set MIE, MPP == S_MODE, TVM, TW, TSR
  asm volatile("csrs mstatus, %0" : : "r"(mstatus_value));
  asm volatile("csrw mtvec, %0" : : "r"(mtvec_value));

  // Setup PMP
  uint32_t pmp_addr = ((uint32_t) (&flag)) >> 2; // Protect flag
  asm volatile("csrw pmpaddr0, %0" : : "r"(pmp_addr));
  uint32_t actual_pmp_addr;
  asm volatile("csrr %0, pmpaddr0" : "=r"(actual_pmp_addr));
  if (actual_pmp_addr != pmp_addr) {
      print("Set PMP granularity down to 4 to run this test!\n");
      mstatus_value = 0x1800; // set mpp back to M_MODE
      asm volatile("csrs mstatus, %0" : : "r"(mstatus_value));
      asm volatile("csrw mepc, %0" : : "r"((uint32_t) &done));
      asm volatile("mret");
  }
  pmp_addr = 0x20001FFF; // Allows for the entire text, bss, stack section
  asm volatile("csrw pmpaddr1, %0" : : "r"(pmp_addr));
  uint32_t pmp_cfg = 0x00001F11; // [NAPOT, RWX, no L] [NA4, R, no L]
  asm volatile("csrw pmpcfg0, %0" : : "r"(pmp_cfg));

  // Jump to user program
  flag = 6;
  uint32_t mepc_value = (uint32_t) supervisor_main;
  asm volatile("csrw mepc, %0" : : "r"(mepc_value));
  asm volatile("mret");

  __builtin_unreachable();
}
