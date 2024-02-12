# See LICENSE for license details.

#*****************************************************************************
# vsra.S
#-----------------------------------------------------------------------------
#
# Test vsra/vnsra instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV tests
  #-------------------------------------------------------------

  TEST_VV_OP( 2,  vsra.vv, 0xffffffff80000000, 0xffffffff80000000, 0  );
  TEST_VV_OP( 3,  vsra.vv, 0xffffffffc0000000, 0xffffffff80000000, 1  );
  TEST_VV_OP( 4,  vsra.vv, 0xffffffffff000000, 0xffffffff80000000, 7  );
  TEST_VV_OP( 5,  vsra.vv, 0xfffffffffffe0000, 0xffffffff80000000, 14 );
  TEST_VV_OP( 6,  vsra.vv, 0xffffffffffffffff, 0xffffffff80000001, 31 );

  TEST_VV_OP( 7,  vsra.vv, 0x000000007fffffff, 0x000000007fffffff, 0  );
  TEST_VV_OP( 8,  vsra.vv, 0x000000003fffffff, 0x000000007fffffff, 1  );
  TEST_VV_OP( 9,  vsra.vv, 0x0000000000ffffff, 0x000000007fffffff, 7  );
  TEST_VV_OP( 10, vsra.vv, 0x000000000001ffff, 0x000000007fffffff, 14 );
  TEST_VV_OP( 11, vsra.vv, 0x0000000000000000, 0x000000007fffffff, 31 );

  TEST_VV_OP( 12, vsra.vv, 0xffffffff81818181, 0xffffffff81818181, 0  );
  TEST_VV_OP( 13, vsra.vv, 0xffffffffc0c0c0c0, 0xffffffff81818181, 1  );
  TEST_VV_OP( 14, vsra.vv, 0xffffffffff030303, 0xffffffff81818181, 7  );
  TEST_VV_OP( 15, vsra.vv, 0xfffffffffffe0606, 0xffffffff81818181, 14 );
  TEST_VV_OP( 16, vsra.vv, 0xffffffffffffffff, 0xffffffff81818181, 31 );

  #-------------------------------------------------------------
  # VX tests
  #-------------------------------------------------------------

  TEST_VX_OP( 17, vsra.vx, 0xffffffff80000000, 0xffffffff80000000, 0  );
  TEST_VX_OP( 18, vsra.vx, 0xffffffffc0000000, 0xffffffff80000000, 1  );
  TEST_VX_OP( 19, vsra.vx, 0xffffffffff000000, 0xffffffff80000000, 7  );
  TEST_VX_OP( 20, vsra.vx, 0xfffffffffffe0000, 0xffffffff80000000, 14 );
  TEST_VX_OP( 21, vsra.vx, 0xffffffffffffffff, 0xffffffff80000001, 31 );

  TEST_VX_OP( 22, vsra.vx, 0x000000007fffffff, 0x000000007fffffff, 0  );
  TEST_VX_OP( 23, vsra.vx, 0x000000003fffffff, 0x000000007fffffff, 1  );
  TEST_VX_OP( 24, vsra.vx, 0x0000000000ffffff, 0x000000007fffffff, 7  );
  TEST_VX_OP( 25, vsra.vx, 0x000000000001ffff, 0x000000007fffffff, 14 );
  TEST_VX_OP( 26, vsra.vx, 0x0000000000000000, 0x000000007fffffff, 31 );

  TEST_VX_OP( 27, vsra.vx, 0xffffffff81818181, 0xffffffff81818181, 0  );
  TEST_VX_OP( 28, vsra.vx, 0xffffffffc0c0c0c0, 0xffffffff81818181, 1  );
  TEST_VX_OP( 29, vsra.vx, 0xffffffffff030303, 0xffffffff81818181, 7  );
  TEST_VX_OP( 30, vsra.vx, 0xfffffffffffe0606, 0xffffffff81818181, 14 );
  TEST_VX_OP( 31, vsra.vx, 0xffffffffffffffff, 0xffffffff81818181, 31 );

  #-------------------------------------------------------------
  # VI tests
  #-------------------------------------------------------------

  TEST_VI_OP( 32, vsra.vi, 0xffffffff80000000, 0xffffffff80000000, 0  );
  TEST_VI_OP( 33, vsra.vi, 0xffffffffc0000000, 0xffffffff80000000, 1  );
  TEST_VI_OP( 34, vsra.vi, 0xffffffffff000000, 0xffffffff80000000, 7  );
  TEST_VI_OP( 35, vsra.vi, 0xfffffffffffe0000, 0xffffffff80000000, 14 );

  TEST_VI_OP( 36, vsra.vi, 0x000000007fffffff, 0x000000007fffffff, 0  );
  TEST_VI_OP( 37, vsra.vi, 0x000000003fffffff, 0x000000007fffffff, 1  );
  TEST_VI_OP( 38, vsra.vi, 0x0000000000ffffff, 0x000000007fffffff, 7  );
  TEST_VI_OP( 39, vsra.vi, 0x000000000001ffff, 0x000000007fffffff, 14 );

  TEST_VI_OP( 40, vsra.vi, 0xffffffff81818181, 0xffffffff81818181, 0  );
  TEST_VI_OP( 41, vsra.vi, 0xffffffffc0c0c0c0, 0xffffffff81818181, 1  );
  TEST_VI_OP( 42, vsra.vi, 0xffffffffff030303, 0xffffffff81818181, 7  );
  TEST_VI_OP( 43, vsra.vi, 0xfffffffffffe0606, 0xffffffff81818181, 14 );

