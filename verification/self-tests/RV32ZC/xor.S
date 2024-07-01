# See LICENSE for license details.

#*****************************************************************************
# xor.S
#*****************************************************************************

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  TEST_CASE(1, x14, 0x3, \
    li x1, 0x1; \
    li x2, 0x2; \
    li x3, 0x0; \
    czero.nez x14, x2, x3; \
    xor x14, x1, x14; \
  )

  TEST_CASE(2, x14, 0x1, \
    li x1, 0x1; \
    li x2, 0x2; \
    li x3, 0x1; \
    czero.nez x14, x2, x3; \
    xor x14, x1, x14; \
  )

  TEST_CASE(3, x14, 0x2, \
    li x1, 0x2; \
    li x2, 0x1; \
    li x3, 0x0; \
    czero.eqz x14, x2, x3; \
    xor x14, x1, x14; \
  )

  TEST_CASE(4, x14, 0x3, \
    li x1, 0x1; \
    li x2, 0x2; \
    li x3, 0x1; \
    czero.eqz x14, x2, x3; \
    xor x14, x1, x14; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
