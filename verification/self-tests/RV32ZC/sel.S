# See LICENSE for license details.

#*****************************************************************************
# sel.S
#*****************************************************************************

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  TEST_CASE(1, x14, 0x1, \
    li x1, 0x1; \
    li x2, 0x0; \
    li x3, 0x0; \
    czero.nez x14, x1, x3; \
    czero.eqz x15, x2, x3; \
    or x14, x14, x15; \
  )

  TEST_CASE(2, x14, 0x0, \
    li x1, 0x0; \
    li x2, 0x1; \
    li x3, 0x1; \
    czero.eqz x14, x1, x3; \
    czero.nez x15, x2, x3; \
    or x14, x14, x15; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
