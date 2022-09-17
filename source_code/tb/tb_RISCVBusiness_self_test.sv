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
*   Filename:		  tb_RISCVBusiness_self_test.sv
*
*   Created by:		John Skubic
*   Email:				jskubic@purdue.edu
*   Date Created:	06/01/2016
*   Description:	Testbench for running RISCVBusiness until a halt condition.
*                 The test bench monitors memory location 0x1000 and prints
*                 the char representation of what is written.
*/

`timescale 1ns/100ps

`include "generic_bus_if.vh"
`include "component_selection_defines.vh"

`define OUTPUT_FILE_NAME "cpu.hex"
`define STATS_FILE_NAME "stats.txt"
`define RVBSELF_CLK_TIMEOUT 5000000

module tb_RISCVBusiness_self_test ();

  parameter PERIOD = 20;

  logic CLK, nRST;
  logic ram_control; // 1 -> CORE, 0 -> TB
  logic halt;
  logic [31:0] addr, data, data_temp;
  logic [63:0] hexdump_temp;
  logic [7:0] checksum;
  integer fptr, stats_ptr;
  integer clk_count;

  //Interface Instantiations
  generic_bus_if gen_bus_if();
  generic_bus_if rvb_gen_bus_if();
  generic_bus_if tb_gen_bus_if();
  core_interrupt_if interrupt_if();

    assign interrupt_if.timer_int = '0;
    assign interrupt_if.timer_int_clear = '0;
    assign interrupt_if.ext_int = '0;
    assign interrupt_if.ext_int_clear = '0;
    assign interrupt_if.soft_int = '0;
    assign interrupt_if.soft_int_clear = '0;

  //Module Instantiations

  RISCVBusiness DUT (
    .CLK(CLK),
    .nRST(nRST),
    .gen_bus_if(rvb_gen_bus_if),
    .interrupt_if
  );

  ram_wrapper ram (
    .CLK(CLK),
    .nRST(nRST),
    .gen_bus_if(gen_bus_if)
  );

  if (BUS_ENDIANNESS == "big")
    endian_swapper swap(data_temp, data);
  else if (BUS_ENDIANNESS == "little")
    assign data = data_temp;
  else ;//TODO:ERROR

  bind tspp_execute_stage cpu_tracker cpu_track1 (
    .CLK(CLK),
    .wb_stall(wb_stall),
    .instr(fetch_ex_if.fetch_ex_reg.instr),
    .pc(fetch_ex_if.fetch_ex_reg.pc),
    .opcode(cu_if.opcode),
    .funct3(funct3),
    .funct12(funct12),
    .rs1(rf_if.rs1),
    .rs2(rf_if.rs2),
    .rd(rf_if.rd),
    .imm_S(cu_if.imm_S),
    .imm_I(cu_if.imm_I),
    .imm_U(cu_if.imm_U),
    .imm_UJ(imm_UJ_ext),
    .imm_SB(cu_if.imm_SB),
    .instr_30(instr_30)
    );

  bind branch_predictor_wrapper branch_tracker branch_perf(
    .CLK(CLK),
    .nRST(nRST),
    .update_predictor(predict_if.update_predictor),
    .prediction(predict_if.prediction),
    .branch_result(predict_if.branch_result)
  );

  //Ramif Mux
  always_comb begin
    if(ram_control) begin
      /* No actual bus, so directly connect ram to generic bus interface */
      gen_bus_if.addr    =   rvb_gen_bus_if.addr;
      gen_bus_if.ren     =   rvb_gen_bus_if.ren;
      gen_bus_if.wen     =   rvb_gen_bus_if.wen;
      gen_bus_if.wdata   =   rvb_gen_bus_if.wdata;
      gen_bus_if.byte_en =   rvb_gen_bus_if.byte_en;
    end else begin
      gen_bus_if.addr    =   tb_gen_bus_if.addr;
      gen_bus_if.ren     =   tb_gen_bus_if.ren;
      gen_bus_if.wen     =   tb_gen_bus_if.wen;
      gen_bus_if.wdata   =   tb_gen_bus_if.wdata;
      gen_bus_if.byte_en = tb_gen_bus_if.byte_en;
    end
  end

  /* No actual bus, so directly connect ram to generic bus interface */
  assign rvb_gen_bus_if.rdata  = gen_bus_if.rdata;
  assign rvb_gen_bus_if.busy   = gen_bus_if.busy;
  assign tb_gen_bus_if.rdata   = gen_bus_if.rdata;
  assign tb_gen_bus_if.busy    = gen_bus_if.busy;

  //Clock generation
  initial begin : INIT
    CLK = 0;
  end : INIT

  always begin : CLOCK_GEN
    #(PERIOD/2) CLK = ~CLK;
  end : CLOCK_GEN

  //Setup core and let it run
  initial begin : CORE_RUN
    nRST = 0;
    ram_control = 1;
    clk_count = 0;

    @(posedge CLK);
    @(posedge CLK);

    nRST = 1;

    while (DUT.halt == 0 && clk_count != `RVBSELF_CLK_TIMEOUT) begin
      @(posedge CLK);
      clk_count++;
      if(gen_bus_if.addr == 16'h0000 & !gen_bus_if.busy & gen_bus_if.wen) begin
        $write("%c", gen_bus_if.wdata[31:24]);
      end
    end

    #(1);

    dump_stats();
    dump_ram();

    // Check Register 28 to see if test passed or failed
    if (clk_count == `RVBSELF_CLK_TIMEOUT)
      $display("ERROR: Test timed out");
    else if(DUT.execute_stage_i.g_rfile_select.rf.registers[28] != 32'h1)
      $display("ERROR: Test %0d did not pass",
                (DUT.execute_stage_i.g_rfile_select.rf.registers[28] - 1)/2);
    else
      $display("SUCCESS");
    $finish;

  end : CORE_RUN

  task dump_stats();
    logic [63:0] instret, cycles;
    instret = DUT.priv_wrapper_i.priv_block_i.csr_rfile_i.instretfull;
    cycles  = DUT.priv_wrapper_i.priv_block_i.csr_rfile_i.cyclefull;
    if (cycles != clk_count) $info("Cycles CSR (%0d) != clk_count (%0d)", cycles, clk_count);
    stats_ptr = $fopen(`STATS_FILE_NAME, "w");
    $fwrite(stats_ptr, "Instructions retired: %2d\n", instret);
    $fwrite(stats_ptr, "Cycles taken: %2d\n", cycles);
    $fwrite(stats_ptr, "CPI: %5f\n", real'(cycles)/instret);
    $fwrite(stats_ptr, "IPC: %5f\n", real'(instret)/cycles);
    $fclose(stats_ptr);
  endtask

  task dump_ram ();
    ram_control = 0;
    tb_gen_bus_if.addr = 0;
    tb_gen_bus_if.ren = 0;
    tb_gen_bus_if.wen = 0;
    tb_gen_bus_if.wdata = 0;
    tb_gen_bus_if.byte_en = 4'hf;

    fptr = $fopen(`OUTPUT_FILE_NAME, "w");

    for(addr = 32'h100; addr < 32'h2000; addr+=4) begin
      read_ram(addr, data_temp);
      #(PERIOD/4);
      hexdump_temp = {8'h04, addr[15:0]>>2, 8'h00, data};
      checksum = calculate_crc(hexdump_temp);
      if(data != 0)
        $fwrite(fptr, ":%2h%4h00%8h%2h\n", 8'h4, addr[15:0]>>2, data, checksum);
    end
    // add the EOL entry to the file
    $fwrite(fptr, ":00000001FF");

  endtask

  task read_ram (input logic [31:0] raddr, output logic [31:0] rdata);
    @(posedge CLK);
    tb_gen_bus_if.addr = raddr;
    tb_gen_bus_if.ren = 1;
    @(posedge CLK);
    while(tb_gen_bus_if.busy == 1) @(posedge CLK);
    rdata = tb_gen_bus_if.rdata;
    tb_gen_bus_if.ren = 0;
  endtask

  function [7:0] calculate_crc (logic [63:0] hex_line);
    static logic [7:0] checksum = 0;
    int i;

    checksum = hex_line[7:0] + hex_line[15:8] + hex_line[23:16] +
                hex_line[31:24] + hex_line[39:32] + hex_line[47:40] +
                hex_line[55:48] + hex_line[63:56];

    //take two's complement
    checksum = (~checksum) + 1;
    return checksum;
  endfunction

endmodule

