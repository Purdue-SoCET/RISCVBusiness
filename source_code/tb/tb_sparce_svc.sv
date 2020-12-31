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
*   Filename:     tb/tb_sparce_svc.sv
*
*   Created by:   Vadim Nikiforov 
*   Email:        vnikifor@purdue.edu
*   Date Created: 08/16/2019
*   Description:  Testbench for the sparsity value checker
*/

`include "sparce_internal_if.vh"
  import rv32i_types_pkg::*;


typedef struct packed
{
  word_t wb_data;
  logic is_sparse;
} sparce_svc_testvec_t;

module tb_sparce_svc ();

  parameter PERIOD = 20;

  sparce_internal_if sparce_if();
  sparce_svc DUT(sparce_if);

  logic tb_clk;
  integer i;
  sparce_svc_testvec_t testvec[2:0];

  assign testvec =
  {
    {32'b0, 1'b1},
    {32'b1, 1'b0},
    {'1, 1'b0}
  };



  always begin
    #(PERIOD/2);
    tb_clk <= ~tb_clk;
  end

  initial begin
    tb_clk <= 0;
    i = 0;
    @(posedge tb_clk);
    while( i < $size(testvec)) begin
      @(negedge tb_clk);
      sparce_if.wb_data = testvec[i].wb_data;
      @(posedge tb_clk);
      assert (sparce_if.is_sparse == testvec[i].is_sparse) else $error("Sparsity not detected properly - Input: %d, Output: %d", testvec[i].wb_data, sparce_if.is_sparse);
      i = i+1;
    end
    $finish;
  end


endmodule
