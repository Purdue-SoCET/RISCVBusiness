# See LICENSE for license details.

#*****************************************************************************
# vsmul.S
#-----------------------------------------------------------------------------
#
# Test vsmul instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

#if __riscv_vsew == 32

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_AVG_VV_OP( 2,  vsmul.vv, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, 0x0000000000000000, 0x0000000000000000 );
  TEST_AVG_VV_OP( 3,  vsmul.vv, (0x0000000000000002 >> (__riscv_vsew - 1)) + 0, (0x0000000000000002 >> (__riscv_vsew - 1)) + 0, (0x0000000000000002 >> (__riscv_vsew - 1)) + 0, (0x0000000000000002 >> (__riscv_vsew - 1)) + 1, 0x0000000000000001, 0x0000000000000002 );
  TEST_AVG_VV_OP( 4,  vsmul.vv, (0x000000fffee00051 >> (__riscv_vsew - 1)) + 1, (0x000000fffee00051 >> (__riscv_vsew - 1)) + 1, (0x000000fffee00051 >> (__riscv_vsew - 1)) + 0, (0x000000fffee00051 >> (__riscv_vsew - 1)) + 0, 0x00000000000ffff7, 0x00000000000ffff7 );

  TEST_AVG_VV_OP( 5,  vsmul.vv, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, 0x0000000000000000, 0xffffffffffffffff );
  TEST_AVG_VV_OP( 6,  vsmul.vv, (0xffffffffffffffff >> (__riscv_vsew - 1)) + 1, (0xffffffffffffffff >> (__riscv_vsew - 1)) + 1, (0xffffffffffffffff >> (__riscv_vsew - 1)) + 0, (0xffffffffffffffff >> (__riscv_vsew - 1)) + 0, 0x0000000000000001, 0xffffffffffffffff );
  TEST_AVG_VV_OP( 7,  vsmul.vv, (0xffffffffffff0000 >> (__riscv_vsew - 1)) + 1, (0xffffffffffff0000 >> (__riscv_vsew - 1)) + 1, (0xffffffffffff0000 >> (__riscv_vsew - 1)) + 0, (0xffffffffffff0000 >> (__riscv_vsew - 1)) + 0, 0x0000000000000002, 0xffffffffffff8000 );

  TEST_AVG_VV_OP( 8,  vsmul.vv, (0x0000000040000000 >> (__riscv_vsew - 1)) + 1, (0x0000000040000000 >> (__riscv_vsew - 1)) + 0, (0x0000000040000000 >> (__riscv_vsew - 1)) + 0, (0x0000000040000000 >> (__riscv_vsew - 1)) + 1, 0xffffffffffff8000, 0xffffffffffff8000 );
  TEST_AVG_VV_OP( 9,  vsmul.vv, (0x0000000000000003 >> (__riscv_vsew - 1)) + 0, (0x0000000000000003 >> (__riscv_vsew - 1)) + 0, (0x0000000000000003 >> (__riscv_vsew - 1)) + 0, (0x0000000000000003 >> (__riscv_vsew - 1)) + 1, 0x0000000000000003, 0x0000000000000001 );
  TEST_AVG_VV_OP( 10, vsmul.vv, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, 0xf000000000000001, 0xf000000000000000 );

  TEST_AVG_VV_OP( 11, vsmul.vv, (0x3fffffff00000001 >> (__riscv_vsew - 1)) + 0, (0x3fffffff00000001 >> (__riscv_vsew - 1)) + 0, (0x3fffffff00000001 >> (__riscv_vsew - 1)) + 0, (0x3fffffff00000001 >> (__riscv_vsew - 1)) + 1, 0x000000007fffffff, 0x000000007fffffff );
  TEST_AVG_VV_OP( 12, vsmul.vv, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, 0xf000000000000000, 0xf000000000000000 );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_AVG_VX_OP( 13, vsmul.vx, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, 0x0000000000000000, 0x0000000000000000 );
  TEST_AVG_VX_OP( 14, vsmul.vx, (0x0000000000000002 >> (__riscv_vsew - 1)) + 0, (0x0000000000000002 >> (__riscv_vsew - 1)) + 0, (0x0000000000000002 >> (__riscv_vsew - 1)) + 0, (0x0000000000000002 >> (__riscv_vsew - 1)) + 1, 0x0000000000000001, 0x0000000000000002 );
  TEST_AVG_VX_OP( 15, vsmul.vx, (0x000000fffee00051 >> (__riscv_vsew - 1)) + 1, (0x000000fffee00051 >> (__riscv_vsew - 1)) + 1, (0x000000fffee00051 >> (__riscv_vsew - 1)) + 0, (0x000000fffee00051 >> (__riscv_vsew - 1)) + 0, 0x00000000000ffff7, 0x00000000000ffff7 );

  TEST_AVG_VX_OP( 16, vsmul.vx, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, 0x0000000000000000, 0xffffffffffffffff );
  TEST_AVG_VX_OP( 17, vsmul.vx, (0xffffffffffffffff >> (__riscv_vsew - 1)) + 1, (0xffffffffffffffff >> (__riscv_vsew - 1)) + 1, (0xffffffffffffffff >> (__riscv_vsew - 1)) + 0, (0xffffffffffffffff >> (__riscv_vsew - 1)) + 0, 0x0000000000000001, 0xffffffffffffffff );
  TEST_AVG_VX_OP( 18, vsmul.vx, (0xffffffffffff0000 >> (__riscv_vsew - 1)) + 1, (0xffffffffffff0000 >> (__riscv_vsew - 1)) + 1, (0xffffffffffff0000 >> (__riscv_vsew - 1)) + 0, (0xffffffffffff0000 >> (__riscv_vsew - 1)) + 0, 0x0000000000000002, 0xffffffffffff8000 );

  TEST_AVG_VX_OP( 19, vsmul.vx, (0x0000000040000000 >> (__riscv_vsew - 1)) + 1, (0x0000000040000000 >> (__riscv_vsew - 1)) + 0, (0x0000000040000000 >> (__riscv_vsew - 1)) + 0, (0x0000000040000000 >> (__riscv_vsew - 1)) + 1, 0xffffffffffff8000, 0xffffffffffff8000 );
  TEST_AVG_VX_OP( 20, vsmul.vx, (0x0000000000000003 >> (__riscv_vsew - 1)) + 0, (0x0000000000000003 >> (__riscv_vsew - 1)) + 0, (0x0000000000000003 >> (__riscv_vsew - 1)) + 0, (0x0000000000000003 >> (__riscv_vsew - 1)) + 1, 0x0000000000000003, 0x0000000000000001 );
  TEST_AVG_VX_OP( 21, vsmul.vx, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, 0xf000000000000001, 0xf000000000000000 );

  TEST_AVG_VX_OP( 22, vsmul.vx, (0x3fffffff00000001 >> (__riscv_vsew - 1)) + 0, (0x3fffffff00000001 >> (__riscv_vsew - 1)) + 0, (0x3fffffff00000001 >> (__riscv_vsew - 1)) + 0, (0x3fffffff00000001 >> (__riscv_vsew - 1)) + 1, 0x000000007fffffff, 0x000000007fffffff );
  TEST_AVG_VX_OP( 23, vsmul.vx, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, 0xf000000000000000, 0xf000000000000000 );
	
