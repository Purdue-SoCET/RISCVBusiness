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
*   Filename:     control_unit.sv
*
*   Created by:   Jacob R. Stevens
*   Email:        steven69@purdue.edu
*   Date Created: 06/09/2016
*   Description:  The control unit combinationally sets all of the control
*                 signals used in the processor based on the incoming instruction.
*/

`include "component_selection_defines.vh"
`include "prv_pipeline_if.vh"
`include "control_unit_if.vh"
`include "rv32i_reg_file_if.vh"
`include "risc_mgmt_if.vh"
`include "decompressor_if.vh"

module control_unit (
    control_unit_if.control_unit       cu_if,
    rv32i_reg_file_if.cu               rf_if,
    prv_pipeline_if.pipe               prv_pipe_if,
    input logic                        [4:0] rmgmt_rsel_s_0,
    rmgmt_rsel_s_1,
    rmgmt_rsel_d,
    input logic                              rmgmt_req_reg_r,
    rmgmt_req_reg_w
);
    import alu_types_pkg::*;
    import rv32i_types_pkg::*;
    import machine_mode_types_1_13_pkg::*;
    import rv32m_pkg::*;
    import rv32b_pkg::*;
    import rv32a_pkg::*;
    import rv32zc_pkg::*;

    stype_t  instr_s;
    itype_t  instr_i;
    rtype_t  instr_r;
    sbtype_t instr_sb;
    utype_t  instr_u;
    ujtype_t instr_uj;

    // Set if base ISA doesn't have this instruction, but overriden by claim from extension
    logic maybe_illegal;
    logic claimed;
    // Per-extension claim signals
    logic rv32m_claim, rv32a_claim, rv32b_claim;
    // A extension helpers
    // TODO: Add cu plumbing for AMO execution
    logic rv32a_lr, rv32a_sc, rv32a_amo;
    logic rv32zc_claim;
    // Privileged trap signals
    logic tvm_trap, tw_trap, tsr_trap, disabled_smode_trap;

    assign instr_s = stype_t'(cu_if.instr);
    assign instr_i = itype_t'(cu_if.instr);
    assign instr_r = rtype_t'(cu_if.instr);
    assign instr_sb = sbtype_t'(cu_if.instr);
    assign instr_u = utype_t'(cu_if.instr);
    assign instr_uj = ujtype_t'(cu_if.instr);

    assign cu_if.opcode = opcode_t'(cu_if.instr[6:0]);
    assign rf_if.rs1 = rmgmt_req_reg_r ? rmgmt_rsel_s_0 : cu_if.instr[19:15];
    assign rf_if.rs2 = rmgmt_req_reg_r ? rmgmt_rsel_s_1 : cu_if.instr[24:20];
    assign cu_if.rd = rmgmt_req_reg_w ? rmgmt_rsel_d : cu_if.instr[11:7];
    assign cu_if.shamt = cu_if.instr[24:20];

    // Assign the immediate values
    assign cu_if.imm_I = instr_i.imm11_00;
    assign cu_if.imm_S = {instr_s.imm11_05, instr_s.imm04_00};
    assign cu_if.imm_SB = {
        instr_sb.imm12, instr_sb.imm11, instr_sb.imm10_05, instr_sb.imm04_01, 1'b0
    };
    assign cu_if.imm_UJ = {
        instr_uj.imm20, instr_uj.imm19_12, instr_uj.imm11, instr_uj.imm10_01, 1'b0
    };
    assign cu_if.imm_U = {instr_u.imm31_12, 12'b0};

    assign cu_if.imm_shamt_sel = (cu_if.opcode == IMMED &&
                            (instr_i.funct3 == SLLI || instr_i.funct3 == SRI));

    // Assign branch and load type
    assign cu_if.load_type = rv32a_lr ? LW : load_t'(instr_i.funct3);
    assign cu_if.branch_type = branch_t'(instr_sb.funct3);

    // Assign memory read/write enables
    assign cu_if.dwen = (cu_if.opcode == STORE) || rv32a_sc;
    assign cu_if.dren = (cu_if.opcode == LOAD) || rv32a_lr;
    assign cu_if.ifence = (cu_if.opcode == MISCMEM) && (rv32i_miscmem_t'(instr_r.funct3) == FENCEI);

    // Assign control flow signals
    assign cu_if.branch = (cu_if.opcode == BRANCH);
    assign cu_if.jump = (cu_if.opcode == JAL || cu_if.opcode == JALR);
    assign cu_if.ex_pc_sel = (cu_if.opcode == JAL || cu_if.opcode == JALR);
    assign cu_if.j_sel = (cu_if.opcode == JAL);

    // Assign alu operands
    always_comb begin
        case (cu_if.opcode)
            REGREG, IMMED, LOAD: cu_if.alu_a_sel = 2'd0;
            STORE:               cu_if.alu_a_sel = 2'd1;
            AUIPC:               cu_if.alu_a_sel = 2'd2;
            default:             cu_if.alu_a_sel = 2'd2;
        endcase
        if (rv32a_lr || rv32a_sc) cu_if.alu_a_sel = 2'd0;
    end

    always_comb begin
        case (cu_if.opcode)
            STORE:       cu_if.alu_b_sel = 2'd0;
            REGREG:      cu_if.alu_b_sel = 2'd1;
            IMMED, LOAD: cu_if.alu_b_sel = 2'd2;
            AUIPC:       cu_if.alu_b_sel = 2'd3;
            default:     cu_if.alu_b_sel = 2'd1;
        endcase
    end

    // Assign write select
    always_comb begin
        case (cu_if.opcode)
            LOAD:                 cu_if.w_sel = W_SEL_FROM_DLOAD;
            JAL, JALR:            cu_if.w_sel = W_SEL_FROM_PC;
            LUI:                  cu_if.w_sel = W_SEL_FROM_IMM_U;
            IMMED, AUIPC, REGREG: cu_if.w_sel = W_SEL_FROM_ALU; // RV32M: Opcodes are REGREG, no change needed
            SYSTEM:               cu_if.w_sel = W_SEL_FROM_PRIV_PIPE;
            default:              cu_if.w_sel = W_SEL_FROM_DLOAD;
        endcase
        if (rv32a_lr || rv32a_sc) cu_if.w_sel = W_SEL_FROM_DLOAD;
    end

    // Assign register write enable
    always_comb begin
        case (cu_if.opcode)
            STORE, BRANCH:                              cu_if.wen = 1'b0;
            IMMED, LUI, AUIPC, REGREG, JAL, JALR, LOAD: cu_if.wen = 1'b1;
            SYSTEM:                                     cu_if.wen = cu_if.csr_rw_valid;
            default:                                    cu_if.wen = 1'b0;
        endcase
        if (rv32a_lr || rv32a_sc) cu_if.wen = 1'b1;
    end

    // Assign alu opcode
    logic sr, aluop_srl, aluop_sra, aluop_add, aluop_sub, aluop_and, aluop_or;
    logic aluop_sll, aluop_xor, aluop_slt, aluop_sltu, add_sub;

    assign sr = ((cu_if.opcode == IMMED && instr_i.funct3 == SRI) ||
                (cu_if.opcode == REGREG && instr_r.funct3 == SR));
    assign add_sub = (cu_if.opcode == REGREG && instr_r.funct3 == ADDSUB);

    assign aluop_sll = ((cu_if.opcode == IMMED && instr_i.funct3 == SLLI) ||
                      (cu_if.opcode == REGREG && instr_r.funct3 == SLL));
    assign aluop_sra = sr && cu_if.instr[30];
    assign aluop_srl = sr && ~cu_if.instr[30];
    assign aluop_add = ((cu_if.opcode == IMMED && instr_i.funct3 == ADDI) ||
                      (cu_if.opcode == AUIPC) ||
                      (add_sub && ~cu_if.instr[30]) ||
                      (cu_if.opcode == LOAD) ||
                      (cu_if.opcode == STORE));
    assign aluop_sub = (add_sub && cu_if.instr[30]);
    assign aluop_and = ((cu_if.opcode == IMMED && instr_i.funct3 == ANDI) ||
                      (cu_if.opcode == REGREG && instr_r.funct3 == AND));
    assign aluop_or = ((cu_if.opcode == IMMED && instr_i.funct3 == ORI) ||
                      (cu_if.opcode == REGREG && instr_r.funct3 == OR));
    assign aluop_xor = ((cu_if.opcode == IMMED && instr_i.funct3 == XORI) ||
                      (cu_if.opcode == REGREG && instr_r.funct3 == XOR));
    assign aluop_slt = ((cu_if.opcode == IMMED && instr_i.funct3 == SLTI) ||
                      (cu_if.opcode == REGREG && instr_r.funct3 == SLT));
    assign aluop_sltu = ((cu_if.opcode == IMMED && instr_i.funct3 == SLTIU) ||
                      (cu_if.opcode == REGREG && instr_r.funct3 == SLTU));

    always_comb begin
        if (aluop_sll) cu_if.alu_op = ALU_SLL;
        else if (aluop_sra) cu_if.alu_op = ALU_SRA;
        else if (aluop_srl) cu_if.alu_op = ALU_SRL;
        else if (aluop_add) cu_if.alu_op = ALU_ADD;
        else if (aluop_sub) cu_if.alu_op = ALU_SUB;
        else if (aluop_and) cu_if.alu_op = ALU_AND;
        else if (aluop_or) cu_if.alu_op = ALU_OR;
        else if (aluop_xor) cu_if.alu_op = ALU_XOR;
        else if (aluop_slt) cu_if.alu_op = ALU_SLT;
        else if (aluop_sltu) cu_if.alu_op = ALU_SLTU;
        else cu_if.alu_op = ALU_ADD;
    end

    // HALT HACK. Just looking for j + 0x0 (infinite loop)
    // Halt required for unit testing, but not useful in tapeout context
    // Due to presence of interrupts, infinite loops are valid
    generate
        if (INFINITE_LOOP_HALTS == "true") begin : g_inf_loop_halt
            assign cu_if.halt = (cu_if.instr == 32'h0000006f);
        end else begin : g_no_halt
            assign cu_if.halt = '0;
        end
    endgenerate
    // Privilege Control Signals
    assign cu_if.fault_insn = '0;

    always_comb begin
        case (cu_if.opcode)
            REGREG: maybe_illegal = instr_r.funct7[0];
            LUI, AUIPC, JAL, JALR, BRANCH, LOAD, STORE, IMMED, SYSTEM, MISCMEM, opcode_t'('0):
            maybe_illegal = 1'b0;
            default: maybe_illegal = 1'b1;
        endcase
    end

    // Trap VM if TVM is set, privilege level is S-Mode and either an sfence or csr R/W to SATP
    assign tvm_trap = ((cu_if.sfence) || (cu_if.csr_rw_valid && cu_if.csr_addr == SATP_ADDR)) && prv_pipe_if.mstatus.tvm && prv_pipe_if.curr_privilege_level == S_MODE;

    // Raise illegal instruction on WFI if Timer Wait is set, and privilege mode is not M-Mode
    assign tw_trap  = cu_if.wfi && prv_pipe_if.mstatus.tw && prv_pipe_if.curr_privilege_level != M_MODE;

    // Trap Supervisor Returns if SRET instruction, TSR is set, and current privilege level is S-Mode
    assign tsr_trap = cu_if.sret_insn && prv_pipe_if.mstatus.tsr && prv_pipe_if.curr_privilege_level == S_MODE;

    // Trap when we have a supervisor instruction and the Supervisor Extension is disabled
    assign disabled_smode_trap = (cu_if.sfence || cu_if.sret_insn) && SUPERVISOR_ENABLED == "disabled";

    // Illegal instruction logic
    assign cu_if.illegal_insn = (maybe_illegal && !claimed) || tvm_trap || tw_trap || tsr_trap || disabled_smode_trap;
    assign claimed = rv32m_claim || rv32a_claim || rv32b_claim || rv32zc_claim; // Add OR conditions for new extensions

    //Decoding of System Priv Instructions
    always_comb begin
        cu_if.mret_insn = 1'b0;
        cu_if.sret_insn = 1'b0;
        cu_if.breakpoint = 1'b0;
        cu_if.ecall_insn = 1'b0;
        cu_if.wfi = 1'b0;
        cu_if.sfence = 1'b0;

        if (cu_if.opcode == SYSTEM) begin
            if (rv32i_system_t'(instr_i.funct3) == PRIV) begin
                if (priv_insn_t'(instr_i.imm11_00) == SRET) cu_if.sret_insn = 1'b1;
                if (priv_insn_t'(instr_i.imm11_00) == MRET) cu_if.mret_insn = 1'b1;
                if (priv_insn_t'(instr_i.imm11_00) == EBREAK) cu_if.breakpoint = 1'b1;
                if (priv_insn_t'(instr_i.imm11_00) == ECALL) cu_if.ecall_insn = 1'b1;
                if (priv_insn_t'(instr_i.imm11_00) == WFI) cu_if.wfi = 1'b1;
                if (memmgmt_t'(instr_r.funct7) == SFENCE_VMA) cu_if.sfence = 1'b1;
            end
        end
    end

    //CSR Insns
    always_comb begin
        cu_if.csr_swap = 1'b0;
        cu_if.csr_clr  = 1'b0;
        cu_if.csr_set  = 1'b0;
        cu_if.csr_imm  = 1'b0;

        if (cu_if.opcode == SYSTEM) begin
            if (rv32i_system_t'(instr_r.funct3) == CSRRW) begin
                cu_if.csr_swap = 1'b1;
            end else if (rv32i_system_t'(instr_r.funct3) == CSRRS) begin
                cu_if.csr_set = 1'b1;
            end else if (rv32i_system_t'(instr_r.funct3) == CSRRC) begin
                cu_if.csr_clr = 1'b1;
            end else if (rv32i_system_t'(instr_r.funct3) == CSRRWI) begin
                cu_if.csr_swap = 1'b1;
                cu_if.csr_imm  = 1'b1;
            end else if (rv32i_system_t'(instr_r.funct3) == CSRRSI) begin
                cu_if.csr_set = 1'b1;
                cu_if.csr_imm = 1'b1;
            end else if (rv32i_system_t'(instr_r.funct3) == CSRRCI) begin
                cu_if.csr_clr = 1'b1;
                cu_if.csr_imm = 1'b1;
            end
        end
    end
    assign cu_if.csr_rw_valid = (cu_if.csr_swap | cu_if.csr_set | cu_if.csr_clr);

    assign cu_if.csr_addr     = csr_addr_t'(instr_i.imm11_00);
    assign cu_if.zimm         = cu_if.instr[19:15];

    // Extension decoding
    `ifdef RV32M_SUPPORTED
    rv32m_decode RV32M_DECODE(
        .insn(cu_if.instr),
        .claim(rv32m_claim),
        .rv32m_control(cu_if.rv32m_control)
    );
    `else
    assign cu_if.rv32m_control = {1'b0, rv32m_op_t'(0)};
    assign rv32m_claim = 1'b0;
    `endif // RV32M_SUPPORTED
    `ifdef RV32A_SUPPORTED
    rv32a_decode RV32A_DECODE(
        .insn(cu_if.instr),
        .claim(rv32a_claim),
        .rv32a_control(cu_if.rv32a_control)
    );
    assign rv32a_lr = rv32a_claim && cu_if.rv32a_control.op == AMO_LR;
    assign rv32a_sc = rv32a_claim && cu_if.rv32a_control.op == AMO_SC;
    assign rv32a_amo = rv32a_claim && ~(rv32a_lr || rv32a_sc);
    assign cu_if.reserve = rv32a_lr || rv32a_sc || rv32a_amo;
    assign cu_if.exclusive = rv32a_amo;
    `else
    assign cu_if.rv32a_control = {1'b0, rv32a_op_e'(0)};
    assign rv32a_claim = 1'b0;
    assign rv32a_lr = 1'b0;
    assign rv32a_sc = 1'b0;
    assign rv32a_amo = 1'b0;
    assign cu_if.reserve = 1'b0;
    assign cu_if.exclusive = 1'b0;
    `endif // RV32M_SUPPORTED

    `ifdef RV32B_SUPPORTED
    rv32b_decode RV32B_DECODE(
        .insn(cu_if.instr),
        .claim(rv32b_claim),
        .rv32b_control(cu_if.rv32b_control)
    );
    `else
    assign cu_if.rv32b_control = {1'b0, rv32b_op_t'(0)};
    assign rv32b_claim = 1'b0;
    `endif

    `ifdef RV32ZICOND_SUPPORTED
    rv32zc_decode RV32ZC_DECODE(
        .insn(cu_if.instr),
        .claim(rv32zc_claim),
        .rv32zc_control(cu_if.rv32zc_control)
    );
    `else
    assign cu_if.rv32zc_control = {1'b0, rv32zc_op_t'(0)};
    assign rv32zc_claim = 1'b0;
    `endif

endmodule
