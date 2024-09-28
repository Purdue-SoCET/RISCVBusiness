# See LICENSE for license details.

#*****************************************************************************
# vsll.S
#-----------------------------------------------------------------------------
#
# Test vsll instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV tests
  #-------------------------------------------------------------

  TEST_VV_OP( 2,  vsll.vv, 0x0000000000000001, 0x0000000000000001, 0  );
  TEST_VV_OP( 3,  vsll.vv, 0x0000000000000002, 0x0000000000000001, 1  );
  TEST_VV_OP( 4,  vsll.vv, 0x0000000000000080, 0x0000000000000001, 7  );
  TEST_VV_OP( 5,  vsll.vv, 0x0000000000004000, 0x0000000000000001, 14 );
  TEST_VV_OP( 6,  vsll.vv, 0x0000000080000000, 0x0000000000000001, 31 );

  TEST_VV_OP( 7,  vsll.vv, 0xffffffffffffffff, 0xffffffffffffffff, 0  );
  TEST_VV_OP( 8,  vsll.vv, 0xfffffffffffffffe, 0xffffffffffffffff, 1  );
  TEST_VV_OP( 9,  vsll.vv, 0xffffffffffffff80, 0xffffffffffffffff, 7  );
  TEST_VV_OP( 10, vsll.vv, 0xffffffffffffc000, 0xffffffffffffffff, 14 );
  TEST_VV_OP( 11, vsll.vv, 0xffffffff80000000, 0xffffffffffffffff, 31 );

  TEST_VV_OP( 12, vsll.vv, 0x0000000021212121, 0x0000000021212121, 0  );
  TEST_VV_OP( 13, vsll.vv, 0x0000000042424242, 0x0000000021212121, 1  );
  TEST_VV_OP( 14, vsll.vv, 0x0000001090909080, 0x0000000021212121, 7  );
  TEST_VV_OP( 15, vsll.vv, 0x0000084848484000, 0x0000000021212121, 14 );
  TEST_VV_OP( 16, vsll.vv, 0x1090909080000000, 0x0000000021212121, 31 );

  #-------------------------------------------------------------
  # VX tests
  #-------------------------------------------------------------

  TEST_VX_OP( 17, vsll.vx, 0x0000000000000001, 0x0000000000000001, 0  );
  TEST_VX_OP( 18, vsll.vx, 0x0000000000000002, 0x0000000000000001, 1  );
  TEST_VX_OP( 19, vsll.vx, 0x0000000000000080, 0x0000000000000001, 7  );
  TEST_VX_OP( 20, vsll.vx, 0x0000000000004000, 0x0000000000000001, 14 );
  TEST_VX_OP( 21, vsll.vx, 0x0000000080000000, 0x0000000000000001, 31 );

  TEST_VX_OP( 22, vsll.vx, 0xffffffffffffffff, 0xffffffffffffffff, 0  );
  TEST_VX_OP( 23, vsll.vx, 0xfffffffffffffffe, 0xffffffffffffffff, 1  );
  TEST_VX_OP( 24, vsll.vx, 0xffffffffffffff80, 0xffffffffffffffff, 7  );
  TEST_VX_OP( 25, vsll.vx, 0xffffffffffffc000, 0xffffffffffffffff, 14 );
  TEST_VX_OP( 26, vsll.vx, 0xffffffff80000000, 0xffffffffffffffff, 31 );

  TEST_VX_OP( 27, vsll.vx, 0x0000000021212121, 0x0000000021212121, 0  );
  TEST_VX_OP( 28, vsll.vx, 0x0000000042424242, 0x0000000021212121, 1  );
  TEST_VX_OP( 29, vsll.vx, 0x0000001090909080, 0x0000000021212121, 7  );
  TEST_VX_OP( 30, vsll.vx, 0x0000084848484000, 0x0000000021212121, 14 );
  TEST_VX_OP( 31, vsll.vx, 0x1090909080000000, 0x0000000021212121, 31 );

  #-------------------------------------------------------------
  # VI tests
  #-------------------------------------------------------------

  TEST_VI_OP( 32, vsll.vi, 0x0000000000000001, 0x0000000000000001, 0  );
  TEST_VI_OP( 33, vsll.vi, 0x0000000000000002, 0x0000000000000001, 1  );
  TEST_VI_OP( 34, vsll.vi, 0x0000000000000080, 0x0000000000000001, 7  );
  TEST_VI_OP( 35, vsll.vi, 0x0000000000004000, 0x0000000000000001, 14 );

  TEST_VI_OP( 36, vsll.vi, 0xffffffffffffffff, 0xffffffffffffffff, 0  );
  TEST_VI_OP( 37, vsll.vi, 0xfffffffffffffffe, 0xffffffffffffffff, 1  );
  TEST_VI_OP( 38, vsll.vi, 0xffffffffffffff80, 0xffffffffffffffff, 7  );
  TEST_VI_OP( 39, vsll.vi, 0xffffffffffffc000, 0xffffffffffffffff, 14 );

  TEST_VI_OP( 40, vsll.vi, 0x0000000021212121, 0x0000000021212121, 0  );
  TEST_VI_OP( 41, vsll.vi, 0x0000000042424242, 0x0000000021212121, 1  );
  TEST_VI_OP( 42, vsll.vi, 0x0000001090909080, 0x0000000021212121, 7  );
  TEST_VI_OP( 43, vsll.vi, 0x0000084848484000, 0x0000000021212121, 14 );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
