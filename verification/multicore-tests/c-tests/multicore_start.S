#include "amo_emu.h"
WANT_AMO_EMU_SUPPORT

#ifndef NUM_CORE
#define NUM_CORE 2
#endif

.global _start
_start:
    # Get the hart ID
    csrr s0, mhartid

    .option push
    .option norelax
    la gp, __global_pointer$
    .option pop

    la s1, bss_cleared
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
    li t0, 1
    sw t0, 0(s1)

wait_for_bss_cleared:
    lw t0, 0(s1)
    beqz t0, wait_for_bss_cleared
    la sp, __stack_top
    slli t0, s0, 14    
    add sp, sp, t0

    li t2, NUM_CORE
    bge s0, t2, hart_wait_loop

    slli t0, s0, 2    
    la t1, main_array
    add t0, t0, t1
    lw t0, 0(t0)
    jalr ra, t0

    slli t0, s0, 2
    la t1, done_array
    add t0, t0, t1
    lw t0, 0(t0)
    jalr ra, t0

.global done
hart0_done:
    la t1, hart_done   
    li t2, 1        

wait_all_harts:
    li t3, NUM_CORE
    bge t2, t3, all_done 
    slli t4, t2, 2
    add t5, t1, t4
    lw t6, 0(t5)
    beqz t6, wait_all_harts
    addi t2, t2, 1
    j wait_all_harts

all_done:
    la x28, flag
    lw x28, 0(x28)
    j __inf_loop

hart1_done_end:
    la t1, hart1_done
    lw x28, 0(t1)
    j __inf_loop

hart2_done_end:
    la t1, hart2_done
    lw x28, 0(t1)
    j __inf_loop

hart3_done_end:
    la t1, hart3_done
    lw x28, 0(t1)
    j __inf_loop

hart4_done_end:
    la t1, hart4_done
    lw x28, 0(t1)
    j __inf_loop

hart5_done_end:
    la t1, hart5_done
    lw x28, 0(t1)
    j __inf_loop

hart6_done_end:
    la t1, hart6_done
    lw x28, 0(t1)
    j __inf_loop

hart7_done_end:
    la t1, hart7_done
    lw x28, 0(t1)
    j __inf_loop

__inf_loop:
    j __inf_loop

.global hart_wait_loop
hart_wait_loop:
    j hart_wait_loop

.global hart0_main
.global hart1_main
.global hart2_main
.global hart3_main
.global hart4_main
.global hart5_main
.global hart6_main
.global hart7_main

.data
.global flag
flag: .word 0x00

.global start_flag
start_flag: .word 0x00

.global bss_cleared
bss_cleared: .word 0x00

.global hart_done
hart_done: .word 0x00

.global hart1_done
hart1_done: .word 0x00

.global hart2_done
hart2_done: .word 0x00

.global hart3_done
hart3_done: .word 0x00

.global hart4_done
hart4_done: .word 0x00

.global hart5_done
hart5_done: .word 0x00

.global hart6_done
hart6_done: .word 0x00

.global hart7_done
hart7_done: .word 0x00

.global main_array
main_array:
    .int hart0_main
    .int hart1_main
    .int hart2_main
    .int hart3_main
    .int hart4_main
    .int hart5_main
    .int hart6_main
    .int hart7_main

.global done_array
done_array:
    .int hart0_done
    .int hart1_done_end
    .int hart2_done_end
    .int hart3_done_end
    .int hart4_done_end
    .int hart5_done_end
    .int hart6_done_end
    .int hart7_done_end
