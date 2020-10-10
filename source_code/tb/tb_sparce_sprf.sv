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
*   Filename:     tb/tb_sparce_sprf.sv
*
*   Created by:   Vadim Nikiforov 
*   Email:        vnikifor@purdue.edu
*   Date Created: 08/18/2019
*   Description:  Testbench for the sparsity register file
*/

`include "sparce_internal_if.vh"
  import rv32i_types_pkg::*;


typedef struct packed
{
  logic wb_en;
  logic [4:0] rd;
  logic is_sparse;
  logic [4:0] sasa_rs1;
  logic [4:0] sasa_rs2;
  logic rs1_sparsity;
  logic rs2_sparsity;
} sparce_sprf_testvec_t;

//  modport sprf (
//    output rs1_sparsity, rs2_sparsity,
//    input wb_en, rd, is_sparse, sasa_rs1, sasa_rs2
//  );

module tb_sparce_sprf ();

  parameter PERIOD = 20;

  logic tb_clk;
  logic tb_nRST;

  sparce_internal_if sparce_if();
  sparce_sprf DUT(tb_clk, tb_nRST, sparce_if);

  integer i;
  sparce_sprf_testvec_t testvec[2:0];

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
    tb_clk  = 0;
    tb_nRST = 1;
    i = 0;
    initialize;
    test_initial_values;
    test_writes;
    test_no_enable;
    test_writes_in_flight;
    $finish;
  end

  task initialize;
    sparce_if.wb_en = 1'b0;
    sparce_if.rd = 5'b0;
    sparce_if.is_sparse = 1'b0;
    sparce_if.sasa_rs1 = 5'b0;
    sparce_if.sasa_rs2 = 5'b0;
    @(negedge tb_clk);
    tb_nRST = 0;
    @(negedge tb_clk);
    tb_nRST = 1;
  endtask

  task test_initial_values;
    @(negedge tb_clk);
    for (i=0; i< 32; i++) begin
      @(negedge tb_clk);
      sparce_if.sasa_rs1 = i;
      sparce_if.sasa_rs2 = 31-i;
      @(posedge tb_clk);
      assert (sparce_if.rs1_sparsity == (i == 0)) else $error("SPRF has wrong init values for register %2d", i);
      assert (sparce_if.rs2_sparsity == (i == 31)) else $error("SPRF has wrong init values for register %2d", 31-i);
    end
  endtask

  task test_writes;
    initialize;
    @(negedge tb_clk);
    // Test writes of 1 to the sprf
    for (i=0; i<32; i++) begin
      @(negedge tb_clk);
      sparce_if.rd = i;
      sparce_if.wb_en = 1;
      sparce_if.is_sparse = 1;
      sparce_if.sasa_rs1 = i;
      sparce_if.sasa_rs2 = i;
      @(negedge tb_clk);
      sparce_if.wb_en = 0;
      @(posedge tb_clk);
      assert (sparce_if.rs1_sparsity == 1) else $error("SPRF did not store sparse value for register %2d", i);
      assert (sparce_if.rs2_sparsity == 1) else $error("SPRF did not store sparse value for register %2d", i);
    end
    // Test writes of 0 to the sprf
    for (i=0; i<32; i++) begin
      @(negedge tb_clk);
      sparce_if.rd = i;
      sparce_if.wb_en = 1;
      sparce_if.is_sparse = 0;
      sparce_if.sasa_rs1 = i;
      sparce_if.sasa_rs2 = i;
      @(negedge tb_clk);
      sparce_if.wb_en = 0;
      @(posedge tb_clk);
      assert (sparce_if.rs1_sparsity == (i==0)) else $error("SPRF did not store non-sparse value for register %2d", i);
      assert (sparce_if.rs2_sparsity == (i==0)) else $error("SPRF did not store non-sparse value for register %2d", i);
    end
  endtask

  task test_no_enable;
    initialize;
    @(negedge tb_clk);
    // Test writes of 1 to the sprf without the enable bit set
    for (i=0; i<32; i++) begin
      @(negedge tb_clk);
      sparce_if.rd = i;
      sparce_if.wb_en = 0;
      sparce_if.is_sparse = 1;
      sparce_if.sasa_rs1 = i;
      sparce_if.sasa_rs2 = i;
      @(negedge tb_clk);
      sparce_if.wb_en = 0;
      @(posedge tb_clk);
      assert (sparce_if.rs1_sparsity == (i==0)) else $error("SPRF stored sparse value for register %2d without enable set", i);
      assert (sparce_if.rs2_sparsity == (i==0)) else $error("SPRF stored sparse value for register %2d without enable set", i);
    end
  endtask

  task test_writes_in_flight;
    // Test writes of 1 to the sprf in flight
    for (i=0; i<32; i++) begin
      @(negedge tb_clk);
      sparce_if.rd = i;
      sparce_if.wb_en = 1;
      sparce_if.is_sparse = 1;
      sparce_if.sasa_rs1 = i;
      sparce_if.sasa_rs2 = i;
      @(posedge tb_clk);
      assert (sparce_if.rs1_sparsity == 1) else $error("SPRF did not process in-flight sparse value for register %2d", i);
      assert (sparce_if.rs2_sparsity == 1) else $error("SPRF did not process in-flight sparse value for register %2d", i);
    end
    // Test writes of 0 to the sprf in flight
    for (i=0; i<32; i++) begin
      @(negedge tb_clk);
      sparce_if.rd = i;
      sparce_if.wb_en = 1;
      sparce_if.is_sparse = 0;
      sparce_if.sasa_rs1 = i;
      sparce_if.sasa_rs2 = i;
      @(posedge tb_clk);
      assert (sparce_if.rs1_sparsity == (i==0)) else $error("SPRF did not process in-flight non-sparse value for register %2d", i);
      assert (sparce_if.rs2_sparsity == (i==0)) else $error("SPRF did not process in-flight non-sparse value for register %2d", i);
    end
  endtask


endmodule
