# See LICENSE for license details.

#*****************************************************************************
# amoand.w.S
#-----------------------------------------------------------------------------
#
# Test amoand.w instruction.
#

#include "riscv_test.h"
#include "test_macros.h"
#include "amo_emu.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

WANT_AMO_EMU_SUPPORT

# Only run on hart0
li t3, 1
csrr s0, mhartid
bnez s0, done
li t3, 0

TEST_CASE(2, a4, 0xffffffff80000000, \
    li a0, 0xffffffff80000000; \
    li a1, 0xfffffffffffff800; \
    la a3, amo_operand; \
    sw a0, 0(a3); \
    amoand.w a4, a1, 0(a3); \
)

TEST_CASE(3, a5, 0xffffffff80000000, lw a5, 0(a3))

# try again after a cache miss
TEST_CASE(4, a4, 0xffffffff80000000, \
    li  a1, 0x0000000080000000; \
    amoand.w a4, a1, 0(a3); \
)

TEST_CASE(5, a5, 0xffffffff80000000, lw a5, 0(a3))

TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

  .bss
  .align 3
amo_operand:
  .dword 00
