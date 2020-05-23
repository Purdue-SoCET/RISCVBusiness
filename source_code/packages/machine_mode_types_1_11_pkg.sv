/*
*   Copyright 2016 Purdue University
*   
*   Licensed under the Apache License, Version 2.0 (the "License");
*   you may not use this file except in compliance with the License.
*   You may obtain a copy of the License at
*   
*       http://www.apache.org/licenses/LICENSE-2.0
*   
*   Unless required by applicable law or agreed to in writing, software
*   distributed under the License is distributed on an "AS IS" BASIS,
*   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*   See the License for the specific language governing permissions and
*   limitations under the License.
*
*
*   Filename:     machine_mode_types_1_11_pkg.sv
*
*   Created by:   Jacob R. Stevens
*   Email:        steven69@purdue.edu
*   Date Created: 08/13/2019
*   Description:  Types needed to implement machine mode priv. isa 1.11
*/

`ifndef MACHINE_MODE_TYPES_1_11_PKG_SV
`define MACHINE_MODE_TYPES_1_11_PKG_SV

package machine_mode_types_1_11_pkg;

  typedef enum logic [11:0] {
    /* Machine Mode Addresses */
    MVENDORID_ADDR  = 12'hF11,
    MARCHID_ADDR    = 12'hF12,
    MIMPID_ADDR     = 12'hF13,
    MHARTID_ADDR    = 12'hF14,

    MSTATUS_ADDR    = 12'h300,
    MISA_ADDR       = 12'h301,
    MEDELEG_ADDR    = 12'h302,
    MIDELEG_ADDR    = 12'h303,
    MIE_ADDR        = 12'h304,
    MTVEC_ADDR      = 12'h305,
    //TODO: MCOUNTEREN AND ASSOCIATED REGS/CONTGROL (e.g. cycle/time)
    MCOUNTEREN_ADDR = 12'h306,
 
    MSCRATCH_ADDR   = 12'h340,
    MEPC_ADDR       = 12'h341,
    MCAUSE_ADDR     = 12'h342,
    MTVAL_ADDR      = 12'h343,
    MIP_ADDR        = 12'h344,

    // TODO: MAY BE ABLE TO REMOVE BELOW
    MBASE_ADDR      = 12'h380,
    MBOUND_ADDR     = 12'h381,
    MIBASE_ADDR     = 12'h382,
    MIBOUND_ADDR    = 12'h383,
    MDBASE_ADDR     = 12'h384,
    MDBOUND_ADDR    = 12'h385,
    // TODO: MAY BE ABLE TO REMOVE ABOVE
    // TODO: BELOW MUST BE REMOVED
    MTOHOST_ADDR    = 12'h780,
    MFROMHOST_ADDR  = 12'h781,
    HTIMEW_ADDR     = 12'hB01,
    HTIMEHW_ADDR    = 12'hB81,
    MTIMECMP_ADDR   = 12'h321,
    MTIME_ADDR      = 12'h701,
    MTIMEH_ADDR     = 12'h741,
    // TODO: ABOVE MUST BE REMOVED

    MCYCLE_ADDR      = 12'hB00,
    MINSTRET_ADDR    = 12'hB02,
    MCYCLEH_ADDR     = 12'hB80,
    MINSTRETH_ADDR   = 12'hB82
  } csr_addr_t;

  /* Priv Levels 
  typedef enum logic [1:0] {
    U_MODE = 2'b00,
    S_MODE = 2'b01,
    H_MODE = 2'b10,
    M_MODE = 2'b11
  } prv_lvl_t; */
  
  /* Machine Mode Register Types */

  /* misaid types */

  typedef enum logic [1:0] {
    BASE_RV32   = 2'h1,
    BASE_RV64   = 2'h2,
    BASE_RV128  = 2'h3
  } misaid_base_t;

  typedef struct packed {
    misaid_base_t base;
    logic [3:0] zero;
    logic [25:0] extensions;
  } misaid_t;

  parameter MISAID_EXT_A   = 26'h1 << 0;
  parameter MISAID_EXT_B   = 26'h1 << 1;
  parameter MISAID_EXT_C   = 26'h1 << 2;
  parameter MISAID_EXT_D   = 26'h1 << 3;
  parameter MISAID_EXT_E   = 26'h1 << 4;
  parameter MISAID_EXT_F   = 26'h1 << 5;
  parameter MISAID_EXT_G   = 26'h1 << 6;
  parameter MISAID_EXT_H   = 26'h1 << 7;
  parameter MISAID_EXT_I   = 26'h1 << 8;
  parameter MISAID_EXT_J   = 26'h1 << 9;
  parameter MISAID_EXT_K   = 26'h1 << 10;
  parameter MISAID_EXT_L   = 26'h1 << 11;
  parameter MISAID_EXT_M   = 26'h1 << 12;
  parameter MISAID_EXT_N   = 26'h1 << 13;
  parameter MISAID_EXT_O   = 26'h1 << 14;
  parameter MISAID_EXT_P   = 26'h1 << 15;
  parameter MISAID_EXT_Q   = 26'h1 << 16;
  parameter MISAID_EXT_R   = 26'h1 << 17;
  parameter MISAID_EXT_S   = 26'h1 << 18;
  parameter MISAID_EXT_T   = 26'h1 << 19;
  parameter MISAID_EXT_U   = 26'h1 << 20;
  parameter MISAID_EXT_V   = 26'h1 << 21;
  parameter MISAID_EXT_W   = 26'h1 << 22;
  parameter MISAID_EXT_X   = 26'h1 << 23;
  parameter MISAID_EXT_Y   = 26'h1 << 24;
  parameter MISAID_EXT_Z   = 26'h1 << 25;

  /* mstatus types */
