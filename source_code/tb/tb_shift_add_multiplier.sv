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
*   Filename:     tb_shift_add_multiplier.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 02/15/2017
*   Description:  Tests a 32bitx32bit multiplier
*/


module tb_shift_add_multiplier ();

  parameter PERIOD = 20;

  int cycles = 0;

  /*  Signal Instantiations */
  logic CLK, nRST;
  logic [31:0] multiplicand;
  logic [31:0] multiplier;
  logic [1:0] is_signed;
  logic start, finished, start2, finished2;
  logic [63:0] product;
  logic [63:0] product2;
  logic [31:0] test_num; 

  /*  Module Instantiations */
  shift_add_multiplier #(32) DUT (.*);
  pp_mul32 DUT_compare(.CLK(CLK), .nRST(nRST), 
                       .multiplicand(multiplicand), .multiplier(multiplier), .is_signed(is_signed),
                       .start(start2), .finished(finished2),
                       .product(product2));

  /*  CLK generation */

  initial begin
    CLK = 0;
  end

  always begin
    CLK = ~CLK;
    #(PERIOD/2);
  end

  task test_mult(
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [1:0] is_signed_t,
    input logic [63:0] expected_out
  );
    cycles = 0;
    multiplicand = a;
    multiplier = b;
    is_signed = is_signed_t;
    start = 1;
    start2 = 1;
    @(posedge CLK);
    start = 0;
    start2 = 0;

    // fork
    //   begin
    //     static time t = $realtime;
    //     while(!finished && $realtime < t + PERIOD*10) 
    //       @(posedge CLK);
    //     $display("  1 finished");
    //   end
    //   begin
    //     static time t = $realtime;
    //     while(!finished2 && $realtime < t + PERIOD*10)
    //       @(posedge CLK);
    //     $display("  2 finished");
    //   end
    // join

    // if (product2 == product) begin
    //   $display("OK. product == %0h EXPECTED %0h", product, expected_out);
    // end else begin
    //   $display("Different Outputs: shift_add_multiplier %0h pp_mul32 %0h EXPECTED %0h", product, product2, expected_out);
    // end

    // while(!finished || !finished2) 
    while(!finished) 
      @(posedge CLK);
      cycles = cycles + 1;
    
    // assert (product == expected_out) else $error("Multiplication failed for test %0d\n", test_num);
    if (product == expected_out) begin
      $display("Test %0d Passed: GOT %0h after %0d cycles", test_num, product, cycles);
    end else begin 
      $display("Test %0d Failed: EXPECTED %0h GOT %0h after %0d cycles", test_num, expected_out, product, cycles);
    end
    // if (product2 == product) begin
    //   $display("OK");
    // end else begin
    //   $display("Different Outputs: shift_add_multiplier %0h pp_mul32 %0h", product, product2);
    // end
    test_num++;
  endtask

  /*  Begin Testing   */

  initial begin
    // reset multiplier
    test_num = 0;
    nRST = 1'b0;
    multiplicand = 0;
    multiplier = 0;
    is_signed = 0;
    start = 0;
    start2 = 0;
    @(posedge CLK);
    #1;
    nRST = 1'b1;
    @(posedge CLK);

    // basic multiplication test
    test_mult(32'd8, 32'd11, 2'b00, 64'd88);
 
    // both signed multiplication test
    test_mult(-1, -108, 2'b11, 108);

    // one signed one unsigned
    test_mult(-8, 100001, 2'b10, -800008); 
    test_mult(100001, -8, 2'b01, -800008); 

    //  negative number and 1
    test_mult(32'hffff_ffff, 32'h1, 2'b11, 64'hffff_ffff);
    test_mult(32'h1, 32'hffff_ffff, 2'b11, 64'hffff_ffff);

    // largest negative number and 1
    test_mult(32'h8000_0000, 32'h1, 2'b11, 64'h8000_0000);    
    test_mult(32'h8000_0000, 32'h1, 2'b00, 64'h8000_0000); 

    // multiply by 0
    test_mult(32'h0, 32'habcd_1234, 2'b00, 64'h0);   
 
    $finish;
  end
  
endmodule
