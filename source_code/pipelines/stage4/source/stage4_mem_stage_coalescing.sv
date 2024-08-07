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
*   Filename:     stage4_mem_stage_coalescing.sv
*
*   Created by:   Maxwell Michalec
*                 William Cunningham
*   Email:        michalem@purdue.edu
*                 wrcunnin@purdue.edu
*   Date Created: 01/30/2024
*   Description:  Memory stage for rv32v pipeline, based on Maxwell Michalec's
*                 previous implementation
*/

`include "stage4_mem_stage_if.vh"
`include "rv32v_mem_coalescer_if.vh"
`include "rv32v_lsc_if.vh"
`include "rv32v_shadow_csr_if.vh"

module stage4_mem_stage_coalescing (
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
    logic vmemop, dmemwen, dmemren;
    word_t [NUM_LANES-1:0] vlane_data;
    logic [NUM_LANES-1:0] vlane_wen, velem_mask;
    logic ven_lanes_one_hot;

    // Interfaces
    rv32v_mem_coalescer_if coalescer_if();
    rv32v_lsc_if lsc_if();

    // Arbitrate scalar and vector memory requests
    assign vmemop = ex_mem_if.vexmem.vmemdren | ex_mem_if.vexmem.vmemdwen;
    assign dmemwen = ((vmemop) ? coalescer_if.vmemdwen_lsc : ex_mem_if.ex_mem_reg.dwen);
    assign dmemren = ((vmemop) ? coalescer_if.vmemdren_lsc : ex_mem_if.ex_mem_reg.dren);
    assign lsc_if.wen = dmemwen && !hazard_if.suppress_data;
    assign lsc_if.ren = dmemren && !hazard_if.suppress_data;
    assign lsc_if.addr = (vmemop) ? coalescer_if.vaddr_lsc : ex_mem_if.ex_mem_reg.port_out;
    assign lsc_if.addr_wide = coalescer_if.vaddr_wide_lsc;
    assign lsc_if.store_data = (vmemop) ? coalescer_if.vdata_store_lsc : ex_mem_if.ex_mem_reg.rs2_data;
    assign lsc_if.store_data_wide = coalescer_if.vdata_store_wide_lsc;
    assign lsc_if.store_en_wide = coalescer_if.vdata_store_en_wide_lsc;
    assign lsc_if.wide_vstore = vmemop && dmemwen && ~ex_mem_if.vexmem.vseg_op;
    assign lsc_if.ven_lanes = coalescer_if.ven_lanes;
    assign lsc_if.load_type = (vmemop) ? coalescer_if.vload_type : ex_mem_if.ex_mem_reg.load_type;
    assign lsc_if.ifence = ex_mem_if.ex_mem_reg.ifence;

    // Coalescer interface signals
    assign coalescer_if.vmemdwen = ex_mem_if.vexmem.vmemdwen; 
    assign coalescer_if.vmemdren = ex_mem_if.vexmem.vmemdren;
    assign coalescer_if.vuop_num = ex_mem_if.vexmem.vuop_num;
    assign coalescer_if.vindexed = ex_mem_if.vexmem.vindexed;
    assign coalescer_if.base = ex_mem_if.ex_mem_reg.rs1_data;
    assign coalescer_if.stride = ex_mem_if.ex_mem_reg.rs2_data;
    assign coalescer_if.veew = ex_mem_if.vexmem.veew;
    assign coalescer_if.vuop_last = ex_mem_if.vexmem.vuop_last;
    assign coalescer_if.vlane_mask = velem_mask;
    assign coalescer_if.vlane_addr = ex_mem_if.vexmem.vres;
    assign coalescer_if.vlane_store_data = ex_mem_if.vexmem.vs1;
    assign coalescer_if.lsc_ready = lsc_if.lsc_ready;
    
    // segment load/store coalescer signals
    assign coalescer_if.vseg_op = ex_mem_if.vexmem.vseg_op; 
    assign coalescer_if.vnew_seg = ex_mem_if.vexmem.vnew_seg;
    assign coalescer_if.strided = ex_mem_if.vexmem.vstrided; 
    assign coalescer_if.unit_strided = ex_mem_if.vexmem.vunitstride;
    assign coalescer_if.veew = ex_mem_if.vexmem.veew;


    // Memory coalescer
    rv32v_mem_coalescer MCU (
        .CLK,
        .nRST,
        .flush(hazard_if.ex_mem_flush),
        .coalescer_if,
        .coalescer_stall(hazard_if.coalescer_stall)
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
    assign hazard_if.dren = dmemren;
    assign hazard_if.dwen = dmemwen;
    assign hazard_if.jump = ex_mem_if.ex_mem_reg.jump;
    assign hazard_if.branch = ex_mem_if.ex_mem_reg.branch;
    assign hazard_if.halt = ex_mem_if.ex_mem_reg.halt;
    assign hazard_if.rd_m = ex_mem_if.ex_mem_reg.rd_m;
    assign hazard_if.reg_write = ex_mem_if.ex_mem_reg.reg_write;
    assign hazard_if.csr_read = prv_pipe_if.valid_write;
    assign hazard_if.token_mem = 0; // TODO: RISC-MGMT
    assign hazard_if.mispredict = ex_mem_if.ex_mem_reg.prediction ^ ex_mem_if.ex_mem_reg.branch_taken;
    
    // Vector-specific signals
    assign hazard_if.vd = ex_mem_if.vexmem.vd_sel;
    assign hazard_if.vregwen = ex_mem_if.vexmem.vregwen;
    assign hazard_if.vvalid_m = ex_mem_if.vexmem.vvalid;
    assign hazard_if.velem_num_m = (vmemop) ? (ex_mem_if.vexmem.vuop_num << 2) + coalescer_if.vcurr_lane + 1  // if a memory access starts, it will finish
                                            : (ex_mem_if.vexmem.vuop_num + 1) << 2;  // if actively writing-back, vstart on next uop
    assign hazard_if.vuop_last = ex_mem_if.vexmem.vuop_last & ~hazard_if.coalescer_stall;
    assign hazard_if.vmem_last_elem = (coalescer_if.last_lane); // will need to change. this is not always true. may need a signal directly from MCU
    assign hazard_if.keep_vstart_m = ex_mem_if.vexmem.keep_vstart;
    assign ex_mem_if.vmskset_fwd_bits = ex_mem_if.vexmem.vres[0][3:0]; 

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
    assign hazard_if.fault_l = dmemren && dgen_bus_if.error;
    assign hazard_if.mal_l = dmemren & lsc_if.mal_addr;
    assign hazard_if.fault_s = dmemwen && dgen_bus_if.error;
    assign hazard_if.mal_s = dmemwen & lsc_if.mal_addr;
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
    assign prv_pipe_if.dren  = dmemren;
    assign prv_pipe_if.dwen  = dmemwen;
    assign prv_pipe_if.daddr = lsc_if.addr;
    assign prv_pipe_if.d_acc_width = WordAcc;

    /*******************
    * Writeback Muxing *
    *******************/
    assign ex_mem_if.brj_addr = ex_mem_if.ex_mem_reg.brj_addr;
    assign ex_mem_if.reg_write = (ex_mem_if.ex_mem_reg.reg_write & (ex_mem_if.ex_mem_reg.rd_m.regclass == RC_SCALAR))
                                 | ex_mem_if.vexmem.sregwen;
    assign ex_mem_if.rd_m = ex_mem_if.ex_mem_reg.rd_m;
    assign ex_mem_if.vwb.vd = ex_mem_if.vexmem.vd_sel.regidx;

    always_comb begin
        // TODO: RISC-MGMT
        casez ({ex_mem_if.vexmem.vsetvl, ex_mem_if.vexmem.sregwen, ex_mem_if.ex_mem_reg.w_sel})
            5'd0:    ex_mem_if.reg_wdata = lsc_if.dload_ext;
            5'd1:    ex_mem_if.reg_wdata = ex_mem_if.ex_mem_reg.pc4;
            5'd2:    ex_mem_if.reg_wdata = ex_mem_if.ex_mem_reg.imm_U;
            5'd3:    ex_mem_if.reg_wdata = ex_mem_if.ex_mem_reg.port_out;
            5'd4:    ex_mem_if.reg_wdata = prv_pipe_if.rdata;
            5'd8:    ex_mem_if.reg_wdata = ex_mem_if.vexmem.vres[0];  // assumes SEW-len element at idx=0 is sign-ext'd in EX
            5'd24:   ex_mem_if.reg_wdata = ex_mem_if.ex_mem_reg.rs1_data;  // vl on rs1_data (for vset{i}vl{i})
            default: ex_mem_if.reg_wdata = '0;
        endcase

        // Forwarding unit
        casez ({ex_mem_if.vexmem.vsetvl, ex_mem_if.vexmem.sregwen, ex_mem_if.ex_mem_reg.w_sel})
            5'd1:    fw_if.rd_mem_data = ex_mem_if.ex_mem_reg.pc4;
            5'd2:    fw_if.rd_mem_data = ex_mem_if.ex_mem_reg.imm_U;
            5'd3:    fw_if.rd_mem_data = ex_mem_if.ex_mem_reg.port_out;
            5'd4:    fw_if.rd_mem_data = prv_pipe_if.rdata;
            5'd8:    fw_if.rd_mem_data = ex_mem_if.vexmem.vres[0];
            5'd24:   fw_if.rd_mem_data = ex_mem_if.ex_mem_reg.rs1_data;
            default: fw_if.rd_mem_data = '0;
        endcase
    end

    // Element mask considering vlane_mask and vstart:
    always_comb begin
        if (ex_mem_if.vexmem.vuop_num < prv_pipe_if.vstart[$clog2(VLMAX)-1:2]) begin
            velem_mask = '0;
        end else if (ex_mem_if.vexmem.vuop_num == prv_pipe_if.vstart[$clog2(VLMAX)-1:2]) begin
            casez (prv_pipe_if.vstart[1:0])
                2'b00: velem_mask = ex_mem_if.vexmem.vlane_mask;
                2'b01: velem_mask = {ex_mem_if.vexmem.vlane_mask[3:1], 1'b0};
                2'b10: velem_mask = {ex_mem_if.vexmem.vlane_mask[3:2], 2'b0};
                2'b11: velem_mask = {ex_mem_if.vexmem.vlane_mask[3]  , 3'b0};
            endcase
        end else begin
            velem_mask = ex_mem_if.vexmem.vlane_mask;
        end

        // segmented load/store instruction handling
         if((ex_mem_if.vexmem.vseg_op) && (ex_mem_if.vexmem.vuop_num < prv_pipe_if.vstart))
            velem_mask = '0; 
         else if(ex_mem_if.vexmem.vseg_op)
            velem_mask = ex_mem_if.vexmem.vlane_mask;

    end
    assign ven_lanes_one_hot = (coalescer_if.ven_lanes == 4'b0001) || (coalescer_if.ven_lanes == 4'b0010) || (coalescer_if.ven_lanes == 4'b0100) || (coalescer_if.ven_lanes == 4'b1000);
    assign vlane_data = (ex_mem_if.vexmem.vmemdren) ? (ven_lanes_one_hot ? {4{lsc_if.dload_ext}} : lsc_if.dload_ext_wide) :
                        (ex_mem_if.vexmem.vmv_s_x) ? {4{ex_mem_if.ex_mem_reg.rs1_data}} : ex_mem_if.vexmem.vres;

    always_comb begin
        if (ex_mem_if.vexmem.vmemdren) begin
            vlane_wen = ~dgen_bus_if.busy ? velem_mask & coalescer_if.ven_lanes : '0; // Coalescer

            if(ex_mem_if.vexmem.vseg_op) begin
                vlane_wen = dgen_bus_if.busy ? '0 : 
                            (velem_mask != 0 ? ex_mem_if.vexmem.vlane_mask : '0); 
            end
        end else if (ex_mem_if.vexmem.vmv_s_x) begin
            vlane_wen = 4'b0001;  // vmv.s.x always to element 0 of vd
        end else if (ex_mem_if.vexmem.vregwen) begin
            vlane_wen = velem_mask;
        end else begin
            vlane_wen = '0;
        end

        // If the destination register is not a vector register, mask off all lanes
        if (ex_mem_if.vexmem.vd_sel.regclass != RC_VECTOR) begin
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
