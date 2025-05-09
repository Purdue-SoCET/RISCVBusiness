# See LICENSE for license details.

#*****************************************************************************
# amomax_d.S
#-----------------------------------------------------------------------------
#
# Test amomax.w instruction.
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
    amomax.w a4, a1, 0(a3); \
)

TEST_CASE(3, a5, 0xfffffffffffff800, lw a5, 0(a3))

TEST_CASE(4, a4, 0, \
    li a1, 1; \
    sw x0, 0(a3); \
    amomax.w a4, a1, 0(a3); \
)

TEST_CASE(5, a5, 1, lw a5, 0(a3))

TEST_CASE(6, a4, 1, \
    li a0, 0x0000000000000001; \
    li a1, 0x0000000080000000; \
    la a3, amo_operand; \
    sw a0, 0(a3); \
    amomax.w a4, a1, 0(a3); \
)

TEST_CASE(7, a5, 1, lw a5, 0(a3))

TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

  .bss
  .align 3
amo_operand:
  .dword 0
