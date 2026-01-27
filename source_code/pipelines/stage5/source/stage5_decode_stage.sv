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
*   Filename:     stage5_decode_stage.sv
*
*   Created by:   William Cunningham
*   Email:        wrcunnin@purdue.edu
*   Date Created: 01/26/2026
*   Description:  Decode Stage for the Five Stage Pipeline
*/

`include "stage5_fetch_decode_if.vh"
`include "stage5_decode_execute_if.vh"
`include "stage5_mem_wb_if.vh"
`include "stage5_hazard_unit_if.vh"
`include "stage5_forwarding_unit_if.vh"
`include "control_unit_if.vh"
`include "component_selection_defines.vh"
`include "rv32i_reg_file_if.vh"
`include "alu_if.vh"

module stage5_decode_stage (
    input CLK,
    input nRST,
    stage5_fetch_decode_if.decode fetch_decode_if,
    stage5_decode_execute_if.decode decode_ex_if,
    stage5_mem_wb_if.decode mem_wb_if,
    stage5_hazard_unit_if.decode hazard_if
);
    import rv32i_types_pkg::*;
    import pma_types_pkg::*;
    import stage5_types_pkg::*;

    // Interface declarations
    control_unit_if cu_if ();
    rv32i_reg_file_if rf_if ();
    alu_if alu_if ();
    jump_calc_if jump_if ();
    branch_res_if branch_if ();

    /**********************
    * Decode/Register Read
    ***********************/
    logic [31:0] decompressor_out;
    logic [31:0] instr_to_cu;
    logic is_compressed;

    // RV32C handling -- TODO: Disable-ability
    decompressor DECOMPRESSOR(
        .compressed(fetch_decode_if.fetch_decode_reg.instr[15:0]),
        .decompressed(decompressor_out)
    );

    // All full-size instructions end with 0b11
    assign is_compressed = fetch_decode_if.fetch_decode_reg.instr[1:0] != 2'b11;
    assign cu_if.instr =
            is_compressed ? 
            decompressor_out
            : fetch_decode_if.fetch_decode_reg.instr;

    // Control unit, inputs are post-decompression
    control_unit cu (
        .cu_if(cu_if),
        .rf_if(rf_if)
    );

    rv32i_reg_file #(.RV32E(BASE_ISA == "RV32E")) rf (
        .CLK,
        .nRST,
        .rf_if
    );

    // CSR Read-only determination
    // No write occurs if CSRRS/C(I) with a statically-zero source operand
    logic csr_read_only;
    assign csr_read_only = (cu_if.csr_clr || cu_if.csr_set)
                            && ((cu_if.csr_imm && cu_if.zimm == 5'b0) || rf_if.rs1 == 5'b0);

    /*************************
    * Hazard Forwarding Signals
    *************************/
    assign hazard_if.rs1_d = rf_if.rs1;
    assign hazard_if.rs2_d = rf_if.rs2;
    assign hazard_if.valid_d = fetch_decode_if.fetch_decode_reg.valid;
    assign hazard_if.pc_d = fetch_decode_if.fetch_decode_reg.pc;

    /*************************
    * Register File Writeback
    *************************/
    word_t rs1_data, rs2_data;
    assign rf_if.w_data = mem_wb_if.mem_wb_reg.rd_data;
    assign rf_if.rd = mem_wb_if.mem_wb_reg.rd;
    assign rf_if.wen = mem_wb_if.mem_wb_reg.reg_write; // && !hazard_if.ex_mem_stall; // TODO: The second signal only matters for some miniscule power reduction by not writing each cycle. This is correct with only the wen signal due to no loop from reg read to reg write
    assign rs1_data = rf_if.wen & rf_if.rd == rf_if.rs1 ? mem_wb_if.mem_wb_reg.rd_data : rf_if.rs1_data;
    assign rs2_data = rf_if.wen & rf_if.rd == rf_if.rs2 ? mem_wb_if.mem_wb_reg.rd_data : rf_if.rs2_data;

    always_ff @( posedge CLK, negedge nRST ) begin
        if (!nRST) begin
            decode_ex_if.decode_ex_reg <= '0;
        end else if (hazard_if.dc_ex_flush && !hazard_if.dc_ex_stall) begin
            decode_ex_if.decode_ex_reg <= '0;
        end else if (!hazard_if.dc_ex_flush && !hazard_if.dc_ex_stall) begin
            // Generated signals from CU
            decode_ex_if.decode_ex_reg.alu_op        <= cu_if.alu_op;
            decode_ex_if.decode_ex_reg.alu_a_sel     <= cu_if.alu_a_sel;
            decode_ex_if.decode_ex_reg.alu_b_sel     <= cu_if.alu_b_sel;
            decode_ex_if.decode_ex_reg.w_sel         <= cu_if.w_sel;
            decode_ex_if.decode_ex_reg.shamt         <= cu_if.shamt;
            decode_ex_if.decode_ex_reg.imm_I         <= cu_if.imm_I;
            decode_ex_if.decode_ex_reg.imm_S         <= cu_if.imm_S;
            decode_ex_if.decode_ex_reg.imm_UJ        <= cu_if.imm_UJ;
            decode_ex_if.decode_ex_reg.imm_SB        <= cu_if.imm_SB;
            decode_ex_if.decode_ex_reg.load_type     <= cu_if.load_type;
            decode_ex_if.decode_ex_reg.branch_type   <= cu_if.branch_type;
            decode_ex_if.decode_ex_reg.opcode        <= cu_if.opcode;

            // We do not want the to propagate on an illegal instruction
            if(!cu_if.illegal_insn) begin
                decode_ex_if.decode_ex_reg.dren           <= cu_if.dren;
                decode_ex_if.decode_ex_reg.dwen           <= cu_if.dwen;
                decode_ex_if.decode_ex_reg.j_sel          <= cu_if.j_sel;
                decode_ex_if.decode_ex_reg.branch         <= cu_if.branch;
                decode_ex_if.decode_ex_reg.jump           <= cu_if.jump;
                decode_ex_if.decode_ex_reg.ex_pc_sel      <= cu_if.ex_pc_sel;
                decode_ex_if.decode_ex_reg.imm_shamt_sel  <= cu_if.imm_shamt_sel;
                decode_ex_if.decode_ex_reg.halt           <= cu_if.halt;
                decode_ex_if.decode_ex_reg.reg_write      <= cu_if.wen;
                decode_ex_if.decode_ex_reg.ifence         <= cu_if.ifence;
                decode_ex_if.decode_ex_reg.sfence         <= cu_if.sfence;
                decode_ex_if.decode_ex_reg.csr_swap       <= cu_if.csr_swap;
                decode_ex_if.decode_ex_reg.csr_clr        <= cu_if.csr_clr;
                decode_ex_if.decode_ex_reg.csr_set        <= cu_if.csr_set;
                decode_ex_if.decode_ex_reg.csr_imm        <= cu_if.csr_imm;
                decode_ex_if.decode_ex_reg.csr_read_only  <= csr_read_only;
                decode_ex_if.decode_ex_reg.breakpoint     <= cu_if.breakpoint;
                decode_ex_if.decode_ex_reg.ecall_insn     <= cu_if.ecall_insn;
                decode_ex_if.decode_ex_reg.mret_insn      <= cu_if.mret_insn;
                decode_ex_if.decode_ex_reg.sret_insn      <= cu_if.sret_insn;
                decode_ex_if.decode_ex_reg.wfi_insn       <= cu_if.wfi;
                decode_ex_if.decode_ex_reg.reserve        <= cu_if.reserve;
                decode_ex_if.decode_ex_reg.exclusive      <= cu_if.exclusive;
                decode_ex_if.decode_ex_reg.was_compressed <= is_compressed;
                decode_ex_if.decode_ex_reg.prediction     <= fetch_decode_if.fetch_decode_reg.prediction;
            end

            // Privilege control signals
            decode_ex_if.decode_ex_reg.illegal_insn      <= cu_if.illegal_insn;
            decode_ex_if.decode_ex_reg.valid             <= fetch_decode_if.fetch_decode_reg.valid;
            decode_ex_if.decode_ex_reg.token             <= fetch_decode_if.fetch_decode_reg.token;
            decode_ex_if.decode_ex_reg.mal_insn          <= fetch_decode_if.fetch_decode_reg.mal_insn;
            decode_ex_if.decode_ex_reg.fault_insn        <= fetch_decode_if.fetch_decode_reg.fault_insn;
            decode_ex_if.decode_ex_reg.fault_insn_page   <= fetch_decode_if.fetch_decode_reg.fault_insn_page;
            decode_ex_if.decode_ex_reg.fault_addr        <= fetch_decode_if.fetch_decode_reg.fault_addr;
            decode_ex_if.decode_ex_reg.predicted_address <= fetch_decode_if.fetch_decode_reg.predicted_address;

            // Bit vectors
            decode_ex_if.decode_ex_reg.w_sel     <= cu_if.w_sel;
            decode_ex_if.decode_ex_reg.zimm      <= cu_if.zimm;
            decode_ex_if.decode_ex_reg.load_type <= cu_if.load_type;
            decode_ex_if.decode_ex_reg.csr_addr  <= cu_if.csr_addr;

            // Extension control signals
            decode_ex_if.decode_ex_reg.rv32m_control <= cu_if.rv32m_control;
            decode_ex_if.decode_ex_reg.rv32b_control <= cu_if.rv32b_control;
            decode_ex_if.decode_ex_reg.rv32a_control <= cu_if.rv32a_control;
            decode_ex_if.decode_ex_reg.rv32zc_control <= cu_if.rv32zc_control;

            // Word sized members
            decode_ex_if.decode_ex_reg.pc    <= fetch_decode_if.fetch_decode_reg.pc;
            decode_ex_if.decode_ex_reg.pc4   <= fetch_decode_if.fetch_decode_reg.pc4;
            decode_ex_if.decode_ex_reg.instr <= cu_if.instr;
            decode_ex_if.decode_ex_reg.imm_U <= cu_if.imm_U;

            // Reg file signals
            decode_ex_if.decode_ex_reg.rs1 <= rf_if.rs1;
            decode_ex_if.decode_ex_reg.rs2 <= rf_if.rs2;
            decode_ex_if.decode_ex_reg.rd  <= cu_if.rd;
            decode_ex_if.decode_ex_reg.rs1_data <= rs1_data;
            decode_ex_if.decode_ex_reg.rs2_data <= rs2_data;
        end
    end
endmodule
