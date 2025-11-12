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
*   Filename:     stage3_fetch_stage.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 06/19/2016
*   Description:  Fetch stage for the two stage pipeline
*/

`include "stage3_fetch_execute_if.vh"
`include "stage3_hazard_unit_if.vh"
`include "predictor_pipeline_if.vh"
`include "generic_bus_if.vh"
`include "component_selection_defines.vh"
`include "cache_control_if.vh"
`include "prv_pipeline_if.vh"

module stage3_fetch_stage (
    input logic CLK,
    nRST,
    stage3_fetch_execute_if.fetch fetch_ex_if,
    stage3_mem_pipe_if.fetch mem_fetch_if,
    stage3_hazard_unit_if.fetch hazard_if,
    predictor_pipeline_if.access predict_if,
    generic_bus_if.cpu igen_bus_if,
    prv_pipeline_if.fetch prv_pipe_if
);
    import rv32i_types_pkg::*;
    import pma_types_pkg::*;

    parameter logic [31:0] RESET_PC = 32'h80000000;

    word_t pc, pc4or2, npc, instr;
    logic ireq;
    logic insn_ready, insn_compressed, ibus_fault;
    word_t instr_to_ex;
    word_t insn_addr;
    
    //Send exceptions through pipeline
    logic mal_addr;
    logic fault_insn;
    logic mal_insn;
    word_t fault_addr;

    // predictor
    logic is_branch, is_compressed_branch;


    //PC logic
    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) begin
            pc <= RESET_PC;
        end else if (hazard_if.pc_en) begin
            pc <= npc;
        end
    end
    
    assign pc4or2 = insn_compressed ? pc + 2 : pc + 4;
    
    //Branch Predictor logic
    localparam logic [15:0] CBRANCH_MASK = 16'hc001;
    sbtype_t instr_sb;
    assign is_branch = !insn_compressed && instr_sb.opcode == BRANCH;
    assign is_compressed_branch = insn_compressed && ((instr_to_ex[15:0] & CBRANCH_MASK) == CBRANCH_MASK);
    assign predict_if.current_pc = pc;
    assign instr_sb = sbtype_t'(instr_to_ex);
    assign predict_if.instr = instr_to_ex;
    assign predict_if.imm_sb = {instr_sb.imm12, instr_sb.imm11, instr_sb.imm10_05, instr_sb.imm04_01, 1'b0};
    assign predict_if.is_branch = is_branch || is_compressed_branch;
    assign predict_if.is_jump = ((instr_sb.opcode == JAL) || (instr_sb.opcode == JALR)) ? 1:0;

    // pc_redirect used to invalidate fetch buffer for RV32C
    assign pc_redirect = hazard_if.insert_priv_pc || hazard_if.rollback || hazard_if.npc_sel || predict_if.predict_taken;
    assign npc = hazard_if.insert_priv_pc    ? hazard_if.priv_pc
                 : (hazard_if.rollback       ? mem_fetch_if.pc4
                 : (hazard_if.npc_sel        ? mem_fetch_if.brj_addr
                 : (predict_if.predict_taken ? predict_if.target_addr
                 : pc4or2)));

    // Instruction Access logic
    assign ireq = hazard_if.iren && !hazard_if.suppress_iren;

`ifdef RV32C_SUPPORTED
    localparam int RVC = 1;
`else
    localparam int RVC = 0;
`endif

    fetch_unit #(.RVC_ENABLED(RVC)) FETCHER(
        .CLK,
        .nRST,
        .ireq,
        .stall(hazard_if.if_ex_stall),
        .pc_redirect,
        .pc,
        .insn_ready,
        .insn_compressed,
        .insn_fault(ibus_fault),
        .mal_addr,
        .insn_out(instr_to_ex),
        .insn_addr,
        .igen_bus_if
    );

    // protection faults require the actual address, 
    // not the address of the instruction (may be different
    // for C-extension)
    assign fault_addr = insn_addr;
    assign hazard_if.i_mem_busy = !insn_ready && !fault_insn;
    assign hazard_if.fault_addr_fetch = fault_addr; // used for instruction page fault handling
    assign fault_insn = prv_pipe_if.prot_fault_i || ibus_fault; // TODO: Set this up to fault on bus error
    assign mal_insn = mal_addr;
    assign hazard_if.pc_f = pc;

    //Fetch Execute Pipeline Signals
    always_ff @(posedge CLK, negedge nRST) begin
        if (!nRST) fetch_ex_if.fetch_ex_reg <= '0;
        else if (hazard_if.if_ex_flush && !hazard_if.if_ex_stall) fetch_ex_if.fetch_ex_reg <= '0;
        else if (!hazard_if.if_ex_stall) begin
            if(mal_insn || fault_insn) begin
                // Squash to NOP if exception
                // Still valid for exception handling
                fetch_ex_if.fetch_ex_reg.instr <= '0;
            end else begin
                fetch_ex_if.fetch_ex_reg.instr      <= instr_to_ex;
            end
            fetch_ex_if.fetch_ex_reg.valid      <= 1'b1;
            fetch_ex_if.fetch_ex_reg.token      <= 1'b1;
            fetch_ex_if.fetch_ex_reg.mal_insn   <= mal_insn;
            fetch_ex_if.fetch_ex_reg.fault_insn <= fault_insn;
            fetch_ex_if.fetch_ex_reg.fault_addr <= fault_addr;
            fetch_ex_if.fetch_ex_reg.pc         <= pc;
            fetch_ex_if.fetch_ex_reg.pc4        <= pc4or2;
            fetch_ex_if.fetch_ex_reg.prediction <= predict_if.predict_taken; // TODO: This is just wrong...
            fetch_ex_if.fetch_ex_reg.predicted_address <= predict_if.target_addr;
        end
    end

    // Send memory protection signals
    assign prv_pipe_if.iren = ~prv_pipe_if.itlb_miss & hazard_if.iren;
    assign prv_pipe_if.iaddr = insn_addr;
    assign prv_pipe_if.i_acc_width = WordAcc;
    assign prv_pipe_if.pc_redirect = pc_redirect;

    // Choose the endianness of the data coming into the processor
    generate
        if (BUS_ENDIANNESS == "big") assign instr = igen_bus_if.rdata;
        else if (BUS_ENDIANNESS == "little")
            endian_swapper ltb_endian (
                .word_in(igen_bus_if.rdata),
                .word_out(instr)
            );
    endgenerate
endmodule