/*
  typedef enum logic [4:0] {
    VM_MBARE  = 5'h0,
    VM_MBB    = 5'h1,
    VM_MBBID  = 5'h2,
    VM_SV32   = 5'h8,
    VM_SV39   = 5'h9,
    VM_SV48   = 5'ha,
    VM_SV57   = 5'hb,
    VM_SV64   = 5'hc
  } vm_t; */

  typedef enum logic [1:0] {
    FS_OFF = 2'h0,
    FS_INITIAL = 2'h1,
    FS_CLEAN    = 2'h2,
    FS_DIRTY    = 2'h3
  } fs_t;

  typedef enum logic [1:0] {
    XS_ALL_OFF  = 2'h0,
    XS_NONE_DC  = 2'h1,
    XS_NONE_D   = 2'h2,
    XS_SOME_D   = 2'h3
  } xs_t;

  typedef enum logic [1:0] {
    U_LEVEL  = 2'h0,
    S_LEVEL  = 2'h1,
    RESERVED_LEVEL   = 2'h2,
    M_LEVEL   = 2'h3
  } priv_level_t;

  typedef enum logic [1:0] {
    DIRECT   = 2'h0,
    VECTORED = 2'h1
  } vector_modes_t;

  typedef struct packed {
    logic [29:0] base;
    vector_modes_t mode;
  } mtvec_t;
  
  typedef struct packed {
    logic       sd;    
    logic [7:0] reserved_3;
    logic	tsr;
    logic	tw;
    logic	tvm;
    logic	mxr;
    logic	sum; 
    logic       mprv;
    xs_t        xs;
    fs_t	fs;
    priv_level_t mpp;
    logic [1:0] reserved_2;
    logic	spp;
    logic       mpie;
    logic	reserved_1;
    logic       spie;
    logic 	upie;
    logic       mie;
    logic	reserved_0;
    logic 	sie;
    logic       uie;
  } mstatus_t;

  /* mip and mie types */

  typedef struct packed { // total size for xlen (or mxlen) is 32 bits for our processor
    logic [19:0]  reserved_3;
    logic         meip;
    logic         reserved_2;
    logic         seip;
    logic         ueip;
    logic         mtip;
    logic         reserved_1;
    logic         stip;
    logic         utip;
    logic         msip;
    logic         reserved_0;
    logic         ssip;
    logic         usip; 
  } mip_t;

  typedef struct packed {
    logic [19:0]  reserved_3;
    logic         meie;
    logic	  reserved_2;
    logic         seie;
    logic 	  ueie;
    logic         mtie;
    logic         reserved_1;
    logic         stie;
    logic         utie;
    logic         msie;
    logic         reserved_0;
    logic         ssie;
    logic         usie; 
  } mie_t;

  /* mcause register variables */

  typedef struct packed {
    logic         interrupt;
    logic [30:0]  cause;
  } mcause_t;

  // ex_code_t should be cast from an 
  // instantiation of mcause_t
  typedef enum logic [30:0] {
    INSN_MAL      = 31'h0,
    INSN_ACCESS   = 31'h1,
    ILLEGAL_INSN  = 31'h2,
    BREAKPOINT    = 31'h3,
    L_ADDR_MAL    = 31'h4,
    L_FAULT       = 31'h5,
    S_ADDR_MAL    = 31'h6,
    S_FAULT       = 31'h7,
    ENV_CALL_U    = 31'h8,
    ENV_CALL_S    = 31'h9,
    RESERVED_0    = 31'hA, 
    ENV_CALL_M    = 31'hB,
    INSN_PAGE     = 31'hC,
    LOAD_PAGE     = 31'hD, 
    RESERVED_1    = 31'hE,
    STORE_PAGE    = 31'hF,
    RESERVED_2    = 31'h10
  } ex_code_t;

  typedef enum logic [30:0] {
    SOFT_INT_U          = 31'h11,
    SOFT_INT_S          = 31'h12,
    RESERVED_4          = 31'h13,
    SOFT_INT_M          = 31'h14,
    TIMER_INT_U         = 31'h15,
    TIMER_INT_S         = 31'h16,
    RESERVED_5          = 31'h17,
    TIMER_INT_M         = 31'h18,
    EXT_INT_U           = 31'h19,
    EXT_INT_S           = 31'h20,
    RESERVED_6          = 31'h21,
    EXT_INT_M           = 31'h22 
  } int_code_t;

  /* Simple registers */

  typedef logic [63:0] mcycle_t;
  typedef logic [63:0] minstret_t;
  typedef logic [31:0] mscratch_t;
  typedef logic [31:0] mtval_t;
  typedef logic [31:0] mvendorid_t;
  typedef logic [31:0] marchid_t;
  typedef logic [31:0] mimpid_t;
  typedef logic [31:0] mhartid_t;
  typedef logic [31:0] medeleg_t;
  typedef logic [31:0] mideleg_t;
  //typedef logic [31:0] mtvec_t;
  typedef logic [31:0] mepc_t;
  typedef logic [31:0] mtime_t;
  typedef logic [31:0] mtimeh_t;
  typedef logic [31:0] mtimecmp_t;

  /* User simple registers */
  typedef logic [31:0] cycle_t;
  typedef logic [31:0] time_t;
  typedef logic [31:0] instret_t;

  //Non Standard Extentions 
  typedef logic [31:0] mtohost_t;
  typedef logic [31:0] mfromhost_t;
  
endpackage

`endif //MACHINE_MODE_TYPES_1_11_PKG_SV
