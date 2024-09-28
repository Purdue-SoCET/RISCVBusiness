# See LICENSE for license details.

#*****************************************************************************
# vcompress.S
#-----------------------------------------------------------------------------
#
# Test vcompress instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV tests
  #-------------------------------------------------------------
  #if __riscv_vsew == 32
  TEST_VCOMPRESS_OP( 2,  vcompress.vm, ans1dat, src11dat, src12dat, vm1dat );
  TEST_VCOMPRESS_OP( 3,  vcompress.vm, ans2dat, src21dat, src22dat, vm1dat );
  #endif 

  #if __riscv_vsew == 64
  TEST_VCOMPRESS_OP_64( 4,  vcompress.vm, ans3dat, src11dat, src12dat, vm1dat );
  TEST_VCOMPRESS_OP_64( 5,  vcompress.vm, ans4dat, src21dat, src22dat, vm1dat );
  #endif
  
  TEST_PASSFAIL


RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

src11dat:
src11dat1:  .word 0x00000000
src11dat2:  .word 0x00000001
src11dat3:  .word 0x00000002
src11dat4:  .word 0x00000003

src12dat:
src12dat1:  .word 0x00000009
src12dat2:  .word 0x00000008
src12dat3:  .word 0x00000007
src12dat4:  .word 0x00000006

ans1dat:
ans1dat1:  .word 0x00000000
ans1dat2:  .word 0x00000002
ans1dat3:  .word 0x00000007
ans1dat4:  .word 0x00000006

vm1dat:
vm1dat1:   .word 0b00000000000000000000000000000101
vm1dat2:   .word 0
vm1dat3:   .word 0
vm1dat4:   .word 0

src21dat:
src21dat1:  .word 0x00000004
src21dat2:  .word 0x00000005
src21dat3:  .word 0x00000006
src21dat4:  .word 0x00000007

src22dat:
src22dat1:  .word 0x00000005
src22dat2:  .word 0x00000004
src22dat3:  .word 0x00000003
src22dat4:  .word 0x00000002

ans2dat:
ans2dat1:  .word 0x00000004
ans2dat2:  .word 0x00000006
ans2dat3:  .word 0x00000003
ans2dat4:  .word 0x00000002

vm2dat:
vm2dat1:   .word 0b00000000000000000000000000001010
vm2dat2:   .word 0
vm2dat3:   .word 0
vm2dat4:   .word 0

ans3dat:
ans3dat1:  .word 0x00000000
ans3dat2:  .word 0x00000001
ans3dat3:  .word 0x00000007
ans3dat4:  .word 0x00000006

ans4dat:
ans4dat1:  .word 0x00000004
ans4dat2:  .word 0x00000005
ans4dat3:  .word 0x00000003
ans4dat4:  .word 0x00000002
RVTEST_DATA_END
