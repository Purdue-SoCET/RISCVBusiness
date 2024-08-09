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
*   Filename:     tb/tb_alu.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 06/12/2016
*   Description:  Testbench for the alu 
*/

`include "alu_if.vh"

module tb_alu ();
  import alu_types_pkg::*;
  import rv32i_types_pkg::*;

  parameter NUM_TESTS = 19;
  parameter DELAY = 20;
 
  logic error_found;

  aluop_t input_aluop_vec [NUM_TESTS-1:0];
  assign input_aluop_vec = {
    ALU_SLL,
    ALU_SRL,
    ALU_SRA,
    ALU_SRA,
    ALU_AND,
    ALU_OR,
    ALU_XOR,
    ALU_SLT,
    ALU_SLT,
    ALU_SLT,
    ALU_SLTU,
    ALU_SLTU,
    ALU_SLTU,
    ALU_ADD,
    ALU_SUB,
    ALU_SLT,
    ALU_SLTU,
    ALU_SLT,
    ALU_SLTU
  };

  word_t input_a_vec [NUM_TESTS-1:0];
  assign input_a_vec = { 
    32'h0000_0040,
    32'h0000_0800,
    32'h8000_0000,
    32'h0000_8000,
    32'hffff_ffff,
    32'h0000_0000,
    32'h5555_0000,
    32'h8000_0000,
    32'h1000_0000,
    32'h0001_0000,
    32'h0001_0000,
    32'h8000_0000,
    32'h1000_0000,
    32'h0000_000a,
    32'h0000_000a,
    32'h0002_0000,
    32'h0002_0000,
    32'hf002_0000,
    32'hf002_0000
  }; 

  word_t input_b_vec [NUM_TESTS-1:0];
  assign input_b_vec = {
    32'h5,
    32'h5,
    32'h4,
    32'h5,
    32'h5555_5555,
    32'h5555_5555,
    32'h5555_5555,
    32'h0800_0000,
    32'h4000_0000,
    32'h0002_0000,
    32'h0002_0000,
    32'h0800_0000,
    32'h4000_0000,
    32'h0000_0003,
    32'h0000_0003,
    32'h0001_0000,
    32'h0001_0000,
    32'hffff_ffff,
    32'hf001_0000
  };

  word_t output_vec [NUM_TESTS-1:0];
  assign output_vec = {
    32'h0000_0800,
    32'h0000_0040,
    32'hf800_0000,
    32'h0000_0400,
    32'h5555_5555,
    32'h5555_5555,
    32'h0000_5555,
    32'h1,
    32'h1,
    32'h1,
    32'h1,
    32'h0,
    32'h1,
    32'h0000_000d,
    32'h0000_0007,
    32'h0,
    32'h0,
    32'h1,
    32'h0
  };

  alu_if aluif();

  alu DUT (
    .alu_if(aluif)
  );
 
  initial begin : MAIN
    error_found = 0;
    #(DELAY);
    for(int i = 0; i < NUM_TESTS;i++) begin
      aluif.aluop = input_aluop_vec[i];
      aluif.port_a = input_a_vec[i];
      aluif.port_b = input_b_vec[i];
      #(DELAY);
      if(aluif.port_out != output_vec[i]) begin
        $error("Error: ALU output was incorrect for index %d.\nExpected %h Received %h\n", i, 
          output_vec[i], aluif.port_out);
        error_found = 1;
      end
    end

    if(!error_found) begin
      $display("ALU Testing : PASSED\n");
    end

    $finish;
  end : MAIN
endmodule

