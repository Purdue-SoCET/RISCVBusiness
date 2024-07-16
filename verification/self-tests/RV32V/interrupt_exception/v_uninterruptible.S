# See LICENSE for license details.

#*****************************************************************************
# v_uninterruptible.S
#-----------------------------------------------------------------------------
#
# Test triggering interrupt during "uninterruptible" instruction
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

  li t5, 0xFFFFFFE0  # MTIME addr
  li t6, 0xFFFFFFE8  # MTIMECMP addr

  # Define trap vector address
  la t3, mvec
  csrw mtvec, t3

  # Use mtimecmp to trigger interrupt after some time (during uninteruptible instruction)
  lw t3, 0(t5)
  lw t4, 4(t5)
  addi t3, t3, 180
  sw t3, 0(t6)
  sw t4, 4(t6)

  # Enable mtime interrupt
  li t3, 0x80
  csrs mie, t3

  # Enable machine interrupt
  li t3, 0x8
  csrs mstatus, t3

	vsetvli x20, x0, e8
  la x1, ldat1
  la x2, ldat2
	la x3, sdat
  vle8.v v0, (x1)
  vle8.v v1, (x2)
  # TODO: UNINTERRUPTIBLE instruction next, align mtime interrupt
  vor.vv v2, v0, v1
  vse8.v v2, (x3)

  lw x4, 0(x3)
  lw x5, 4(x3)
  lw x6, 8(x3)
  lw x7, 12(x3)

  # Verify that interrupt was triggered
  la x8, flag
  lw x9, 0(x8)

  TEST_CASE(1, x20, 16, NOP)
	TEST_CASE(2, x4, 0x33221100, NOP)
  TEST_CASE(3, x5, 0x77665544, NOP)
  TEST_CASE(4, x6, 0xbbaa9988, NOP)
  TEST_CASE(5, x7, 0xffeeddcc, NOP)
  TEST_CASE(6, x9, 1, NOP)

  TEST_PASSFAIL

RVTEST_CODE_END

mvec:
RVTEST_INTVEC_MACH_BEGIN
  ori t3, x0, 1
  la  t4, flag
  sw  t3, 0(t4)
  # Make mtimecmp very large to prevent further interrupts
  li  t3, 0xFFFFFFFF
  sw  t3, 4(t6)
  # lw t3, 0(t5)
  # addi t3, t3, 40
  # sw t3, 0(t6)
  mret

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

  flag:
  .word 0x0

  ldat1:
  .word 0x03020100
  .word 0x07060504
  .word 0x0b0a0908
  .word 0x0f0e0d0c
  ldat2:
  .word 0x30201000
  .word 0x70605040
  .word 0xb0a09080
  .word 0xf0e0d0c0

  sdat:
  .word 0x55555555
  .word 0x55555555
  .word 0x55555555
  .word 0x55555555

RVTEST_DATA_END
