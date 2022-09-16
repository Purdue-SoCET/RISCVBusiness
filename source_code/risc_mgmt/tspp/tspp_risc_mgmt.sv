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
*   Filename:     tspp_risc_mgmt.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 02/07/2017
*   Description:  Top Level Module for RISC-MGMT
*                 Provides the interface between extensions
*                 and the standard core.
*
*                 This version will connect extensions
*                 to a two stage pipeline (tspp).
*/

`include "risc_mgmt_macros.vh"
`include "component_selection_defines.vh"
`include "risc_mgmt_if.vh"

module tspp_risc_mgmt (
    input logic CLK,
    nRST,
    risc_mgmt_if.ts_rmgmt rm_if
);
    import rv32i_types_pkg::*;

    parameter N_EXTENSIONS = `NUM_EXTENSIONS;
    localparam N_EXT_BITS = $clog2(N_EXTENSIONS);

    /******************************************************************
  * Signal Instantiations
  ******************************************************************/

    // Decode Stage Signals
    word_t [N_EXTENSIONS-1:0] d_insn;
    logic [N_EXTENSIONS-1:0] d_insn_claim;
    logic [N_EXTENSIONS-1:0] d_mem_to_reg;  // ignored in two stage pipe rmgmt
    logic [N_EXTENSIONS-1:0][4:0] d_rsel_s_0;
    logic [N_EXTENSIONS-1:0][4:0] d_rsel_s_1;
    logic [N_EXTENSIONS-1:0][4:0] d_rsel_d;

    //Execute Stage Signals
    logic [N_EXTENSIONS-1:0] e_start;
    logic [N_EXTENSIONS-1:0] e_exception;
    logic [N_EXTENSIONS-1:0] e_busy;
    word_t [N_EXTENSIONS-1:0] e_rdata_s_0;
    word_t [N_EXTENSIONS-1:0] e_rdata_s_1;
    logic [N_EXTENSIONS-1:0] e_branch_jump;
    word_t [N_EXTENSIONS-1:0] e_pc;
    word_t [N_EXTENSIONS-1:0] e_br_j_addr;
    word_t [N_EXTENSIONS-1:0] e_reg_wdata;
    logic [N_EXTENSIONS-1:0] e_reg_w;

    //Memory Stage Signals
    logic [N_EXTENSIONS-1:0] m_exception;
    logic [N_EXTENSIONS-1:0] m_busy;
    word_t [N_EXTENSIONS-1:0] m_mem_addr;
    logic [N_EXTENSIONS-1:0] m_mem_ren;
    logic [N_EXTENSIONS-1:0] m_mem_wen;
    logic [N_EXTENSIONS-1:0] m_mem_busy;
    logic [N_EXTENSIONS-1:0][3:0] m_mem_byte_en;
    word_t [N_EXTENSIONS-1:0] m_mem_load;
    word_t [N_EXTENSIONS-1:0] m_mem_store;
    logic [N_EXTENSIONS-1:0] m_reg_wdata;
    logic [N_EXTENSIONS-1:0] m_reg_w;


    /******************************************************************
  *   Extension connections
  *
  *   Modify RISC_MGMT_EXTENSIONS in component_selection_defines.vh
  *   to edit the included instruction extensions
  *
  ******************************************************************/

    `RISC_MGMT_EXTENSIONS


    /******************************************************************
  * Begin RISC-MGMT Logic
  ******************************************************************/

    /* Send instruction to extensions */
    assign d_insn = {N_EXTENSIONS{rm_if.insn}};

    /*  Extension Tokens  */

    integer i;
    logic [N_EXTENSIONS-1:0]  tokens;
    logic ext_is_active;
    logic [N_EXT_BITS-1:0]    active_ext;

    assign tokens            = d_insn_claim;
    assign ext_is_active     = |tokens;
    assign rm_if.active_insn = ext_is_active;

    assign rm_if.ex_token    = ext_is_active;

    always_comb begin
        active_ext = 0;
        for (i = 0; i < N_EXTENSIONS; i++) begin
            if (tokens[i]) active_ext = i;
        end
    end


    /* Pipeline Control / Automatic Clock Gating
  *  Not present in 2 stage pipeline implementation
  *  All pipeline control is handled in standard core automatically
  *  Stalls will be forwarded to the standard core
  */
    assign rm_if.execute_stall = e_busy[active_ext] && ext_is_active;
    assign rm_if.memory_stall  = m_busy[active_ext] && ext_is_active;

    // start signal for multicycle execute stages
    logic ex_start;

    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) ex_start <= 1'b0;
        else if (rm_if.if_ex_enable) ex_start <= 1'b1;
        else ex_start <= 1'b0;
    end

    assign e_start = {N_EXTENSIONS{ex_start}} & tokens;
    assign rm_if.risc_mgmt_start = e_start;  // to stall rv32c load buffer

    /* Registerfile / Forwarding Logic
  *  Forwarding not present in 2 stage pipeline
  */

    // Reg reads and decode
    assign rm_if.req_reg_r = ext_is_active;
    assign rm_if.rsel_s_0 = d_rsel_s_0[active_ext];
    assign rm_if.rsel_s_1 = d_rsel_s_1[active_ext];
    assign rm_if.rsel_d = d_rsel_d[active_ext];
    assign e_rdata_s_0 = {N_EXTENSIONS{rm_if.rdata_s_0}};
    assign e_rdata_s_1 = {N_EXTENSIONS{rm_if.rdata_s_1}};

    // Reg Writeback
    assign rm_if.req_reg_w = (e_reg_w[active_ext] || m_reg_w[active_ext]) && ext_is_active;
    assign rm_if.reg_w = e_reg_w[active_ext] || m_reg_w[active_ext];
    assign rm_if.reg_wdata = e_reg_w[active_ext] ? e_reg_wdata[active_ext] : m_reg_wdata[active_ext];


    /*  Branch Jump Control  */

    assign rm_if.req_br_j = e_branch_jump[active_ext] && ext_is_active;
    assign rm_if.branch_jump = e_branch_jump[active_ext];
    assign rm_if.br_j_addr = e_br_j_addr[active_ext];
    assign e_pc = {N_EXTENSIONS{rm_if.pc}};

    /*  Memory Access Control  */

    assign rm_if.req_mem = (m_mem_ren[active_ext] || m_mem_wen[active_ext]) && ext_is_active;
    assign rm_if.mem_addr = m_mem_addr[active_ext];
    assign rm_if.mem_byte_en = m_mem_byte_en[active_ext];
    assign rm_if.mem_store = m_mem_store[active_ext];
    assign rm_if.mem_ren = m_mem_ren[active_ext];
    assign rm_if.mem_wen = m_mem_wen[active_ext];
    assign m_mem_busy = {N_EXTENSIONS{rm_if.mem_busy}};
    assign m_mem_load = {N_EXTENSIONS{rm_if.mem_load}};


    /*  Exception Reporting  */
    assign rm_if.exception = (e_exception[active_ext] || m_exception[active_ext]) && ext_is_active;
    assign rm_if.ex_cause = active_ext;


endmodule
