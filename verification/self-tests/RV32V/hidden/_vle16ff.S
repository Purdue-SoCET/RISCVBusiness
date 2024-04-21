# See LICENSE for license details.

#*****************************************************************************
# vle.S
#-----------------------------------------------------------------------------
#
# Test vle, vleff instruction.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # vleff tests
  #-------------------------------------------------------------

  TEST_VLEFF_OP( 31, vle16ff.v, 16, 0x000ff, 0x000ff, tdat1 );
  
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

tdat:
tdat1:  .word 0x00ff00ff
tdat2:  .word 0xff00ff00
tdat3:  .word 0x0ff00ff0
tdat4:  .word 0xf00ff00f
tdat5:  .word 0x00ff00ff
tdat6:  .word 0xff00ff00
tdat7:  .word 0x0ff00ff0
tdat8:  .word 0xf00ff00f

RVTEST_DATA_END
