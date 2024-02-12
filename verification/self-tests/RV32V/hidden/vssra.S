# See LICENSE for license details.

#*****************************************************************************
# vssra.S
#-----------------------------------------------------------------------------
#
# Test vssra instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

 #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_AVG_VV_OP( 2, vssra.vv, 0xffffffff80000000, 0xffffffff80000000, 0xffffffff80000000, 0xffffffff80000000, 0xffffffff80000000, 0  );
  TEST_AVG_VV_OP( 3, vssra.vv, 0xffffffffc0000000, 0xffffffffc0000000, 0xffffffffc0000000, 0xffffffffc0000000, 0xffffffff80000000, 1  );
  TEST_AVG_VV_OP( 4, vssra.vv, 0xffffffffff000000, 0xffffffffff000000, 0xffffffffff000000, 0xffffffffff000000, 0xffffffff80000000, 7  );
  TEST_AVG_VV_OP( 5, vssra.vv, 0xFFFFFFFFfffe0000, 0xFFFFFFFFfffe0000, 0xFFFFFFFFfffe0000, 0xFFFFFFFFfffe0000, 0xffffffff80000000, 14 );
  TEST_AVG_VV_OP( 6, vssra.vv, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffff80000000, 31 );
  
  TEST_AVG_VV_OP( 7, vssra.vv, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0  );
  TEST_AVG_VV_OP( 8, vssra.vv, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 1  );
  TEST_AVG_VV_OP( 9, vssra.vv, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 7  );
  TEST_AVG_VV_OP(10, vssra.vv, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 14 );
  TEST_AVG_VV_OP(11, vssra.vv, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 31 );

  TEST_AVG_VV_OP(12, vssra.vv, 0x0000000021212121, 0x0000000021212121, 0x0000000021212121, 0x0000000021212121, 0x0000000021212121, 0  );
  TEST_AVG_VV_OP(13, vssra.vv, 0x0000000010909091, 0x0000000010909090, 0x0000000010909090, 0x0000000010909091, 0x0000000021212121, 1  );
  TEST_AVG_VV_OP(14, vssra.vv, 0x0000000000424242, 0x0000000000424242, 0x0000000000424242, 0x0000000000424243, 0x0000000021212121, 7  );
  TEST_AVG_VV_OP(15, vssra.vv, 0x0000000000008485, 0x0000000000008485, 0x0000000000008484, 0x0000000000008485, 0x0000000021212121, 14 );
  TEST_AVG_VV_OP(16, vssra.vv, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000, 0x0000000000000001, 0x0000000021212121, 31 );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_AVG_VX_OP(17, vssra.vx, 0xffffffff80000000, 0xffffffff80000000, 0xffffffff80000000, 0xffffffff80000000, 0xffffffff80000000, 0  );
  TEST_AVG_VX_OP(18, vssra.vx, 0xffffffffc0000000, 0xffffffffc0000000, 0xffffffffc0000000, 0xffffffffc0000000, 0xffffffff80000000, 1  );
  TEST_AVG_VX_OP(19, vssra.vx, 0xffffffffff000000, 0xffffffffff000000, 0xffffffffff000000, 0xffffffffff000000, 0xffffffff80000000, 7  );
  TEST_AVG_VX_OP(20, vssra.vx, 0xFFFFFFFFfffe0000, 0xFFFFFFFFfffe0000, 0xFFFFFFFFfffe0000, 0xFFFFFFFFfffe0000, 0xffffffff80000000, 14 );
  TEST_AVG_VX_OP(21, vssra.vx, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffff80000000, 31 );
  
  TEST_AVG_VX_OP(22, vssra.vx, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0  );
  TEST_AVG_VX_OP(23, vssra.vx, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 1  );
  TEST_AVG_VX_OP(24, vssra.vx, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 7  );
  TEST_AVG_VX_OP(25, vssra.vx, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 14 );
  TEST_AVG_VX_OP(26, vssra.vx, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 31 );

  TEST_AVG_VX_OP(27, vssra.vx, 0x0000000021212121, 0x0000000021212121, 0x0000000021212121, 0x0000000021212121, 0x0000000021212121, 0  );
  TEST_AVG_VX_OP(28, vssra.vx, 0x0000000010909091, 0x0000000010909090, 0x0000000010909090, 0x0000000010909091, 0x0000000021212121, 1  );
  TEST_AVG_VX_OP(29, vssra.vx, 0x0000000000424242, 0x0000000000424242, 0x0000000000424242, 0x0000000000424243, 0x0000000021212121, 7  );
  TEST_AVG_VX_OP(30, vssra.vx, 0x0000000000008485, 0x0000000000008485, 0x0000000000008484, 0x0000000000008485, 0x0000000021212121, 14 );
  TEST_AVG_VX_OP(31, vssra.vx, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000, 0x0000000000000001, 0x0000000021212121, 31 );

  #-------------------------------------------------------------
  # VI Tests
  #-------------------------------------------------------------

  TEST_AVG_VI_OP(32, vssra.vi, 0xffffffff80000000, 0xffffffff80000000, 0xffffffff80000000, 0xffffffff80000000, 0xffffffff80000000, 0  );
  TEST_AVG_VI_OP(33, vssra.vi, 0xffffffffc0000000, 0xffffffffc0000000, 0xffffffffc0000000, 0xffffffffc0000000, 0xffffffff80000000, 1  );
  TEST_AVG_VI_OP(34, vssra.vi, 0xffffffffff000000, 0xffffffffff000000, 0xffffffffff000000, 0xffffffffff000000, 0xffffffff80000000, 7  );
  TEST_AVG_VI_OP(35, vssra.vi, 0xFFFFFFFFfffe0000, 0xFFFFFFFFfffe0000, 0xFFFFFFFFfffe0000, 0xFFFFFFFFfffe0000, 0xffffffff80000000, 14 );
  TEST_AVG_VI_OP(36, vssra.vi, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffff80000000, 31 );
  
  TEST_AVG_VI_OP(37, vssra.vi, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0  );
  TEST_AVG_VI_OP(38, vssra.vi, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 1  );
  TEST_AVG_VI_OP(39, vssra.vi, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 7  );
  TEST_AVG_VI_OP(40, vssra.vi, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 14 );
  TEST_AVG_VI_OP(41, vssra.vi, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 31 );

  TEST_AVG_VI_OP(42, vssra.vi, 0x0000000021212121, 0x0000000021212121, 0x0000000021212121, 0x0000000021212121, 0x0000000021212121, 0  );
  TEST_AVG_VI_OP(43, vssra.vi, 0x0000000010909091, 0x0000000010909090, 0x0000000010909090, 0x0000000010909091, 0x0000000021212121, 1  );
  TEST_AVG_VI_OP(44, vssra.vi, 0x0000000000424242, 0x0000000000424242, 0x0000000000424242, 0x0000000000424243, 0x0000000021212121, 7  );
  TEST_AVG_VI_OP(45, vssra.vi, 0x0000000000008485, 0x0000000000008485, 0x0000000000008484, 0x0000000000008485, 0x0000000021212121, 14 );
  TEST_AVG_VI_OP(46, vssra.vi, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000, 0x0000000000000001, 0x0000000021212121, 31 );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
