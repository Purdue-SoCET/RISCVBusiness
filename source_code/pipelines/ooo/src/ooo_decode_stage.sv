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
*   Filename:     ooo_decode_stage.sv
*
*   Created by:   Owen Prince
*   Email:        oprince@purdue.edu
*   Date Created: 02/24/2022
*   Description:  Decode stage for out of order pipeline 
*/

`include "ooo_fetch2_decode_if.vh"
`include "ooo_decode_execute_if.vh"
`include "control_unit_if.vh"
`include "component_selection_defines.vh"
`include "rv32i_reg_file_if.vh"
`include "ooo_hazard_unit_if.vh"
`include "cache_control_if.vh"


module ooo_decode_stage (
  input logic CLK, nRST, halt,
  ooo_fetch2_decode_if.decode fetch_decode_if,
  ooo_decode_execute_if.decode decode_execute_if,
  rv32i_reg_file_if.decode rf_if,
  ooo_hazard_unit_if.decode hazard_if,
  cache_control_if.pipeline cc_if
);

  import rv32i_types_pkg::*;
  import alu_types_pkg::*;
  //import rv32m_pkg::*;
  import machine_mode_types_1_11_pkg::*;

  // Interface declarations
  control_unit_if   cu_if();
 
  // Module instantiations
  /*******************************************************
  * Input to the Control Unit
  *******************************************************/
  assign cu_if.instr = fetch_decode_if.instr;

  control_unit cu (
    .cu_if(cu_if)
  );
  
  /*******************************************************
  *** fence instruction and Associated Logic 
  *******************************************************/
  // posedge detector for ifence
  // subsequent ifences will have same effect as a single fence
  logic ifence_reg;
  logic ifence_pulse;

  always_ff @ (posedge CLK, negedge nRST) begin
    if (~nRST)
      ifence_reg <= 1'b0;
    else if (hazard_if.pc_en)
      ifence_reg <= cu_if.ifence;
  end
  
  assign ifence_pulse = cu_if.ifence && ~ifence_reg;
  assign cc_if.icache_flush = ifence_pulse;
  assign cc_if.icache_clear = 1'b0;
  assign cc_if.dcache_flush = ifence_pulse;
  assign cc_if.dcache_clear = 1'b0;

  //regs to detect flush completion
  logic dflushed, iflushed;

  always_ff @ (posedge CLK, negedge nRST) begin
    if (~nRST)
      iflushed <= 1'b1;
    else if (ifence_pulse)
      iflushed <= 1'b0;
    else if (cc_if.iflush_done & hazard_if.pc_en)
      iflushed <= 1'b1;
  end

  always_ff @ (posedge CLK, negedge nRST) begin
    if (~nRST)
      dflushed <= 1'b1;
    else if (ifence_pulse)
      dflushed <= 1'b0;
    else if (cc_if.dflush_done & hazard_if.pc_en)
      dflushed <= 1'b1;
  end
  
  assign hazard_if.dflushed = dflushed;
  assign hazard_if.iflushed = iflushed;
  assign hazard_if.ifence = decode_execute_if.ifence;
  assign hazard_if.ifence_pc = decode_execute_if.pc;


  /*******************************************************
  * Reg File Logic
  *******************************************************/
  assign rf_if.rs1 = cu_if.reg_rs1;
  assign rf_if.rs2 = cu_if.reg_rs2;

  
  /*******************************************************
  *** Sign Extensions of the Immediate Value
  *******************************************************/
  word_t imm_I_ext, imm_S_ext, imm_UJ_ext;
  assign imm_I_ext  = {{20{cu_if.imm_I[11]}}, cu_if.imm_I};
  assign imm_UJ_ext = {{11{cu_if.imm_UJ[20]}}, cu_if.imm_UJ};
  assign imm_S_ext  = {{20{cu_if.imm_S[11]}}, cu_if.imm_S};

  /*******************************************************
  *** Jump Target Calculator and Associated Logic 
  *******************************************************/
  word_t base, offset;
  always_comb begin
    if (cu_if.j_sel) begin
      base = fetch_decode_if.pc;
      offset = imm_UJ_ext;
    end else begin
      base = rf_if.rs1_data;
      offset = imm_I_ext;
    end
  end 

  /*******************************************************
  *** Source Select Logic
  *******************************************************/
  word_t imm_or_shamt, next_reg_file_wdata;
  assign imm_or_shamt = (cu_if.imm_shamt_sel == 1'b1) ? cu_if.shamt : imm_I_ext;

  word_t fu_source_a;
  word_t fu_source_b;
  always_comb begin
    case (cu_if.source_a_sel)
      2'd0: fu_source_a = rf_if.rs1_data;
      2'd1: fu_source_a = imm_S_ext;
      2'd2: fu_source_a = fetch_decode_if.pc;
      2'd3: fu_source_a = '0; //Not Used 
    endcase
  end
 
  always_comb begin
    case(cu_if.source_b_sel)
      2'd0: fu_source_b = rf_if.rs1_data;
      2'd1: fu_source_b = rf_if.rs2_data;
      2'd2: fu_source_b = imm_or_shamt;
      2'd3: fu_source_b = cu_if.imm_U;
    endcase
  end

  always_comb begin
    case(cu_if.w_src)
      3'd1    : next_reg_file_wdata = fetch_decode_if.pc4;
      3'd2    : next_reg_file_wdata = cu_if.imm_U;
      default : next_reg_file_wdata = '0; 
    endcase
  end
  
  
  
  /*******************************************************
  *** Hazard unit connection  
  *******************************************************/
  assign hazard_if.halt = cu_if.halt; //TODO

  /*********************************************************
  *** Signals for Bind Tracking - Read-Only, These don't affect execution
  *********************************************************/
  // CPU Tracker binding
  cpu_tracker_t tracker_sigs;
  assign tracker_sigs.funct3     = cu_if.instr[14:12];
  assign tracker_sigs.funct12    = cu_if.instr[31:20];
  assign tracker_sigs.instr_30   = cu_if.instr[30];
  assign tracker_sigs.imm_S      = cu_if.imm_S;
  assign tracker_sigs.imm_I      = cu_if.imm_I;
  assign tracker_sigs.imm_U      = cu_if.imm_U;
  assign tracker_sigs.imm_UJ_ext = imm_UJ_ext;
  assign tracker_sigs.imm_SB     = cu_if.imm_SB;
  assign tracker_sigs.reg_rs1    = cu_if.reg_rs1;
  assign tracker_sigs.reg_rs2    = cu_if.reg_rs2;

  /*********************************************************
  *** Stall signals
  *********************************************************/
  assign stall_multiply = hazard_if.stall; 
  assign stall_divide = hazard_if.stall; 
  assign stall_arith = hazard_if.stall; 
  assign stall_loadstore = hazard_if.stall; 



  always_ff @(posedge CLK, negedge nRST) begin
    if (~nRST) begin
            //FUNC UNIT
            decode_execute_if.sfu_type   <= ARITH_S;
           //REG_FILE/ WRITEBACK
            //HALT
            decode_execute_if.halt_instr <= '0;
            //CPU tracker
            decode_execute_if.tracker_sigs <= '0;
    end 
    else begin 
        if (((hazard_if.id_ex_flush | hazard_if.stall) & hazard_if.pc_en) | halt) begin
            //FUNC UNIT
          decode_execute_if.sfu_type   <= ARITH_S;
           //REG_FILE/ WRITEBACK
            //HALT
          decode_execute_if.halt_instr <= '0;
            //CPU tracker
          decode_execute_if.tracker_sigs <= '0;
        end else if(hazard_if.pc_en & ~hazard_if.stall) begin
          //FUNC UNIT
          decode_execute_if.sfu_type   <= cu_if.sfu_type;
          //REG_FILE/ WRITEBACK
          //HALT
          decode_execute_if.halt_instr <= cu_if.halt;
          //CPU tracker
          decode_execute_if.cpu_track_sigs <= tracker_sigs;
        end
    end
  end
  // BIG TODO: put in the logic for rs1 and rs2
  always @(posedge CLK, negedge nRST) begin : MULTIPLY_UNIT
    if (~nRST) begin
      decode_execute_if.mult_sigs <= '0;
      decode_execute_if.div_sigs <= '0;
      decode_execute_if.lsu_sigs <= '0;
    end else begin
      if ((hazard_if.id_ex_flush & hazard_if.pc_en) | halt) begin
        // case of a flush
        decode_execute_if.mult_sigs <= '0;
        decode_execute_if.div_sigs <= '0;
        decode_execute_if.lsu_sigs <= '0;
      end
      // stall cases
      else if(hazard_if.stall & hazard_if.pc_en) begin
        decode_execute_if.mult_sigs <= '0;
        decode_execute_if.div_sigs <= '0;
        decode_execute_if.lsu_sigs <= '0;
      end
      // normal operation
      end else if(hazard_if.pc_en) begin
        decode_execute_if.mult_sigs <= cu_if.mult_sigs;
        decode_execute_if.div_sigs <= cu_if.div_sigs;
        decode_execute_if.lsu_sigs <= cu_if.lsu_sigs;
      end
    end
  end

  always @(posedge CLK, negedge nRST) begin : ARITH_UNIT
    if (~nRST) begin
        decode_execute_if.arith_sigs <= '0;
        decode_execute_if.arith.aluop                   <= 0;
        decode_execute_if.arith.port_a                  <= 0;
        decode_execute_if.arith.port_b                  <= 0;
        decode_execute_if.arith.reg_file_wdata          <= '0;
        decode_execute_if.arith.pc              <= '0;
        //WRITEBACK
        //JUMP
        decode_execute_if.JUMP_STRUCT.jump_instr        <= '0;
        decode_execute_if.JUMP_STRUCT.j_base            <= '0;
        decode_execute_if.JUMP_STRUCT.j_offset          <= '0;
        decode_execute_if.JUMP_STRUCT.j_sel             <= '0;
        //BRANCH
        decode_execute_if.BRANCH_STRUCT.br_imm_sb       <= '0;
        decode_execute_if.BRANCH_STRUCT.br_branch_type  <= '0;
        //BRANCH PREDICTOR UPDATE
        decode_execute_if.BRANCH_STRUCT.branch_instr    <= '0;
        decode_execute_if.BRANCH_STRUCT.prediction      <= '0;
        decode_execute_if.BRANCH_STRUCT.pc4             <= '0;
        //csr
        decode_execute_if.CSR_STRUCT.csr_instr          <= '0;
        decode_execute_if.CSR_STRUCT.csr_swap           <= '0;
        decode_execute_if.CSR_STRUCT.csr_clr            <= '0;
        decode_execute_if.CSR_STRUCT.csr_set            <= '0;
        decode_execute_if.CSR_STRUCT.csr_addr           <= '0;
        decode_execute_if.CSR_STRUCT.csr_imm            <= '0;
        decode_execute_if.CSR_STRUCT.csr_imm_value      <= '0;
        decode_execute_if.CSR_STRUCT.instr              <= '0;
        //Exceptions
        decode_execute_if.EXCEPTION_STRUCT.illegal_insn <= '0;
        decode_execute_if.EXCEPTION_STRUCT.breakpoint   <= '0;
        decode_execute_if.EXCEPTION_STRUCT.ecall_insn   <= '0;
        decode_execute_if.EXCEPTION_STRUCT.ret_insn     <= '0;
        decode_execute_if.EXCEPTION_STRUCT.token        <= '0;
        decode_execute_if.EXCEPTION_STRUCT.mal_insn     <= '0;
        decode_execute_if.EXCEPTION_STRUCT.fault_insn   <= '0;
        decode_execute_if.EXCEPTION_STRUCT.wfi          <= '0;
    end else begin
      if (((hazard_if.id_ex_flush | hazard_if.stall_au) & hazard_if.pc_en) | halt) begin
        decode_execute_if.arith_sigs <= '0;
        decode_execute_if.arith.aluop                   <= aluop_t'(0);
        decode_execute_if.arith.port_a                  <= 0;
        decode_execute_if.arith.port_b                  <= 0;
        decode_execute_if.arith.reg_file_wdata          <= '0;
        //WRITEBACK
        //JUMP
        decode_execute_if.JUMP_STRUCT.jump_instr        <= '0;
        decode_execute_if.JUMP_STRUCT.j_base            <= '0;
        decode_execute_if.JUMP_STRUCT.j_offset          <= '0;
        decode_execute_if.JUMP_STRUCT.j_sel             <= '0;
        //BRANCH
        decode_execute_if.BRANCH_STRUCT.br_imm_sb       <= '0;
        decode_execute_if.BRANCH_STRUCT.br_branch_type  <= '0;
        //BRANCH PREDICTOR UPDATE
        decode_execute_if.BRANCH_STRUCT.branch_instr    <= '0;
        decode_execute_if.BRANCH_STRUCT.prediction      <= '0;
        decode_execute_if.BRANCH_STRUCT.pc              <= '0;
        decode_execute_if.BRANCH_STRUCT.pc4             <= '0;
        //csr
        decode_execute_if.CSR_STRUCT.csr_instr          <= '0;
        decode_execute_if.CSR_STRUCT.csr_swap           <= '0;
        decode_execute_if.CSR_STRUCT.csr_clr            <= '0;
        decode_execute_if.CSR_STRUCT.csr_set            <= '0;
        decode_execute_if.CSR_STRUCT.csr_addr           <= '0;
        decode_execute_if.CSR_STRUCT.csr_imm            <= '0;
        decode_execute_if.CSR_STRUCT.csr_imm_value      <= '0;
        decode_execute_if.CSR_STRUCT.instr              <= '0;
        //Exceptions
        decode_execute_if.EXCEPTION_STRUCT.illegal_insn <= '0;
        decode_execute_if.EXCEPTION_STRUCT.breakpoint   <= '0;
        decode_execute_if.EXCEPTION_STRUCT.ecall_insn   <= '0;
        decode_execute_if.EXCEPTION_STRUCT.ret_insn     <= '0;
        decode_execute_if.EXCEPTION_STRUCT.token        <= '0;
        decode_execute_if.EXCEPTION_STRUCT.mal_insn     <= '0;
        decode_execute_if.EXCEPTION_STRUCT.fault_insn   <= '0;
        decode_execute_if.EXCEPTION_STRUCT.wfi          <= '0;

      end else if(hazard_if.pc_en & ~hazard_if.stall_au) begin
        decode_execute_if.arith_sigs <= cu_if.arith_sigs;
        decode_execute_if.arith.port_a                  <= fu_source_a;
        decode_execute_if.arith.port_b                  <= fu_source_b;
        decode_execute_if.arith.reg_file_wdata          <= next_reg_file_wdata;
        //WRITEBACK
        //JUMP
        decode_execute_if.JUMP_STRUCT.jump_instr        <= cu_if.jump;
        decode_execute_if.JUMP_STRUCT.j_base            <= base;
        decode_execute_if.JUMP_STRUCT.j_offset          <= offset;
        decode_execute_if.JUMP_STRUCT.j_sel             <= cu_if.j_sel;
        //BRANCH
        decode_execute_if.BRANCH_STRUCT.br_imm_sb       <= cu_if.imm_SB;
        decode_execute_if.BRANCH_STRUCT.br_branch_type  <= cu_if.branch_type;
        //BRANCH PREDICTOR UPDATE
        decode_execute_if.BRANCH_STRUCT.branch_instr    <= cu_if.branch;
        decode_execute_if.BRANCH_STRUCT.prediction      <= fetch_decode_if.prediction;
        decode_execute_if.BRANCH_STRUCT.pc              <= fetch_decode_if.pc;
        decode_execute_if.BRANCH_STRUCT.pc4             <= fetch_decode_if.pc4;
                //csr
        decode_execute_if.CSR_STRUCT.csr_instr          <= (cu_if.opcode == SYSTEM);
        decode_execute_if.CSR_STRUCT.csr_swap           <= cu_if.csr_swap;
        decode_execute_if.CSR_STRUCT.csr_clr            <= cu_if.csr_clr;
        decode_execute_if.CSR_STRUCT.csr_set            <= cu_if.csr_set;
        decode_execute_if.CSR_STRUCT.csr_addr           <= cu_if.csr_addr;
        decode_execute_if.CSR_STRUCT.csr_imm            <= cu_if.csr_imm;
        decode_execute_if.CSR_STRUCT.csr_imm_value      <= {27'h0, cu_if.zimm};
        decode_execute_if.CSR_STRUCT.instr              <= fetch_decode_if.instr;
        //Exceptions
        decode_execute_if.EXCEPTION_STRUCT.illegal_insn <= cu_if.illegal_insn;
        decode_execute_if.EXCEPTION_STRUCT.breakpoint   <= cu_if.breakpoint;
        decode_execute_if.EXCEPTION_STRUCT.ecall_insn   <= cu_if.ecall_insn;
        decode_execute_if.EXCEPTION_STRUCT.ret_insn     <= cu_if.ret_insn;
        decode_execute_if.EXCEPTION_STRUCT.token        <= fetch_decode_if.token;
        decode_execute_if.EXCEPTION_STRUCT.mal_insn     <= fetch_decode_if.mal_insn;
        decode_execute_if.EXCEPTION_STRUCT.fault_insn   <= fetch_decode_if.fault_insn;
        decode_execute_if.EXCEPTION_STRUCT.wfi          <= cu_if.wfi;
        decode_execute_if.EXCEPTION_STRUCT.w_src        <= cu_if.arith.w_src;

      end
    end
  end

endmodule
