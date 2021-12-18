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
*   Filename:     rv32v_execute_stage.sv
*
*   Created by:   Jing Yin See
*   Email:        see4@purdue.edu
*   Date Created: 10/30/2021
*   Description:  RV32V Execute Stage
*/

`include "rv32v_execute_memory_if.vh"
`include "rv32v_decode_execute_if.vh"
`include "vector_lane_if.vh"
`include "iota_logic_if.vh"

module rv32v_execute_stage (
  input logic CLK, nRST,
  rv32v_hazard_unit_if.execute hu_if,
  rv32v_decode_execute_if.execute decode_execute_if,
  rv32v_execute_memory_if.execute execute_memory_if
);

  import rv32v_types_pkg::*;

  logic [31:0] aluresult0, aluresult1, portb0, base_addr, addr_buffer, coherence_res;
  logic ls, latch_ena;

  logic mask_bit_found;
  logic zero_aluresult1, ones_aluresult0, ones_aluresult1;
  logic mul_done_ff2, mul_done_ff0, mul_done_ff1, mul_done_ff3;
  logic mlu_ff0, mlu_ff1, mlu_ff2;
  sew_t eew_ff0, eew_ff1, eew_ff2;
  logic [4:0] vd_ff0, vd_ff1, vd_ff2;

  vector_lane_if vif0 ();
  vector_lane_if vif1 ();
  iota_logic_if iif ();

  vector_lane V0 (CLK, nRST, vif0);
  vector_lane V1 (CLK, nRST, vif1);
  iota_logic IL (CLK, nRST, iif);

  assign portb0    = decode_execute_if.stride_type ? decode_execute_if.stride_val : 4;
  assign base_addr = decode_execute_if.xs1;
  assign rd_wen    = decode_execute_if.rd_wen | decode_execute_if.config_type;
  assign rd_sel    = decode_execute_if.rd_sel;
  assign rd_data   = decode_execute_if.config_type ? decode_execute_if.vl : coherence_res; //TODO: Add coherence unit signal

  // Iota logic signals
  assign iif.mask_bits = {vif1.vs2_data, vif0.vs2_data};
  assign iif.start     = decode_execute_if.fu_type == MASK & decode_execute_if.mask_type == VMASK_IOTA;
  assign iif.sew       = decode_execute_if.sew;
  assign iif.max       = decode_execute_if.vl;

  // Data select 
  assign vif0.vs3_data = decode_execute_if.vs3_lane0; // Needed for mul-add instr
  assign vif1.vs3_data = decode_execute_if.vs3_lane1; // Needed for mul-add instr
  always_comb begin
    case(decode_execute_if.rs1_type)
      V:
      begin
        vif0.vs1_data = decode_execute_if.vs1_lane0;
        vif1.vs1_data = decode_execute_if.vs1_lane1;
      end
      I:
      begin
        vif0.vs1_data = decode_execute_if.imm;
        vif1.vs1_data = decode_execute_if.imm;
      end
      X:
      begin
        vif0.vs1_data = decode_execute_if.xs1;
        vif1.vs1_data = decode_execute_if.xs1;
      end
      default:
      begin
        vif0.vs1_data = '0;
        vif1.vs1_data = '0;
      end 
    endcase
  end

  always_comb begin
    case(decode_execute_if.rs2_type)
      V:
      begin
        vif0.vs2_data = decode_execute_if.vs2_lane0;
        vif1.vs2_data = decode_execute_if.vs2_lane1;
      end
      I:
      begin
        vif0.vs2_data = decode_execute_if.imm;
        vif1.vs2_data = decode_execute_if.imm;
      end
      X:
      begin
        vif0.vs2_data = decode_execute_if.xs2;
        vif1.vs2_data = decode_execute_if.xs2;
      end
      default:
      begin
        vif0.vs2_data = '0;
        vif1.vs2_data = '0;
      end 
    endcase
  end

  // Vector Lane 0
  //assign vif0.stride          = decode_execute_if.stride;
  assign vif0.fu_type         = decode_execute_if.fu_type;
  //assign vif0.load_store_type = decode_execute_if.load_store_type;
  assign vif0.result_type     = decode_execute_if.result_type;
  assign vif0.offset          = decode_execute_if.woffset0;
  assign vif0.aluop           = decode_execute_if.aluop;
  assign vif0.mask            = decode_execute_if.mask0;
  assign vif0.reduction_ena   = decode_execute_if.reduction_ena;
  assign vif0.porta0          = addr_buffer;
  assign vif0.porta1          = base_addr;
  assign vif0.portb0          = portb0;
  assign vif0.portb1          = decode_execute_if.vs2_lane0;
  assign vif0.porta_sel       = decode_execute_if.ls_idx | (decode_execute_if.woffset0 == 0);
  assign vif0.portb_sel       = decode_execute_if.ls_idx;
  assign vif0.is_signed_mul   = decode_execute_if.is_signed;
  assign vif0.multiply_type   = decode_execute_if.multiply_type;
  assign vif0.multiply_pos_neg= decode_execute_if.multiply_pos_neg;
  assign vif0.mul_widen_ena   = decode_execute_if.mul_widen_ena;
  assign vif0.high_low        = decode_execute_if.high_low;
  assign vif0.div_type        = decode_execute_if.div_type;
  assign vif0.is_signed_div   = decode_execute_if.is_signed == SIGNED;
  assign vif0.out_inv         = decode_execute_if.out_inv;
  assign vif0.in_inv          = decode_execute_if.in_inv;
  assign vif0.mask_type       = decode_execute_if.mask_type;
  assign vif0.mask_32bit      = decode_execute_if.mask_32bit_lane0;
  assign vif0.iota_res        = iif.res0;

  // Vector Lane 1
  //assign vif1.stride          = decode_execute_if.stride;
  assign vif1.fu_type         = decode_execute_if.fu_type;
  //assign vif1.load_store_type = decode_execute_if.load_store_type;
  assign vif1.result_type     = decode_execute_if.result_type;
  assign vif1.offset          = decode_execute_if.woffset1;
  assign vif1.aluop           = decode_execute_if.aluop;
  assign vif1.mask            = decode_execute_if.mask1;
  assign vif1.reduction_ena   = decode_execute_if.reduction_ena;
  assign vif1.porta0          = vif0.out_addr;
  assign vif1.porta1          = base_addr;
  assign vif1.portb0          = portb0;
  assign vif1.portb1          = decode_execute_if.vs2_lane1;
  assign vif1.porta_sel       = decode_execute_if.ls_idx;
  assign vif1.portb_sel       = decode_execute_if.ls_idx;
  assign vif1.is_signed_mul   = decode_execute_if.is_signed;
  assign vif1.multiply_type   = decode_execute_if.multiply_type;
  assign vif1.multiply_pos_neg= decode_execute_if.multiply_pos_neg;
  assign vif1.mul_widen_ena   = decode_execute_if.mul_widen_ena;
  assign vif1.high_low        = decode_execute_if.high_low;
  assign vif1.div_type        = decode_execute_if.div_type;
  assign vif1.is_signed_div   = decode_execute_if.is_signed == SIGNED;
  assign vif1.out_inv         = decode_execute_if.out_inv;
  assign vif1.in_inv          = decode_execute_if.in_inv;
  assign vif1.mask_type       = decode_execute_if.mask_type;
  assign vif1.mask_32bit      = decode_execute_if.mask_32bit_lane1;
  assign vif1.iota_res        = iif.res1;


  //missing signals

  assign vif0.adc_sbc          = decode_execute_if.adc_sbc;
  assign vif0.carry_borrow_ena = decode_execute_if.carry_borrow_ena;
  assign vif0.carryin_ena      = decode_execute_if.carryin_ena;
  assign vif0.comp_type        = decode_execute_if.comp_type;
  assign vif0.rev              = decode_execute_if.rev;
  assign vif0.sew              = decode_execute_if.sew;
  assign vif0.ext_type         = decode_execute_if.ext_type;
  assign vif0.minmax_type      = decode_execute_if.minmax_type;

  assign vif0.woutu = decode_execute_if.woutu;
  assign vif0.win = decode_execute_if.win;
  assign vif0.zext_w = decode_execute_if.zext_w;
  assign vif0.is_masked = decode_execute_if.is_masked;

  // assign vif0.index = decode_execute_if.woffset0;

  
  assign vif1.adc_sbc          = decode_execute_if.adc_sbc;
  assign vif1.carry_borrow_ena = decode_execute_if.carry_borrow_ena;
  assign vif1.carryin_ena      = decode_execute_if.carryin_ena;
  assign vif1.comp_type        = decode_execute_if.comp_type;
  assign vif1.rev              = decode_execute_if.rev;
  assign vif1.sew              = decode_execute_if.sew;
  assign vif1.ext_type         = decode_execute_if.ext_type;
  assign vif1.minmax_type      = decode_execute_if.minmax_type;

  assign vif1.woutu  = decode_execute_if.woutu;
  assign vif1.win    = decode_execute_if.win;
  assign vif1.zext_w = decode_execute_if.zext_w;
  assign vif1.is_masked = decode_execute_if.is_masked;


  assign hu_if.busy_ex = vif0.busy | vif1.busy;
  //  | mul_done_ff0 | mul_done_ff1 | mul_done_ff2 | mul_done_ff3;
  assign hu_if.next_busy_ex = vif0.next_busy | vif1.next_busy;
  
  // assign vif1.index
  // assign vif1.start
  // assign vif1.win
  // assign vif1.woutu
  // assign vif1.zext_w
  assign vif0.vd_widen  = decode_execute_if.vd_widen;
  assign vif0.is_signed = decode_execute_if.is_signed;
  assign vif0.index     = decode_execute_if.vs2_offset0;
  assign vif0.vd_narrow = decode_execute_if.vd_narrow;
  assign vif0.decode_done = decode_execute_if.decode_done;
  // assign vif0.mul_ena = decode_execute_if.fu_type == MUL;

  // assign vif0.mask_32bit = decode_execute_if.vs2_lane0;

  // assign vif0.mask      = decode_execute_if.mask0;

  assign vif1.vd_widen  = decode_execute_if.vd_widen;
  assign vif1.is_signed = decode_execute_if.is_signed;
  assign vif1.index     = decode_execute_if.vs2_offset1;
  assign vif1.vd_narrow = decode_execute_if.vd_narrow;
  assign vif1.decode_done = decode_execute_if.decode_done;
  // assign vif1.mul_ena = decode_execute_if.fu_type == MUL;

  // assign vif1.mask_32bit = decode_execute_if.vs2_lane1;
   

  // assign vif1.mask      = decode_execute_if.mask1;




  // Address Buffer
  always_ff @ (posedge CLK, negedge nRST) begin
    if (nRST == 0) begin
      addr_buffer <= '0;
    end else if (!hu_if.stall_ex) begin
      addr_buffer <= vif1.out_addr;
    end
  end

  // Pipeline wen, woffset for MUL
  offset_t woffset0_ff0, woffset0_ff1, woffset0_ff2, woffset1_ff0, woffset1_ff1, woffset1_ff2, next_woffset0, next_woffset1;
  logic [1:0] wen_ff0, wen_ff1, wen_ff2, next_wen;
  // assign next_woffset0 = vif0.mul_on ? woffset0_ff2 : decode_execute_if.woffset0;
  assign next_woffset0 = vif0.mul_on |  mul_done_ff0 | mul_done_ff1 | mul_done_ff2  ? woffset0_ff2 : decode_execute_if.woffset0;
  // assign next_woffset1 = vif0.mul_on ? woffset1_ff2 : decode_execute_if.woffset1;
  assign next_woffset1 = vif1.mul_on | mul_done_ff0 | mul_done_ff1 | mul_done_ff2  ? woffset1_ff2 : decode_execute_if.woffset1;
  assign next_wen      = vif0.mul_on | mul_done_ff0 | mul_done_ff1 | mul_done_ff2  ? wen_ff2 : decode_execute_if.wen;

  logic [31:0] reduction_alu_result;
  logic sltu, slt;
  always_comb begin
    sltu = aluresult1 < aluresult0;
    slt  =  decode_execute_if.sew == SEW8  ? $signed(aluresult1[7:0])  < $signed(aluresult0[7:0]) : 
            decode_execute_if.sew == SEW16 ? $signed(aluresult1[15:0]) < $signed(aluresult0[15:0]) : 
                                              $signed(aluresult1)       < $signed(aluresult0);
    case (decode_execute_if.aluop)
      VALU_ADD   : reduction_alu_result = aluresult0 + aluresult1;
      VALU_AND   : reduction_alu_result = aluresult0 & aluresult1;
      VALU_OR    : reduction_alu_result = aluresult0 | aluresult1;
      VALU_XOR   : reduction_alu_result = aluresult0 ^ aluresult1;
      VALU_MM    : begin
        case (decode_execute_if.minmax_type)
          MIN  : reduction_alu_result = slt  ? aluresult1 : aluresult0;
          MINU : reduction_alu_result = sltu ? aluresult1 : aluresult0;
          MAX  : reduction_alu_result = slt  ? aluresult0 : aluresult1;
          MAXU : reduction_alu_result = sltu ? aluresult0 : aluresult1;
        endcase
      end  
      default: reduction_alu_result = 32'hbad0bad0;
    endcase
  end


  always_ff @ (posedge CLK, negedge nRST) begin
    if (nRST == 0) begin
      woffset0_ff0 <= '0;
      woffset0_ff1 <= '0;
      woffset0_ff2 <= '0;
      woffset1_ff0 <= '0;
      woffset1_ff1 <= '0;
      woffset1_ff2 <= '0;
      wen_ff0 <= '0;
      wen_ff1 <= '0;
      wen_ff2 <= '0;
      mul_done_ff0 <= 0;
      mul_done_ff1 <= 0;
      mul_done_ff2 <= 0;
      mlu_ff0 <= 0;
      mlu_ff1 <= 0;
      mlu_ff2 <= 0;
      eew_ff0 <= 0;
      eew_ff1 <= 0;
      eew_ff2 <= 0;
      vd_ff0  <= 0;
      vd_ff1  <= 0;
      vd_ff2  <= 0;


      // mul_done_ff3 <= 0;
    end else if (hu_if.flush_ex) begin
      woffset0_ff0 <= 0;
      woffset0_ff1 <= 0;
      woffset0_ff2 <= 0;
      woffset1_ff0 <= 0;
      woffset1_ff1 <= 0;
      woffset1_ff2 <= 0;
      wen_ff0 <= 0;
      wen_ff1 <= 0;
      wen_ff2 <= 0;
      mul_done_ff0 <= 0;
      mul_done_ff1 <= 0;
      mul_done_ff2  <= 0;
      mlu_ff0 <= 0;
      mlu_ff1 <= 0;
      mlu_ff2 <= 0;
      eew_ff0 <= 0;
      eew_ff1 <= 0;
      eew_ff2 <= 0;
      vd_ff0  <= 0;
      vd_ff1  <= 0;
      vd_ff2  <= 0;


      // mul_done_ff3 <= 0;
    end else begin
      woffset0_ff0 <= decode_execute_if.woffset0;
      woffset0_ff1 <= woffset0_ff0;
      woffset0_ff2 <= woffset0_ff1;
      woffset1_ff0 <= decode_execute_if.woffset1;
      woffset1_ff1 <= woffset1_ff0;
      woffset1_ff2 <= woffset1_ff0;
      wen_ff0 <= decode_execute_if.wen;
      wen_ff1 <= wen_ff0;
      wen_ff2 <= wen_ff1;
      mul_done_ff0 <= decode_execute_if.decode_done & (decode_execute_if.fu_type == MUL);
      mul_done_ff1 <= mul_done_ff0;
      mul_done_ff2 <= mul_done_ff1;
      mlu_ff0 <= decode_execute_if.fu_type == MUL;
      mlu_ff1 <= mlu_ff0;
      mlu_ff2 <= mlu_ff1;
      eew_ff0 <= decode_execute_if.sew;
      eew_ff1 <= eew_ff0;
      eew_ff2 <= eew_ff1;
      vd_ff0  <= decode_execute_if.vd;
      vd_ff1  <= vd_ff0;
      vd_ff2  <= vd_ff1;

      // mul_done_ff3 <= mul_done_ff2;
    end
  end

  assign vif0.mul_wait =  mlu_ff0 | mlu_ff1 | mlu_ff2;
  assign vif1.mul_wait = mlu_ff0 | mlu_ff1 | mlu_ff2;

  // Pipeline Latch
  assign ls = decode_execute_if.load | decode_execute_if.store;
  assign aluresult0 = ls ? vif0.in_addr : vif0.lane_result;
  assign aluresult1 = ls ? vif0.out_addr : vif1.lane_result;
  // assign latch_ena = vif0.mul_on ? vif0.done_mu : ~hu_if.stall_ex;
  assign latch_ena = ~hu_if.stall_ex;
  always_ff @ (posedge CLK, negedge nRST) begin
    if (nRST == 0) begin
      execute_memory_if.load        <= '0;
      execute_memory_if.store       <= '0;
      execute_memory_if.storedata0  <= '0;
      execute_memory_if.storedata1  <= '0;
      execute_memory_if.aluresult0  <= '0;
      execute_memory_if.aluresult1  <= '0;
      execute_memory_if.wen[0]      <= '0;
      execute_memory_if.wen[1]      <= '0;
      execute_memory_if.woffset0    <= '0;
      execute_memory_if.woffset1    <= '0;
      execute_memory_if.config_type <= '0;
      execute_memory_if.vl          <= '0;
      execute_memory_if.vtype       <= '0;
      execute_memory_if.vd          <= '0;
      execute_memory_if.eew         <= '0;
      execute_memory_if.single_bit_write  <= '0;
      execute_memory_if.next_vtype_csr  <= '0;
      execute_memory_if.next_avl_csr  <= '0;

      execute_memory_if.rd_wen <= 0;
      execute_memory_if.rd_sel <= 0;
      execute_memory_if.rd_data <= 0;

      //TESTBENCH ONLY
      execute_memory_if.tb_line_num        <= 0;

    end else if (hu_if.flush_ex) begin
      execute_memory_if.load        <= '0;
      execute_memory_if.store       <= '0;
      execute_memory_if.storedata0  <= '0;
      execute_memory_if.storedata1  <= '0;
      execute_memory_if.aluresult0  <= '0;
      execute_memory_if.aluresult1  <= '0;
      execute_memory_if.wen[0]      <= '0;
      execute_memory_if.wen[1]      <= '0;
      execute_memory_if.woffset0    <= '0;
      execute_memory_if.woffset1    <= '0;
      execute_memory_if.config_type <= '0;
      execute_memory_if.vl          <= '0;
      execute_memory_if.vtype       <= '0;
      execute_memory_if.vd          <= '0;
      execute_memory_if.eew         <= '0;
      execute_memory_if.single_bit_write  <= '0;
      execute_memory_if.next_vtype_csr    <= '0;
      execute_memory_if.next_avl_csr      <= '0;

      execute_memory_if.rd_wen <= 0;
      execute_memory_if.rd_sel <= 0;
      execute_memory_if.rd_data <= 0;

      //TESTBENCH ONLY
      execute_memory_if.tb_line_num        <= 0;



    end else if (latch_ena) begin
      execute_memory_if.load        <= decode_execute_if.load;
      execute_memory_if.store       <= decode_execute_if.store;
      execute_memory_if.storedata0  <= decode_execute_if.storedata0;
      execute_memory_if.storedata1  <= decode_execute_if.storedata1;
      execute_memory_if.aluresult0  <= ones_aluresult0 ? 32'hFFFF_FFFF : 
                                        mask_bit_found & (decode_execute_if.fu_type == MASK) ? 0 : 
                                        decode_execute_if.reduction_ena ? reduction_alu_result : 
                                        decode_execute_if.fu_type == MOVE ? decode_execute_if.vs2_lane0 : aluresult0;
      execute_memory_if.aluresult1  <= ones_aluresult1 & (decode_execute_if.fu_type == MASK)? 32'hFFFF_FFFF : 
                                        zero_aluresult1 & (decode_execute_if.fu_type == MASK) ? 0 : 
                                        decode_execute_if.fu_type == MOVE ? decode_execute_if.vs2_lane1 : aluresult1;
      // ones_aluresult0 ? 32'hFFFF_FFFF : 
                                        
      execute_memory_if.wen[0]      <= next_wen[0];
      execute_memory_if.wen[1]      <= next_wen[1];
      execute_memory_if.woffset0    <= next_woffset0;
      execute_memory_if.woffset1    <= next_woffset1;
      execute_memory_if.config_type <= decode_execute_if.config_type;
      execute_memory_if.vtype       <= decode_execute_if.vtype;

      execute_memory_if.vl          <= decode_execute_if.vl;
      // execute_memory_if.vd          <= decode_execute_if.vd;
      execute_memory_if.vd          <= vif0.mul_wait ? vd_ff2 : decode_execute_if.vd;
      // execute_memory_if.eew         <= decode_execute_if.eew;
      execute_memory_if.eew         <= vif0.mul_wait ? eew_ff2 : decode_execute_if.eew;
      execute_memory_if.single_bit_write  <= decode_execute_if.single_bit_write;
      execute_memory_if.next_vtype_csr  <= decode_execute_if.next_vtype_csr;
      execute_memory_if.next_avl_csr  <= decode_execute_if.next_avl_csr;

      execute_memory_if.rd_wen  <= decode_execute_if.rd_wen;
      execute_memory_if.rd_sel  <= decode_execute_if.rd_sel;
      execute_memory_if.rd_data <= decode_execute_if.rd_data;

            //TESTBENCH ONLY
      execute_memory_if.tb_line_num        <= decode_execute_if.tb_line_num;


    end
  end

  assign ones_aluresult0 = ~mask_bit_found & (aluresult0 == 0) & ((decode_execute_if.mask_type == VMASK_SBF) || (decode_execute_if.mask_type == VMASK_SIF));
  assign ones_aluresult1 = ~mask_bit_found & (aluresult1 == 0);
  assign zero_aluresult1 = mask_bit_found | (aluresult0 != 0) ;

  always_ff @(posedge CLK, negedge nRST) begin
    if (~nRST) begin
      mask_bit_found <= 0;
    end else if (~(decode_execute_if.fu_type == MASK)) begin
      mask_bit_found <= 0;
    end else if (~mask_bit_found & ((decode_execute_if.mask_type == VMASK_SBF) || (decode_execute_if.mask_type == VMASK_SIF) || (decode_execute_if.mask_type == VMASK_SOF))) begin
      if ((aluresult0 != 0) || (aluresult1 != 0)) begin
        mask_bit_found <= 1;
      end
    end
  end

endmodule
