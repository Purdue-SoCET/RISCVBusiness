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
*   Filename:		  tb_RISCVBusiness.sv	
*   
*   Created by:		John Skubic
*   Email:				jskubic@purdue.edu
*   Date Created:	06/01/2016
*   Description:	Testbench for running RISCVBusiness until a halt condition.
*                 A hexdump of memory will occur after the halt condition.
*/

// Note: Figure out whether or not I need to change the name to Enes Shaltami.

`timescale 1ns/100ps

`include "prv_pipeline_if.vh"
`include "priv_1_11_internal_if.vh"

`define OUTPUT_FILE_NAME "cpu.hex"
`define STATS_FILE_NAME "stats.txt"
`define RVB_CLK_TIMEOUT 10000

module tb_priv_1_11_block ();
   
  parameter PERIOD = 20;
 
  logic CLK, nRST;
  logic ram_control; // 1 -> CORE, 0 -> TB
  logic halt;
  logic [31:0] addr, data_temp, data;
  logic [63:0] hexdump_temp;
  logic [7:0] checksum;
  integer fptr, stats_ptr;
  //integer clk_count;

  //Interface Instantiations
  prv_pipeline_if prv_pipeline_if();

  //Module Instantiations

  priv_1_11_block DUT (
    .CLK(CLK),
    .nRST(nRST),
    .prv_pipe_if(prv_pipeline_if) // using the "priv_block" modport of the prv_pieline_if.vh file
  ); // TODO: Figure out IO for the priv pipeline unit

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

   // TODO: Expected output signals: ex_src, exception, 


/*
   // Resetting all of the inputs for the priv_block unit
    prv_pipeline_if.pipe_clear = '0;
    prv_pipeline_if.ret = '0;
    prv_pipeline_if.epc = '0;

    // control signals for the exception combinational logic
    prv_pipeline_if.fault_insn = 1'b0;
    prv_pipeline_if.mal_insn = 1'b0;
    prv_pipeline_if.illegal_insn = 1'b0;
    prv_pipeline_if.fault_l = 1'b0;
    prv_pipeline_if.mal_l = 1'b0;
    prv_pipeline_if.fault_s = 1'b0;
    prv_pipeline_if.mal_s = 1'b0;
    prv_pipeline_if.breakpoint = 1'b0;
    prv_pipeline_if.env_m = 1'b0;


    prv_pipeline_if.badaddr = '0; // TODO: Below signal is not being used!!!
    prv_pipeline_if.wdata = '0; 
    prv_pipeline_if.addr = '0;
    prv_pipeline_if.valid_write = '0;
    prv_pipeline_if.wb_enable = '0;
    prv_pipeline_if.instr = '0;

    // TODO: SIGNALS ARE NOT BEING USED!!! Below 3 signals will check the funct3 op code for an R-type instruction. Output of control unit, but not used in the priv unit
    prv_pipeline_if.swap = '0; // CSRRW field which means to atomically swap values in the CSRs and integer registers
    prv_pipeline_if.clr = '0; // CSRRC field which means to perform an atomic read and clear the bit in CSR
    prv_pipeline_if.set = '0; // CSRRS where the instruction reads the value of the CSR, and writes it to integer register rd

    prv_pipeline_if.ex_rmgmt = '0;
    prv_pipeline_if.ex_rmgmt_cause = '0;
    


   
    prv_pipeline_if.mal_insn = 1'b1;
    prv_pipeline_if.breakpoint = 1'b1;
   // tb_expected_ex_src = BREAKPOINT;
    tb_expected_exception = 1'b1; */
 
    @(posedge CLK);
    @(posedge CLK);

    nRST = 1;
    
    /*while (halt == 0 && clk_count != `RVB_CLK_TIMEOUT) begin
      @(posedge CLK);
      clk_count++;
      if (gen_bus_if.addr == 16'h0000 & !gen_bus_if.busy & gen_bus_if.wen)
        $write("%c",gen_bus_if.wdata[31:24]);
    end

    #(1);

    dump_stats();
    dump_ram();

    if (clk_count == `RVB_CLK_TIMEOUT) 
      $display("ERROR: Test timed out"); */

    $finish;

  end : CORE_RUN

 /* task dump_stats();
    integer instret, cycles;
    instret = DUT.priv_wrapper_i.priv_block_i.csr_rfile_i.instretfull;
    cycles  = DUT.priv_wrapper_i.priv_block_i.csr_rfile_i.cyclefull;
    if (cycles != clk_count) $info("Cycles CSR != clk_count");
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

    for(addr = 32'h80000000; addr < 32'h80007000; addr+=4) begin
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
  endfunction */

endmodule
