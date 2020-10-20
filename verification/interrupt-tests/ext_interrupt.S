/*
*   Copyright 2016 Purdue University
*   
*   Licensed under the Apache License, Version 2.0 (the "License");
*   you may not use this file except in compliance with the License.
*   You may obtain a copy of the License at
*   
*       http://www.apache.org/licenses/LICENSE-2.0
*   
*   Unless required by applicable law or agreed to in writing, software
*   distributed under the License is distributed on an "AS IS" BASIS,
*   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*   See the License for the specific language governing permissions and
*   limitations under the License.
*
*
*   Filename:     ext_interrupt.S
*
*   Created by:   Enes Shaltami
*   Email:        ashaltam@purdue.edu
*   Date Created: 03/15/2020
*   Description:  Test of external interrupts
*/

#include "riscv_test.h"
#include "test_macros.h"

#define claim_complete_reg 0x80040018

RVTEST_RV32U
RVTEST_CODE_BEGIN


main:
  la t0, mtvec_handler // load in address of mtvec_handler
  ori t0, t0, 0x1 // or in the MODE (Vectored)
  li TESTNUM, 0 // initialize TESTNUM (x28)
  csrw mtvec, t0 // assign the supported vector handler into mtvec

  addi x3, x0, 0x1
  slli x3, x3, 11 // store 0x800 into x3 and x4
  csrw mie, x3 // Write value of 0x800 into mie, external interrupt enable for M-mode

  ori x4, x0, 0x1
  slli x4, x4, 3
  csrw mstatus, x4 // turn on the mie bit within mstatus

idle_loop:
  beq TESTNUM, x0, idle_loop // infinite loop will only finish once the external interrupt ISR has completed properly

  j done // jump to outside subroutine which will halt
  //RVTEST_PASS


.align 2
mtvec_handler: // General vector table for all exceptions and interrupts
  // Interrupts must be disabled at entry to handler, could have jumps to different parts of code, potentially
IRQ_0:
  j exception_handler // NOTE: PC for exception handler and user software interrupt handler are the same
IRQ_1:
  j supervisor_software_interrupt_handler
IRQ_2:
  j reserved_software_interrupt_handler
IRQ_3:
  j machine_software_interrupt_handler
IRQ_4:
  j user_timer_interrupt_handler
IRQ_5:
  j supervisor_timer_interrupt_handler
IRQ_6:
  j reserved_timer_interrupt_handler
IRQ_7:
  j machine_timer_interrupt_handler
IRQ_8:
  j user_external_interrupt_handler
IRQ_9:
  j supervisor_external_interrupt_handler
IRQ_10:
  j reserved_external_interrupt_handler
IRQ_11:
  j machine_external_interrupt_handler

exception_handler: // manage all exceptions here
supervisor_software_interrupt_handler: 
reserved_software_interrupt_handler: 
machine_software_interrupt_handler:
user_timer_interrupt_handler:
supervisor_timer_interrupt_handler:
reserved_timer_interrupt_handler:
machine_timer_interrupt_handler:
user_external_interrupt_handler: 
supervisor_external_interrupt_handler:
reserved_external_interrupt_handler:
    jal x1, push_registers
    nop
    jal x1, pop_registers
    mret

machine_external_interrupt_handler:
    //jal x1, push_registers
    addi x16, x0, 16
    addi x17, x0, 17
    addi x18, x0, 18
    addi x19, x0, 19
    addi x20, x0, 20

    //la x2, claim_complete_reg // read the claim complete register to know the type of interrupt that occurred
    lui x2, 0x80040 // load in the claim complete register address
    addi x2, x2, 0x018 
    lw x3, 0(x2)
    beq x0, x3, invalid_id_read
    li TESTNUM, 1
    sw x3, 0(x2)

invalid_id_read:
    //jal x1, pop_registers
    mret

push_registers:
    // push RISC-V ABI registers
    lui x2, 0x8
    ori x2, x2, 0x3FC
    addi x2, x2, -64 // stack pointer
    //sw x1, 4(x2) // return address
    sw x5, 8(x2) // temporary registers
    sw x6, 12(x2)
    sw x7, 16(x2)
    //sw x28, 20(x2) // disclude TESTNUM
    sw x29, 24(x2)
    sw x30, 28(x2)
    sw x31, 32(x2)
    sw x10, 36(x2) // function arguments
    sw x11, 40(x2)
    sw x12, 44(x2)
    sw x13, 48(x2)
    sw x14, 52(x2)
    sw x15, 56(x2)
    sw x16, 60(x2)
    sw x17, 64(x2)
    jr x1

pop_registers:
    // pop registers
    //lw x1, 4(x2)
    lw x5, 8(x2)
    lw x6, 12(x2)
    lw x7, 16(x2)
    //lw x28, 20(x2)
    lw x29, 24(x2)
    lw x30, 28(x2)
    lw x31, 32(x2)
    lw x10, 36(x2)
    lw x11, 40(x2)
    lw x12, 44(x2)
    lw x13, 48(x2)
    lw x14, 52(x2)
    lw x15, 56(x2)
    lw x16, 60(x2)
    lw x17, 64(x2)
    addi x2, x2, 64
    jr x1
   


RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
  TEST_DATA
RVTEST_DATA_END
  
