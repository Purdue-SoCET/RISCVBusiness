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
*   Filename:     machine_mode_types_1_7_pkg.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 07/05/2016
*   Description:  Types needed to implement machine mode priv. isa 1.7
*/

`ifndef MACHINE_MODE_TYPES_1_7_PKG_SV
`define MACHINE_MODE_TYPES_1_7_PKG_SV

package machine_mode_types_1_7_pkg;

    typedef enum logic [11:0] {
        /* Machine Mode Addresses */
        MCPUID_ADDR  = 12'hF00,
        MIMPID_ADDR  = 12'hF01,
        MHARTID_ADDR = 12'hF10,

        MSTATUS_ADDR = 12'h300,
        MTVEC_ADDR   = 12'h301,
        MTDELEG_ADDR = 12'h302,
        MIE_ADDR     = 12'h304,

        MSCRATCH_ADDR = 12'h340,
        MEPC_ADDR     = 12'h341,
        MCAUSE_ADDR   = 12'h342,
        MBADADDR_ADDR = 12'h343,
        MIP_ADDR      = 12'h344,

        MBASE_ADDR   = 12'h380,
        MBOUND_ADDR  = 12'h381,
        MIBASE_ADDR  = 12'h382,
        MIBOUND_ADDR = 12'h383,
        MDBASE_ADDR  = 12'h384,
        MDBOUND_ADDR = 12'h385,

        HTIMEW_ADDR  = 12'hB01,
        HTIMEHW_ADDR = 12'hB81,

        MTIMECMP_ADDR = 12'h321,
        MTIME_ADDR    = 12'h701,
        MTIMEH_ADDR   = 12'h741,

        MTOHOST_ADDR   = 12'h780,
        MFROMHOST_ADDR = 12'h781,
        /* User Mode Addresses */
        CYCLE_ADDR     = 12'hC00,
        TIME_ADDR      = 12'hC01,
        INSTRET_ADDR   = 12'hC02,
        CYCLEH_ADDR    = 12'hC80,
        TIMEH_ADDR     = 12'hC81,
        INSTRETH_ADDR  = 12'hC82
    } csr_addr_t;


    /* Priv Levels */
    typedef enum logic [1:0] {
        U_MODE = 2'b00,
        S_MODE = 2'b01,
        H_MODE = 2'b10,
        M_MODE = 2'b11
    } prv_lvl_t;

    /* Machine Mode Register Types */

    /* mcpuid types */

    typedef enum logic [1:0] {
        BASE_RV32  = 2'h1,
        BASE_RV64  = 2'h2,
        BASE_RV128 = 2'h3
    } mcpuid_base_t;

    typedef struct packed {
        mcpuid_base_t base;
        logic [3:0]   zero;
        logic [25:0]  extensions;
    } mcpuid_t;

    parameter MCPUID_EXT_A = 26'h1 << 0;
    parameter MCPUID_EXT_B = 26'h1 << 1;
    parameter MCPUID_EXT_C = 26'h1 << 2;
    parameter MCPUID_EXT_D = 26'h1 << 3;
    parameter MCPUID_EXT_E = 26'h1 << 4;
    parameter MCPUID_EXT_F = 26'h1 << 5;
    parameter MCPUID_EXT_G = 26'h1 << 6;
    parameter MCPUID_EXT_H = 26'h1 << 7;
    parameter MCPUID_EXT_I = 26'h1 << 8;
    parameter MCPUID_EXT_J = 26'h1 << 9;
    parameter MCPUID_EXT_K = 26'h1 << 10;
    parameter MCPUID_EXT_L = 26'h1 << 11;
    parameter MCPUID_EXT_M = 26'h1 << 12;
    parameter MCPUID_EXT_N = 26'h1 << 13;
    parameter MCPUID_EXT_O = 26'h1 << 14;
    parameter MCPUID_EXT_P = 26'h1 << 15;
    parameter MCPUID_EXT_Q = 26'h1 << 16;
    parameter MCPUID_EXT_R = 26'h1 << 17;
    parameter MCPUID_EXT_S = 26'h1 << 18;
    parameter MCPUID_EXT_T = 26'h1 << 19;
    parameter MCPUID_EXT_U = 26'h1 << 20;
    parameter MCPUID_EXT_V = 26'h1 << 21;
    parameter MCPUID_EXT_W = 26'h1 << 22;
    parameter MCPUID_EXT_X = 26'h1 << 23;
    parameter MCPUID_EXT_Y = 26'h1 << 24;
    parameter MCPUID_EXT_Z = 26'h1 << 25;
    parameter MTVEC_MEMORY_ADDR = 32'h1c0;

    /* mstatus types */

    typedef enum logic [4:0] {
        VM_MBARE = 5'h0,
        VM_MBB   = 5'h1,
        VM_MBBID = 5'h2,
        VM_SV32  = 5'h8,
        VM_SV39  = 5'h9,
        VM_SV48  = 5'ha,
        VM_SV57  = 5'hb,
        VM_SV64  = 5'hc
    } vm_t;

    typedef enum logic [1:0] {
        FS_OFF = 2'h0,
        FS_INITIAL = 2'h1,
        FS_CLEAN    = 2'h2,
        FS_DIRTY    = 2'h3
    } fs_t;

    typedef enum logic [1:0] {
        XS_ALL_OFF = 2'h0,
        XS_NONE_DC = 2'h1,
        XS_NONE_D  = 2'h2,
        XS_SOME_D  = 2'h3
    } xs_t;

    typedef struct packed {
        logic       sd;
        logic [8:0] zero;
        vm_t        vm;
        logic       mprv;
        xs_t        xs;
        fs_t        fs;
        prv_lvl_t   prv3;
        logic       ie3;
        prv_lvl_t   prv2;
        logic       ie2;
        prv_lvl_t   prv1;
        logic       ie1;
        prv_lvl_t   prv;
        logic       ie;
    } mstatus_t;

    /* mip and mie types */

    typedef struct packed {
        logic [23:0] zero_2;
        logic        mtip;
        logic        htip;
        logic        stip;
        logic        zero_1;
        logic        msip;
        logic        hsip;
        logic        ssip;
        logic        zero_0;
    } mip_t;

    typedef struct packed {
        logic [23:0] zero_2;
        logic        mtie;
        logic        htie;
        logic        stie;
        logic        zero_1;
        logic        msie;
        logic        hsie;
        logic        ssie;
        logic        zero_0;
    } mie_t;

    /* mcause register variables */

    typedef struct packed {
        logic        interrupt;
        logic [30:0] cause;
    } mcause_t;

    // ex_code_t should be cast from an
    // instantiation of mcause_t
    typedef enum logic [30:0] {
        INSN_MAL     = 31'h0,
        INSN_FAULT   = 31'h1,
        ILLEGAL_INSN = 31'h2,
        BREAKPOINT   = 31'h3,
        L_ADDR_MAL   = 31'h4,
        L_FAULT      = 31'h5,
        S_ADDR_MAL   = 31'h6,
        S_FAULT      = 31'h7,
        ENV_CALL_U   = 31'h8,
        ENV_CALL_S   = 31'h9,
        ENV_CALL_H   = 31'ha,
        ENV_CALL_M   = 31'hb
    } ex_code_t;

    typedef enum logic [30:0] {
        SOFT_INT  = 31'h0,
        TIMER_INT = 31'h1,
        EXT_INT   = 31'hb   //NON-STANDARD in priv-1.7
    } int_code_t;

    /* Simple registers */

    typedef logic [63:0] mcycle_t;
    typedef logic [63:0] minstret_t;
    typedef logic [31:0] mscratch_t;
    typedef logic [31:0] mbadaddr_t;
    typedef logic [31:0] mimpid_t;
    typedef logic [31:0] mhartid_t;
    typedef logic [31:0] mtdeleg_t;
    typedef logic [31:0] mtvec_t;
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

`endif  //MACHINE_MODE_TYPES_1_7_PKG_SV
