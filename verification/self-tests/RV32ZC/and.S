# See LICENSE for license details.

#*****************************************************************************
# and.S
#*****************************************************************************

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  TEST_CASE(1, x14, 0x8, \
    li x1, 0xC; \
    li x2, 0x19; \
    li x3, 0x0; \
    and x14, x1, x2; \
    czero.eqz x15, x1, x3; \
    or x14, x14, x15; \
  )

  TEST_CASE(2, x14, 0x8, \
    li x1, 0xC; \
    li x2, 0x19; \
    li x3, 0x1; \
    and x14, x1, x2; \
    czero.nez x15, x1, x3; \
    or x14, x14, x15; \
  )


  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
