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

`include "control_unit_if.vh"
`include "rv32i_reg_file_if.vh"
`include "risc_mgmt_if.vh"
`include "decompressor_if.vh"

module control_unit 
(
  control_unit_if.control_unit  cu_if,
  rv32i_reg_file_if.cu          rf_if,
  input logic [4:0] rmgmt_rsel_s_0, rmgmt_rsel_s_1, rmgmt_rsel_d,
  input logic rmgmt_req_reg_r, rmgmt_req_reg_w 
);
  import alu_types_pkg::*;
  import rv32i_types_pkg::*;
  import machine_mode_types_1_11_pkg::*;

  stype_t         instr_s;
  itype_t         instr_i;
  rtype_t         instr_r;
  sbtype_t        instr_sb;
  utype_t         instr_u;
  ujtype_t        instr_uj;

  assign instr_s = stype_t'(cu_if.instr);
  assign instr_i = itype_t'(cu_if.instr);
  assign instr_r = rtype_t'(cu_if.instr);
  assign instr_sb = sbtype_t'(cu_if.instr);
  assign instr_u = utype_t'(cu_if.instr);
  assign instr_uj = ujtype_t'(cu_if.instr);

  assign cu_if.opcode = opcode_t'(cu_if.instr[6:0]);
  assign rf_if.rs1  = rmgmt_req_reg_r ? rmgmt_rsel_s_0 : cu_if.instr[19:15];
  assign rf_if.rs2  = rmgmt_req_reg_r ? rmgmt_rsel_s_1 : cu_if.instr[24:20];
  assign rf_if.rd   = rmgmt_req_reg_w ? rmgmt_rsel_d   : cu_if.instr[11:7]; 
  assign cu_if.shamt = cu_if.instr[24:20];
 
  // Assign the immediate values
  assign cu_if.imm_I  = instr_i.imm11_00;
  assign cu_if.imm_S  = {instr_s.imm11_05, instr_s.imm04_00};
  assign cu_if.imm_SB = {instr_sb.imm12, instr_sb.imm11, instr_sb.imm10_05,
                         instr_sb.imm04_01, 1'b0};
  assign cu_if.imm_UJ = {instr_uj.imm20, instr_uj.imm19_12, instr_uj.imm11,
                         instr_uj.imm10_01, 1'b0};
  assign cu_if.imm_U  = {instr_u.imm31_12, 12'b0};

  assign cu_if.imm_shamt_sel = (cu_if.opcode == IMMED &&
                            (instr_i.funct3 == SLLI || instr_i.funct3 == SRI));

  // Assign branch and load type
  assign cu_if.load_type    = load_t'(instr_i.funct3);
  assign cu_if.branch_type  = branch_t'(instr_sb.funct3);

  // Assign memory read/write enables
  assign cu_if.dwen = (cu_if.opcode == STORE);
  assign cu_if.dren = (cu_if.opcode == LOAD);
  assign cu_if.ifence = (cu_if.opcode == MISCMEM) && (rv32i_miscmem_t'(instr_r.funct3) == FENCEI);

  // Assign control flow signals
  assign cu_if.branch     = (cu_if.opcode == BRANCH);
  assign cu_if.jump       = (cu_if.opcode == JAL || cu_if.opcode == JALR);
  assign cu_if.ex_pc_sel  = (cu_if.opcode == JAL || cu_if.opcode == JALR);
  assign cu_if.j_sel      = (cu_if.opcode == JAL);
  // Assign alu operands
  always_comb begin
    case(cu_if.opcode)
      REGREG, IMMED, LOAD : cu_if.alu_a_sel = 2'd0;
      STORE               : cu_if.alu_a_sel = 2'd1;
      AUIPC               : cu_if.alu_a_sel = 2'd2;
      default             : cu_if.alu_a_sel = 2'd2;
    endcase
  end

  always_comb begin
    case(cu_if.opcode)
      STORE       : cu_if.alu_b_sel = 2'd0;
      REGREG      : cu_if.alu_b_sel = 2'd1;
      IMMED, LOAD : cu_if.alu_b_sel = 2'd2;
      AUIPC       : cu_if.alu_b_sel = 2'd3;
      default     : cu_if.alu_b_sel = 2'd1;
    endcase
  end

  // Assign write select
  always_comb begin
    case(cu_if.opcode)
      LOAD                  : cu_if.w_sel   = 3'd0;
      JAL, JALR             : cu_if.w_sel   = 3'd1;
      LUI                   : cu_if.w_sel   = 3'd2;
      IMMED, AUIPC, REGREG  : cu_if.w_sel   = 3'd3;
      SYSTEM                : cu_if.w_sel   = 3'd4;
      default               : cu_if.w_sel   = 3'd0;
    endcase
  end

  // Assign register write enable
  always_comb begin
    case(cu_if.opcode)
      STORE, BRANCH       : cu_if.wen   = 1'b0;
      IMMED, LUI, AUIPC,
      REGREG, JAL, JALR,
      LOAD                : cu_if.wen   = 1'b1;
      SYSTEM              : cu_if.wen   = cu_if.csr_rw_valid;
      default:  cu_if.wen   = 1'b0;
    endcase
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
    if (aluop_sll)
      cu_if.alu_op = ALU_SLL;
    else if (aluop_sra)
      cu_if.alu_op = ALU_SRA;
    else if (aluop_srl)
      cu_if.alu_op = ALU_SRL;
    else if (aluop_add)
      cu_if.alu_op = ALU_ADD;
    else if (aluop_sub)
      cu_if.alu_op = ALU_SUB;
    else if (aluop_and)
      cu_if.alu_op = ALU_AND;
    else if (aluop_or)
      cu_if.alu_op = ALU_OR;
    else if (aluop_xor)
      cu_if.alu_op = ALU_XOR;
    else if (aluop_slt)
      cu_if.alu_op = ALU_SLT;
    else if (aluop_sltu)
      cu_if.alu_op = ALU_SLTU;
    else
      cu_if.alu_op = ALU_ADD;
  end

  // HALT HACK. Just looking for j + 0x0 (infinite loop)
  // Halt required for unit testing, but not useful in tapeout context
  // Due to presence of interrupts, infinite loops are valid
  generate
    if(INFINITE_LOOP_HALTS == "true") begin
      assign cu_if.halt = (cu_if.instr == 32'h0000006f);
    end else begin
      assign cu_if.halt = '0;
    end
  endgenerate
  // Privilege Control Signals
  assign cu_if.fault_insn = '0;
 
  always_comb begin
    case(cu_if.opcode)
      REGREG: cu_if.illegal_insn = instr_r.funct7[0];
      LUI, AUIPC, JAL, JALR,
      BRANCH, LOAD, STORE,
      IMMED, SYSTEM,
      MISCMEM, opcode_t'('0)           : cu_if.illegal_insn = 1'b0;
      default                 : cu_if.illegal_insn = 1'b1;
    endcase
  end
 
  //Decoding of System Priv Instructions
  always_comb begin
    cu_if.ret_insn = 1'b0;
    cu_if.breakpoint = 1'b0;
    cu_if.ecall_insn = 1'b0;
    cu_if.wfi = 1'b0;

    if (cu_if.opcode == SYSTEM) begin
      if (rv32i_system_t'(instr_i.funct3) == PRIV) begin
        if (priv_insn_t'(instr_i.imm11_00) == MRET)
          cu_if.ret_insn = 1'b1;
        if (priv_insn_t'(instr_i.imm11_00) == EBREAK)
          cu_if.breakpoint = 1'b1;
        if (priv_insn_t'(instr_i.imm11_00) == ECALL)
          cu_if.ecall_insn = 1'b1;
        if (priv_insn_t'(instr_i.imm11_00) == WFI)
          cu_if.wfi = 1'b1;
      end
    end
  end

  //CSR Insns
  always_comb begin
    cu_if.csr_swap  = 1'b0;
    cu_if.csr_clr   = 1'b0;
    cu_if.csr_set   = 1'b0;
    cu_if.csr_imm   = 1'b0;

    if (cu_if.opcode == SYSTEM) begin
      if (rv32i_system_t'(instr_r.funct3) == CSRRW) begin
        cu_if.csr_swap  = 1'b1;
      end  else
      if (rv32i_system_t'(instr_r.funct3) == CSRRS) begin
        cu_if.csr_set   = 1'b1;
      end else if (rv32i_system_t'(instr_r.funct3) == CSRRC) begin 
        cu_if.csr_clr = 1'b1;
      end else if (rv32i_system_t'(instr_r.funct3) == CSRRWI) begin
        cu_if.csr_swap  = 1'b1;
        cu_if.csr_imm   = 1'b1;
      end else if (rv32i_system_t'(instr_r.funct3) == CSRRSI) begin
        cu_if.csr_set   = 1'b1;
        cu_if.csr_imm   = 1'b1;
      end else if (rv32i_system_t'(instr_r.funct3) == CSRRCI) begin
        cu_if.csr_clr = 1'b1;
        cu_if.csr_imm   = 1'b1;
      end
    end
  end
  assign cu_if.csr_rw_valid = (cu_if.csr_swap | cu_if.csr_set | cu_if.csr_clr);

  assign cu_if.csr_addr = csr_addr_t'(instr_i.imm11_00);
  assign cu_if.zimm     = cu_if.instr[19:15];

endmodule

