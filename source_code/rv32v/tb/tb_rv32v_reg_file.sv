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
*   Filename:     tb/tb_rv32v_reg_file.sv
*
*   Created by:   Owen Prince	
*   Email:        oprince@purdue.edu
*   Date Created: 10/10/2021
*   Description:  testbench for vector register file
*/

`include "rv32v_reg_file_if.vh"
// `define TESTBENCH

module tb_rv32v_reg_file ();
  // import rv32i_types_pkg::*;
  import rv32i_types_pkg::*;

  parameter NUM_TESTS = 19;
  parameter PERIOD = 20;
  parameter DELAY = 20;
  int testnum;
  string testname = "";

 
  logic error_found;
  logic CLK, nRST;

  rv32v_reg_file_if # (.READ_PORTS(2), .WRITE_PORTS(1)) rfv_if();
  // element_counter_if ele_if();

  rv32v_reg_file # (.READ_PORTS(2), .WRITE_PORTS(1)) DUT (.*);
  // element_counter ELE (.*);
  //   .rfv_if(CLK, nRST, rfv_if)
  // );

  assign rfv_if.vs1_offset = 0;
  assign rfv_if.vs2_offset = 0;
  assign rfv_if.vs3_offset = 0;
  assign rfv_if.vd_offset =  0;


  initial begin : CLK_INIT
    CLK = 1'b0;
    nRST = 1;
  end : CLK_INIT

  always begin : CLK_GEN
    #(PERIOD/2) CLK = ~CLK;
  end : CLK_GEN
 
  task reset;
    // `ifdef TESTBENCH
    DUT.tb_ctrl = 0;
    // `endif
    @(negedge CLK);
    rfv_if.vd = 0;
    rfv_if.w_data = 0;
    rfv_if.wen = 0;
    // rfv_if.vs1_offset = 0;
    // rfv_if.vs2_offset = 0;
    // rfv_if.vd_offset  = 0;
    rfv_if.vl[0] = 127;
    rfv_if.vl[1] = 127;
    nRST = 0;
    // ele_if.vstart = 0;
    // ele_if.vl = rfv_if.vl;
    // ele_if.stall = 0;
    // ele_if.ex_return = 0;
    // ele_if.de_en = 0;
    // ele_if.sew = SEW32;
    // ele_if.clear = 0;

    @(posedge CLK);
    nRST = 1;
  endtask

  task load_reg_data;
    // `ifdef TESTBENCH
      @(negedge CLK);
      DUT.tb_ctrl = 1;
      DUT.tb_sel = 0;
      DUT.tb_data = {32{4'hA}};
      @(negedge CLK);
      DUT.tb_ctrl = 0;
    // `endif
  endtask

  task display_reg;
    input logic [4:0] rs;

    int i;
    automatic int sum;
    sum = 0;
    for (i = VLENB - 1; i >= 0; i--) begin
      sum += DUT.registers[rs][i];
    end
    if (sum != 0) begin
      $write("register[%d]: ", rs);
      for (i = VLENB - 1; i >= 0; i--) begin
        if (i % 4 == 3 && (i != 15)) begin
          $write(" --- [%x]", DUT.registers[rs][i]);
        end else begin
          $write(" [%x]", DUT.registers[rs][i]);
        end
      end
      $write("\n");
    end
    // $display("[%x] [%x] [%x] [%x] [%x] [%x] [%x] [%x]", DUT.registers[vs1][7], DUT.registers[vs1][6],DUT.registers[vs1][5],DUT.registers[vs1][4],DUT.registers[vs1][3],DUT.registers[vs1][2],DUT.registers[vs1][1],DUT.registers[vs1][0]);
    // #2;
  endtask
  
  task display_reg_file;
    int i;
    $write("\n");
    for (i = 0; i < 32; i++) begin
      display_reg(i);
    end
    $write("\n");

  endtask

  task write_reg;
    input logic [1:0] wen;
    input sew_t sew;
    input word_t [1:0] dat;
    input [4:0] wsel;
    input offset_t offset;
    // input offset_t vd_offset;

    // @(negedge CLK);
    rfv_if.vl = 4;
    rfv_if.single_bit_write  = 0; 
    rfv_if.vd_offset         = {offset + 1, offset};
    rfv_if.vd                = wsel;
    rfv_if.w_data            = dat;
    rfv_if.wen               = wen;
    // rfv_if.wen               = 0;
    rfv_if.sew               = sew;
    rfv_if.eew               = sew;
    rfv_if.vs2_sew           = sew;
    


    @(posedge CLK);
    #2;
    // $write ("WRITE to registers[%d], offset(%d) : [%x], [%x]\n", wsel, vd_offset, rfv_if.w_data[1], rfv_if.w_data[0]);
    // display_reg(wsel);
  endtask


  task read_reg;
    input sew_t sew;
    input [4:0] vs1;
    input [4:0] vs2;
    // input offset_t vs1_offset;
    // input offset_t vs2_offset;

    // @(negedge CLK);
    #1;
    rfv_if.sew[0] = sew;
    rfv_if.eew[0] = sew;
    // ele_if.sew = sew;
    rfv_if.vs1[0] = vs1;
    rfv_if.vs2[0] = vs2;
    rfv_if.vs3[0] = vs2;



    rfv_if.vs1_offset[0] = {8'd1, 8'd0};
    rfv_if.vs2_offset[0] = {8'd1, 8'd0};
    rfv_if.vs3_offset[0] = {8'd1, 8'd0}; //yes it is the same as vs2

    // display_reg(vs1);
    // $write ("READ: registers[%d], rdat1: [%x], [%x]\n \
// registers[%d], rdat2: [%x], [%x]\n", vs1, rfv_if.vs1_data[1], rfv_if.vs1_data[0], vs2, rfv_if.vs2_data[1], rfv_if.vs2_data[0]);
  endtask

  task newtest;
    input string testname;
    reset();
    $info("\nTEST CASE %d: %s\n", testnum, testname);
    testnum+=1;
  endtask

  task write_with_offset;
    input sew_t sew;
    input int max_cnt;

    word_t [1:0] data;
    word_t [1:0] data_temp;
    // int max_cnt;
    int reg_idx;

    data = {$urandom(), $urandom()};
    data_temp = data;
    // max_cnt = 128 / (1 << sew);
    reg_idx = 0;
    // ele_if.de_en = 0;
    rfv_if.vl = max_cnt;

    for(int el_idx = 0; el_idx < max_cnt; el_idx+=2) begin
      // ele_if.de_en = 1;
      // data = {data[1] >> (), data[0] >> ()};
      write_reg(3, sew, data, reg_idx, el_idx);
      read_reg(sew, reg_idx, reg_idx);
      // if 
      // data = next_data;
    end
    // ele_if.de_en = 0;

    display_reg_file();
  endtask


  logic [1:0][3:0] a, b;
  logic [1:0][1:0] sel;
  logic [1:0][1:0] wen;
  logic [1:0][31:0] dat_a, dat_b;
  test T1 (.*);

  initial begin : MAIN
    testnum = 0;
    testname = "";
    error_found = 0;
    #(DELAY);
    nRST = 0;
    #(DELAY);
    nRST = 1;

    // newtest("test load");
    // load_reg_data();
    // #(10);
    // display_reg_file();

    @(posedge CLK);
    // newtest("write disable");
    // write_reg(4'h0, SEW32, {$urandom(), $urandom()}, 0, 0);

    // //32 bit
    // newtest("32 bit, no offset");
    // for(int i = 0; i < 32; i+=8) begin
    //   // $write("----------------------------\n");
    //   write_reg(4'hF, SEW32, {$urandom(), $urandom()}, i, 0);
    //   read_reg(SEW32, i, i);
    // end
    // display_reg_file();

    //16 bit
    newtest("16 bit, no offset");
    for(int i = 0; i < 32; i+=1) begin
      // $write("----------------------------\n");
      write_reg(2'h3, SEW16, {$urandom(i), $urandom(i + 1)}, i, 0);
      read_reg(SEW16, i, i);
      if (rfv_if.vs1_data != {$urandom(i), $urandom(i + 1)}) $display("fail");
    end
    display_reg_file();
    
    // //8 bit
    // newtest("8 bit, no offset");
    // for(int i = 0; i < 32; i+=8) begin
    //   // $write("----------------------------\n");
    //   write_reg(4'h1, SEW8, {$urandom(), $urandom()}, i, 0);
    //   read_reg(SEW8, i, i);
    // end

    // newtest("32 bit, with offset");
    // write_with_offset(SEW32, 32);
    
    // newtest("16 bit, with offset");
    // write_with_offset(SEW16, 64);
    // display_reg_file();

    // newtest("8 bit, with offset");
    // write_with_offset(SEW8, 128);

    // newtest("32 bit, 1 element");
    // write_with_offset(SEW32, 1);

    // newtest("16 bit, 1 element");
    // write_with_offset(SEW16, 1);
    
    // newtest("8  bit, 1 element");
    // write_with_offset(SEW8, 1);


    $finish;
  end : MAIN
endmodule



module test(
  input logic CLK, nRST,
  input logic [1:0][3:0] a, b,
  input logic [1:0] sel,
  input logic [1:0] wen,
  input logic [1:0][31:0] dat_a, dat_b
);
  integer i, j, s, k;
  logic [3:0][3:0][31:0] regs, next_regs;
  logic [3:0][3:0][31:0] temp;

  always_ff @(posedge CLK, negedge nRST) begin
    if (~nRST) 
      regs <= 0;
    else 
      regs <= next_regs;
  end

  always_comb   begin
    // next_regs = regs;
    
    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        next_regs[i][j] = 0;
        for (k = 0; k < 2; k = k + 1) begin
          if ((i == a[k]) && (j == b[k])) begin 
            // if (k == sel)
              next_regs[i][j] = dat_a[k]; 
            // end
          end
          // if (i == a && j == a) begin next_regs[i][j] = dat_a; end
        end
      end
    end
    // for (i = 0; i < 4; i = i + 1) begin
    //   for (j = 0; j < 4; j = j + 1) begin
    //     // for (s = 0; s < 2; s = s + 1)
    //     if (temp[i][j] != 0) next_regs[i][j] = temp[i][j];
    //     else next_regs[i][j] = 1;
    //   end
    // end

  end
endmodule