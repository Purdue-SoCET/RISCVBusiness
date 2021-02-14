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
*   Filename:     tspp_fetch_stage.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 06/19/2016
*   Description:  Fetch stage for the two stage pipeline
*/

`include "tspp_fetch_execute_if.vh"
`include "tspp_hazard_unit_if.vh"
`include "predictor_pipeline_if.vh"
`include "generic_bus_if.vh"
`include "component_selection_defines.vh"
`include "cache_control_if.vh"
`include "fetch_buffer_if.vh"

module tspp_fetch_stage (
  input logic CLK, nRST,
  tspp_fetch_execute_if.fetch fetch_ex_if,
  tspp_hazard_unit_if.fetch hazard_if,
  predictor_pipeline_if.access predict_if,
  generic_bus_if.cpu igen_bus_if,
  sparce_pipeline_if.pipe_fetch sparce_if
);
  import rv32i_types_pkg::*;

  fetch_buffer_if fb_if();

  //parameter RESET_PC = 32'h200;
  parameter RESET_PC = 32'h80000000;

  word_t  pc, pc4or2, npc, instr;

  //PC logic

  always_ff @ (posedge CLK, negedge nRST) begin
    if(~nRST) begin
      pc <= RESET_PC;
    end else if (hazard_if.pc_en) begin
      pc <= npc;
    end
  end

  //RV32C Buffer 
  fetch_buffer #(RESET_PC) BUFFER
  (
    .clk(CLK),
    .n_rst(nRST),
    .fb_if(fb_if)
  );
  assign fb_if.inst = igen_bus_if.rdata;
  assign fb_if.inst_arrived = hazard_if.if_ex_flush == 0 & hazard_if.if_ex_stall == 0;
  assign fb_if.reset_en = hazard_if.insert_priv_pc | sparce_if.skipping | hazard_if.npc_sel | predict_if.predict_taken;
  assign fb_if.pc_update = hazard_if.pc_en;
  assign fb_if.reset_pc = npc;

  assign pc4or2 = (fb_if.result[1:0] != 2'b11) ? (pc + 2) : (pc + 4);
  assign predict_if.current_pc = pc;
  assign npc = hazard_if.insert_priv_pc ? hazard_if.priv_pc : ( sparce_if.skipping ? sparce_if.sparce_target : (hazard_if.npc_sel ? fetch_ex_if.brj_addr : 
                (predict_if.predict_taken ? predict_if.target_addr : fb_if.nextpc)));

  //Instruction Access logic
  assign hazard_if.i_mem_busy  = igen_bus_if.busy;
  assign igen_bus_if.addr         = fb_if.countread;
  assign igen_bus_if.ren          = hazard_if.iren;
  assign igen_bus_if.wen          = 1'b0;
  assign igen_bus_if.byte_en      = 4'b1111;
  assign igen_bus_if.wdata        = '0;
  
  //Fetch Execute Pipeline Signals
  always_ff @ (posedge CLK, negedge nRST) begin
    if (!nRST)
      fetch_ex_if.fetch_ex_reg <= '0;
    else if (hazard_if.if_ex_flush)
      fetch_ex_if.fetch_ex_reg <= '0;
    else if (!hazard_if.if_ex_stall & fb_if.done) begin
      fetch_ex_if.fetch_ex_reg.token       <= 1'b1;
      fetch_ex_if.fetch_ex_reg.pc          <= pc;
      fetch_ex_if.fetch_ex_reg.pc4         <= pc4or2;
      fetch_ex_if.fetch_ex_reg.instr       <= fb_if.result;
      fetch_ex_if.fetch_ex_reg.prediction  <= predict_if.predict_taken;
    end
  end

  //Send exceptions to Hazard Unit
  logic mal_addr;
  assign mal_addr = (igen_bus_if.addr[1:0] != 2'b00);
  assign hazard_if.fault_insn = 1'b0;
  assign hazard_if.mal_insn = mal_addr;  
  assign hazard_if.badaddr_f = igen_bus_if.addr;
  assign hazard_if.epc_f = pc; 

  // Choose the endianness of the data coming into the processor
  generate
    if (BUS_ENDIANNESS == "big")
      assign instr = igen_bus_if.rdata;
    else if (BUS_ENDIANNESS == "little")
      endian_swapper ltb_endian(igen_bus_if.rdata, instr);
  endgenerate

  /*********************************************************
  *** SparCE Module Logic
  *********************************************************/

  assign sparce_if.pc = pc;
  assign sparce_if.rdata = igen_bus_if.rdata;
endmodule


