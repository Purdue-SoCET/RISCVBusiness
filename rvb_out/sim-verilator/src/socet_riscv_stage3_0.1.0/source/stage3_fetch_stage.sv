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
`include "rv32c_if.vh"
`include "prv_pipeline_if.vh"

module stage3_fetch_stage (
    input logic CLK,
    nRST,
    stage3_fetch_execute_if.fetch fetch_ex_if,
    stage3_mem_pipe_if.fetch mem_fetch_if,
    stage3_hazard_unit_if.fetch hazard_if,
    predictor_pipeline_if.access predict_if,
    generic_bus_if.cpu igen_bus_if,
    sparce_pipeline_if.pipe_fetch sparce_if,
    rv32c_if.fetch rv32cif,
    prv_pipeline_if.fetch prv_pipe_if
);
    import rv32i_types_pkg::*;
    import pma_types_1_12_pkg::*;

    parameter logic [31:0] RESET_PC = 32'h80000000;

    word_t pc, pc4or2, npc, instr;

    //PC logic

    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) begin
            pc <= RESET_PC;
        end else if (hazard_if.pc_en | rv32cif.done_earlier) begin
            pc <= npc;
        end
    end

    //RV32C
    assign rv32cif.inst = igen_bus_if.rdata;
    assign rv32cif.inst_arrived = hazard_if.if_ex_flush == 0 & hazard_if.if_ex_stall == 0;
    assign rv32cif.reset_en = hazard_if.insert_priv_pc | hazard_if.rollback | sparce_if.skipping
                              | hazard_if.npc_sel | predict_if.predict_taken;
    assign rv32cif.pc_update = hazard_if.pc_en;
    assign rv32cif.reset_pc = hazard_if.insert_priv_pc  ? hazard_if.priv_pc
                            : (hazard_if.rollback        ? mem_fetch_if.pc4
                            : (sparce_if.skipping       ? sparce_if.sparce_target
                            : (hazard_if.npc_sel        ? mem_fetch_if.brj_addr
                            : (predict_if.predict_taken ? predict_if.target_addr
                            : pc4or2))));
    assign rv32cif.reset_pc_val = RESET_PC;

    assign pc4or2 = (rv32cif.rv32c_ena & (rv32cif.result[1:0] != 2'b11)) ? (pc + 2) : (pc + 4);
    assign predict_if.current_pc = pc;
    assign npc = hazard_if.insert_priv_pc    ? hazard_if.priv_pc
                 : (hazard_if.rollback        ? mem_fetch_if.pc4
                 : (sparce_if.skipping       ? sparce_if.sparce_target
                 : (hazard_if.npc_sel        ? mem_fetch_if.brj_addr
                 : (predict_if.predict_taken ? predict_if.target_addr
                 : rv32cif.rv32c_ena         ? rv32cif.nextpc
                 : pc4or2))));

    //Instruction Access logic
    assign hazard_if.i_mem_busy = igen_bus_if.busy;
    assign igen_bus_if.addr = rv32cif.rv32c_ena ? rv32cif.imem_pc : pc;
    assign igen_bus_if.ren = hazard_if.iren && !rv32cif.done_earlier && !hazard_if.suppress_iren;
    assign igen_bus_if.wen = 1'b0;
    assign igen_bus_if.byte_en = 4'b1111;
    assign igen_bus_if.wdata = '0;

    //Send exceptions through pipeline
    logic mal_addr;
    logic fault_insn;
    logic mal_insn;
    word_t badaddr;

    assign mal_addr = (igen_bus_if.addr[1:0] != 2'b00);
    assign fault_insn = 1'b0;
    assign mal_insn = mal_addr;
    assign badaddr = igen_bus_if.addr;
    assign hazard_if.pc_f = pc;
    assign hazard_if.rv32c_ready = rv32cif.done_earlier && rv32cif.rv32c_ena; // TODO: Is rv32cif.done needed? Seems like it coincides with busy = 0


    //Fetch Execute Pipeline Signals
    word_t instr_to_ex;
    assign instr_to_ex = rv32cif.rv32c_ena ? rv32cif.result : igen_bus_if.rdata;
    always_ff @(posedge CLK, negedge nRST) begin
        if (!nRST) fetch_ex_if.fetch_ex_reg <= '0;
        else if (hazard_if.if_ex_flush && !hazard_if.if_ex_stall) fetch_ex_if.fetch_ex_reg <= '0;
        else if (!hazard_if.if_ex_stall) begin
            fetch_ex_if.fetch_ex_reg.valid      <= 1'b1;
            fetch_ex_if.fetch_ex_reg.token      <= 1'b1;
            fetch_ex_if.fetch_ex_reg.mal_insn   <= mal_insn;
            fetch_ex_if.fetch_ex_reg.fault_insn <= fault_insn;
            fetch_ex_if.fetch_ex_reg.badaddr    <= badaddr;
            fetch_ex_if.fetch_ex_reg.pc         <= pc;
            fetch_ex_if.fetch_ex_reg.pc4        <= pc4or2;
            fetch_ex_if.fetch_ex_reg.instr      <= instr_to_ex;
            fetch_ex_if.fetch_ex_reg.prediction <= predict_if.predict_taken; // TODO: This is just wrong...
        end
    end


    // Send memory protection signals
    assign prv_pipe_if.iren = hazard_if.iren;
    assign prv_pipe_if.iaddr = igen_bus_if.addr;
    assign prv_pipe_if.i_acc_width = WordAcc;

    // Choose the endianness of the data coming into the processor
    generate
        if (BUS_ENDIANNESS == "big") assign instr = igen_bus_if.rdata;
        else if (BUS_ENDIANNESS == "little")
            endian_swapper ltb_endian (
                .word_in(igen_bus_if.rdata),
                .word_out(instr)
            );
    endgenerate

    /*********************************************************
      *** SparCE Module Logic
      *********************************************************/

    assign sparce_if.pc = pc;
    assign sparce_if.rdata = igen_bus_if.rdata;
endmodule


