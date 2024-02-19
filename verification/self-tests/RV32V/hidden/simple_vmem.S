# See LICENSE for license details.

#*****************************************************************************
# simple_vmem.S
#-----------------------------------------------------------------------------
#
# Test vle* and vse* instructions
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32UV

# vsetvl 
# vsetvli
# vsetivli


RVTEST_CODE_BEGIN
  vsetivli x10, 1, e32
  li x1, tdat
  vle32.v v1, x10
  NOP
  NOP
  NOP
  li x2, (tdat + 4)
  vse32.v v1, x2
  NOP
  NOP
  NOP
  lw x5, 0(x2)
  TEST_CASE(1, x5, 15, NOP)


  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

tdat:
tdat1:  .word 15
tdat2:  .word 0xffffffff
tdat3:  .word 0x0ff00ff0
tdat4:  .word 0xf00ff00f
tdat5:  .word 0x00ff00ff
tdat6:  .word 0xff00ff00
tdat7:  .word 0x0ff00ff0
tdat8:  .word 0xf00ff00f


RVTEST_DATA_END
