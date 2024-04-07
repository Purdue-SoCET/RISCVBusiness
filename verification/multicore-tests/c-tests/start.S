#include "amo_emu.h"

WANT_AMO_EMU_SUPPORT

.global _start
_start:
    # Start out by getting mhartid to tell which core we're on
    csrr s0, mhartid
    .option push
    .option norelax
    la gp, __global_pointer$
    .option pop
    la s1, bss_cleared
    # Only clear bss on hart0
    bnez s0, wait_for_bss_cleared
clr_bss:
    la t0, __bss_start
    la t1, __bss_end
    beq t0, t1, set_bss_cleared
clr_bss_loop:
    sb zero, 0(t0)
    addi t0, t0, 1
    blt t0, t1, clr_bss_loop
set_bss_cleared:
    addi t0, zero, 1
    sw t0, 0(s1)
wait_for_bss_cleared:
    lw t0, 0(s1)
    beqz t0, wait_for_bss_cleared

start:
    # Get a 2kB stack starting at 0x8000F000
    li sp, 0x8000F000
    slli t0, s0, 11
    add sp, sp, t0
    # Calculate which main to call
    # IMPORTANT: hart1_main *must* set hart1_done to 1
    slli t0, s0, 2
    la t1, main_array
    add t0, t0, t1
    lw t0, 0(t0)
    jalr ra, t0
    # Calculate which done do call
    slli t0, s0, 2
    la t1, done_array
    add t0, t0, t1
    lw t0, 0(t0)
    jalr ra, t0

.global done
hart0_done:
    la a0, hart1_done
wait_for_hart1_done:
    lw a1, 0(a0)
    beq a1, zero, wait_for_hart1_done
    la x28, flag
    lw x28, 0(x28)
    j __inf_loop
hart1_done_end:
    la x28, hart1_done
    lw x28, 0(x28)
__inf_loop:
    j __inf_loop

.global hart_wait_loop
hart_wait_loop:
    j hart_wait_loop

.global hart0_main
.global hart1_main

.data
.global flag
flag: .word 0x00
.global hart1_done
hart1_done: .word 0x00
.global bss_cleared
bss_cleared: .word 0x00

.global main_array
main_array:
.int hart0_main
.int hart1_main

.global done_array
done_array:
.int hart0_done
.int hart1_done_end
