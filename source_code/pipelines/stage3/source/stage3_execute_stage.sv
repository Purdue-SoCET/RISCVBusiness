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
*   Filename:     stage3_execute_stage.sv
*
*   Created by:   Jacob R. Stevens
*   Email:        steven69@purdue.edu
*   Date Created: 06/16/2016
*   Description:  Execute Stage for the Two Stage Pipeline
*/

`include "stage3_fetch_execute_if.vh"
`include "stage3_hazard_unit_if.vh"
`include "stage3_forwarding_unit_if.vh"
`include "control_unit_if.vh"
`include "component_selection_defines.vh"
`include "rv32i_reg_file_if.vh"
`include "alu_if.vh"
//`include "prv_pipeline_if.vh"
//`include "risc_mgmt_if.vh"
`include "rv32c_if.vh"
import stage3_types_pkg::*;
import rv32i_types_pkg::*;

module stage3_execute_stage (
    input CLK,
    input nRST,

    // stage3_fetch_execute_if.execute fetch_ex_if,
    input uop_t uop_out, 
    stage3_mem_pipe_if.execute ex_mem_if,
    stage3_hazard_unit_if.execute hazard_if,
    stage3_forwarding_unit_if.execute fw_if,
    //risc_mgmt_if.ts_execute rm_if,
    sparce_pipeline_if.pipe_execute sparce_if,
    rv32c_if.execute rv32cif
);

    import rv32i_types_pkg::*;
    import pma_types_1_12_pkg::*;
    import stage3_types_pkg::*;

    // Interface declarations
    control_unit_if cu_if ();
    rv32i_reg_file_if rf_if ();
    alu_if alu_if ();
    jump_calc_if jump_if ();
    branch_res_if branch_if ();

    assign rf_if.rs1 = uop_out.ctrl_out.rs1; 
    assign rf_if.rs2 = uop_out.ctrl_out.rs2; 


    /**********************
    * Decode/Register Read 
    ***********************/

    // // RV32C inputs
    // assign rv32cif.inst16 = fetch_ex_if.fetch_ex_reg.instr[15:0];
    // assign rv32cif.halt = 1'b0; // TODO: Is this signal necessary? Can't get it right on decode of a halt instruction
    // assign rv32cif.ex_busy = hazard_if.ex_mem_stall; //cu_if.dren | cu_if.dwen | rm_if.risc_mgmt_start;
    // assign cu_if.instr = rv32cif.c_ena ? rv32cif.inst32 : fetch_ex_if.fetch_ex_reg.instr;
    // //assign rm_if.insn = rv32cif.c_ena ? rv32cif.inst32 : fetch_ex_if.fetch_ex_reg.instr;

    // // Control unit, inputs are post-decompression
    // control_unit cu (
    //     .cu_if(cu_if),
    //     .rf_if(rf_if),
    //     .rmgmt_rsel_s_0('0),
    //     .rmgmt_rsel_s_1('0),
    //     .rmgmt_rsel_d('0),
    //     .rmgmt_req_reg_r('0),
    //     .rmgmt_req_reg_w('0)
    //     //.rmgmt_rsel_s_0(rm_if.rsel_s_0),
    //     //.rmgmt_rsel_s_1(rm_if.rsel_s_1),
    //     //.rmgmt_rsel_d(rm_if.rsel_d),
    //     //.rmgmt_req_reg_r(rm_if.req_reg_r),
    //     //.rmgmt_req_reg_w(rm_if.req_reg_w)
    // );

    assign wfi = uop_out.ctrl_out.wfi;  //Added by rkannank

    generate
        if (BASE_ISA == "RV32E") begin : g_rfile_select
            rv32e_reg_file rf (
                .CLK,
                .nRST,
                .rf_if
            );
        end else begin : g_rfile_select
            rv32i_reg_file rf (
                .CLK,
                .nRST,
                .rf_if
            );
        end
    endgenerate


    /******************
    * Functional Units
    *******************/
    logic rv32m_busy;
    word_t rv32m_out;
    word_t ex_out;
    word_t rs1_post_fwd, rs2_post_fwd;

    alu alu (.*);
    jump_calc jump_calc (.*);
    branch_res branch_res (.br_if(branch_if));

    rv32m_wrapper RV32M_FU (
        .CLK,
        .nRST,
        .rv32m_start(uop_out.ctrl_out.rv32m_control.select),
        .operation(uop_out.ctrl_out.rv32m_control.op), // TODO: Better way?
        .rv32m_a(rs1_post_fwd), // All RV32M are reg-reg, so just feed post-fwd regs
        .rv32m_b(rs2_post_fwd),
        .rv32m_busy,
        .rv32m_out
    );

    // Forwarding
    // These rs*_post_fwd values should be used in place of rs1/rs2 anywhere they are used
    assign rs1_post_fwd = fw_if.fwd_rs1 ? fw_if.rd_mem_data : rf_if.rs1_data;
    assign rs2_post_fwd = fw_if.fwd_rs2 ? fw_if.rd_mem_data : rf_if.rs2_data;


    /******************
    * Sign Extensions
    ******************/
    word_t imm_I_ext, imm_S_ext, imm_UJ_ext;
    assign imm_I_ext  = {{20{uop_out.ctrl_out.imm_I[11]}}, uop_out.ctrl_out.imm_I};
    assign imm_UJ_ext = {{11{uop_out.ctrl_out.imm_UJ[20]}}, uop_out.ctrl_out.imm_UJ};
    assign imm_S_ext  = {{20{uop_out.ctrl_out.imm_S[11]}}, uop_out.ctrl_out.imm_S};

    /**********************************************
    * Jump Target Calculator and Associated Logic
    **********************************************/
    word_t jump_addr  /* verilator isolate_assignments */;
    always_comb begin
        if (uop_out.ctrl_out.j_sel) begin
            jump_if.base = uop_out.if_out.pc;
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
    assign imm_or_shamt = (uop_out.ctrl_out.imm_shamt_sel == 1'b1) ? uop_out.ctrl_out.shamt : imm_I_ext;
    assign alu_if.aluop = uop_out.ctrl_out.alu_op;
    logic mal_addr;

    always_comb begin
        case (uop_out.ctrl_out.alu_a_sel)
            2'd0: alu_if.port_a = rs1_post_fwd;
            2'd1: alu_if.port_a = imm_S_ext;
            2'd2: alu_if.port_a = uop_out.if_out.pc;
            2'd3: alu_if.port_a = '0;  //Not Used
        endcase
    end

    always_comb begin
        case (uop_out.ctrl_out.alu_b_sel)
            2'd0: alu_if.port_b = rs1_post_fwd;
            2'd1: alu_if.port_b = rs2_post_fwd;
            2'd2: alu_if.port_b = imm_or_shamt;
            2'd3: alu_if.port_b = uop_out.ctrl_out.imm_U;
        endcase
    end


    // FU output mux -- feeds into pipeline register
    // Add to this when more FUs are added
    // TODO: Make this nicer, with enum for FU selection
    assign ex_out = (uop_out.ctrl_out.rv32m_control.select) ? rv32m_out : alu_if.port_out;

    /*************************
    * Register File Writeback
    *************************/
    assign rf_if.w_data = ex_mem_if.reg_wdata;
    assign rf_if.rd = ex_mem_if.rd_m;
    assign rf_if.wen = ex_mem_if.reg_write && !hazard_if.ex_mem_stall; // TODO: The second signal only matters for some miniscule power reduction by not writing each cycle. This is correct with only the wen signal due to no loop from reg read to reg write

    /***********************************************
    * Branch Target Resolution and Associated Logic
    ***********************************************/
    word_t resolved_addr;
    logic  branch_taken;
    word_t branch_addr;
    word_t brj_addr;

    assign branch_if.rs1_data = rs1_post_fwd;//rf_if.rs1_data;
    assign branch_if.rs2_data = rs2_post_fwd; //rf_if.rs2_data;
    assign branch_if.pc = uop_out.if_out.pc;
    assign branch_if.imm_sb = uop_out.ctrl_out.imm_SB;
    assign branch_if.branch_type = uop_out.ctrl_out.branch_type;

    // Mux resource based on if RISC-MGMT is trying to access it
    assign branch_taken = branch_if.branch_taken;//rm_if.req_br_j ? rm_if.branch_jump : branch_if.branch_taken;
    assign branch_addr = branch_if.branch_addr;//rm_if.req_br_j ? rm_if.br_j_addr : branch_if.branch_addr;
    //assign rm_if.pc = fetch_ex_if.fetch_ex_reg.pc;

    assign resolved_addr = branch_if.branch_taken ? branch_addr : uop_out.if_out.pc4;
    assign brj_addr = uop_out.ctrl_out.ex_pc_sel ? jump_addr : resolved_addr;
    //assign brj_addr = ((uop_out.ctrl_out.ex_pc_sel == 1'b1) && ~rm_if.req_br_j) ?
    //                        jump_addr : resolved_addr;

    //assign hazard_if.mispredict = fetch_ex_if.fetch_ex_reg.prediction ^ branch_taken;

    /********************************
    * Hazard/Forwarding Unit Signals
    *********************************/
    assign hazard_if.rs1_e = rf_if.rs1;
    assign hazard_if.rs2_e = rf_if.rs2;

    assign fw_if.rs1_e = rf_if.rs1;
    assign fw_if.rs2_e = rf_if.rs2;

    assign hazard_if.pc_e = uop_out.if_out.pc;
    assign hazard_if.ex_busy = (rv32m_busy && uop_out.ctrl_out.rv32m_control.select); // Add & conditions here for other FUs that can stall
    assign hazard_if.valid_e = uop_out.if_out.valid;


    // TODO: NEW
    always_ff @(posedge CLK, negedge nRST) begin
        if(!nRST) begin
            /*verilator lint_off ENUMVALUE*/
            ex_mem_if.ex_mem_reg <= '{default: '0};
            /*verilator lint_on ENUMVALUE*/
        end else begin
            // TODO: This register is ~180b. Not awful, but can it be smaller?
            // PS: Does it even matter? Synth. tools may be able to merge regs.
            if(!hazard_if.ex_mem_flush && !hazard_if.ex_mem_stall) begin
                // TODO: Handle case of exceptions earlier in the pipe being passed on to handle in the last stage
                // Single bit control signals -- squash these if we have an exception
                // Only need to check illegal since it's the only "new" exception we have
                ex_mem_if.ex_mem_reg.valid              <= uop_out.if_out.valid;
                if(!uop_out.ctrl_out.illegal_insn) begin
                    ex_mem_if.ex_mem_reg.branch         <= uop_out.ctrl_out.branch;
                    ex_mem_if.ex_mem_reg.prediction     <= uop_out.if_out.prediction;
                    ex_mem_if.ex_mem_reg.branch_taken   <= branch_if.branch_taken;
                    ex_mem_if.ex_mem_reg.dren           <= uop_out.ctrl_out.dren;
                    ex_mem_if.ex_mem_reg.dwen           <= uop_out.ctrl_out.dwen;
                    ex_mem_if.ex_mem_reg.reg_write      <= uop_out.ctrl_out.wen;
                    ex_mem_if.ex_mem_reg.ifence         <= uop_out.ctrl_out.ifence;
                    ex_mem_if.ex_mem_reg.jump           <= uop_out.ctrl_out.jump;
                    ex_mem_if.ex_mem_reg.halt           <= uop_out.ctrl_out.halt;
                    ex_mem_if.ex_mem_reg.csr_swap       <= uop_out.ctrl_out.csr_swap;
                    ex_mem_if.ex_mem_reg.csr_clr        <= uop_out.ctrl_out.csr_clr;
                    ex_mem_if.ex_mem_reg.csr_set        <= uop_out.ctrl_out.csr_set;
                    ex_mem_if.ex_mem_reg.csr_imm        <= uop_out.ctrl_out.csr_imm;
                    ex_mem_if.ex_mem_reg.csr_read_only  <= (rf_if.rs1 == '0) || (uop_out.ctrl_out.zimm == '0);
                    ex_mem_if.ex_mem_reg.breakpoint     <= uop_out.ctrl_out.breakpoint;
                    ex_mem_if.ex_mem_reg.ecall_insn     <= uop_out.ctrl_out.ecall_insn;
                    ex_mem_if.ex_mem_reg.ret_insn       <= uop_out.ctrl_out.ret_insn;
                    ex_mem_if.ex_mem_reg.wfi_insn       <= uop_out.ctrl_out.wfi;
                    ex_mem_if.ex_mem_reg.was_compressed <= 1'b0; // TODO: RV32C support
                end
                ex_mem_if.ex_mem_reg.illegal_insn              <= uop_out.ctrl_out.illegal_insn;
                ex_mem_if.ex_mem_reg.badaddr                   <= uop_out.if_out.badaddr;
                ex_mem_if.ex_mem_reg.mal_insn                  <= uop_out.if_out.mal_insn;
                ex_mem_if.ex_mem_reg.fault_insn                <= uop_out.if_out.fault_insn;

                // Bit vectors
                ex_mem_if.ex_mem_reg.w_sel      <= uop_out.ctrl_out.w_sel;
                ex_mem_if.ex_mem_reg.zimm       <= uop_out.ctrl_out.zimm;
                ex_mem_if.ex_mem_reg.rd_m       <= uop_out.ctrl_out.rd;
                ex_mem_if.ex_mem_reg.load_type  <= uop_out.ctrl_out.load_type;
                ex_mem_if.ex_mem_reg.csr_addr   <= uop_out.ctrl_out.csr_addr;

                // Word sized members
                ex_mem_if.ex_mem_reg.brj_addr   <= brj_addr;
                ex_mem_if.ex_mem_reg.port_out   <= ex_out;
                ex_mem_if.ex_mem_reg.rs1_data   <= rs1_post_fwd;
                ex_mem_if.ex_mem_reg.rs2_data   <= rs2_post_fwd;
                ex_mem_if.ex_mem_reg.instr      <= uop_out.if_out.instr;
                ex_mem_if.ex_mem_reg.pc         <= uop_out.if_out.pc;
                ex_mem_if.ex_mem_reg.pc4        <= uop_out.if_out.pc4;
                ex_mem_if.ex_mem_reg.imm_U      <= uop_out.ctrl_out.imm_U;

                // CPU Tracker
                ex_mem_if.ex_mem_reg.tracker_signals.opcode <= uop_out.ctrl_out.opcode;
                ex_mem_if.ex_mem_reg.tracker_signals.imm_SB <= uop_out.ctrl_out.imm_SB;
                ex_mem_if.ex_mem_reg.tracker_signals.imm_S  <= uop_out.ctrl_out.imm_S;
                ex_mem_if.ex_mem_reg.tracker_signals.imm_I  <= uop_out.ctrl_out.imm_I;
                ex_mem_if.ex_mem_reg.tracker_signals.imm_UJ <= uop_out.ctrl_out.imm_UJ;
                ex_mem_if.ex_mem_reg.tracker_signals.imm_U  <= uop_out.ctrl_out.imm_U;

            end else if(hazard_if.ex_mem_flush && !hazard_if.ex_mem_stall) begin
                /*verilator lint_off ENUMVALUE*/
                ex_mem_if.ex_mem_reg <= '{default: '0};
                /*verilator lint_on ENUMVALUE*/
            end
            // else: retain state
        end
    end

    /*********************************************************
  *** SparCE Module Logic
  *********************************************************/
    /*assign sparce_if.wb_data = rf_if.w_data;
    assign sparce_if.wb_en = rf_if.wen;
    assign sparce_if.sasa_data = rf_if.rs2_data;
    assign sparce_if.sasa_addr = alu_if.port_out;
    assign sparce_if.sasa_wen = uop_out.ctrl_out.dwen;
    assign sparce_if.rd = rf_if.rd;*/

endmodule
