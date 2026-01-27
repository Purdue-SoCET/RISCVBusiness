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
*   Filename:     stage5_execute_stage.sv
*
*   Created by:   William Cunningham
*   Email:        wrcunnin@purdue.edu
*   Date Created: 01/26/2026
*   Description:  Execute Stage for the Five Stage Pipeline
*/

`include "stage5_decode_execute_if.vh"
`include "stage5_execute_mem_if.vh"
`include "stage5_hazard_unit_if.vh"
`include "stage5_forwarding_unit_if.vh"
`include "control_unit_if.vh"
`include "component_selection_defines.vh"
`include "rv32i_reg_file_if.vh"
`include "alu_if.vh"
`include "branch_res_if.vh"
`include "jump_calc_if.vh"

module stage5_execute_stage (
    input CLK,
    input nRST,
    stage5_decode_execute_if.execute decode_ex_if,
    stage5_execute_mem_if.execute ex_mem_if,
    stage5_hazard_unit_if.execute hazard_if,
    stage5_forwarding_unit_if.execute fw_if
);
    import rv32i_types_pkg::*;
    import pma_types_pkg::*;
    import stage5_types_pkg::*;

    // Interface declarations
    alu_if alu_if ();
    jump_calc_if jump_if ();
    branch_res_if branch_if ();

    /******************
    * Functional Units
    *******************/
    logic rv32m_done;
    logic rv32b_done;
    logic rv32zc_done;
    word_t rv32m_out;
    word_t rv32b_out;
    word_t rv32zc_out;
    word_t ex_out;
    word_t rs1_post_fwd, rs2_post_fwd;

    alu alu (.*);
    jump_calc jump_calc (.*);
    branch_res branch_res (.br_if(branch_if));

    rv32m_wrapper RV32M_FU (
        .CLK(CLK),
        .nRST(nRST),
        .rv32m_start(decode_ex_if.decode_ex_reg.rv32m_control.select),
        .operation(decode_ex_if.decode_ex_reg.rv32m_control.op), // TODO: Better way?
        .rv32m_a(rs1_post_fwd), // All RV32M are reg-reg, so just feed post-fwd regs
        .rv32m_b(rs2_post_fwd),
        .rv32m_done(rv32m_done),
        .rv32m_out(rv32m_out)
    );

    rv32b_wrapper RV32B_FU(
        .rv32b_a(alu_if.port_a),
        .rv32b_b(alu_if.port_b),
        .operation(decode_ex_if.decode_ex_reg.rv32b_control.op),
        .rv32b_done(rv32b_done),
        .rv32b_out(rv32b_out)
    );

    rv32zc_wrapper RV32ZC_FU(
        .rv32zc_a(alu_if.port_a),
        .rv32zc_b(alu_if.port_b),
        .operation(decode_ex_if.decode_ex_reg.rv32zc_control.op),
        .rv32zc_done(rv32zc_done),
        .rv32zc_out(rv32zc_out)
    );

    // Forwarding
    // These rs*_post_fwd values should be used in place of rs1/rs2 anywhere they are used
    always_comb begin
        casez (fw_if.fwd_rs1_2ex)
            2'b?1: rs1_post_fwd = fw_if.rd_m_data;
            2'b10: rs1_post_fwd = fw_if.rd_wb_data;
            default: rs1_post_fwd = decode_ex_if.decode_ex_reg.rs1_data;
        endcase

        casez (fw_if.fwd_rs2_2ex)
            2'b?1: rs2_post_fwd = fw_if.rd_m_data;
            2'b10: rs2_post_fwd = fw_if.rd_wb_data;
            default: rs2_post_fwd = decode_ex_if.decode_ex_reg.rs2_data;
        endcase
    end

    /******************
    * Sign Extensions
    ******************/
    word_t imm_I_ext, imm_S_ext, imm_UJ_ext;
    assign imm_I_ext  = {{20{decode_ex_if.decode_ex_reg.imm_I[11]}}, decode_ex_if.decode_ex_reg.imm_I};
    assign imm_UJ_ext = {{11{decode_ex_if.decode_ex_reg.imm_UJ[20]}}, decode_ex_if.decode_ex_reg.imm_UJ};
    assign imm_S_ext  = {{20{decode_ex_if.decode_ex_reg.imm_S[11]}}, decode_ex_if.decode_ex_reg.imm_S};

    /**********************************************
    * Jump Target Calculator and Associated Logic
    **********************************************/
    word_t jump_addr  /* verilator isolate_assignments */;
    always_comb begin
        if (decode_ex_if.decode_ex_reg.j_sel) begin
            jump_if.base = decode_ex_if.decode_ex_reg.pc;
            jump_if.offset = imm_UJ_ext;
            jump_addr = jump_if.jal_addr;
        end else begin
            jump_if.base = rs1_post_fwd;
            jump_if.offset = imm_I_ext;
            jump_addr = jump_if.jalr_addr;
        end
    end

    /*****
    * ALU
    *****/
    word_t imm_or_shamt;
    assign imm_or_shamt = (decode_ex_if.decode_ex_reg.imm_shamt_sel == 1'b1) ?
        decode_ex_if.decode_ex_reg.shamt : imm_I_ext;
    assign alu_if.aluop = decode_ex_if.decode_ex_reg.alu_op;
    logic mal_addr;

    always_comb begin
        case (decode_ex_if.decode_ex_reg.alu_a_sel)
            2'd0: alu_if.port_a = rs1_post_fwd;
            2'd1: alu_if.port_a = imm_S_ext;
            2'd2: alu_if.port_a = decode_ex_if.decode_ex_reg.pc;
            2'd3: alu_if.port_a = '0;  //Not Used
        endcase
    end

    always_comb begin
        casez ({decode_ex_if.decode_ex_reg.alu_b_sel, decode_ex_if.decode_ex_reg.reserve})
            {2'd?, 1'b1}: alu_if.port_b = '0;
            {2'd0, 1'b0}: alu_if.port_b = rs1_post_fwd;
            {2'd1, 1'b0}: alu_if.port_b = rs2_post_fwd;
            {2'd2, 1'b0}: alu_if.port_b = imm_or_shamt;
            {2'd3, 1'b0}: alu_if.port_b = decode_ex_if.decode_ex_reg.imm_U;
        endcase
    end

    // FU output mux -- feeds into pipeline register
    // Add to this when more FUs are added
    always_comb begin
        if(decode_ex_if.decode_ex_reg.rv32m_control.select) begin
            ex_out = rv32m_out;
        end else if(decode_ex_if.decode_ex_reg.rv32b_control.select) begin
            ex_out = rv32b_out;
        end else if(decode_ex_if.decode_ex_reg.rv32zc_control.select) begin
            ex_out = rv32zc_out;
        end else begin
            ex_out = alu_if.port_out;
        end
    end

    /***********************************************
    * Branch Target Resolution and Associated Logic
    ***********************************************/
    word_t resolved_addr;
    logic  branch_taken;
    word_t branch_addr;
    word_t brj_addr;

    assign branch_if.rs1_data = rs1_post_fwd;
    assign branch_if.rs2_data = rs2_post_fwd;
    assign branch_if.pc = decode_ex_if.decode_ex_reg.pc;
    assign branch_if.imm_sb = decode_ex_if.decode_ex_reg.imm_SB;
    assign branch_if.branch_type = decode_ex_if.decode_ex_reg.branch_type;

    // Mux resource based on if RISC-MGMT is trying to access it
    assign branch_taken = branch_if.branch_taken;//rm_if.req_br_j ? rm_if.branch_jump : branch_if.branch_taken;
    assign branch_addr = branch_if.branch_addr;//rm_if.req_br_j ? rm_if.br_j_addr : branch_if.branch_addr;
    //assign rm_if.pc = decode_ex_if.decode_ex_reg.pc;

    assign resolved_addr = branch_if.branch_taken ? branch_addr : decode_ex_if.decode_ex_reg.pc4;
    assign brj_addr = decode_ex_if.decode_ex_reg.ex_pc_sel ? jump_addr : resolved_addr;
    //assign brj_addr = ((decode_ex_if.decode_ex_reg.ex_pc_sel == 1'b1) && ~rm_if.req_br_j) ?
    //                        jump_addr : resolved_addr;

    //assign hazard_if.mispredict = decode_ex_if.decode_ex_reg.prediction ^ branch_taken;

    /********************************
    * Hazard/Forwarding Unit Signals
    *********************************/
    logic csr_read;
    assign csr_read = decode_ex_if.decode_ex_reg.csr_swap | decode_ex_if.decode_ex_reg.csr_clr | decode_ex_if.decode_ex_reg.csr_set;
    assign fw_if.rs1_e = decode_ex_if.decode_ex_reg.rs1;
    assign fw_if.rs2_e = decode_ex_if.decode_ex_reg.rs2;

    assign hazard_if.rs1_e = decode_ex_if.decode_ex_reg.rs1;
    assign hazard_if.rs2_e = decode_ex_if.decode_ex_reg.rs2;
    assign hazard_if.rd_e = decode_ex_if.decode_ex_reg.rd;
    assign hazard_if.pc_e = decode_ex_if.decode_ex_reg.pc;
    assign hazard_if.cannot_forward_e = decode_ex_if.decode_ex_reg.dren || (decode_ex_if.decode_ex_reg.dwen && decode_ex_if.decode_ex_reg.reserve) || csr_read;
    assign hazard_if.ex_busy = (!rv32m_done && decode_ex_if.decode_ex_reg.rv32m_control.select)
                            || (!rv32b_done && decode_ex_if.decode_ex_reg.rv32b_control.select)
                            || (!rv32zc_done && decode_ex_if.decode_ex_reg.rv32zc_control.select); // Add & conditions here for other FUs that can stall
    assign hazard_if.valid_e = decode_ex_if.decode_ex_reg.valid;

    // TODO: NEW
    always_ff @(posedge CLK, negedge nRST) begin
        if(!nRST) begin
            ex_mem_if.ex_mem_reg <= '{default: '0};
        end else if(hazard_if.ex_mem_flush && !hazard_if.ex_mem_stall) begin
            ex_mem_if.ex_mem_reg <= '0;
        end else if(!hazard_if.ex_mem_flush && !hazard_if.ex_mem_stall)begin
            // TODO: This register is LARGE. Not awful, but can it be smaller?
            // PS: Does it even matter? Synth. tools may be able to merge regs.
            // TODO: Handle case of exceptions earlier in the pipe being passed on to handle in the last stage
            // Single bit control signals -- squash these if we have an exception
            // Only need to check illegal since it's the only "new" exception we have
            ex_mem_if.ex_mem_reg.valid              <= decode_ex_if.decode_ex_reg.valid;
            if(!decode_ex_if.decode_ex_reg.illegal_insn) begin
                ex_mem_if.ex_mem_reg.branch         <= decode_ex_if.decode_ex_reg.branch;
                ex_mem_if.ex_mem_reg.prediction     <= decode_ex_if.decode_ex_reg.prediction;
                ex_mem_if.ex_mem_reg.branch_taken   <= branch_if.branch_taken;
                ex_mem_if.ex_mem_reg.dren           <= decode_ex_if.decode_ex_reg.dren;
                ex_mem_if.ex_mem_reg.dwen           <= decode_ex_if.decode_ex_reg.dwen;
                ex_mem_if.ex_mem_reg.reg_write      <= decode_ex_if.decode_ex_reg.reg_write;
                ex_mem_if.ex_mem_reg.ifence         <= decode_ex_if.decode_ex_reg.ifence;
                ex_mem_if.ex_mem_reg.sfence         <= decode_ex_if.decode_ex_reg.sfence;
                ex_mem_if.ex_mem_reg.jump           <= decode_ex_if.decode_ex_reg.jump;
                ex_mem_if.ex_mem_reg.halt           <= decode_ex_if.decode_ex_reg.halt;
                ex_mem_if.ex_mem_reg.csr_swap       <= decode_ex_if.decode_ex_reg.csr_swap;
                ex_mem_if.ex_mem_reg.csr_clr        <= decode_ex_if.decode_ex_reg.csr_clr;
                ex_mem_if.ex_mem_reg.csr_set        <= decode_ex_if.decode_ex_reg.csr_set;
                ex_mem_if.ex_mem_reg.csr_imm        <= decode_ex_if.decode_ex_reg.csr_imm;
                ex_mem_if.ex_mem_reg.csr_read_only  <= decode_ex_if.decode_ex_reg.csr_read_only;
                ex_mem_if.ex_mem_reg.breakpoint     <= decode_ex_if.decode_ex_reg.breakpoint;
                ex_mem_if.ex_mem_reg.ecall_insn     <= decode_ex_if.decode_ex_reg.ecall_insn;
                ex_mem_if.ex_mem_reg.mret_insn      <= decode_ex_if.decode_ex_reg.mret_insn;
                ex_mem_if.ex_mem_reg.sret_insn      <= decode_ex_if.decode_ex_reg.sret_insn;
                ex_mem_if.ex_mem_reg.wfi_insn       <= decode_ex_if.decode_ex_reg.wfi_insn;
                ex_mem_if.ex_mem_reg.was_compressed <= decode_ex_if.decode_ex_reg.was_compressed;
                ex_mem_if.ex_mem_reg.reserve        <= decode_ex_if.decode_ex_reg.reserve;
                ex_mem_if.ex_mem_reg.exclusive      <= decode_ex_if.decode_ex_reg.exclusive;
            end
            ex_mem_if.ex_mem_reg.illegal_insn      <= decode_ex_if.decode_ex_reg.illegal_insn;
            ex_mem_if.ex_mem_reg.fault_addr        <= decode_ex_if.decode_ex_reg.fault_addr;
            ex_mem_if.ex_mem_reg.mal_insn          <= decode_ex_if.decode_ex_reg.mal_insn;
            ex_mem_if.ex_mem_reg.fault_insn        <= decode_ex_if.decode_ex_reg.fault_insn;
            ex_mem_if.ex_mem_reg.fault_insn_page   <= decode_ex_if.decode_ex_reg.fault_insn_page;
            ex_mem_if.ex_mem_reg.predicted_address <= decode_ex_if.decode_ex_reg.predicted_address;

            // Bit vectors
            ex_mem_if.ex_mem_reg.w_sel      <= decode_ex_if.decode_ex_reg.w_sel;
            ex_mem_if.ex_mem_reg.zimm       <= decode_ex_if.decode_ex_reg.zimm;
            ex_mem_if.ex_mem_reg.rs1        <= decode_ex_if.decode_ex_reg.rs1;
            ex_mem_if.ex_mem_reg.rs2        <= decode_ex_if.decode_ex_reg.rs2;
            ex_mem_if.ex_mem_reg.rd         <= decode_ex_if.decode_ex_reg.rd;
            ex_mem_if.ex_mem_reg.load_type  <= decode_ex_if.decode_ex_reg.load_type;
            ex_mem_if.ex_mem_reg.csr_addr   <= decode_ex_if.decode_ex_reg.csr_addr;

            // Word sized members
            ex_mem_if.ex_mem_reg.brj_addr   <= brj_addr;
            ex_mem_if.ex_mem_reg.port_out   <= ex_out;
            ex_mem_if.ex_mem_reg.rs1_data   <= rs1_post_fwd;
            ex_mem_if.ex_mem_reg.rs2_data   <= rs2_post_fwd;
            ex_mem_if.ex_mem_reg.instr      <= decode_ex_if.decode_ex_reg.instr;
            ex_mem_if.ex_mem_reg.pc         <= decode_ex_if.decode_ex_reg.pc;
            ex_mem_if.ex_mem_reg.pc4        <= decode_ex_if.decode_ex_reg.pc4;
            ex_mem_if.ex_mem_reg.imm_U      <= decode_ex_if.decode_ex_reg.imm_U;

            // CPU Tracker
            ex_mem_if.ex_mem_reg.tracker_signals.opcode <= decode_ex_if.decode_ex_reg.opcode;
            ex_mem_if.ex_mem_reg.tracker_signals.imm_SB <= decode_ex_if.decode_ex_reg.imm_SB;
            ex_mem_if.ex_mem_reg.tracker_signals.imm_S  <= decode_ex_if.decode_ex_reg.imm_S;
            ex_mem_if.ex_mem_reg.tracker_signals.imm_I  <= decode_ex_if.decode_ex_reg.imm_I;
            ex_mem_if.ex_mem_reg.tracker_signals.imm_UJ <= decode_ex_if.decode_ex_reg.imm_UJ;
            ex_mem_if.ex_mem_reg.tracker_signals.imm_U  <= decode_ex_if.decode_ex_reg.imm_U;
        end
    end
endmodule
