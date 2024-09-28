# See LICENSE for license details.

#*****************************************************************************
# vmadc.S
#-----------------------------------------------------------------------------
#
# Test vmadc, vmsbc, vmadc.m, vmsbc.m instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # vmadc.VV tests
  #-------------------------------------------------------------

  TEST_VVM_OP( 2,  vmadc.vv,  0, 0x00000000, 0x00000000 );
  TEST_VVM_OP( 3,  vmadc.vv,  0, 0x00000000, 0x00000001 );
  TEST_VVM_OP( 4,  vmadc.vv,  0, 0x00000000, 0xffffffff );
  TEST_VVM_OP( 5,  vmadc.vv,  1, 0xffffffff, 0x00000001 );
  TEST_VVM_OP( 6,  vmadc.vv,  1, 0xffffffff, 0xffffffff );

  #-------------------------------------------------------------
  # vmadc.VX tests
  #-------------------------------------------------------------

  TEST_VXM_OP(  7,  vmadc.vx,  0, 0x00000000, 0x00000000 );
  TEST_VXM_OP(  8,  vmadc.vx,  0, 0x00000000, 0x00000001 );
  TEST_VXM_OP(  9,  vmadc.vx,  0, 0x00000000, 0xffffffff );
  TEST_VXM_OP( 10,  vmadc.vx,  1, 0xffffffff, 0x00000001 );
  TEST_VXM_OP( 11,  vmadc.vx,  1, 0xffffffff, 0xffffffff );

  #-------------------------------------------------------------
  # vmadc.VI tests
  #-------------------------------------------------------------

  TEST_VIM_OP( 12,  vmadc.vi,  0, 0x00000000, 0x0 );
  TEST_VIM_OP( 13,  vmadc.vi,  0, 0x00000000, 0x1 );
  TEST_VIM_OP( 14,  vmadc.vi,  0, 0x00000000, 0xf );
  TEST_VIM_OP( 15,  vmadc.vi,  0, 0xfffffffe, 0x0 );
  TEST_VIM_OP( 16,  vmadc.vi,  0, 0xfffffffe, 0x1 );
  TEST_VIM_OP( 17,  vmadc.vi,  1, 0xffffffff, 0x1 );

  #-------------------------------------------------------------
  # vmsbc.VV tests
  #-------------------------------------------------------------

  TEST_VVM_OP( 18,  vmsbc.vv,  0, 0x00000000, 0x00000000 );
  TEST_VVM_OP( 19,  vmsbc.vv,  1, 0x00000000, 0x00000001 );
  TEST_VVM_OP( 20,  vmsbc.vv,  1, 0x00000000, 0xffffffff );
  TEST_VVM_OP( 21,  vmsbc.vv,  0, 0xffffffff, 0x00000001 );
  TEST_VVM_OP( 22,  vmsbc.vv,  0, 0xffffffff, 0xffffffff );

  #-------------------------------------------------------------
  # vmsbc.VX tests
  #-------------------------------------------------------------

  TEST_VXM_OP( 23,  vmsbc.vx,  0, 0x00000000, 0x00000000 );
  TEST_VXM_OP( 24,  vmsbc.vx,  1, 0x00000000, 0x00000001 );
  TEST_VXM_OP( 25,  vmsbc.vx,  1, 0x00000000, 0xffffffff );
  TEST_VXM_OP( 26,  vmsbc.vx,  0, 0xffffffff, 0x00000001 );
  TEST_VXM_OP( 27,  vmsbc.vx,  0, 0xffffffff, 0xffffffff );

  #-------------------------------------------------------------
  # vmadc.VV tests
  #-------------------------------------------------------------

  TEST_ADC_VVM_OP( 28,  vmadc.vvm,  0, 0x00000000, 0x00000000 );
  TEST_ADC_VVM_OP( 29,  vmadc.vvm,  0, 0x00000000, 0x00000001 );
  TEST_ADC_VVM_OP( 30,  vmadc.vvm,  0, 0x00000000, 0xffffffff );
  TEST_ADC_VVM_OP( 31,  vmadc.vvm,  1, 0xffffffff, 0x00000001 );
  TEST_ADC_VVM_OP( 32,  vmadc.vvm,  1, 0xffffffff, 0xffffffff );

  #-------------------------------------------------------------
  # vmadc.VX tests
  #-------------------------------------------------------------

  TEST_ADC_VXM_OP( 33,  vmadc.vxm,  0, 0x00000000, 0x00000000 );
  TEST_ADC_VXM_OP( 34,  vmadc.vxm,  0, 0x00000000, 0x00000001 );
  TEST_ADC_VXM_OP( 35,  vmadc.vxm,  0, 0x00000000, 0xffffffff );
  TEST_ADC_VXM_OP( 36,  vmadc.vxm,  1, 0xffffffff, 0x00000001 );
  TEST_ADC_VXM_OP( 37,  vmadc.vxm,  1, 0xffffffff, 0xffffffff );

  #-------------------------------------------------------------
  # vmadc.VI tests
  #-------------------------------------------------------------

  TEST_ADC_VIM_OP( 38,  vmadc.vim,  0, 0x00000000, 0x0 );
  TEST_ADC_VIM_OP( 39,  vmadc.vim,  1, 0x00000000, 0x1 );
  TEST_ADC_VIM_OP( 40,  vmadc.vim,  1, 0x00000000, 0xf );
  TEST_ADC_VIM_OP( 41,  vmadc.vim,  0, 0xfffffffe, 0x0 );
  TEST_ADC_VIM_OP( 42,  vmadc.vim,  1, 0xfffffffe, 0x1 );
  TEST_ADC_VIM_OP( 43,  vmadc.vim,  1, 0xffffffff, 0x1 );

  #-------------------------------------------------------------
  # vmsbc.VV tests
  #-------------------------------------------------------------

  TEST_ADC_VVM_OP( 44,  vmsbc.vvm,  0, 0x00000000, 0x00000000 );
  TEST_ADC_VVM_OP( 45,  vmsbc.vvm,  1, 0x00000000, 0x00000001 );
  TEST_ADC_VVM_OP( 46,  vmsbc.vvm,  1, 0x00000000, 0xffffffff );
  TEST_ADC_VVM_OP( 47,  vmsbc.vvm,  0, 0xffffffff, 0x00000001 );
  TEST_ADC_VVM_OP( 48,  vmsbc.vvm,  0, 0xffffffff, 0xffffffff );

  #-------------------------------------------------------------
  # vmsbc.VX tests
  #-------------------------------------------------------------

  TEST_ADC_VXM_OP( 49,  vmsbc.vxm,  0, 0x00000000, 0x00000000 );
  TEST_ADC_VXM_OP( 50,  vmsbc.vxm,  1, 0x00000000, 0x00000001 );
  TEST_ADC_VXM_OP( 51,  vmsbc.vxm,  1, 0x00000000, 0xffffffff );
  TEST_ADC_VXM_OP( 52,  vmsbc.vxm,  0, 0xffffffff, 0x00000001 );
  TEST_ADC_VXM_OP( 53,  vmsbc.vxm,  0, 0xffffffff, 0xffffffff );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
