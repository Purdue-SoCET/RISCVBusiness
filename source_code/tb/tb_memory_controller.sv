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
*   Filename:     tb/tb_memory_controller.sv
*
*   Created by:   Chuan Yean Tan
*   Email:        tan56@purdue.edu
*   Date Created: 09/08/2016
*   Description:  Testbench for the alu 
*/

`include "generic_bus_if.vh" 
`include "ahb_if.vh" 

module memory_controller_tb ();

  parameter NUM_TESTS = 1;
  parameter PERIOD = 20; 

  logic CLK, nRST; 

  generic_bus_if d_gen_bus_if(); 
  generic_bus_if i_gen_bus_if(); 
  generic_bus_if out_gen_bus_if(); 

  ahb_if ahb_m();

  memory_controller DUT ( CLK, nRST, d_gen_bus_if, i_gen_bus_if, out_gen_bus_if );
  ahb DUT2 ( CLK, nRST, ahb_m, out_gen_bus_if); 
  
  //-- CLOCK INITIALIZATION --// 
  initial begin : INIT 
    CLK = 0; 
  end : INIT 

  //-- CLOCK GENERATION --// 
  always begin : CLOCK_GEN 
    #(PERIOD/2) CLK = ~CLK; 
  end : CLOCK_GEN

  initial begin : MAIN
     
    //-- Initial reset --// 
    nRST = 0; 
    d_gen_bus_if.ren = 0; 
    d_gen_bus_if.wen = 0;
    i_gen_bus_if.ren = 0; 
    i_gen_bus_if.wen = 0;

    i_gen_bus_if.addr = 32'h00000000; 
    i_gen_bus_if.wdata = 32'h00000000; 
    i_gen_bus_if.byte_en = 4'h1;
    d_gen_bus_if.addr = 32'h00000000; 
    d_gen_bus_if.wdata = 32'h00000000; 
    d_gen_bus_if.byte_en = 4'h1;

    ahb_m.HRDATA = 32'hbad1bad1; 
    ahb_m.HREADY = 0;
    ahb_m.HRESP = 0;

    //-- Base Address Initilization --// 
    i_gen_bus_if.addr = 32'h00000010; 
    d_gen_bus_if.addr = 32'h00000080; 

    @(posedge CLK); 
    #(PERIOD); 

    //-- Program starts here --// 
    nRST = 1;

    instruction_read();
    data_read();
    data_write(); 
     
    #(3 * PERIOD); 

    $finish;
  end : MAIN

  task instruction_read; 
  begin 
    d_gen_bus_if.ren = 0; 
    d_gen_bus_if.wen = 0;
    i_gen_bus_if.ren = 1; 
    i_gen_bus_if.wen = 0;
    i_gen_bus_if.addr = i_gen_bus_if.addr + 4; 
    #(5 * PERIOD) 
    @(posedge CLK)
    ahb_m.HRDATA = 32'hDEADBEEF; 
    ahb_m.HWDATA = 0;
    ahb_m.HREADY = 1; 
    #(PERIOD) 
    ahb_m.HRDATA = 32'hbad1bad1; 
    ahb_m.HREADY = 0; 
    d_gen_bus_if.ren = 0; 
    d_gen_bus_if.wen = 0;
    i_gen_bus_if.ren = 1; 
    i_gen_bus_if.wen = 0;
  end
  endtask

  task data_read; 
  begin 
    d_gen_bus_if.addr = d_gen_bus_if.addr + 4; 
    d_gen_bus_if.ren = 1; 
    d_gen_bus_if.wen = 0;
    i_gen_bus_if.ren = 1; 
    i_gen_bus_if.wen = 0;
    #(5 * PERIOD) 
    ahb_m.HRDATA = 32'hDEADBEEF; 
    ahb_m.HWDATA = 0; 
    ahb_m.HREADY = 0; 
    #(PERIOD) 
    ahb_m.HRDATA = 32'hDEADBEEF; 
    ahb_m.HREADY = 0; 
    d_gen_bus_if.ren = 1; 
    d_gen_bus_if.wen = 0;
    i_gen_bus_if.ren = 1; 
    i_gen_bus_if.wen = 0;
    #(5 * PERIOD) 
    ahb_m.HRDATA = 32'hbad1bad1; 
    ahb_m.HWDATA = 0; 
    ahb_m.HREADY = 0; 
    #(PERIOD) 
    ahb_m.HRDATA = 32'hbad1bad1; 
    ahb_m.HREADY = 0; 
    d_gen_bus_if.ren = 0; 
    d_gen_bus_if.wen = 0;
    i_gen_bus_if.ren = 1; 
    i_gen_bus_if.wen = 0;
  end
  endtask

  task data_write; 
  begin 
    d_gen_bus_if.addr = d_gen_bus_if.addr + 4; 
    d_gen_bus_if.ren = 0; 
    d_gen_bus_if.wen = 1;
    i_gen_bus_if.ren = 1; 
    i_gen_bus_if.wen = 0;
    #(5 * PERIOD) 
    ahb_m.HRDATA = 32'hDEADBEEF; 
    ahb_m.HWDATA = 0; 
    ahb_m.HREADY = 1; 
    #(PERIOD) 
    ahb_m.HRDATA = 32'hDEADBEEF; 
    ahb_m.HREADY = 1; 
    d_gen_bus_if.ren = 0; 
    d_gen_bus_if.wen = 1;
    i_gen_bus_if.ren = 1; 
    i_gen_bus_if.wen = 0;
    #(5 * PERIOD) 
    ahb_m.HRDATA = 32'hbad1bad1; 
    ahb_m.HWDATA = 0; 
    ahb_m.HREADY = 1; 
    #(PERIOD) 
    ahb_m.HRDATA = 32'hbad1bad1; 
    ahb_m.HREADY = 1; 
    d_gen_bus_if.ren = 0; 
    d_gen_bus_if.wen = 0;
    i_gen_bus_if.ren = 1; 
    i_gen_bus_if.wen = 0;
  end 
  endtask

endmodule
