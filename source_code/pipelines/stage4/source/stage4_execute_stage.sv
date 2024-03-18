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
*   Filename:     stage4_execute_stage.sv
*
*   Created by:   Jacob R. Stevens
*   Email:        steven69@purdue.edu
*   Date Created: 06/16/2016
*   Description:  Execute Stage for the Two Stage Pipeline
*/

// `include "stage4_fetch_execute_if.vh"
`include "stage4_hazard_unit_if.vh"
`include "stage4_mem_stage_if.vh"
`include "stage4_forwarding_unit_if.vh"
`include "control_unit_if.vh"
`include "component_selection_defines.vh"
`include "rv32i_reg_file_if.vh"
`include "alu_if.vh"
//`include "prv_pipeline_if.vh"
//`include "risc_mgmt_if.vh"
`include "rv32c_if.vh"
import stage4_types_pkg::*;
import rv32i_types_pkg::*;
import rv32v_types_pkg::*;

module stage4_execute_stage (
    input CLK,
    input nRST,

    // pipeline_stages_if.execute ex,
    input uop_t ex_in, 
    //input uop_t uop_out, 
    stage4_mem_stage_if.ex ex_mem_if,
    stage4_hazard_unit_if.execute hazard_if,
    stage4_forwarding_unit_if.execute fw_if,
    //risc_mgmt_if.ts_execute rm_if,
    sparce_pipeline_if.pipe_execute sparce_if,
    rv32c_if.execute rv32cif, 
    rv32v_shadow_csr_if.execute shadow_if
);

    // import rv32i_types_pkg::*;
    import pma_types_1_12_pkg::*;


    //import stage3_types_pkg::*;

    vexmem_t vex_out; 
    word_t vstride; 
    // word_t vl; 
    // vtype_t vtype; 
    word_t vlmax; // determined from lmul and sew settings 
    // logic vsetvl;
    logic vex_stall;

    // Interface declarations
    control_unit_if cu_if ();
    rv32i_reg_file_if rf_if ();
    alu_if alu_if ();
    jump_calc_if jump_if ();
    branch_res_if branch_if ();

    assign rf_if.rs1 = ex_in.ctrl_out.rs1.regidx; 
    assign rf_if.rs2 = ex_in.ctrl_out.rs2.regidx; 

    /*******************
    * Vector Datapath
    ********************/
    // feed signals to hazard unit in for RAW hazards
    always_comb begin
        hazard_if.vs1 = ex_in.vctrl_out.vs1_sel; 
        hazard_if.vs2 = ex_in.vctrl_out.vs2_sel; 
        hazard_if.vs1_used = 1'b0; 
        hazard_if.vs2_used = 1'b0; 
        if(ex_in.vctrl_out.vlaneactive && (ex_in.vctrl_out.vmemdwen || (!ex_in.vctrl_out.vxin1_use_imm && !ex_in.vctrl_out.vxin1_use_rs1)))
            hazard_if.vs1_used = 1'b1; 
        if(ex_in.vctrl_out.vlaneactive && !ex_in.vctrl_out.vxin2_use_rs2)
            hazard_if.vs2_used = 1'b1; 
        
        hazard_if.ex_mask_en = ex_in.vctrl_out.vlaneactive ? ex_in.vctrl_out.vmask_en : 0; 

        if(ex_in.vctrl_out.vuop_num != 0) begin
            // only do hazard tracking across different instructions
            hazard_if.ex_mask_en = 0; 
            hazard_if.vs2_used = 0; 
            hazard_if.vs1_used = 0; 
        end

    end


    //assign ex_mem_if.vexmem = '{default:0, veew: SEW32}; 
    rv32v_ex_datapath RVV_DATAPATH(
        .CLK(CLK), .nRST(nRST), 
        .rdat1(rs1_post_fwd), .rdat2(rs2_post_fwd), 
        .vctrls(ex_in.vctrl_out), 
        .vwb_ctrls(ex_mem_if.vwb), 
        .vmskset_fwd_bits(ex_mem_if.vmskset_fwd_bits), 
        
        .vmem_in(vex_out),
        .vex_stall(vex_stall)
    );

    // stride calculation for mem operations
    always_comb begin
        if(ex_in.vctrl_out.vunitstride) begin
            case(ex_in.vctrl_out.veew_dest)
                SEW32: vstride = 4; 
                SEW16: vstride = 2; 
                default:  vstride = 1; 
            endcase 
        end
        else begin
            vstride = rs2_post_fwd; 
        end
    end


    // Vector CSR values (vl and vtype) logic
    assign hazard_if.vsetvl_ex = (ex_in.vctrl_out.vsetvl_type != NOT_CFG);
    assign shadow_if.vsetvl = (ex_in.vctrl_out.vsetvl_type != NOT_CFG); 
    assign shadow_if.vkeepvl = ex_in.vctrl_out.vkeepvl; 
    always_comb begin
        shadow_if.avl_spec = '0; 
        shadow_if.vtype_spec = vtype_t'(0); 
        case(ex_in.vctrl_out.vsetvl_type)
            VSETIVLI: begin
                shadow_if.avl_spec = {'0, ex_in.ctrl_out.zimm};
                shadow_if.vtype_spec = ex_in.vctrl_out.vtype_imm; 
            end
            VSETVLI: begin
                shadow_if.avl_spec = rs1_post_fwd;
                shadow_if.vtype_spec = ex_in.vctrl_out.vtype_imm; 
            end
            default: begin
                shadow_if.avl_spec = rs1_post_fwd;
                shadow_if.vtype_spec = word_t'(rs2_post_fwd); 
            end
        endcase

        // set the logic for vlmax 
        vlmax = 16; // set to VLEN and then perform shifts to get right value
        case(shadow_if.vtype_spec.vsew)
            SEW32: vlmax = vlmax >> 2; 
            SEW16: vlmax = vlmax >> 1;
            SEW8: vlmax = vlmax; 
            default: begin
                shadow_if.vtype_spec = vtype_t'(0); 
                shadow_if.vtype_spec.vill = 1'b1; 
            end
        endcase 

        case(shadow_if.vtype_spec.vlmul)
            LMUL1: vlmax = vlmax; 
            LMUL2: vlmax = vlmax << 1; 
            LMUL4: vlmax = vlmax << 2; 
            LMUL8: vlmax = vlmax << 3; 
            LMULHALF: vlmax = vlmax >> 1; 
            LMULFOURTH: vlmax = vlmax >> 2; 
            LMULEIGHTH: vlmax = vlmax >> 3; 
            default: begin
                shadow_if.vtype_spec = vtype_t'(0); 
                shadow_if.vtype_spec.vill = 1'b1; 
            end 
        endcase 

        // if vsetvl or vsetvli instr and rs1 == 0, set shadow_if.avl_spec to vlmax 
        if((ex_in.vctrl_out.vsetvl_type == VSETVL || ex_in.vctrl_out.vsetvl_type == VSETVLI) && ex_in.ctrl_out.rs1.regidx == 0) 
            shadow_if.avl_spec = vlmax;
        else if(shadow_if.avl_spec > vlmax) // handle stripmining if AVL > VLMAX 
            shadow_if.avl_spec = vlmax; 

        // logic for setting the illegal bit in shadow_if.vtype_spec
        if(shadow_if.vtype_spec[31:7] != 0) begin
            shadow_if.vtype_spec = vtype_t'(0); 
            shadow_if.vtype_spec.vill = 1'b1;
        end

    end

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

    assign wfi = ex_in.ctrl_out.wfi;  //Added by rkannank

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
        .rv32m_start(ex_in.ctrl_out.rv32m_control.select),
        .operation(ex_in.ctrl_out.rv32m_control.op), // TODO: Better way?
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
    assign imm_I_ext  = {{20{ex_in.ctrl_out.imm_I[11]}}, ex_in.ctrl_out.imm_I};
    assign imm_UJ_ext = {{11{ex_in.ctrl_out.imm_UJ[20]}}, ex_in.ctrl_out.imm_UJ};
    assign imm_S_ext  = {{20{ex_in.ctrl_out.imm_S[11]}}, ex_in.ctrl_out.imm_S};

    /**********************************************
    * Jump Target Calculator and Associated Logic
    **********************************************/
    word_t jump_addr  /* verilator isolate_assignments */;
    always_comb begin
        if (ex_in.ctrl_out.j_sel) begin
            jump_if.base = ex_in.if_out.pc;
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
    assign imm_or_shamt = (ex_in.ctrl_out.imm_shamt_sel == 1'b1) ? ex_in.ctrl_out.shamt : imm_I_ext;
    assign alu_if.aluop = ex_in.ctrl_out.alu_op;
    logic mal_addr;

    always_comb begin
        case (ex_in.ctrl_out.alu_a_sel)
            2'd0: alu_if.port_a = rs1_post_fwd;
            2'd1: alu_if.port_a = imm_S_ext;
            2'd2: alu_if.port_a = ex_in.if_out.pc;
            2'd3: alu_if.port_a = '0;  //Not Used
        endcase
    end

    always_comb begin
        case (ex_in.ctrl_out.alu_b_sel)
            2'd0: alu_if.port_b = rs1_post_fwd;
            2'd1: alu_if.port_b = rs2_post_fwd;
            2'd2: alu_if.port_b = imm_or_shamt;
            2'd3: alu_if.port_b = ex_in.ctrl_out.imm_U;
        endcase
    end


    // FU output mux -- feeds into pipeline register
    // Add to this when more FUs are added
    // TODO: Make this nicer, with enum for FU selection
    assign ex_out = (ex_in.ctrl_out.rv32m_control.select) ? rv32m_out : alu_if.port_out;

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
    assign branch_if.pc = ex_in.if_out.pc;
    assign branch_if.imm_sb = ex_in.ctrl_out.imm_SB;
    assign branch_if.branch_type = ex_in.ctrl_out.branch_type;

    // Mux resource based on if RISC-MGMT is trying to access it
    assign branch_taken = branch_if.branch_taken;//rm_if.req_br_j ? rm_if.branch_jump : branch_if.branch_taken;
    assign branch_addr = branch_if.branch_addr;//rm_if.req_br_j ? rm_if.br_j_addr : branch_if.branch_addr;
    //assign rm_if.pc = fetch_ex_if.fetch_ex_reg.pc;

    assign resolved_addr = branch_if.branch_taken ? branch_addr : ex_in.if_out.pc4;
    assign brj_addr = ex_in.ctrl_out.ex_pc_sel ? jump_addr : resolved_addr;
    //assign brj_addr = ((ex_in.ctrl_out.ex_pc_sel == 1'b1) && ~rm_if.req_br_j) ?
    //                        jump_addr : resolved_addr;

    //assign hazard_if.mispredict = fetch_ex_if.fetch_ex_reg.prediction ^ branch_taken;

    /********************************
    * Hazard/Forwarding Unit Signals
    *********************************/
    assign hazard_if.rs1_e = rf_if.rs1;
    assign hazard_if.rs2_e = rf_if.rs2;

    assign fw_if.rs1_e = rf_if.rs1;
    assign fw_if.rs2_e = rf_if.rs2;

    assign hazard_if.pc_e = ex_in.if_out.pc;
    assign hazard_if.ex_busy = (rv32m_busy && ex_in.ctrl_out.rv32m_control.select) | vex_stall; // Add & conditions here for other FUs that can stall
    assign hazard_if.valid_e = ex_in.if_out.valid;


    // TODO: NEW
    always_ff @(posedge CLK, negedge nRST) begin
        if(!nRST) begin
            /*verilator lint_off ENUMVALUE*/
            ex_mem_if.ex_mem_reg <= '{default: '0};
            ex_mem_if.vexmem <= '{default: '0, veew: SEW32}; 
            /*verilator lint_on ENUMVALUE*/
        end else begin
            // TODO: This register is ~180b. Not awful, but can it be smaller?
            // PS: Does it even matter? Synth. tools may be able to merge regs.
            if(!hazard_if.ex_mem_flush && !hazard_if.ex_mem_stall) begin
                // TODO: Handle case of exceptions earlier in the pipe being passed on to handle in the last stage
                // Single bit control signals -- squash these if we have an exception
                // Only need to check illegal since it's the only "new" exception we have
                ex_mem_if.ex_mem_reg.valid              <= ex_in.if_out.valid;
                if(!ex_in.ctrl_out.illegal_insn) begin
                    ex_mem_if.ex_mem_reg.branch         <= ex_in.ctrl_out.branch;
                    ex_mem_if.ex_mem_reg.prediction     <= ex_in.if_out.prediction;
                    ex_mem_if.ex_mem_reg.branch_taken   <= branch_if.branch_taken;
                    ex_mem_if.ex_mem_reg.dren           <= ex_in.ctrl_out.dren;
                    ex_mem_if.ex_mem_reg.dwen           <= ex_in.ctrl_out.dwen;
                    ex_mem_if.ex_mem_reg.reg_write      <= ex_in.ctrl_out.wen;
                    ex_mem_if.ex_mem_reg.ifence         <= ex_in.ctrl_out.ifence;
                    ex_mem_if.ex_mem_reg.jump           <= ex_in.ctrl_out.jump;
                    ex_mem_if.ex_mem_reg.halt           <= ex_in.ctrl_out.halt;
                    ex_mem_if.ex_mem_reg.csr_swap       <= ex_in.ctrl_out.csr_swap;
                    ex_mem_if.ex_mem_reg.csr_clr        <= ex_in.ctrl_out.csr_clr;
                    ex_mem_if.ex_mem_reg.csr_set        <= ex_in.ctrl_out.csr_set;
                    ex_mem_if.ex_mem_reg.csr_imm        <= ex_in.ctrl_out.csr_imm;
                    ex_mem_if.ex_mem_reg.csr_read_only  <= (rf_if.rs1 == '0) || (ex_in.ctrl_out.zimm == '0);
                    ex_mem_if.ex_mem_reg.breakpoint     <= ex_in.ctrl_out.breakpoint;
                    ex_mem_if.ex_mem_reg.ecall_insn     <= ex_in.ctrl_out.ecall_insn;
                    ex_mem_if.ex_mem_reg.ret_insn       <= ex_in.ctrl_out.ret_insn;
                    ex_mem_if.ex_mem_reg.wfi_insn       <= ex_in.ctrl_out.wfi;
                    ex_mem_if.ex_mem_reg.was_compressed <= 1'b0; // TODO: RV32C support
                end
                ex_mem_if.ex_mem_reg.illegal_insn              <= ex_in.ctrl_out.illegal_insn;
                ex_mem_if.ex_mem_reg.badaddr                   <= ex_in.if_out.badaddr;
                ex_mem_if.ex_mem_reg.mal_insn                  <= ex_in.if_out.mal_insn;
                ex_mem_if.ex_mem_reg.fault_insn                <= ex_in.if_out.fault_insn;

                // Bit vectors
                ex_mem_if.ex_mem_reg.w_sel      <= ex_in.ctrl_out.w_sel;
                ex_mem_if.ex_mem_reg.zimm       <= ex_in.ctrl_out.zimm;
                ex_mem_if.ex_mem_reg.rd_m       <= ex_in.ctrl_out.rd;
                ex_mem_if.ex_mem_reg.load_type  <= ex_in.ctrl_out.load_type;
                ex_mem_if.ex_mem_reg.csr_addr   <= (ex_in.vctrl_out.vsetvl_type != NOT_CFG) ? VL_ADDR : ex_in.ctrl_out.csr_addr; // NOTE: Change this for vsetvl insturctions

                // Word sized members
                ex_mem_if.ex_mem_reg.brj_addr   <= brj_addr;
                ex_mem_if.ex_mem_reg.port_out   <= ex_out;
                ex_mem_if.ex_mem_reg.rs1_data   <= (ex_in.vctrl_out.vsetvl_type != NOT_CFG) ? shadow_if.avl_spec : rs1_post_fwd;
                ex_mem_if.ex_mem_reg.rs2_data   <= (ex_in.vctrl_out.vmemdren | ex_in.vctrl_out.vmemdwen) ? vstride : 
                                                   ( (ex_in.vctrl_out.vsetvl_type != NOT_CFG) ? word_t'(shadow_if.vtype_spec) :rs2_post_fwd);
                ex_mem_if.ex_mem_reg.instr      <= ex_in.if_out.instr;
                ex_mem_if.ex_mem_reg.pc         <= ex_in.if_out.pc;
                ex_mem_if.ex_mem_reg.pc4        <= ex_in.if_out.pc4;
                ex_mem_if.ex_mem_reg.imm_U      <= ex_in.ctrl_out.imm_U;

                // CPU Tracker
                ex_mem_if.ex_mem_reg.tracker_signals.opcode <= ex_in.ctrl_out.opcode;
                ex_mem_if.ex_mem_reg.tracker_signals.imm_SB <= ex_in.ctrl_out.imm_SB;
                ex_mem_if.ex_mem_reg.tracker_signals.imm_S  <= ex_in.ctrl_out.imm_S;
                ex_mem_if.ex_mem_reg.tracker_signals.imm_I  <= ex_in.ctrl_out.imm_I;
                ex_mem_if.ex_mem_reg.tracker_signals.imm_UJ <= ex_in.ctrl_out.imm_UJ;
                ex_mem_if.ex_mem_reg.tracker_signals.imm_U  <= ex_in.ctrl_out.imm_U;

                ex_mem_if.vexmem <= vex_out; 

            end else if(hazard_if.ex_mem_flush && !hazard_if.ex_mem_stall) begin
                /*verilator lint_off ENUMVALUE*/
                ex_mem_if.ex_mem_reg <= '{default: '0};
                ex_mem_if.vexmem <= '{default: '0, veew: SEW32}; 
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
