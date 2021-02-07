# See LICENSE for license details.

#*****************************************************************************
# c_slli.S
#-----------------------------------------------------------------------------
#
# Test c_slli instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_RV32C_IMM_OP( 2,  c.slli, 0x00000000, 0x00000000, 11  );
  TEST_RV32C_IMM_OP( 3,  c.slli, 0x00000002, 0x00000001, 1  );
  TEST_RV32C_IMM_OP( 4,  c.slli, 0x00000080, 0x00000001, 7  );
  TEST_RV32C_IMM_OP( 5,  c.slli, 0x00004000, 0x00000001, 14 );
  TEST_RV32C_IMM_OP( 6,  c.slli, 0x80000000, 0x00000001, 31 );

  TEST_RV32C_IMM_OP( 7,  c.slli, 0x00000000, 0x00000000, 23  );
  TEST_RV32C_IMM_OP( 8,  c.slli, 0xfffffffe, 0xffffffff, 1  );
  TEST_RV32C_IMM_OP( 9,  c.slli, 0xffffff80, 0xffffffff, 7  );
  TEST_RV32C_IMM_OP( 10, c.slli, 0xffffc000, 0xffffffff, 14 );
  TEST_RV32C_IMM_OP( 11, c.slli, 0x80000000, 0xffffffff, 31 );

  TEST_RV32C_IMM_OP( 12, c.slli, 0x00000000, 0x00000000, 30  );
  TEST_RV32C_IMM_OP( 13, c.slli, 0x42424242, 0x21212121, 1  );
  TEST_RV32C_IMM_OP( 14, c.slli, 0x90909080, 0x21212121, 7  );
  TEST_RV32C_IMM_OP( 15, c.slli, 0x48484000, 0x21212121, 14 );
  TEST_RV32C_IMM_OP( 16, c.slli, 0x80000000, 0x21212121, 31 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RV32C_IMM_DEST_BYPASS( 17, 0, c.slli, 0x00000080, 0x00000001, 7  );
  TEST_RV32C_IMM_DEST_BYPASS( 18, 1, c.slli, 0x00004000, 0x00000001, 14 );
  TEST_RV32C_IMM_DEST_BYPASS( 19, 2, c.slli, 0x80000000, 0x00000001, 31 );

  TEST_RV32C_IMM_SRC1_BYPASS( 20, 0, c.slli, 0x00000080, 0x00000001, 7  );
  TEST_RV32C_IMM_SRC1_BYPASS( 21, 1, c.slli, 0x00004000, 0x00000001, 14 );
  TEST_RV32C_IMM_SRC1_BYPASS( 22, 2, c.slli, 0x80000000, 0x00000001, 31 );


  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
