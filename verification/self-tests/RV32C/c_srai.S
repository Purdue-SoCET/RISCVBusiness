# See LICENSE for license details.

#*****************************************************************************
# c_srai.S
#-----------------------------------------------------------------------------
#
# Test c_srai instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_RV32C_IMM_OP( 2,  c.srai, 0x00000000, 0x00000000, 16  );
  TEST_RV32C_IMM_OP( 3,  c.srai, 0xc0000000, 0x80000000, 1  );
  TEST_RV32C_IMM_OP( 4,  c.srai, 0xff000000, 0x80000000, 7  );
  TEST_RV32C_IMM_OP( 5,  c.srai, 0xfffe0000, 0x80000000, 14 );
  TEST_RV32C_IMM_OP( 6,  c.srai, 0xffffffff, 0x80000001, 31 );

  TEST_RV32C_IMM_OP( 7,  c.srai, 0x00007fff, 0x7fffffff, 16  );
  TEST_RV32C_IMM_OP( 8,  c.srai, 0x3fffffff, 0x7fffffff, 1  );
  TEST_RV32C_IMM_OP( 9,  c.srai, 0x00ffffff, 0x7fffffff, 7  );
  TEST_RV32C_IMM_OP( 10, c.srai, 0x0001ffff, 0x7fffffff, 14 );
  TEST_RV32C_IMM_OP( 11, c.srai, 0x00000000, 0x7fffffff, 31 );

  TEST_RV32C_IMM_OP( 12, c.srai, 0xffff8181, 0x81818181, 16  );
  TEST_RV32C_IMM_OP( 13, c.srai, 0xc0c0c0c0, 0x81818181, 1  );
  TEST_RV32C_IMM_OP( 14, c.srai, 0xff030303, 0x81818181, 7  );
  TEST_RV32C_IMM_OP( 15, c.srai, 0xfffe0606, 0x81818181, 14 );
  TEST_RV32C_IMM_OP( 16, c.srai, 0xffffffff, 0x81818181, 31 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RV32C_IMM_DEST_BYPASS( 17, 0, c.srai, 0xff000000, 0x80000000, 7  );
  TEST_RV32C_IMM_DEST_BYPASS( 18, 1, c.srai, 0xfffe0000, 0x80000000, 14 );
  TEST_RV32C_IMM_DEST_BYPASS( 19, 2, c.srai, 0xffffffff, 0x80000001, 31 );

  TEST_RV32C_IMM_SRC1_BYPASS( 20, 0, c.srai, 0xff000000, 0x80000000, 7 );
  TEST_RV32C_IMM_SRC1_BYPASS( 21, 1, c.srai, 0xfffe0000, 0x80000000, 14 );
  TEST_RV32C_IMM_SRC1_BYPASS( 22, 2, c.srai, 0xffffffff, 0x80000001, 31 );


  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
