#include <stdint.h>
#include <stdnoreturn.h>
#include "csr.h"
#include "format.h"
#include "utility.h"

/*
*  tvm_tw_tsr.c - tests S-mode control bits
*/

void __attribute__((interrupt)) __attribute__((aligned(4))) handler() {
  exception_context_t ctx;
  read_exception_context(&ctx);
  print_exception_context(&ctx);

  uint32_t satp = CSRR("satp");
  print("satp: %x\n", satp);
  print("-----\n");

  if (ctx.cause == EX_ECALL_SMODE) {
    CSRS("mstatus", MSTATUS_MPP);
    set_mepc(&done);
  } else {
    advance_mepc(4);
    flag -= 1;
  }
  asm volatile("mret");
}

noreturn void __attribute__((aligned(4))) supervisor_main(void) {

  CSRW("satp", 0x8000FFFF);

  uint32_t temp = CSRR("satp");
  (void)temp;

  asm volatile("sfence.vma");
  asm volatile("wfi");
  asm volatile("sret");

  ecall();

  __builtin_unreachable();
}

int main(void) {
  require_supervisor_mode();

  CSRW("mtvec", (uint32_t) handler);
  uint32_t mstatus_value = (1 << 3) | (1 << 11) | (1 << 20) | (1 << 21) | (1 << 22);
  CSRS("mstatus", mstatus_value);

  uint32_t pmp_addr = ((uint32_t) (&flag)) >> 2;
  CSRW("pmpaddr0", pmp_addr);
  uint32_t actual_pmp_addr = CSRR("pmpaddr0");
  if (actual_pmp_addr != pmp_addr) {
      print("Set PMP granularity down to 4 to run this test!\n");
      CSRS("mstatus", MSTATUS_MPP);
      set_mepc(&done);
      asm volatile("mret");
  }
  pmp_addr = 0x20001FFF;
  CSRW("pmpaddr1", pmp_addr);
  uint32_t pmp_cfg = 0x00001F11;
  CSRW("pmpcfg0", pmp_cfg);

  flag = 6;
  set_mepc(supervisor_main);
  asm volatile("mret");

  __builtin_unreachable();
}
