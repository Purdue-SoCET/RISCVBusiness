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
*   Filename:     tb/tb_sparce_cfid.sv
*
*   Created by:   Wengyan Chan
*   Email:        cwengyan@purdue.edu
*   Date Created: Oct 3rd, 2019
*   Description:  Testbench for the control flow instruction detector
*/

`include "sparce_internal_if.vh"
  import rv32i_types_pkg::*;

typedef struct packed
{
  word_t rdata;
  logic enable;
} sparce_cfid_testvec_t;

module tb_sparce_cfid ();

  parameter PERIOD = 20;

  sparce_internal_if sparce_if();
  sparce_cfid DUT(sparce_if);

  logic tb_clk;
  integer i;
  sparce_cfid_testvec_t testvec[4:0];

  assign testvec = 
    {
      {{{25{1'b0}}, JAL}, 1'b0 },
      {{{25{1'b0}}, JALR}, 1'b0 },
      {{{25{1'b0}}, LOAD}, 1'b1 },
      {{{25{1'b0}}, BRANCH}, 1'b0 },
      {{{25{1'b0}}, IMMED}, 1'b1 }
    };

  always begin
    #(PERIOD/2);
    tb_clk <= ~tb_clk;
  end

  initial begin
    tb_clk <= 0;
    i = 0;
    @(posedge tb_clk);
    while (i<$size(testvec)) begin
      @(negedge tb_clk);
      sparce_if.rdata = testvec[i].rdata;
      @(posedge tb_clk);
      assert (sparce_if.ctrl_flow_enable == testvec[i].enable)
      else 
        $error("INCORRECT ENABLE");
      i = i+1;
    end
    $finish;
  end
endmodule
