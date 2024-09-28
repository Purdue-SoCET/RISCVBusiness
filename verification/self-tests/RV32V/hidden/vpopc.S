# See LICENSE for license details.

#*****************************************************************************
# vpopc.S
#-----------------------------------------------------------------------------
#
# Test vpopc, vfirst instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # vpopc tests
  #-------------------------------------------------------------
#if __riscv_vsew == 32
  TEST_VPOPC_OP( 2, vpopc.m, 0, vm1dat );
  TEST_VPOPC_OP( 3, vpopc.m, 1, vm2dat );
  TEST_VPOPC_OP( 4, vpopc.m, 2, vm3dat );
  TEST_VPOPC_OP( 5, vpopc.m, 3, vm4dat );
  TEST_VPOPC_OP( 6, vpopc.m, 4, vm5dat );
#endif 

#if __riscv_vsew == 64
  TEST_VPOPC_OP_64( 5, vpopc.m, 0, vm1dat );
  TEST_VPOPC_OP_64( 6, vpopc.m, 0, vm2dat );
  TEST_VPOPC_OP_64( 7, vpopc.m, 0, vm3dat );
  TEST_VPOPC_OP_64( 8, vpopc.m, 1, vm4dat );
  TEST_VPOPC_OP_64( 9, vpopc.m, 2, vm5dat );
#endif 

  #-------------------------------------------------------------
  # vfirst tests
  #-------------------------------------------------------------
#if __riscv_vsew == 32
  TEST_VPOPC_OP( 10, vfirst.m, -1, vm1dat );
  TEST_VPOPC_OP( 11, vfirst.m,  3, vm2dat );
  TEST_VPOPC_OP( 12, vfirst.m,  2, vm3dat );
  TEST_VPOPC_OP( 13, vfirst.m,  1, vm4dat );
  TEST_VPOPC_OP( 14, vfirst.m,  0, vm5dat );
#endif

#if __riscv_vsew == 64
  TEST_VPOPC_OP_64( 15, vfirst.m, -1, vm1dat );
  TEST_VPOPC_OP_64( 16, vfirst.m, -1, vm2dat );
  TEST_VPOPC_OP_64( 17, vfirst.m, -1, vm3dat );
  TEST_VPOPC_OP_64( 18, vfirst.m, 1, vm4dat );
  TEST_VPOPC_OP_64( 19, vfirst.m, 0, vm5dat );
#endif 
  #
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

vm1dat:
vm1dat1:   .word 0b00000000000000000000000000000000
vm1dat2:   .word 0
vm1dat3:   .word 0
vm1dat4:   .word 0

vm2dat:
vm2dat1:   .word 0b00000000000000000000000000001000
vm2dat2:   .word 0
vm2dat3:   .word 0
vm2dat4:   .word 0

vm3dat:
vm3dat1:   .word 0b00000000000000000000000000001100
vm3dat2:   .word 0
vm3dat3:   .word 0
vm3dat4:   .word 0

vm4dat:
vm4dat1:   .word 0b00000000000000000000000000001110
vm4dat2:   .word 0
vm4dat3:   .word 0
vm4dat4:   .word 0

vm5dat:
vm5dat1:   .word 0b00000000000000000000000000001111
vm5dat2:   .word 0
vm5dat3:   .word 0
vm5dat4:   .word 0

RVTEST_DATA_END
