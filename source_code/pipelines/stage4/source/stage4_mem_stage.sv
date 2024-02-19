/*
*   Copyright 2023 Purdue University
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
*   Filename:     stage4_mem_stage.sv
*
*   Created by:   Maxwell Michalec
*   Email:        michalem@purdue.edu
*   Date Created: 01/30/2024
*   Description:  Memory stage for rv32v pipeline
*/

`include "stage4_mem_stage_if.vh"
`include "rv32v_mem_serializer_if.vh"
`include "rv32v_lsc_if.vh"
`include "rv32v_shadow_csr_if.vh"

module stage4_mem_stage (
    input logic CLK,
    input logic nRST,
    stage4_mem_stage_if.mem ex_mem_if,
    stage4_hazard_unit_if.mem hazard_if,
    stage4_forwarding_unit_if.mem fw_if,
    generic_bus_if.cpu dgen_bus_if,
    prv_pipeline_if.pipe prv_pipe_if,
    cache_control_if.pipeline cc_if,
    predictor_pipeline_if.update predict_if,
    rv32v_shadow_csr_if.mem shadow_if,
    output logic halt,
    output logic wfi
);

    import rv32i_types_pkg::*;
    import rv32v_types_pkg::*;
    import pma_types_1_12_pkg::*;

    genvar i;
    logic vmemop;
    word_t [NUM_LANES-1:0] vlane_data;
    logic [NUM_LANES-1:0] vlane_wen;

    // Interfaces
    rv32v_mem_serializer_if serial_if();
    rv32v_lsc_if lsc_if();

    // Arbitrate scalar and vector memory requests
    assign vmemop = ex_mem_if.vexmem.vmemdren | ex_mem_if.vexmem.vmemdwen;
    assign lsc_if.wen = ((vmemop) ? serial_if.vmemdwen_lsc : ex_mem_if.ex_mem_reg.dwen) && !hazard_if.suppress_data;
    assign lsc_if.ren = ((vmemop) ? serial_if.vmemdren_lsc : ex_mem_if.ex_mem_reg.dren) && !hazard_if.suppress_data;
    assign lsc_if.addr = (vmemop) ? serial_if.vaddr_lsc : ex_mem_if.ex_mem_reg.port_out;
    assign lsc_if.store_data = (vmemop) ? serial_if.vdata_store_lsc : ex_mem_if.ex_mem_reg.rs2_data;
    // assign lsc_if.byte_en = 0;
    assign lsc_if.load_type = (vmemop) ? serial_if.vload_type : ex_mem_if.ex_mem_reg.load_type;
    assign lsc_if.ifence = ex_mem_if.ex_mem_reg.ifence;
    assign serial_if.lsc_ready = lsc_if.lsc_ready;

    // Memory serializer
    rv32v_mem_serializer SLZR (
        .CLK,
        .nRST,
        .serial_if
    );

    // Load-store controller
    rv32v_load_store_controller LSC (
        .CLK,
        .nRST,
        .lsc_if,
        .dgen_bus_if,
        .cc_if
    );

    /***************
    * Branch Update
    ****************/
    assign predict_if.update_predictor = ex_mem_if.ex_mem_reg.branch;
    assign predict_if.prediction = ex_mem_if.ex_mem_reg.prediction;
    assign predict_if.branch_result = ex_mem_if.ex_mem_reg.branch_taken;
    assign predict_if.update_addr = ex_mem_if.ex_mem_reg.brj_addr;

    /************************
    * Hazard/Forwarding Unit
    *************************/
    // Note: Some hazard unit signals are assigned below in the CSR section
    assign hazard_if.d_mem_busy = dgen_bus_if.busy;
    assign hazard_if.ifence = ex_mem_if.ex_mem_reg.ifence;
    assign hazard_if.fence_stall = lsc_if.fence_stall;
    assign hazard_if.dren = ex_mem_if.ex_mem_reg.dren;
    assign hazard_if.dwen = ex_mem_if.ex_mem_reg.dwen;
    assign hazard_if.jump = ex_mem_if.ex_mem_reg.jump;
    assign hazard_if.branch = ex_mem_if.ex_mem_reg.branch;
    assign hazard_if.halt = ex_mem_if.ex_mem_reg.halt;
    assign hazard_if.rd_m = ex_mem_if.ex_mem_reg.rd_m;
    assign hazard_if.reg_write = ex_mem_if.ex_mem_reg.reg_write;
    assign hazard_if.csr_read = prv_pipe_if.valid_write;
    assign hazard_if.token_mem = 0; // TODO: RISC-MGMT
    assign hazard_if.mispredict = ex_mem_if.ex_mem_reg.prediction ^ ex_mem_if.ex_mem_reg.branch_taken;
    //assign hazard_if.pc = ex_mem_if.ex_mem_reg.pc;
    assign hazard_if.serializer_stall = (serial_if.vcurr_lane != (NUM_LANES-1)) & vmemop;

    assign halt = ex_mem_if.ex_mem_reg.halt;
    assign fw_if.rd_m = ex_mem_if.ex_mem_reg.rd_m;
    assign fw_if.reg_write = ex_mem_if.reg_write;
    assign fw_if.load = (ex_mem_if.ex_mem_reg.dren || ex_mem_if.ex_mem_reg.dwen);

    /******
    * CSRs
    *******/
    assign prv_pipe_if.swap = ex_mem_if.ex_mem_reg.csr_swap;
    assign prv_pipe_if.clr = ex_mem_if.ex_mem_reg.csr_clr;
    assign prv_pipe_if.set = ex_mem_if.ex_mem_reg.csr_set;
    assign prv_pipe_if.read_only = ex_mem_if.ex_mem_reg.csr_read_only;
    assign prv_pipe_if.wdata = ex_mem_if.ex_mem_reg.csr_imm ? {27'h0, ex_mem_if.ex_mem_reg.zimm} : ex_mem_if.ex_mem_reg.rs1_data;
    assign prv_pipe_if.csr_addr = ex_mem_if.ex_mem_reg.csr_addr;
    assign prv_pipe_if.valid_write = (prv_pipe_if.swap | prv_pipe_if.clr
                                        | prv_pipe_if.set) & ~hazard_if.ex_mem_stall;
    assign prv_pipe_if.instr = (ex_mem_if.ex_mem_reg.instr != '0);
    // Vector-specific
    assign prv_pipe_if.vsetvl = ex_mem_if.vexmem.vsetvl;
    assign prv_pipe_if.vkeepvl = ex_mem_if.vexmem.vkeepvl;
    assign prv_pipe_if.new_vtype = vtype_t'(ex_mem_if.ex_mem_reg.rs2_data);  // if immediates are used, they are muxed in in EX
    assign shadow_if.vtype_arch = prv_pipe_if.vtype;
    assign shadow_if.vl_arch = prv_pipe_if.vl;

    assign hazard_if.fault_insn = ex_mem_if.ex_mem_reg.fault_insn;
    assign hazard_if.mal_insn = ex_mem_if.ex_mem_reg.mal_insn;
    assign hazard_if.illegal_insn = ex_mem_if.ex_mem_reg.illegal_insn || prv_pipe_if.invalid_priv_isn;
    assign hazard_if.fault_l = ex_mem_if.ex_mem_reg.dren && dgen_bus_if.error;
    assign hazard_if.mal_l = ex_mem_if.ex_mem_reg.dren & lsc_if.mal_addr;
    assign hazard_if.fault_s = ex_mem_if.ex_mem_reg.dwen && dgen_bus_if.error;
    assign hazard_if.mal_s = ex_mem_if.ex_mem_reg.dwen & lsc_if.mal_addr;
    assign hazard_if.breakpoint = ex_mem_if.ex_mem_reg.breakpoint;
    assign hazard_if.env = ex_mem_if.ex_mem_reg.ecall_insn;
    assign hazard_if.ret = ex_mem_if.ex_mem_reg.ret_insn;
    assign hazard_if.wfi = ex_mem_if.ex_mem_reg.wfi_insn;
    assign hazard_if.badaddr = (hazard_if.fault_insn || hazard_if.mal_insn) ? ex_mem_if.ex_mem_reg.badaddr : dgen_bus_if.addr;

    // NEW
    assign hazard_if.pc_m = ex_mem_if.ex_mem_reg.pc;
    assign hazard_if.valid_m = ex_mem_if.ex_mem_reg.valid;
    assign ex_mem_if.pc4 = ex_mem_if.ex_mem_reg.pc4;

    // Memory protection (doesn't consider RISC-MGMT)
    assign prv_pipe_if.dren  = ex_mem_if.ex_mem_reg.dren;
    assign prv_pipe_if.dwen  = ex_mem_if.ex_mem_reg.dwen;
    assign prv_pipe_if.daddr = ex_mem_if.ex_mem_reg.port_out;
    assign prv_pipe_if.d_acc_width = WordAcc;

    /*******************
    * Writeback Muxing *
    *******************/
    assign ex_mem_if.brj_addr = ex_mem_if.ex_mem_reg.brj_addr;
    assign ex_mem_if.reg_write = (ex_mem_if.ex_mem_reg.reg_write & (ex_mem_if.ex_mem_reg.rd_m.regclass == RC_SCALAR))
                                 | ex_mem_if.vexmem.sregwen;
    assign ex_mem_if.rd_m = ex_mem_if.ex_mem_reg.rd_m;
    assign ex_mem_if.vwb.vd = (ex_mem_if.ex_mem_reg.rd_m.regclass == RC_VECTOR) ? ex_mem_if.ex_mem_reg.rd_m.regidx
                                                                                : ex_mem_if.vexmem.vd_sel.regidx;

    always_comb begin
        // TODO: RISC-MGMT
        case ({ex_mem_if.vexmem.sregwen, ex_mem_if.ex_mem_reg.w_sel})
            4'd0:    ex_mem_if.reg_wdata = lsc_if.dload_ext;
            4'd1:    ex_mem_if.reg_wdata = ex_mem_if.ex_mem_reg.pc4;
            4'd2:    ex_mem_if.reg_wdata = ex_mem_if.ex_mem_reg.imm_U;
            4'd3:    ex_mem_if.reg_wdata = ex_mem_if.ex_mem_reg.port_out;
            4'd4:    ex_mem_if.reg_wdata = prv_pipe_if.rdata;
            4'd8:    ex_mem_if.reg_wdata = ex_mem_if.vexmem.valu_res[0];  // assumes SEW-len element at idx=0 is sign-ext'd in EX
            default: ex_mem_if.reg_wdata = '0;
        endcase

        // Forwarding unit
        case ({ex_mem_if.vexmem.sregwen, ex_mem_if.ex_mem_reg.w_sel})
            4'd1:    fw_if.rd_mem_data = ex_mem_if.ex_mem_reg.pc4;
            4'd2:    fw_if.rd_mem_data = ex_mem_if.ex_mem_reg.imm_U;
            4'd3:    fw_if.rd_mem_data = ex_mem_if.ex_mem_reg.port_out;
            4'd4:    fw_if.rd_mem_data = prv_pipe_if.rdata;
            4'd8:    fw_if.rd_mem_data = ex_mem_if.vexmem.valu_res[0];
            default: fw_if.rd_mem_data = '0;
        endcase

        // for vset{i}vl{i} instructions write the vl value into rd
        // if(ex_mem_if.vexmem.vsetvl)
        //     ex_mem_if.reg_wdata = ex_mem_if.ex_mem_reg.rs1_data; // vl is in rs1
    end

    assign vlane_data = (ex_mem_if.vexmem.vmemdren) ? {4{lsc_if.dload_ext}} :
                        (ex_mem_if.ex_mem_reg.rd_m.regclass == RC_VECTOR) ? {4{ex_mem_if.ex_mem_reg.port_out}} : ex_mem_if.vexmem.valu_res;

    always_comb begin
        if (ex_mem_if.vexmem.vmemdren) begin
            casez (serial_if.vcurr_lane)
                2'd0: vlane_wen = {3'b0, ~dgen_bus_if.busy & ex_mem_if.vexmem.vlane_mask[0]      };
                2'd1: vlane_wen = {2'b0, ~dgen_bus_if.busy & ex_mem_if.vexmem.vlane_mask[1], 1'b0};
                2'd2: vlane_wen = {1'b0, ~dgen_bus_if.busy & ex_mem_if.vexmem.vlane_mask[2], 2'b0};
                2'd3: vlane_wen = {      ~dgen_bus_if.busy & ex_mem_if.vexmem.vlane_mask[3], 3'b0};
            endcase
        end else if (ex_mem_if.ex_mem_reg.rd_m.regclass == RC_VECTOR) begin
            vlane_wen = {3'b0, ex_mem_if.ex_mem_reg.reg_write};  // vmv.s.x always to element 0 of vd
        end else if (ex_mem_if.vexmem.vregwen) begin
            vlane_wen = ex_mem_if.vexmem.vlane_mask;
        end else begin
            vlane_wen = '0;
        end
    end

    // Write-back crossbar for each vector RF bank
    generate
        for (i = 0; i < NUM_LANES; i++) begin : gen_wb_xbar
            rv32v_write_xbar #(.BANK_NUM(i)) WBXBAR (
                .lane_dat(vlane_data),
                .lane_wen(vlane_wen),
                .eew(ex_mem_if.vexmem.veew),
                .bank_offset(ex_mem_if.vexmem.vbank_offset),
                .vwdat(ex_mem_if.vwb.vwdata[i]),
                .byte_wen(ex_mem_if.vwb.vbyte_wen[i])
            );
        end
    endgenerate

    /**************
    * CPU Tracking
    ***************/
    logic wb_stall;
    logic [2:0] funct3;
    logic [11:0] funct12;
    logic instr_30;

    // TODO: Fix up hazard unit
    assign funct3 = ex_mem_if.ex_mem_reg.instr[14:12];
    assign funct12 = ex_mem_if.ex_mem_reg.instr[31:20];
    assign instr_30 = ex_mem_if.ex_mem_reg.instr[30];
    assign wb_stall = hazard_if.ex_mem_stall & ~hazard_if.jump & ~hazard_if.branch; // TODO: Is this right?

endmodule // stage4_mem_stage
