# See LICENSE for license details.

#*****************************************************************************
# vadc.S
#-----------------------------------------------------------------------------
#
# Test vadc, vsbc instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET
  
  #-------------------------------------------------------------
  # vadc.VV Tests
  #-------------------------------------------------------------

  TEST_ADC_VV_OP( 2,  vadc.vvm, 0x00000000, 0x00000000, 0x00000000 );
  TEST_ADC_VV_OP( 3,  vadc.vvm, 0x00000002, 0x00000001, 0x00000001 );
  TEST_ADC_VV_OP( 4,  vadc.vvm, 0x0000000a, 0x00000003, 0x00000007 );

  TEST_ADC_VV_OP( 5,  vadc.vvm, 0xffffffffffff8000, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_ADC_VV_OP( 6,  vadc.vvm, 0xffffffff80000000, 0xffffffff80000000, 0x00000000 );
  TEST_ADC_VV_OP( 7,  vadc.vvm, 0xffffffff7fff8000, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_ADC_VV_OP( 8,  vadc.vvm, 0x0000000000007fff, 0x0000000000000000, 0x0000000000007fff );
  TEST_ADC_VV_OP( 9,  vadc.vvm, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 );
  TEST_ADC_VV_OP( 10, vadc.vvm, 0x0000000080007ffe, 0x000000007fffffff, 0x0000000000007fff );

  TEST_ADC_VV_OP( 11, vadc.vvm, 0xffffffff80007fff, 0xffffffff80000000, 0x0000000000007fff );
  TEST_ADC_VV_OP( 12, vadc.vvm, 0x000000007fff7fff, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_ADC_VV_OP( 13, vadc.vvm, 0xffffffffffffffff, 0x0000000000000000, 0xffffffffffffffff );
  TEST_ADC_VV_OP( 14, vadc.vvm, 0x0000000000000000, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_ADC_VV_OP( 15, vadc.vvm, 0xfffffffffffffffe, 0xffffffffffffffff, 0xffffffffffffffff );

  TEST_ADC_VV_OP( 16, vadc.vvm, 0x0000000080000000, 0x0000000000000001, 0x000000007fffffff );
	
  #-------------------------------------------------------------
  # vadc.VX Tests
  #-------------------------------------------------------------

  TEST_ADC_VX_OP( 17, vadc.vxm, 0x00000000, 0x00000000, 0x00000000 );
  TEST_ADC_VX_OP( 18, vadc.vxm, 0x00000002, 0x00000001, 0x00000001 );
  TEST_ADC_VX_OP( 19, vadc.vxm, 0x0000000a, 0x00000003, 0x00000007 );

  TEST_ADC_VX_OP( 20, vadc.vxm, 0xffffffffffff8000, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_ADC_VX_OP( 21, vadc.vxm, 0xffffffff80000000, 0xffffffff80000000, 0x00000000 );
  TEST_ADC_VX_OP( 22, vadc.vxm, 0xffffffff7fff8000, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_ADC_VX_OP( 23, vadc.vxm, 0x0000000000007fff, 0x0000000000000000, 0x0000000000007fff );
  TEST_ADC_VX_OP( 24, vadc.vxm, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 );
  TEST_ADC_VX_OP( 25, vadc.vxm, 0x0000000080007ffe, 0x000000007fffffff, 0x0000000000007fff );

  TEST_ADC_VX_OP( 26, vadc.vxm, 0xffffffff80007fff, 0xffffffff80000000, 0x0000000000007fff );
  TEST_ADC_VX_OP( 27, vadc.vxm, 0x000000007fff7fff, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_ADC_VX_OP( 28, vadc.vxm, 0xffffffffffffffff, 0x0000000000000000, 0xffffffffffffffff );
  TEST_ADC_VX_OP( 29, vadc.vxm, 0x0000000000000000, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_ADC_VX_OP( 30, vadc.vxm, 0xfffffffffffffffe, 0xffffffffffffffff, 0xffffffffffffffff );

  TEST_ADC_VX_OP( 31, vadc.vxm, 0x0000000080000000, 0x0000000000000001, 0x000000007fffffff );
	
  #-------------------------------------------------------------
  # vadc.VI Tests
  #-------------------------------------------------------------

  TEST_ADC_VI_OP( 32, vadc.vim, 0x00000000, 0x00000000, 0x0 );
  TEST_ADC_VI_OP( 33, vadc.vim, 0x00000002, 0x00000001, 0x1 );
  TEST_ADC_VI_OP( 34, vadc.vim, 0x0000000a, 0x00000003, 0x7 );

  TEST_ADC_VI_OP( 35, vadc.vim, 0xfffffffffffffff8, 0xfffffffffffffff0, 0x8 );
  TEST_ADC_VI_OP( 36, vadc.vim, 0xffffffff80000000, 0xffffffff80000000, 0x0 );
  TEST_ADC_VI_OP( 37, vadc.vim, 0xffffffff7fff8000, 0xffffffff7fff7ff8, 0x8 );

  TEST_ADC_VI_OP( 38, vadc.vim, 0x0000000000000007, 0x0000000000000000, 0x7 );
  TEST_ADC_VI_OP( 39, vadc.vim, 0x000000007fffffff, 0x000000007fffffff, 0x0 );
  TEST_ADC_VI_OP( 40, vadc.vim, 0x0000000080000006, 0x000000007fffffff, 0x7 );

  TEST_ADC_VI_OP( 41, vadc.vim, 0xffffffff8000800d, 0xffffffff80008006, 0x7 );
  TEST_ADC_VI_OP( 42, vadc.vim, 0x000000007fff7fff, 0x000000007fff7ff7, 0x8 );

  TEST_ADC_VI_OP( 43, vadc.vim, 0x000000000000000f, 0x0000000000000000, 0xf );
  TEST_ADC_VI_OP( 44, vadc.vim, 0x0000000000000000, 0xffffffffffffffff, 0x1 );
  TEST_ADC_VI_OP( 45, vadc.vim, 0x000000000000000e, 0xffffffffffffffff, 0xf );

  TEST_ADC_VI_OP( 46, vadc.vim, 0x000000000000008, 0x0000000000000001, 0x7 );

  #-------------------------------------------------------------
  # vsbc.VV Tests
  #-------------------------------------------------------------

  TEST_ADC_VV_OP( 47, vsbc.vvm, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_ADC_VV_OP( 48, vsbc.vvm, 0x0000000000000000, 0x0000000000000001, 0x0000000000000001 );
  TEST_ADC_VV_OP( 49, vsbc.vvm, 0xfffffffffffffffc, 0x0000000000000003, 0x0000000000000007 );
  TEST_ADC_VV_OP( 50, vsbc.vvm, 0x0000000000008000, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_ADC_VV_OP( 51, vsbc.vvm, 0xffffffff80000000, 0xffffffff80000000, 0x0000000000000000 );
  TEST_ADC_VV_OP( 52, vsbc.vvm, 0xffffffff80008000, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_ADC_VV_OP( 53, vsbc.vvm, 0xffffffffffff8001, 0x0000000000000000, 0x0000000000007fff );
  TEST_ADC_VV_OP( 54, vsbc.vvm, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 );
  TEST_ADC_VV_OP( 55, vsbc.vvm, 0x000000007fff8000, 0x000000007fffffff, 0x0000000000007fff );

  TEST_ADC_VV_OP( 56, vsbc.vvm, 0xffffffff7fff8001, 0xffffffff80000000, 0x0000000000007fff );
  TEST_ADC_VV_OP( 57, vsbc.vvm, 0x0000000080007fff, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_ADC_VV_OP( 58, vsbc.vvm, 0x0000000000000001, 0x0000000000000000, 0xffffffffffffffff );
  TEST_ADC_VV_OP( 59, vsbc.vvm, 0xfffffffffffffffe, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_ADC_VV_OP( 60, vsbc.vvm, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff );
	
  #-------------------------------------------------------------
  # vsbc.VX Tests
  #-------------------------------------------------------------

  TEST_ADC_VX_OP( 61, vsbc.vxm, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_ADC_VX_OP( 62, vsbc.vxm, 0x0000000000000000, 0x0000000000000001, 0x0000000000000001 );
  TEST_ADC_VX_OP( 63, vsbc.vxm, 0xfffffffffffffffc, 0x0000000000000003, 0x0000000000000007 );

  TEST_ADC_VX_OP( 64, vsbc.vxm, 0x0000000000008000, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_ADC_VX_OP( 65, vsbc.vxm, 0xffffffff80000000, 0xffffffff80000000, 0x0000000000000000 );
  TEST_ADC_VX_OP( 66, vsbc.vxm, 0xffffffff80008000, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_ADC_VX_OP( 67, vsbc.vxm, 0xffffffffffff8001, 0x0000000000000000, 0x0000000000007fff );
  TEST_ADC_VX_OP( 68, vsbc.vxm, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 );
  TEST_ADC_VX_OP( 69, vsbc.vxm, 0x000000007fff8000, 0x000000007fffffff, 0x0000000000007fff );

  TEST_ADC_VX_OP( 70, vsbc.vxm, 0xffffffff7fff8001, 0xffffffff80000000, 0x0000000000007fff );
  TEST_ADC_VX_OP( 71, vsbc.vxm, 0x0000000080007fff, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_ADC_VX_OP( 72, vsbc.vxm, 0x0000000000000001, 0x0000000000000000, 0xffffffffffffffff );
  TEST_ADC_VX_OP( 73, vsbc.vxm, 0xfffffffffffffffe, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_ADC_VX_OP( 74, vsbc.vxm, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff );	
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
