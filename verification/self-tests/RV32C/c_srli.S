# See LICENSE for license details.

#*****************************************************************************
# c_srli.S
#-----------------------------------------------------------------------------
#
# Test c_srli instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_RV32C_IMM_OP( 3,  c.srli, 0x7fffc000, 0xffff8000, 1  );
  TEST_RV32C_IMM_OP( 4,  c.srli, 0x01ffff00, 0xffff8000, 7  );
  TEST_RV32C_IMM_OP( 5,  c.srli, 0x0003fffe, 0xffff8000, 14 );
  TEST_RV32C_IMM_OP( 6,  c.srli, 0x0001ffff, 0xffff8001, 15 );

  TEST_RV32C_IMM_OP( 7,  c.srli, 0x00000000, 0x00000000, 17  );
  TEST_RV32C_IMM_OP( 8,  c.srli, 0x7fffffff, 0xffffffff, 1  );
  TEST_RV32C_IMM_OP( 9,  c.srli, 0x01ffffff, 0xffffffff, 7  );
  TEST_RV32C_IMM_OP( 10, c.srli, 0x0003ffff, 0xffffffff, 14 );
  TEST_RV32C_IMM_OP( 11, c.srli, 0x00000001, 0xffffffff, 31 );

  TEST_RV32C_IMM_OP( 12, c.srli, 0x00000000, 0x00000000, 30  );
  TEST_RV32C_IMM_OP( 13, c.srli, 0x10909090, 0x21212121, 1  );
  TEST_RV32C_IMM_OP( 14, c.srli, 0x00424242, 0x21212121, 7  );
  TEST_RV32C_IMM_OP( 15, c.srli, 0x00008484, 0x21212121, 14 );
  TEST_RV32C_IMM_OP( 16, c.srli, 0x00000000, 0x21212121, 31 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RV32C_IMM_DEST_BYPASS( 17, 0, c.srli, 0x7fffc000, 0xffff8000, 1  );
  TEST_RV32C_IMM_DEST_BYPASS( 18, 1, c.srli, 0x0003fffe, 0xffff8000, 14 );
  TEST_RV32C_IMM_DEST_BYPASS( 19, 2, c.srli, 0x0001ffff, 0xffff8000, 15 );
  
  TEST_RV32C_IMM_SRC1_BYPASS( 20, 0, c.srli, 0x7fffc000, 0xffff8000, 1  );
  TEST_RV32C_IMM_SRC1_BYPASS( 21, 1, c.srli, 0x0003fffe, 0xffff8000, 14 );
  TEST_RV32C_IMM_SRC1_BYPASS( 22, 2, c.srli, 0x0001ffff, 0xffff8000, 15 );
  

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
