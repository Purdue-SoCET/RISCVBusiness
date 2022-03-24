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
*   Filename:     loadstore_unit.sv
*
*   Created by:   Owen Prince
*   Email:        oprince@purdue.edu
*   Date Created: 2/21/2016
*   Description:  Load store functional unit
*/

`include "loadstore_unit_if.vh"
`include "component_selection_defines.vh"
`include "generic_bus_if.vh"




module loadstore_unit (
  input logic CLK, nRST, halt,
  generic_bus_if.cpu dgen_bus_if,
  ooo_hazard_unit_if.memory hazard_if,
  loadstore_unit_if.execute lsif
);

  import rv32i_types_pkg::*;

  // input

  logic [31:0] store_data_ff1, store_data_ff0;
  logic [31:0] pc_ff1, pc_ff0;
  logic  dren_ff1, dren_ff0;
  logic  dwen_ff1, dwen_ff0;
  logic  wen_ff1, wen_ff0;
  logic [4:0] reg_rd_ff1, reg_rd_ff0;
  logic [31:0] address_ff1, address_ff0;
  logic [3:0] byte_en_ff1, byte_en_ff0;
  load_t load_type_ff1, load_type_ff0;
  opcode_t opcode_ff0, opcode_ff1;
  logic mal_addr_ff0, mal_addr_ff1;
  logic [$clog2(NUM_CB_ENTRY)-1:0] index_ff0, index_ff1;
  word_t dload_ext;
  logic [3:0] byte_en_standard;
  logic stall_mem;
  logic ena_ff1;

  assign stall_mem = dgen_bus_if.busy & (dren_ff1 | dwen_ff1) ;

  //assign stall = '0;

  assign store_data_ff0 = lsif.store_data;
  assign dren_ff0       = lsif.dren;
  assign dwen_ff0       = lsif.dwen;
  assign wen_ff0        = lsif.wen;
  assign reg_rd_ff0     = lsif.reg_rd;
  assign load_type_ff0  = lsif.load_type;
  assign pc_ff0         = lsif.pc;
  assign opcode_ff0     = lsif.opcode;
  assign index_ff0      = lsif.index;
  assign hazard_if.dmem_access = dren_ff1 | dwen_ff1;
  assign hazard_if.busy_ls = stall_mem | lsif.ena & ~ena_ff1 & (dren_ff0 | dwen_ff0);

  agu AGU (
    .port_a(lsif.port_a), 
    .port_b(lsif.port_b),
    .load_type(lsif.load_type),
    .byte_en_standard(byte_en_ff0),
    .address(address_ff0), 
    .mal_addr(mal_addr_ff0)
  );

  // THIS IS THE MEM LATCH --> STALL_MEM STALLS THIS LATCH

  always_ff @(posedge CLK, negedge nRST) begin
    if (~nRST ) begin
      store_data_ff1 <= '0;
      dren_ff1       <= '0;
      dwen_ff1       <= '0;
      wen_ff1        <= '0;
      reg_rd_ff1     <= '0;
      address_ff1    <= '0;
      byte_en_ff1    <= '0;
      mal_addr_ff1    <= '0;
      load_type_ff1  <= load_t'('0);
      pc_ff1         <= '0;
      opcode_ff1     <= opcode_t'('0);
      index_ff1     <= '0;
    end else begin
      //if (hazard_if.ex_mem_flush | (hazard_if.stall_ls & ~stall_mem) | halt ) begin
      if (hazard_if.loadstore_flush | halt ) begin
        store_data_ff1 <= '0;
        dren_ff1       <= '0;
        dwen_ff1       <= '0;
        wen_ff1        <= '0;
        reg_rd_ff1     <= '0;
        address_ff1    <= '0;
        byte_en_ff1    <= '0;
        mal_addr_ff1    <= '0;
        load_type_ff1  <= load_t'('0);
        pc_ff1         <= '0;
        opcode_ff1     <= opcode_t'('0);
        index_ff1     <= '0;
      end else if (hazard_if.dmem_access & ~hazard_if.d_mem_busy) begin //arbitate dren, dwen for iaccess
        dren_ff1 <= '0;
        dwen_ff1 <= '0;
      end else if(~stall_mem) begin 
        store_data_ff1 <= store_data_ff0;
        dren_ff1       <= dren_ff0;
        dwen_ff1       <= dwen_ff0;
        wen_ff1        <= wen_ff0;
        reg_rd_ff1     <= reg_rd_ff0;
        address_ff1    <= address_ff0;
        byte_en_ff1    <= byte_en_ff0;
        mal_addr_ff1    <= mal_addr_ff0;
        load_type_ff1  <= load_type_ff0;
        pc_ff1         <= pc_ff0;
        opcode_ff1     <= opcode_ff0;
        index_ff1     <= index_ff0;
      end
    end
  end

  // OUTPUT:
  logic stall_mem_ff1;

  assign lsif.wdata_ls = dload_ext;
  assign lsif.wen_ls   = wen_ff1;
  assign lsif.reg_rd_ls   = reg_rd_ff1;
  assign lsif.dren_ls  = dren_ff1;
  assign lsif.dwen_ls  = dwen_ff1;
  assign lsif.opcode_ls  = opcode_ff1;
  assign lsif.mal_addr = mal_addr_ff1;
  assign lsif.memory_addr = address_ff1;
  assign lsif.done_ls = stall_mem_ff1 & ~stall_mem; 
  assign lsif.index_ls = index_ff1;


  always_ff @(posedge CLK, negedge nRST) begin
    if (~nRST) begin
      stall_mem_ff1 <= 0;
    end else begin
      stall_mem_ff1 <= stall_mem;
    end
  end 

  always_ff @(posedge CLK, negedge nRST) begin
    if (~nRST) begin
      ena_ff1 <= 0;
    end else begin
      ena_ff1 <= lsif.ena;
    end
  end 

  /*******************************************************
  *** Choose the Endianness Coming into the processor
  *******************************************************/
  logic [3:0] byte_en, byte_en_temp;
  assign byte_en_temp = byte_en_ff1;
  generate
    if (BUS_ENDIANNESS == "big")
    begin
      assign byte_en = byte_en_temp;
    end else if (BUS_ENDIANNESS == "little")
    begin
      assign byte_en = dren_ff1 ? byte_en_temp :
                                  {byte_en_temp[0], byte_en_temp[1],
                                    byte_en_temp[2], byte_en_temp[3]};
    end
  endgenerate 

  dmem_extender dmem_ext (
    .dmem_in(dgen_bus_if.rdata),
    .load_type(load_type_ff1),
    .byte_en(byte_en),
    .ext_out(dload_ext)
  );


  /*******************************************************
  *** mal_addr  and Associated Logic 
  *******************************************************/
  assign hazard_if.d_mem_busy = dgen_bus_if.busy ;
  assign hazard_if.dren       = lsif.dren;
  assign hazard_if.dwen       = lsif.dwen;

  /*******************************************************
  *** data bus  and Associated Logic 
  *******************************************************/
  assign dgen_bus_if.ren     = dren_ff1 & ~mal_addr_ff1;
  assign dgen_bus_if.wen     = dwen_ff1 & ~mal_addr_ff1;
  assign dgen_bus_if.byte_en = byte_en;
  assign dgen_bus_if.addr    = address_ff1;
  always_comb begin
    dgen_bus_if.wdata = '0;
    case(load_type_ff1) // load_type can be used for store_type as well
      LB: dgen_bus_if.wdata = {4{store_data_ff1[7:0]}};
      LH: dgen_bus_if.wdata = {2{store_data_ff1[15:0]}};
      LW: dgen_bus_if.wdata = store_data_ff1; 
    endcase
  end

endmodule