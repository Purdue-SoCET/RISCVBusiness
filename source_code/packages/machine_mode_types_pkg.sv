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
*   Filename:     machine_mode_types_pkg.sv
*
*   Created by:   William Cunningham
*   Email:        wrcunnin@purdue.edu
*   Date Created: 09/26/2024
*   Description:  Types needed to implement machine mode priv. isa 1.13
*/

`ifndef MACHINE_MODE_TYPES_PKG_SV
`define MACHINE_MODE_TYPES_PKG_SV

package machine_mode_types_pkg;
  parameter int MXLEN  = 32;
  parameter int SXLEN  = 32;
  parameter int UXLEN  = 32;
  parameter int VSXLEN = 32;
  parameter int HSXLEN = 32;
  
  // Address Translation Constants
  parameter int SV32_MODE   = 1;
  parameter int SV39_MODE   = 8;
  parameter int SV48_MODE   = 9;
  parameter int SV57_MODE   = 10;
  parameter int SV64_MODE   = 11;
  parameter int SV32_PPNLEN = 22;
  parameter int SV39_PPNLEN = 44;
  parameter int SV48_PPNLEN = 44;
  parameter int SV57_PPNLEN = 44;
  parameter int ASID_LENGTH = SXLEN == 32 ? 9 : 16;
  parameter int PPNLEN      = SXLEN == 32 ? SV32_PPNLEN : SV39_PPNLEN;
  parameter int PGSIZE_BITS = 12;

  // Page permission bits
  localparam PAGE_PERM_RSW_1    = 1 << 9;
  localparam PAGE_PERM_RSW_0    = 1 << 8;
  localparam PAGE_PERM_DIRTY    = 1 << 7;
  localparam PAGE_PERM_ACCESSED = 1 << 6;
  localparam PAGE_PERM_GLOBAL   = 1 << 5;
  localparam PAGE_PERM_USER     = 1 << 4;
  localparam PAGE_PERM_EXECUTE  = 1 << 3;
  localparam PAGE_PERM_WRITE    = 1 << 2;
  localparam PAGE_PERM_READ     = 1 << 1;
  localparam PAGE_PERM_VALID    = 1 << 0;

  // Masks
  parameter int SSTATUS_MASK = 32'h800DE762; // 32'b1000_0000_0000_1101_1110_0111_0110_0010
  parameter int SIE_MASK     = 32'h00002222; // 32'b0000_0000_0000_0000_0010_0010_0010_0010

  // Page Permission Types
  typedef enum logic [1:0] {
    ACCESS_LOAD  = 2'b11,
    ACCESS_STORE = 2'b10,
    ACCESS_INSN  = 2'b01,
    ACCESS_NONE  = 2'b00
  } access_t;

  typedef struct packed {
    logic [1:0] reserved_0;
    logic       dirty;
    logic       accessed;
    logic       global_page;
    logic       user;
    logic       executable;
    logic       writable;
    logic       readable;
    logic       valid;
  } pte_perms_t;

  // sv32 types
  typedef struct packed {
    logic [SV32_PPNLEN-1:0] ppn;   // Physical Page Number
    pte_perms_t             perms; // Page permissions
  } pte_sv32_t;

  typedef struct packed {
    logic [1:0] [9:0]         vpn; // vpn[0] and vpn[1]
    logic [(PGSIZE_BITS-1):0] offset;
  } va_sv32_t;

  /* Machine Mode Addresses */
  typedef enum logic [11:0] {
    /* Machine Information Registers */
    MVENDORID_ADDR  = 12'hF11,
    MARCHID_ADDR    = 12'hF12,
    MIMPID_ADDR     = 12'hF13,
    MHARTID_ADDR    = 12'hF14,
    MCONFIGPTR_ADDR = 12'hF15,

    /* Machine Trap Setup */
    MSTATUS_ADDR    = 12'h300,
    MISA_ADDR       = 12'h301,
    MEDELEG_ADDR    = 12'h302,
    MIDELEG_ADDR    = 12'h303,
    MIE_ADDR        = 12'h304,
    MTVEC_ADDR      = 12'h305,
    MCOUNTEREN_ADDR = 12'h306,
    MSTATUSH_ADDR   = 12'h310,
    MEDELEGH_ADDR   = 12'h312,

    /* Machine Trap Handling */
    MSCRATCH_ADDR   = 12'h340,
    MEPC_ADDR       = 12'h341,
    MCAUSE_ADDR     = 12'h342,
    MTVAL_ADDR      = 12'h343,
    MIP_ADDR        = 12'h344,
    MTINST_ADDR     = 12'h34A,
    MTVAL2_ADDR     = 12'h34B,

    /* Machine Configuration */
    MENVCFG_ADDR    = 12'h30A,
    MENVCFGH_ADDR   = 12'h31A,
    MSECCFG_ADDR    = 12'h747,
    MSECCFGH_ADDR   = 12'h757,

    /* Machine Memory Protection */
    /* See pmp_types_pkg.sv */

    /* Machine Counter/Timers */
    MCYCLE_ADDR         = 12'hB00,
    MINSTRET_ADDR       = 12'hB02,
    MHPMCOUNTER3_ADDR   = 12'hB03,
    MHPMCOUNTER4_ADDR   = 12'hB04,
    MHPMCOUNTER5_ADDR   = 12'hB05,
    MHPMCOUNTER6_ADDR   = 12'hB06,
    MHPMCOUNTER7_ADDR   = 12'hB07,
    MHPMCOUNTER8_ADDR   = 12'hB08,
    MHPMCOUNTER9_ADDR   = 12'hB09,
    MHPMCOUNTER10_ADDR  = 12'hB0A,
    MHPMCOUNTER11_ADDR  = 12'hB0B,
    MHPMCOUNTER12_ADDR  = 12'hB0C,
    MHPMCOUNTER13_ADDR  = 12'hB0D,
    MHPMCOUNTER14_ADDR  = 12'hB0E,
    MHPMCOUNTER15_ADDR  = 12'hB0F,
    MHPMCOUNTER16_ADDR  = 12'hB10,
    MHPMCOUNTER17_ADDR  = 12'hB11,
    MHPMCOUNTER18_ADDR  = 12'hB12,
    MHPMCOUNTER19_ADDR  = 12'hB13,
    MHPMCOUNTER20_ADDR  = 12'hB14,
    MHPMCOUNTER21_ADDR  = 12'hB15,
    MHPMCOUNTER22_ADDR  = 12'hB16,
    MHPMCOUNTER23_ADDR  = 12'hB17,
    MHPMCOUNTER24_ADDR  = 12'hB18,
    MHPMCOUNTER25_ADDR  = 12'hB19,
    MHPMCOUNTER26_ADDR  = 12'hB1A,
    MHPMCOUNTER27_ADDR  = 12'hB1B,
    MHPMCOUNTER28_ADDR  = 12'hB1C,
    MHPMCOUNTER29_ADDR  = 12'hB1D,
    MHPMCOUNTER30_ADDR  = 12'hB1E,
    MHPMCOUNTER31_ADDR  = 12'hB1F,
    MCYCLEH_ADDR        = 12'hB80,
    MINSTRETH_ADDR      = 12'hB82,
    MHPMCOUNTER3H_ADDR  = 12'hB83,
    MHPMCOUNTER4H_ADDR  = 12'hB84,
    MHPMCOUNTER5H_ADDR  = 12'hB85,
    MHPMCOUNTER6H_ADDR  = 12'hB86,
    MHPMCOUNTER7H_ADDR  = 12'hB87,
    MHPMCOUNTER8H_ADDR  = 12'hB88,
    MHPMCOUNTER9H_ADDR  = 12'hB89,
    MHPMCOUNTER10H_ADDR = 12'hB8A,
    MHPMCOUNTER11H_ADDR = 12'hB8B,
    MHPMCOUNTER12H_ADDR = 12'hB8C,
    MHPMCOUNTER13H_ADDR = 12'hB8D,
    MHPMCOUNTER14H_ADDR = 12'hB8E,
    MHPMCOUNTER15H_ADDR = 12'hB8F,
    MHPMCOUNTER16H_ADDR = 12'hB90,
    MHPMCOUNTER17H_ADDR = 12'hB91,
    MHPMCOUNTER18H_ADDR = 12'hB92,
    MHPMCOUNTER19H_ADDR = 12'hB93,
    MHPMCOUNTER20H_ADDR = 12'hB94,
    MHPMCOUNTER21H_ADDR = 12'hB95,
    MHPMCOUNTER22H_ADDR = 12'hB96,
    MHPMCOUNTER23H_ADDR = 12'hB97,
    MHPMCOUNTER24H_ADDR = 12'hB98,
    MHPMCOUNTER25H_ADDR = 12'hB99,
    MHPMCOUNTER26H_ADDR = 12'hB9A,
    MHPMCOUNTER27H_ADDR = 12'hB9B,
    MHPMCOUNTER28H_ADDR = 12'hB9C,
    MHPMCOUNTER29H_ADDR = 12'hB9D,
    MHPMCOUNTER30H_ADDR = 12'hB9E,
    MHPMCOUNTER31H_ADDR = 12'hB9F,

    /* Machine Counter Setup */
    MCOUNTINHIBIT_ADDR = 12'h320,
    MHPMEVENT3_ADDR    = 12'h323,
    MHPMEVENT4_ADDR    = 12'h324,
    MHPMEVENT5_ADDR    = 12'h325,
    MHPMEVENT6_ADDR    = 12'h326,
    MHPMEVENT7_ADDR    = 12'h327,
    MHPMEVENT8_ADDR    = 12'h328,
    MHPMEVENT9_ADDR    = 12'h329,
    MHPMEVENT10_ADDR   = 12'h32A,
    MHPMEVENT11_ADDR   = 12'h32B,
    MHPMEVENT12_ADDR   = 12'h32C,
    MHPMEVENT13_ADDR   = 12'h32D,
    MHPMEVENT14_ADDR   = 12'h32E,
    MHPMEVENT15_ADDR   = 12'h32F,
    MHPMEVENT16_ADDR   = 12'h330,
    MHPMEVENT17_ADDR   = 12'h331,
    MHPMEVENT18_ADDR   = 12'h332,
    MHPMEVENT19_ADDR   = 12'h333,
    MHPMEVENT20_ADDR   = 12'h334,
    MHPMEVENT21_ADDR   = 12'h335,
    MHPMEVENT22_ADDR   = 12'h336,
    MHPMEVENT23_ADDR   = 12'h337,
    MHPMEVENT24_ADDR   = 12'h338,
    MHPMEVENT25_ADDR   = 12'h339,
    MHPMEVENT26_ADDR   = 12'h33A,
    MHPMEVENT27_ADDR   = 12'h33B,
    MHPMEVENT28_ADDR   = 12'h33C,
    MHPMEVENT29_ADDR   = 12'h33D,
    MHPMEVENT30_ADDR   = 12'h33E,
    MHPMEVENT31_ADDR   = 12'h33F
  } maddr_t;

  /* Supervisor Mode Addresses */
  typedef enum logic [11:0] {
    /* Supervisor Protection and Translation */
    SATP_ADDR       = 12'h180,

    /* Supervisor Debug/Trace Registers */
    SCONTEXT_ADDR   = 12'h5A8,

    /* Supervisor State Enable Registers */
    SSTATEEN0_ADDR  = 12'h10C,
    SSTATEEN1_ADDR  = 12'h10D,
    SSTATEEN2_ADDR  = 12'h10E,
    SSTATEEN3_ADDR  = 12'h10F,

    /* Supervisor Trap Setup */
    SSTATUS_ADDR    = 12'h100,
    SIE_ADDR        = 12'h104,
    STVEC_ADDR      = 12'h105,
    SCOUNTEREN_ADDR = 12'h106,

    /* Supervisor Trap Handling */
    SSCRATCH_ADDR   = 12'h140,
    SEPC_ADDR       = 12'h141,
    SCAUSE_ADDR     = 12'h142,
    STVAL_ADDR      = 12'h143,
    SIP_ADDR        = 12'h144,
    SCOUNTOVF_ADDR  = 12'hDA0,

    /* Supervisor Configuration */
    SENVCFG_ADDR    = 12'h10A,

    /* Supervisor Counter Setup */
    SCOUNTINHIBIT_ADDR = 12'h120
  } saddr_t;

  /* User Mode Addresses */
  typedef enum logic [11:0] { 
    CYCLE_ADDR         = 12'hC00,
    TIME_ADDR          = 12'hC01,
    INSTRET_ADDR       = 12'hC02,
    HPMCOUNTER3_ADDR   = 12'hC03,
    HPMCOUNTER4_ADDR   = 12'hC04,
    HPMCOUNTER5_ADDR   = 12'hC05,
    HPMCOUNTER6_ADDR   = 12'hC06,
    HPMCOUNTER7_ADDR   = 12'hC07,
    HPMCOUNTER8_ADDR   = 12'hC08,
    HPMCOUNTER9_ADDR   = 12'hC09,
    HPMCOUNTER10_ADDR  = 12'hC0A,
    HPMCOUNTER11_ADDR  = 12'hC0B,
    HPMCOUNTER12_ADDR  = 12'hC0C,
    HPMCOUNTER13_ADDR  = 12'hC0D,
    HPMCOUNTER14_ADDR  = 12'hC0E,
    HPMCOUNTER15_ADDR  = 12'hC0F,
    HPMCOUNTER16_ADDR  = 12'hC10,
    HPMCOUNTER17_ADDR  = 12'hC11,
    HPMCOUNTER18_ADDR  = 12'hC12,
    HPMCOUNTER19_ADDR  = 12'hC13,
    HPMCOUNTER20_ADDR  = 12'hC14,
    HPMCOUNTER21_ADDR  = 12'hC15,
    HPMCOUNTER22_ADDR  = 12'hC16,
    HPMCOUNTER23_ADDR  = 12'hC17,
    HPMCOUNTER24_ADDR  = 12'hC18,
    HPMCOUNTER25_ADDR  = 12'hC19,
    HPMCOUNTER26_ADDR  = 12'hC1A,
    HPMCOUNTER27_ADDR  = 12'hC1B,
    HPMCOUNTER28_ADDR  = 12'hC1C,
    HPMCOUNTER29_ADDR  = 12'hC1D,
    HPMCOUNTER30_ADDR  = 12'hC1E,
    HPMCOUNTER31_ADDR  = 12'hC1F,
    CYCLEH_ADDR        = 12'hC80,
    INSTRETH_ADDR      = 12'hC81,
    TIMEH_ADDR         = 12'hC82,
    HPMCOUNTER3H_ADDR  = 12'hC83,
    HPMCOUNTER4H_ADDR  = 12'hC84,
    HPMCOUNTER5H_ADDR  = 12'hC85,
    HPMCOUNTER6H_ADDR  = 12'hC86,
    HPMCOUNTER7H_ADDR  = 12'hC87,
    HPMCOUNTER8H_ADDR  = 12'hC88,
    HPMCOUNTER9H_ADDR  = 12'hC89,
    HPMCOUNTER10H_ADDR = 12'hC8A,
    HPMCOUNTER11H_ADDR = 12'hC8B,
    HPMCOUNTER12H_ADDR = 12'hC8C,
    HPMCOUNTER13H_ADDR = 12'hC8D,
    HPMCOUNTER14H_ADDR = 12'hC8E,
    HPMCOUNTER15H_ADDR = 12'hC8F,
    HPMCOUNTER16H_ADDR = 12'hC90,
    HPMCOUNTER17H_ADDR = 12'hC91,
    HPMCOUNTER18H_ADDR = 12'hC92,
    HPMCOUNTER19H_ADDR = 12'hC93,
    HPMCOUNTER20H_ADDR = 12'hC94,
    HPMCOUNTER21H_ADDR = 12'hC95,
    HPMCOUNTER22H_ADDR = 12'hC96,
    HPMCOUNTER23H_ADDR = 12'hC97,
    HPMCOUNTER24H_ADDR = 12'hC98,
    HPMCOUNTER25H_ADDR = 12'hC99,
    HPMCOUNTER26H_ADDR = 12'hC9A,
    HPMCOUNTER27H_ADDR = 12'hC9B,
    HPMCOUNTER28H_ADDR = 12'hC9C,
    HPMCOUNTER29H_ADDR = 12'hC9D,
    HPMCOUNTER30H_ADDR = 12'hC9E,
    HPMCOUNTER31H_ADDR = 12'hC9F
  } uaddr_t;


  /* Machine Mode Register Types */

  /* misa types */

  typedef enum logic [1:0] {
    BASE_RV32   = 2'h1,
    BASE_RV64   = 2'h2,
    BASE_RV128  = 2'h3
  } misa_base_t;

  typedef struct packed {
    misa_base_t base;
    logic [3:0] zero;
    logic [25:0] extensions;
  } misa_t;

  localparam logic[25:0] MISA_EXT_A = 26'h1 << 0;
  localparam logic[25:0] MISA_EXT_B = 26'h1 << 1;
  localparam logic[25:0] MISA_EXT_C = 26'h1 << 2;
  localparam logic[25:0] MISA_EXT_D = 26'h1 << 3;
  localparam logic[25:0] MISA_EXT_E = 26'h1 << 4;
  localparam logic[25:0] MISA_EXT_F = 26'h1 << 5;
  localparam logic[25:0] MISA_EXT_G = 26'h1 << 6;
  localparam logic[25:0] MISA_EXT_H = 26'h1 << 7;
  localparam logic[25:0] MISA_EXT_I = 26'h1 << 8;
  localparam logic[25:0] MISA_EXT_J = 26'h1 << 9;
  localparam logic[25:0] MISA_EXT_K = 26'h1 << 10;
  localparam logic[25:0] MISA_EXT_L = 26'h1 << 11;
  localparam logic[25:0] MISA_EXT_M = 26'h1 << 12;
  localparam logic[25:0] MISA_EXT_N = 26'h1 << 13;
  localparam logic[25:0] MISA_EXT_O = 26'h1 << 14;
  localparam logic[25:0] MISA_EXT_P = 26'h1 << 15;
  localparam logic[25:0] MISA_EXT_Q = 26'h1 << 16;
  localparam logic[25:0] MISA_EXT_R = 26'h1 << 17;
  localparam logic[25:0] MISA_EXT_S = 26'h1 << 18;
  localparam logic[25:0] MISA_EXT_T = 26'h1 << 19;
  localparam logic[25:0] MISA_EXT_U = 26'h1 << 20;
  localparam logic[25:0] MISA_EXT_V = 26'h1 << 21;
  localparam logic[25:0] MISA_EXT_W = 26'h1 << 22;
  localparam logic[25:0] MISA_EXT_X = 26'h1 << 23;
  localparam logic[25:0] MISA_EXT_Y = 26'h1 << 24;
  localparam logic[25:0] MISA_EXT_Z = 26'h1 << 25;

  /* mstatus types */

  typedef enum logic [1:0] {
    FS_OFF = 2'h0,
    FS_INITIAL = 2'h1,
    FS_CLEAN    = 2'h2,
    FS_DIRTY    = 2'h3
  } fs_t;

  typedef enum logic [1:0] {
    VS_OFF = 2'h0,
    VS_INITIAL = 2'h1,
    VS_CLEAN    = 2'h2,
    VS_DIRTY    = 2'h3
  } vs_t;

  typedef enum logic [1:0] {
    XS_ALL_OFF  = 2'h0,
    XS_NONE_DC  = 2'h1,
    XS_NONE_D   = 2'h2,
    XS_SOME_D   = 2'h3
  } xs_t;

  typedef enum logic [1:0] {
    U_MODE  = 2'h0,
    S_MODE  = 2'h1,
    RESERVED_MODE   = 2'h2,
    M_MODE   = 2'h3
  } priv_level_t;

  typedef struct packed {
    logic        sd;            // Extension dirty signal (R/O)
    logic [7:0]  reserved_3;
    logic        tsr;           // Trap SRET (no effect without S-Mode)
    logic        tw;            // Timeout wait
    logic        tvm;           // Trap virtual memory (no effect without S-Mode)
    logic        mxr;           // Make executable readable (no effect without S-Mode)
    logic        sum;           // Supervisor user memory access (no effect without S-Mode)
    logic        mprv;          // Modify privilege
    xs_t         xs;            // User extensions state
    fs_t         fs;            // FP extension state
    priv_level_t mpp;           // Previous privilege level
    vs_t         vs;            // Vector extension state
    logic        spp;           // Supervisor previous privilege level (no effect without S-Mode)
    logic        mpie;          // M-Mode previous enable
    logic        ube;           // U-Mode endianness control
    logic        spie;          // S-Mode previous enable
    logic        reserved_2;
    logic        mie;           // M-Mode interrupt enable
    logic        reserved_1;
    logic        sie;           // S-Mode interrupt enable
    logic        reserved_0;
  } mstatus_t;

  typedef struct packed {
    logic [25:0] reserved_1;
    logic        mbe;          // M-Mode endianness control
    logic        sbe;          // S-Mode endianness control
    logic [3:0]  reserved_0;
  } mstatush_t;

  /* mtvec types */
  typedef enum logic [1:0] {
    DIRECT   = 2'h0,
    VECTORED = 2'h1,
    RES_0    = 2'h2,
    RES_1    = 2'h3
  } vector_modes_t;

  typedef struct packed {
    logic [29:0] base;
    vector_modes_t mode;
  } mtvec_t;

  /* mip and mie types */

  // Decreasing priority: MEI, MSI, MTI

  typedef struct packed {
    logic [15:0] impl_defined; // Implementation defined
    logic [3:0]  zero_6;
    logic        meip;         // M-Mode external interrupt pending
    logic        zero_5;
    logic        seip;         // S-Mode external interrupt pending
    logic        zero_4;
    logic        mtip;         // M-Mode timer interrupt pending
    logic        zero_3;
    logic        stip;         // S-Mode timer interrupt pending
    logic        zero_2;
    logic        msip;         // M-Mode software interrupt pending
    logic        zero_1;
    logic        ssip;         // S-Mode software interrupt pending
    logic        zero_0;
  } mip_t;

  typedef struct packed {
    logic [15:0] impl_defined; // Implementation defined
    logic [3:0]  zero_6;
    logic        meie;         // M-Mode external interrupt enable
    logic        zero_5;
    logic        seie;         // S-Mode external interrupt enable
    logic        zero_4;
    logic        mtie;         // M-Mode timer interrupt enable
    logic        zero_3;
    logic        stie;         // S-Mode timer interrupt enable
    logic        zero_2;
    logic        msie;         // M-Mode software interrupt enable
    logic        zero_1;
    logic        ssie;         // S-Mode software interrupt enable
    logic        zero_0;
  } mie_t;

  /* mcounteren and mcountinhibit types */
  typedef struct packed {
    logic [31:3] hpm;
    logic ir;
    logic tm;
    logic cy;
 } mcounteren_t;

  typedef struct packed {
    logic [31:3] hpm;
    logic ir;
    logic reserved_0;
    logic cy;
  } mcountinhibit_t;

  /* mcause register variables */

  typedef struct packed {
    logic         interrupt;
    logic [30:0]  cause;
  } mcause_t;

  // ex_code_t should be cast from an
  // instantiation of mcause_t
  typedef enum logic [30:0] {
    INSN_MAL      = 31'd0,
    INSN_ACCESS   = 31'd1,
    ILLEGAL_INSN  = 31'd2,
    BREAKPOINT    = 31'd3,
    L_ADDR_MAL    = 31'd4,
    L_FAULT       = 31'd5,
    S_ADDR_MAL    = 31'd6,
    S_FAULT       = 31'd7,
    ENV_CALL_U    = 31'd8,
    ENV_CALL_S    = 31'd9,
    ENV_CALL_M    = 31'd11,
    INSN_PAGE     = 31'd12,
    LOAD_PAGE     = 31'd13,
    STORE_PAGE    = 31'd15
  } ex_code_t;

  typedef enum logic [30:0] {
    SOFT_INT_S          = 31'd1,
    SOFT_INT_M          = 31'd3,
    TIMER_INT_S         = 31'd5,
    TIMER_INT_M         = 31'd7,
    EXT_INT_S           = 31'd9,
    EXT_INT_M           = 31'd11
  } int_code_t;

  // General CSR definition
  typedef logic [11:0] csr_addr_t;
  typedef logic [31:0] csr_reg_t;
  typedef logic [63:0] long_csr_t;

  //Non Standard Extentions
  // Unsure what these are for,
  //  part of priv 1.11
  typedef logic [31:0] mtohost_t;
  typedef logic [31:0] mfromhost_t;

  /* Supervisor Mode Register Types */

  /* sstatus and stvec types */

  typedef struct packed {
    logic        sd;            // Extension dirty signal (R/O)
    logic [10:0] reserved_5;
    logic        mxr;           // Make executable readable
    logic        sum;           // Supervisor user memory access
    logic        reserved_4;
    xs_t         xs;            // User extensions state
    fs_t         fs;            // FP extension state
    logic        reserved_3;
    vs_t         vs;            // Vector extension state
    logic        spp;           // Supervisor previous privilege level
    logic        reserved_2;
    logic        ube;           // U-Mode endianness control
    logic        spie;          // S-Mode previous enable
    logic [2:0]  reserved_1;
    logic        sie;           // S-Mode interrupt enable
    logic        reserved_0;
  } sstatus_t;

  typedef struct packed {
    logic [29:0] base;
    vector_modes_t mode;
  } stvec_t;

  /* sip and sie types */

  typedef struct packed {
    logic [15:0] impl_defined; // Implementation defined
    logic [1:0]  zero_4;
    logic        lcofip;       // Local counter-overflow interrupt pending (No effect without Sscofpmf)
    logic [2:0]  zero_3;
    logic        seip;         // S-Mode external interrupt pending
    logic [2:0]  zero_2;
    logic        stip;         // S-Mode timer interrupt pending
    logic [2:0]  zero_1;
    logic        ssip;         // S-Mode software interrupt pending
    logic        zero_0;
  } sip_t;

  typedef struct packed {
    logic [15:0] impl_defined; // Implementation defined
    logic [1:0]  zero_4;
    logic        lcofip;       // Local counter-overflow interrupt enable (No effect without Sscofpmf)
    logic [2:0]  zero_3;
    logic        seie;         // S-Mode external interrupt enable
    logic [2:0]  zero_2;
    logic        stie;         // S-Mode timer interrupt enable
    logic [2:0]  zero_1;
    logic        ssie;         // S-Mode software interrupt enable
    logic        zero_0;
  } sie_t;

  /* scounteren and scountinhibit types */

  typedef struct packed {
    logic hpm31;
    logic hpm30;
    logic hpm29;
    logic hpm28;
    logic hpm27;
    logic hpm26;
    logic hpm25;
    logic hpm24;
    logic hpm23;
    logic hpm22;
    logic hpm21;
    logic hpm20;
    logic hpm19;
    logic hpm18;
    logic hpm17;
    logic hpm16;
    logic hpm15;
    logic hpm14;
    logic hpm13;
    logic hpm12;
    logic hpm11;
    logic hpm10;
    logic hpm9;
    logic hpm8;
    logic hpm7;
    logic hpm6;
    logic hpm5;
    logic hpm4;
    logic hpm3;
    logic ir;
    logic tm;
    logic cy;
 } scounteren_t;

 typedef struct packed {
    logic hpm31;
    logic hpm30;
    logic hpm29;
    logic hpm28;
    logic hpm27;
    logic hpm26;
    logic hpm25;
    logic hpm24;
    logic hpm23;
    logic hpm22;
    logic hpm21;
    logic hpm20;
    logic hpm19;
    logic hpm18;
    logic hpm17;
    logic hpm16;
    logic hpm15;
    logic hpm14;
    logic hpm13;
    logic hpm12;
    logic hpm11;
    logic hpm10;
    logic hpm9;
    logic hpm8;
    logic hpm7;
    logic hpm6;
    logic hpm5;
    logic hpm4;
    logic hpm3;
    logic ir;
    logic reserved_0;
    logic cy;
  } scountinhibit_t;

  /* scause types */

  typedef struct packed {
    logic               interrupt;
    logic [(SXLEN-2):0] cause;
  } scause_t;

  /* senvcfg register types */
  typedef struct packed {
    logic [23:0] reserved_1;
    logic        cbze;       // Zicboz extension, may change when ratified
    logic        cbcfe;      // Zicbom extension, may change when ratified
    logic        cbie;       // Zicbom extension, may change when ratified
    logic [2:0]  reserved_0;
    logic        fiom;       // Fence of I/O implies Memory
  } senvcfg_t;

  /* satp register types */

  typedef struct packed {
    logic        mode;
    logic [ASID_LENGTH-1:0]  asid;
    logic [PPNLEN-1:0] ppn;
  } satp_t;

endpackage

`endif //MACHINE_MODE_TYPES_PKG_SV