#endif

#if __riscv_vsew == 64

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_AVG_VV_OP( 2,  vsmul.vv, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, 0x0000000000000000, 0x0000000000000000 );
  TEST_AVG_VV_OP( 3,  vsmul.vv, (0x0000000000000002 >> (__riscv_vsew - 1)) + 0, (0x0000000000000002 >> (__riscv_vsew - 1)) + 0, (0x0000000000000002 >> (__riscv_vsew - 1)) + 0, (0x0000000000000002 >> (__riscv_vsew - 1)) + 1, 0x0000000000000001, 0x0000000000000002 );
  TEST_AVG_VV_OP( 4,  vsmul.vv, (0x000000fffee00051 >> (__riscv_vsew - 1)) + 0, (0x000000fffee00051 >> (__riscv_vsew - 1)) + 0, (0x000000fffee00051 >> (__riscv_vsew - 1)) + 0, (0x000000fffee00051 >> (__riscv_vsew - 1)) + 1, 0x00000000000ffff7, 0x00000000000ffff7 );

  TEST_AVG_VV_OP( 5,  vsmul.vv, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, 0x0000000000000000, 0xffffffffffffffff );
  TEST_AVG_VV_OP( 6,  vsmul.vv, (0xffffffffffffffff) + 1, (0xffffffffffffffff) + 1, (0xffffffffffffffff) + 0, (0xffffffffffffffff) + 0, 0x0000000000000001, 0xffffffffffffffff );
  TEST_AVG_VV_OP( 7,  vsmul.vv, (0xffffffffffffffff) + 1, (0xffffffffffffffff) + 1, (0xffffffffffffffff) + 0, (0xffffffffffffffff) + 0, 0x0000000000000002, 0xffffffffffff8000 );

  TEST_AVG_VV_OP( 8,  vsmul.vv, (0x0000000040000000 >> (__riscv_vsew - 1)) + 0, (0x0000000040000000 >> (__riscv_vsew - 1)) + 0, (0x0000000040000000 >> (__riscv_vsew - 1)) + 0, (0x0000000040000000 >> (__riscv_vsew - 1)) + 1, 0xffffffffffff8000, 0xffffffffffff8000 );
  TEST_AVG_VV_OP( 9,  vsmul.vv, (0x0000000000000003 >> (__riscv_vsew - 1)) + 0, (0x0000000000000003 >> (__riscv_vsew - 1)) + 0, (0x0000000000000003 >> (__riscv_vsew - 1)) + 0, (0x0000000000000003 >> (__riscv_vsew - 1)) + 1, 0x0000000000000003, 0x0000000000000001 );
  TEST_AVG_VV_OP( 10, vsmul.vv, (0x1FFFFFFFFFFFFFF) + 1, (0x1FFFFFFFFFFFFFF) + 1, (0x1FFFFFFFFFFFFFF) + 0, (0x1FFFFFFFFFFFFFF) + 0,  0xf000000000000001, 0xf000000000000000 );

  TEST_AVG_VV_OP( 11, vsmul.vv, (0x00003fff80000000 >> (__riscv_vsew - 1)) + 0, (0x00003fff80000000 >> (__riscv_vsew - 1)) + 0, (0x00003fff80000000 >> (__riscv_vsew - 1)) + 0, (0x00003fff80000000 >> (__riscv_vsew - 1)) + 1, 0x0000000080000000, 0x0000000000007fff );
  TEST_AVG_VV_OP( 12, vsmul.vv, (0x0000000000000fff) + 1, (0x0000000000000fff) + 1, (0x0000000000000fff) + 0, (0x0000000000000fff) + 0,  0x0fffffffffffffff, 0x0000000000007fff );

  TEST_AVG_VV_OP( 13, vsmul.vv, (0x3fffffff00000001 >> (__riscv_vsew - 1)) + 0, (0x3fffffff00000001 >> (__riscv_vsew - 1)) + 0, (0x3fffffff00000001 >> (__riscv_vsew - 1)) + 0, (0x3fffffff00000001 >> (__riscv_vsew - 1)) + 1, 0x000000007fffffff, 0x000000007fffffff );
  TEST_AVG_VV_OP( 14, vsmul.vv, (0x1FFFFFFFFFFFFFF) + 1, (0x1FFFFFFFFFFFFFF) + 1, (0x1FFFFFFFFFFFFFF) + 1, (0x1FFFFFFFFFFFFFF) + 1,  0xf000000000000000, 0xf000000000000000 );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_AVG_VX_OP( 15, vsmul.vx, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, 0x0000000000000000, 0x0000000000000000 );
  TEST_AVG_VX_OP( 16, vsmul.vx, (0x0000000000000002 >> (__riscv_vsew - 1)) + 0, (0x0000000000000002 >> (__riscv_vsew - 1)) + 0, (0x0000000000000002 >> (__riscv_vsew - 1)) + 0, (0x0000000000000002 >> (__riscv_vsew - 1)) + 1, 0x0000000000000001, 0x0000000000000002 );
  TEST_AVG_VX_OP( 17, vsmul.vx, (0x000000fffee00051 >> (__riscv_vsew - 1)) + 0, (0x000000fffee00051 >> (__riscv_vsew - 1)) + 0, (0x000000fffee00051 >> (__riscv_vsew - 1)) + 0, (0x000000fffee00051 >> (__riscv_vsew - 1)) + 1, 0x00000000000ffff7, 0x00000000000ffff7 );

  TEST_AVG_VX_OP( 18, vsmul.vx, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, (0x0000000000000000 >> (__riscv_vsew - 1)) + 0, 0x0000000000000000, 0xffffffffffffffff );
  TEST_AVG_VX_OP( 19, vsmul.vx, (0xffffffffffffffff) + 1, (0xffffffffffffffff) + 1, (0xffffffffffffffff) + 0, (0xffffffffffffffff) + 0, 0x0000000000000001, 0xffffffffffffffff );
  TEST_AVG_VX_OP( 20, vsmul.vx, (0xffffffffffffffff) + 1, (0xffffffffffffffff) + 1, (0xffffffffffffffff) + 0, (0xffffffffffffffff) + 0, 0x0000000000000002, 0xffffffffffff8000 );

  TEST_AVG_VX_OP( 21, vsmul.vx, (0x0000000040000000 >> (__riscv_vsew - 1)) + 0, (0x0000000040000000 >> (__riscv_vsew - 1)) + 0, (0x0000000040000000 >> (__riscv_vsew - 1)) + 0, (0x0000000040000000 >> (__riscv_vsew - 1)) + 1, 0xffffffffffff8000, 0xffffffffffff8000 );
  TEST_AVG_VX_OP( 22, vsmul.vx, (0x0000000000000003 >> (__riscv_vsew - 1)) + 0, (0x0000000000000003 >> (__riscv_vsew - 1)) + 0, (0x0000000000000003 >> (__riscv_vsew - 1)) + 0, (0x0000000000000003 >> (__riscv_vsew - 1)) + 1, 0x0000000000000003, 0x0000000000000001 );
  TEST_AVG_VX_OP( 23, vsmul.vx, (0x1FFFFFFFFFFFFFF) + 1, (0x1FFFFFFFFFFFFFF) + 1, (0x1FFFFFFFFFFFFFF) + 0, (0x1FFFFFFFFFFFFFF) + 0,  0xf000000000000001, 0xf000000000000000 );

  TEST_AVG_VX_OP( 24, vsmul.vx, (0x00003fff80000000 >> (__riscv_vsew - 1)) + 0, (0x00003fff80000000 >> (__riscv_vsew - 1)) + 0, (0x00003fff80000000 >> (__riscv_vsew - 1)) + 0, (0x00003fff80000000 >> (__riscv_vsew - 1)) + 1, 0x0000000080000000, 0x0000000000007fff );
  TEST_AVG_VX_OP( 25, vsmul.vx, (0x0000000000000fff) + 1, (0x0000000000000fff) + 1, (0x0000000000000fff) + 0, (0x0000000000000fff) + 0,  0x0fffffffffffffff, 0x0000000000007fff );
  
  TEST_AVG_VX_OP( 29, vsmul.vx, (0x3fffffff00000001 >> (__riscv_vsew - 1)) + 0, (0x3fffffff00000001 >> (__riscv_vsew - 1)) + 0, (0x3fffffff00000001 >> (__riscv_vsew - 1)) + 0, (0x3fffffff00000001 >> (__riscv_vsew - 1)) + 1, 0x000000007fffffff, 0x000000007fffffff );
  TEST_AVG_VX_OP( 31, vsmul.vx, (0x1FFFFFFFFFFFFFF) + 1, (0x1FFFFFFFFFFFFFF) + 1, (0x1FFFFFFFFFFFFFF) + 1, (0x1FFFFFFFFFFFFFF) + 1,  0xf000000000000000, 0xf000000000000000 );

#endif	

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