#if __riscv_vsew <= 32

  #-------------------------------------------------------------
  # WV tests
  #-------------------------------------------------------------

  TEST_N_VV_OP( 44, vnsra.wv, 0xffffffff80000000, 0xffffffff80000000, 0  );
  TEST_N_VV_OP( 45, vnsra.wv, 0xffffffff40000000, 0xffffffff80000000, 1  );
  TEST_N_VV_OP( 46, vnsra.wv, 0xffffffff01000000, 0xffffffff80000000, 7  );
  TEST_N_VV_OP( 47, vnsra.wv, 0xffffffff00020000, 0xffffffff80000000, 14 );
  TEST_N_VV_OP( 48, vnsra.wv, 0xffffffff00000001, 0xffffffff80000001, 31 );

  TEST_N_VV_OP( 49, vnsra.wv, 0x000000007fffffff, 0x000000007fffffff, 0  );
  TEST_N_VV_OP( 50, vnsra.wv, 0x000000003fffffff, 0x000000007fffffff, 1  );
  TEST_N_VV_OP( 51, vnsra.wv, 0x0000000000ffffff, 0x000000007fffffff, 7  );
  TEST_N_VV_OP( 52, vnsra.wv, 0x000000000001ffff, 0x000000007fffffff, 14 );
  TEST_N_VV_OP( 53, vnsra.wv, 0x0000000000000000, 0x000000007fffffff, 31 );

  TEST_N_VV_OP( 54, vnsra.wv, 0xffffffff81818181, 0xffffffff81818181, 0  );
  TEST_N_VV_OP( 55, vnsra.wv, 0xffffffff40c0c0c0, 0xffffffff81818181, 1  );
  TEST_N_VV_OP( 56, vnsra.wv, 0xffffffff01030303, 0xffffffff81818181, 7  );
  TEST_N_VV_OP( 57, vnsra.wv, 0xffffffff00020606, 0xffffffff81818181, 14 );
  TEST_N_VV_OP( 58, vnsra.wv, 0xffffffff00000001, 0xffffffff81818181, 31 );

  #-----------------------------------------------------------
  # WX tests
  #-----------------------------------------------------------

  TEST_N_VX_OP( 59, vnsra.wx, 0xffffffff80000000, 0xffffffff80000000, 0  );
  TEST_N_VX_OP( 60, vnsra.wx, 0xffffffff40000000, 0xffffffff80000000, 1  );
  TEST_N_VX_OP( 61, vnsra.wx, 0xffffffff01000000, 0xffffffff80000000, 7  );
  TEST_N_VX_OP( 62, vnsra.wx, 0xffffffff00020000, 0xffffffff80000000, 14 );
  TEST_N_VX_OP( 63, vnsra.wx, 0xffffffff00000001, 0xffffffff80000001, 31 );
	
  TEST_N_VX_OP( 64, vnsra.wx, 0x000000007fffffff, 0x000000007fffffff, 0  );
  TEST_N_VX_OP( 65, vnsra.wx, 0x000000003fffffff, 0x000000007fffffff, 1  );
  TEST_N_VX_OP( 66, vnsra.wx, 0x0000000000ffffff, 0x000000007fffffff, 7  );
  TEST_N_VX_OP( 67, vnsra.wx, 0x000000000001ffff, 0x000000007fffffff, 14 );
  TEST_N_VX_OP( 68, vnsra.wx, 0x0000000000000000, 0x000000007fffffff, 31 );
	
  TEST_N_VX_OP( 69, vnsra.wx, 0xffffffff81818181, 0xffffffff81818181, 0  );
  TEST_N_VX_OP( 70, vnsra.wx, 0xffffffff40c0c0c0, 0xffffffff81818181, 1  );
  TEST_N_VX_OP( 71, vnsra.wx, 0xffffffff01030303, 0xffffffff81818181, 7  );
  TEST_N_VX_OP( 72, vnsra.wx, 0xffffffff00020606, 0xffffffff81818181, 14 );
  TEST_N_VX_OP( 73, vnsra.wx, 0xffffffff00000001, 0xffffffff81818181, 31 );

  #-----------------------------------------------------------
  # WI tests
  #-----------------------------------------------------------

  TEST_N_VI_OP( 74, vnsra.wi, 0xffffffff80000000, 0xffffffff80000000, 0  );
  TEST_N_VI_OP( 75, vnsra.wi, 0xffffffff40000000, 0xffffffff80000000, 1  );
  TEST_N_VI_OP( 76, vnsra.wi, 0xffffffff01000000, 0xffffffff80000000, 7  );
  TEST_N_VI_OP( 77, vnsra.wi, 0xffffffff00020000, 0xffffffff80000000, 14 );
	
  TEST_N_VI_OP( 78, vnsra.wi, 0x000000007fffffff, 0x000000007fffffff, 0  );
  TEST_N_VI_OP( 79, vnsra.wi, 0x000000003fffffff, 0x000000007fffffff, 1  );
  TEST_N_VI_OP( 80, vnsra.wi, 0x0000000000ffffff, 0x000000007fffffff, 7  );
  TEST_N_VI_OP( 81, vnsra.wi, 0x000000000001ffff, 0x000000007fffffff, 14 );
	
  TEST_N_VI_OP( 82, vnsra.wi, 0xffffffff81818181, 0xffffffff81818181, 0  );
  TEST_N_VI_OP( 83, vnsra.wi, 0xffffffff40c0c0c0, 0xffffffff81818181, 1  );
  TEST_N_VI_OP( 84, vnsra.wi, 0xffffffff01030303, 0xffffffff81818181, 7  );
  TEST_N_VI_OP( 85, vnsra.wi, 0xffffffff00020606, 0xffffffff81818181, 14 );	
	
#endif

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
