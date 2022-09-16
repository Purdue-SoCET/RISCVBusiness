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
*   Filename:     RISCVBusiness_fpga.sv
*   
*   Created by:   Jacob R. Stevens
*   Email:        steven69@purdue.edu
*   Date Created: 10/18/2016
*   Description:  Top level module for RISCVBusiness on an FPGA
*/
`include "generic_bus_if.vh"
 
module RISCVBusiness_fpga
(
  input logic CLOCK_50,
  input logic [3:0] KEY,
  output logic [8:0] LEDG,
  output logic [6:0] HEX0,
  output logic [6:0] HEX1,
  output logic [6:0] HEX2,
  output logic [6:0] HEX3,
  output logic [6:0] HEX4,
  output logic [6:0] HEX5,
  output logic [6:0] HEX6,
  output logic [6:0] HEX7
);
  // auto reset
  logic nRST;
  logic auto_nRST;
  logic [3:0] nRST_count;

  initial begin
    auto_nRST = '0;
    nRST_count = '0;
  end

  always_ff @(posedge CLOCK_50)
  begin
    if (nRST_count != 4'hF)
    begin
      nRST_count <= nRST_count + '1;
      auto_nRST <= '0;
    end
    else
    begin
      auto_nRST <= '1;
    end
  end
  
  //portmap
  generic_bus_if gen_bus_if();
  logic halt;
  RISCVBusiness proc (
    .CLK(CLOCK_50),
    .nRST(nRST),
    .halt(halt),
    .gen_bus_if(gen_bus_if)
  );

  ram_wrapper ram (
    .CLK(CLOCK_50),
    .nRST(nRST),
    .gen_bus_if(gen_bus_if)
  );


  // map board to system
  assign LEDG[8] = halt;
  assign nRST = KEY[3] & auto_nRST;
 

  /************************* Set up HEX output ********************/
  struct packed {
    logic [6:0] hex7;
    logic [6:0] hex6;
    logic [6:0] hex5;
    logic [6:0] hex4;
    logic [6:0] hex3;
    logic [6:0] hex2;
    logic [6:0] hex1;
    logic [6:0] hex0;
  } display;

  assign HEX0 = ~display.hex0;
  assign HEX1 = ~display.hex1;
  assign HEX2 = ~display.hex2;
  assign HEX3 = ~display.hex3;
  assign HEX4 = ~display.hex4;
  assign HEX5 = ~display.hex5;
  assign HEX6 = ~display.hex6;
  assign HEX7 = ~display.hex7;

  generate 
    genvar seg_select;
    for(seg_select=0; seg_select < 8; seg_select= seg_select + 1)
    begin: seven_seg_display_controller
      always_comb
      begin
        casez(gen_bus_if.rdata[31-seg_select*4:(31-(seg_select+1)*4) + 1])
          4'h0: display[55-seg_select*7:(55-(seg_select + 1) * 7) + 1] = 7'b0111111;
          4'h1: display[55-seg_select*7:(55-(seg_select + 1) * 7) + 1] = 7'b0000110;
          4'h2: display[55-seg_select*7:(55-(seg_select + 1) * 7) + 1] = 7'b1011011;
          4'h3: display[55-seg_select*7:(55-(seg_select + 1) * 7) + 1] = 7'b1001111;
          4'h4: display[55-seg_select*7:(55-(seg_select + 1) * 7) + 1] = 7'b1100110;
          4'h5: display[55-seg_select*7:(55-(seg_select + 1) * 7) + 1] = 7'b1101101;
          4'h6: display[55-seg_select*7:(55-(seg_select + 1) * 7) + 1] = 7'b1111100;
          4'h7: display[55-seg_select*7:(55-(seg_select + 1) * 7) + 1] = 7'b0000111;
          4'h8: display[55-seg_select*7:(55-(seg_select + 1) * 7) + 1] = 7'b1111111;
          4'h9: display[55-seg_select*7:(55-(seg_select + 1) * 7) + 1] = 7'b1100111;
          4'hA: display[55-seg_select*7:(55-(seg_select + 1) * 7) + 1] = 7'b1110110;
          4'hB: display[55-seg_select*7:(55-(seg_select + 1) * 7) + 1] = 7'b1111100;
          4'hC: display[55-seg_select*7:(55-(seg_select + 1) * 7) + 1] = 7'b0111001;
          4'hD: display[55-seg_select*7:(55-(seg_select + 1) * 7) + 1] = 7'b1011110;
          4'hE: display[55-seg_select*7:(55-(seg_select + 1) * 7) + 1] = 7'b1111001;
          4'hF: display[55-seg_select*7:(55-(seg_select + 1) * 7) + 1] = 7'b1110001;
        endcase
      end
    end
  endgenerate

   
endmodule
