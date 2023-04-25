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
*   Filename:     rv32b_execute.sv
*
*   Created by:   Tanuj Sengupta
*   Email:        tsengup@purdue.edu
*   Date Created: 04/25/2023
*   Description:  Execute stage for Bitmanipulation
*/

`include "component_selection_defines.vh"

module rv32b_enabled (
    input CLK,
    input nRST,
    input valid_cmd,
    input [31:0] instr,
    input [31:0] rs1_val,
    input [31:0] rs2_val,
    output valid,
    output logic [31:0] rv32b_out
);
//    import rv32i_types_pkg::*;
//    import rv32b_pkg::*;
//    rv32b_insn_t instr_in;

    logic [47:0] valid_out;
    logic [31:0] andn_out;
    logic [31:0] orn_out;
    logic [31:0] xnor_out;
    logic [31:0] max_out;
    logic [31:0] maxu_out;
    logic [31:0] min_out;
    logic [31:0] minu_out;
    logic [31:0] rol_out;
    logic [31:0] ror_out;
    logic [31:0] sh1add_out;
    logic [31:0] sh2add_out;
    logic [31:0] sh3add_out;
    logic [31:0] bclr_out;
    logic [31:0] bext_out;
    logic [31:0] binv_out;
    logic [31:0] bset_out;
    logic [31:0] clmul_out;
    logic [31:0] clmulh_out;
    logic [31:0] clmulr_out;
    logic [31:0] clz_out;
    logic [31:0] cpop_out;
    logic [31:0] ctz_out;
    logic [31:0] orc_b_out;
    logic [31:0] rev8_out;
    logic [31:0] rori_out;
    logic [31:0] sext_b_out;
    logic [31:0] sext_h_out;
    logic [31:0] bclri_out;
    logic [31:0] bexti_out;
    logic [31:0] binvi_out;
    logic [31:0] bseti_out;
    logic [31:0] clzw_out;
    logic [31:0] cpopw_out;
    logic [31:0] ctzw_out;
    logic [31:0] roriw_out;
    logic [31:0] slli_uw_out;
    logic [31:0] add_uw_out;
    logic [31:0] sh1add_uw_out;
    logic [31:0] sh2add_uw_out;
    logic [31:0] sh3add_uw_out;
    logic [31:0] zext_h_out;

/////////////////////////////////////////////////
// Selection of the appropriate output
/////////////////////////////////////////////////

assign rv32b_out = valid_out[0] ? andn_out :
                      valid_out[1] ? orn_out  :  
                      valid_out[2] ? xnor_out  :  
                      valid_out[3] ? max_out  :  
                      valid_out[4] ? maxu_out  :  
                      valid_out[5] ? min_out  :  
                      valid_out[6] ? minu_out  :  
                      valid_out[7] ? rol_out  :  
                      valid_out[8] ? ror_out  :  
                      valid_out[9] ? sh1add_out  :  
                      valid_out[10] ? sh2add_out  :  
                      valid_out[11] ? sh3add_out  :  
                      valid_out[12] ? bclr_out  :  
                      valid_out[13] ? bext_out  :  
                      valid_out[14] ? binv_out  :  
                      valid_out[15] ? bset_out  :  
                      valid_out[16] ? clmul_out  :  
                      valid_out[17] ? clmulh_out  :  
                      valid_out[18] ? clmulr_out  : 
                      valid_out[19] ? clz_out  : 
                      valid_out[20] ? cpop_out  : 
                      valid_out[21] ? ctz_out  : 
                      valid_out[22] ? orc_b_out  : 
                      valid_out[23] ? rev8_out  : 
                      valid_out[24] ? rori_out  : 
                      valid_out[25] ? sext_b_out  : 
                      valid_out[26] ? sext_h_out  : 
                      valid_out[27] ? bclri_out  : 
                      valid_out[28] ? bexti_out  : 
                      valid_out[29] ? binvi_out  : 
                      valid_out[30] ? bseti_out  : 
                      valid_out[31] ? clzw_out  : 
                      valid_out[32] ? cpopw_out  : 
                      valid_out[33] ? ctzw_out  : 
                      valid_out[34] ? roriw_out  : 
                      valid_out[35] ? slli_uw_out  : 
                      valid_out[36] ? add_uw_out  : 
                      valid_out[37] ? sh1add_uw_out  : 
                      valid_out[38] ? sh2add_uw_out  : 
                      valid_out[39] ? sh3add_uw_out  : 
                      valid_out[40] ? zext_h_out  : 
                                      0 ; // Although this can be interpreted as a result but we need to make sure that valid is not high during this time. So this result will not be considered. 

assign valid = |valid_out[47:0];

/////////////////////////////////////////////////
// Different operation implementations
/////////////////////////////////////////////////

///////////////////////////////////////////
// 1.) MAJOR OPCODE 011_0011 
///////////////////////////////////////////

///////////////////////////////////////////
// ANDN
///////////////////////////////////////////

always_comb begin //{
if (valid_cmd && instr[31:25]==7'b010_0000 && instr[14:12]==3'b111 && instr[6:0]==7'b011_0011) begin //{
 andn_out = rs1_val & (~rs2_val);
 valid_out[0] = 1'b1;
end //}
else begin //{
 andn_out = 0;
 valid_out[0] = 1'b0;
end //}
end //}

///////////////////////////////////////////
// ORN
///////////////////////////////////////////

always_comb begin //{
if (valid_cmd && instr[31:25]==7'b010_0000 && instr[14:12]==3'b110 && instr[6:0]==7'b011_0011) begin //{
 orn_out = rs1_val | (~rs2_val);
 valid_out[1] = 1'b1;
end //}
else begin //{
 orn_out = 0;
 valid_out[1] = 1'b0;
end //}
end //}

///////////////////////////////////////////
// XNOR
///////////////////////////////////////////

always_comb begin //{
if (valid_cmd && instr[31:25]==7'b010_0000 && instr[14:12]==3'b100 && instr[6:0]==7'b011_0011) begin //{
 xnor_out = ~(rs1_val ^ rs2_val);
 valid_out[2] = 1'b1;
end //}
else begin //{
 xnor_out = 0;
 valid_out[2] = 1'b0;
end //}
end //}


///////////////////////////////////////////
// MAX
///////////////////////////////////////////

// Compare signed integers
always_comb begin //{
   if (valid_cmd && instr[31:25]==7'b000_0101 && instr[14:12]==3'b110 && instr[6:0]==7'b011_0011) begin //{
    if (rs1_val[31]>rs2_val[31]) begin //{ // ie rs1_val is -vs and rs2_val is +ve
     max_out = rs2_val;
     valid_out[3] = 1'b1;
    end //}
    else if (rs2_val[31]>rs1_val[31]) begin //{ // ie rs1_val is +ve and rs2_val is -ve
     max_out = rs1_val;
     valid_out[3] = 1'b1;
    end //} 
    else begin //{
     if (rs1_val>=rs2_val) begin //{
      max_out = rs1_val;
      valid_out[3] = 1'b1;
     end //}
     else begin //{
      max_out = rs2_val;
      valid_out[3] = 1'b1;
     end //}
    end //}
   end //}
   
   else begin //{
     max_out = 0;
     valid_out[3] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// MAXU
///////////////////////////////////////////

// Compare unsigned integers
always_comb begin //{
   if (valid_cmd && instr[31:25]==7'b000_0101 && instr[14:12]==3'b111 && instr[6:0]==7'b011_0011) begin //{
     if (rs1_val>=rs2_val) begin //{
      maxu_out = rs1_val;
      valid_out[4] = 1'b1;
     end //}
     else begin //{
      maxu_out = rs2_val;
      valid_out[4] = 1'b1;
     end //}
   end //}
   else begin //{
     maxu_out = 0;
     valid_out[4] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// MIN
///////////////////////////////////////////

// Compare signed integers
always_comb begin //{
   if (valid_cmd && instr[31:25]==7'b000_0101 && instr[14:12]==3'b100 && instr[6:0]==7'b011_0011) begin //{
    if (rs1_val[31]>rs2_val[31]) begin //{ // ie rs1_val is -ve and rs2_val is +ve
     min_out = rs1_val;
     valid_out[5] = 1'b1;
    end //}
    else if (rs2_val[31]>rs1_val[31]) begin //{ // ie rs1_val is +ve and rs2_val is -ve
     min_out = rs2_val;
     valid_out[5] = 1'b1;
    end //} 
    else begin //{
     if (rs1_val>=rs2_val) begin //{
      min_out = rs2_val;
      valid_out[5] = 1'b1;
     end //}
     else begin //{
      min_out = rs1_val;
      valid_out[5] = 1'b1;
     end //}
    end //}
   end //}
   
   else begin //{
     min_out = 0;
     valid_out[5] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// MINU
///////////////////////////////////////////

// Compare unsigned integers
always_comb begin //{
   if (valid_cmd && instr[31:25]==7'b000_0101 && instr[14:12]==3'b101 && instr[6:0]==7'b011_0011) begin //{
     if (rs1_val>=rs2_val) begin //{
      minu_out = rs2_val;
      valid_out[6] = 1'b1;
     end //}
     else begin //{
      minu_out = rs1_val;
      valid_out[6] = 1'b1;
     end //}
   end //}
   else begin //{
     minu_out = 0;
     valid_out[6] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// ROL
///////////////////////////////////////////

// Assuming its a 32 bit architecture and hence shift amount is 5 LSB of rs2_val
always_comb begin //{
   if (valid_cmd && instr[31:25]==7'b011_0000 && instr[14:12]==3'b001 && instr[6:0]==7'b011_0011) begin //{
     rol_out = (rs1_val << rs2_val[4:0]) | (rs1_val>>(6'd32 - rs2_val[4:0])); // 4:0 only for 32 bit architecture. Otherwise log2(XLEN) bits of rs2_val
     valid_out[7] = 1'b1;
   end //}
   else begin //{
     rol_out = 0;
     valid_out[7] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// ROR
///////////////////////////////////////////

// Assuming its a 32 bit architecture and hence shift amount is 5 LSB of rs2_val
always_comb begin //{
   if (valid_cmd && instr[31:25]==7'b011_0000 && instr[14:12]==3'b101 && instr[6:0]==7'b011_0011) begin //{
     ror_out = (rs1_val >> rs2_val[4:0]) | (rs1_val << (6'd32 - rs2_val[4:0])); // 4:0 only for 32 bit architecture. Otherwise log2(XLEN) bits of rs2_val
     valid_out[8] = 1'b1;
   end //}
   else begin //{
     ror_out = 0;
     valid_out[8] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// SH1ADD
///////////////////////////////////////////

always_comb begin //{
   if (valid_cmd && instr[31:25]==7'b001_0000 && instr[14:12]==3'b010 && instr[6:0]==7'b011_0011) begin //{
     sh1add_out = rs2_val + (rs1_val<<1); 
     valid_out[9] = 1'b1;
   end //}
   else begin //{
     sh1add_out = 0;
     valid_out[9] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// SH2ADD
///////////////////////////////////////////

always_comb begin //{
   if (valid_cmd && instr[31:25]==7'b001_0000 && instr[14:12]==3'b100 && instr[6:0]==7'b011_0011) begin //{
     sh2add_out = rs2_val + (rs1_val<<2); 
     valid_out[10] = 1'b1;
   end //}
   else begin //{
     sh2add_out = 0;
     valid_out[10] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// SH3ADD
///////////////////////////////////////////

always_comb begin //{
   if (valid_cmd && instr[31:25]==7'b001_0000 && instr[14:12]==3'b110 && instr[6:0]==7'b011_0011) begin //{
     sh3add_out = rs2_val + (rs1_val<<3); 
     valid_out[11] = 1'b1;
   end //}
   else begin //{
     sh3add_out = 0;
     valid_out[11] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// BCLR
///////////////////////////////////////////

always_comb begin //{
   if (valid_cmd && instr[31:25]==7'b010_0100 && instr[14:12]==3'b001 && instr[6:0]==7'b011_0011) begin //{
     bclr_out = rs1_val & (~(1<<rs2_val[4:0]));  // Assuming its a 32 bit architecture. 
     valid_out[12] = 1'b1;
   end //}
   else begin //{
     bclr_out = 0;
     valid_out[12] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// BEXT
///////////////////////////////////////////

always_comb begin //{
   if (valid_cmd && instr[31:25]==7'b010_0100 && instr[14:12]==3'b101 && instr[6:0]==7'b011_0011) begin //{
     bext_out = (rs1_val>>rs2_val[4:0]) & (32'd1);  // Assuming its a 32 bit architecture. 
     valid_out[13] = 1'b1;
   end //}
   else begin //{
     bext_out = 0;
     valid_out[13] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// BINV
///////////////////////////////////////////

always_comb begin //{
   if (valid_cmd && instr[31:25]==7'b011_0100 && instr[14:12]==3'b001 && instr[6:0]==7'b011_0011) begin //{
     binv_out = rs1_val ^ (1<<rs2_val[4:0]);  // Assuming its a 32 bit architecture. 
     valid_out[14] = 1'b1;
   end //}
   else begin //{
     binv_out = 0;
     valid_out[14] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// BSET
///////////////////////////////////////////
always_comb begin //{
   if (valid_cmd && instr[31:25]==7'b001_0100 && instr[14:12]==3'b001 && instr[6:0]==7'b011_0011) begin //{
     bset_out = rs1_val | (1<<rs2_val[4:0]);  // Assuming its a 32 bit architecture. 
     valid_out[15] = 1'b1;
   end //}
   else begin //{
     bset_out = 0;
     valid_out[15] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// CLMUL
///////////////////////////////////////////
//integer i;
always_comb begin //{
   if (valid_cmd && instr[31:25]==7'b000_0101 && instr[14:12]==3'b001 && instr[6:0]==7'b011_0011) begin //{
     clmul_out = 32'd0;
     for (integer i=0;i<32;i++) begin//{
      if (((rs2_val>>i) & 32'd1)==32'd1)
      clmul_out = clmul_out ^ (rs1_val<<i);
      else
      clmul_out = clmul_out ^ 0; // Retains the same value . Can also just keep it as clmul_out = clmul_out
     end//}
     valid_out[16] = 1'b1;
   end //}
   else begin //{
     clmul_out = 0;
     valid_out[16] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// CLMULH
///////////////////////////////////////////
//integer i;
always_comb begin //{
   if (valid_cmd && instr[31:25]==7'b000_0101 && instr[14:12]==3'b011 && instr[6:0]==7'b011_0011) begin //{
     clmulh_out = 32'd0;
     for (integer i=1;i<32;i++) begin//{
      if (((rs2_val>>i) & 32'd1)==32'd1)
      clmulh_out = clmulh_out ^ (rs1_val>>(32-i));
      else
      clmulh_out = clmulh_out ^ 0; // Retains the same value . Can also just keep it as clmulh_out = clmulh_out
     end//}
     valid_out[17] = 1'b1;
   end //}
   else begin //{
     clmulh_out = 0;
     valid_out[17] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// CLMULR
///////////////////////////////////////////
//integer i;
always_comb begin //{
   if (valid_cmd && instr[31:25]==7'b000_0101 && instr[14:12]==3'b010 && instr[6:0]==7'b011_0011) begin //{
     clmulr_out = 32'd0;
     for (integer i=1;i<32;i++) begin//{
      if (((rs2_val>>i) & 32'd1)==32'd1)
      clmulr_out = clmulr_out ^ (rs1_val>>(32-i-1));
      else
      clmulr_out = clmulr_out ^ 0; // Retains the same value . Can also just keep it as clmulr_out = clmulr_out
     end//}
     valid_out[18] = 1'b1;
   end //}
   else begin //{
     clmulr_out = 0;
     valid_out[18] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// 2.) MAJOR OPCODE 001_0011
///////////////////////////////////////////

///////////////////////////////////////////
// CLZ
///////////////////////////////////////////

//integer i;
logic [31:0] highest_bit_set_clz; // Although 6 bits will also suffice
logic flag_clz ;

always_comb begin //{
   if (valid_cmd && instr[31:20]==12'b011_0000_00000 && instr[14:12]==3'b001 && instr[6:0]==7'b001_0011) begin //{
    highest_bit_set_clz = 0;
    flag_clz  = 0; 
    
    // Finding out the highest bit set
    for (integer i=31;i>0;i--) begin//{
     if (rs1_val[i] && !flag_clz ) begin //{
      highest_bit_set_clz = i;
      flag_clz  = 1'b1;
     end //}
     end//}
 
     // Calculating the number of leading zeroes 
     if (!flag_clz )
     clz_out = 32'd32;
     else if (highest_bit_set_clz==32'd31) // Assuming a 32 bit architecture
     clz_out = 32'd0;
     else
     clz_out = 32'd31 - highest_bit_set_clz;  // Assuming a 32 bit architecture
     
     // Setting the valid flag
     valid_out[19] = 1'b1;
   end //}
   else begin //{
     highest_bit_set_clz = 0;
     flag_clz  = 0; 
     clz_out = 0;
     valid_out[19] = 1'b0;
   end //}
end //}


///////////////////////////////////////////
// CPOP
///////////////////////////////////////////

//integer i;
logic [31:0] sum_cpop;

always_comb begin //{
   if (valid_cmd && instr[31:20]==12'b011_0000_00010 && instr[14:12]==3'b001 && instr[6:0]==7'b001_0011) begin //{
      sum_cpop = 0;
      for (integer i=0;i<32;i++)
      sum_cpop = sum_cpop + {31'd0,rs1_val[i]}; // Check if this leads to combo loop #DOUBT
     
     // Setting the valid flag
     valid_out[20] = 1'b1;
   end //}
   else begin //{
      sum_cpop = 0;
      valid_out[20] = 1'b0;
   end //}
end //}

assign cpop_out = sum_cpop;


///////////////////////////////////////////
// CTZ
///////////////////////////////////////////

//integer i;
logic [31:0] lowest_set_bit_ctz;
logic flag_ctz;

always_comb begin //{
   if (valid_cmd && instr[31:20]==12'b011_0000_00001 && instr[14:12]==3'b001 && instr[6:0]==7'b001_0011) begin //{
    lowest_set_bit_ctz = 0;
    flag_ctz = 0;  
    // Finding out the lowest set bit 
    for (integer i=0;i<32;i++) begin//{
     if (rs1_val[i] && !flag_ctz) begin //{
      lowest_set_bit_ctz = i;
      flag_ctz = 1'b1;
     end //}
     end//}
 
     // Calculating the number of trailing zeroes 
     if (!flag_ctz)
     ctz_out = 32'd32; // Assuming 32 bit architecture
     else
     ctz_out = lowest_set_bit_ctz;  
     
     // Setting the valid flag
     valid_out[21] = 1'b1;
   end //}
   else begin //{
     lowest_set_bit_ctz = 0;
     flag_ctz = 0;  
     ctz_out = 0;
     valid_out[21] = 1'b0;
   end //}
end //}


///////////////////////////////////////////
// ORC_B
///////////////////////////////////////////

always_comb begin //{
   if (valid_cmd && instr[31:20]==12'b001_0100_00111 && instr[14:12]==3'b101 && instr[6:0]==7'b001_0011) begin //{
     if (|rs1_val[7:0])
        orc_b_out[7:0] = 8'hff;
     else
        orc_b_out[7:0] = 0;

     if (|rs1_val[15:8])
        orc_b_out[15:8] = 8'hff;
     else
        orc_b_out[15:8] = 0;

     if (|rs1_val[23:16])
        orc_b_out[23:16] = 8'hff;
     else
        orc_b_out[23:16] = 0;

     if (|rs1_val[31:24])
        orc_b_out[31:24] = 8'hff;
     else
        orc_b_out[31:24] = 0;
     
     // Setting the valid flag
     valid_out[22] = 1'b1;
   end //}
   else begin //{
     orc_b_out = 0;
     valid_out[22] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// REV8
///////////////////////////////////////////

always_comb begin //{
   if (valid_cmd && instr[31:20]==12'b011_0100_11000 && instr[14:12]==3'b101 && instr[6:0]==7'b001_0011) begin //{
     rev8_out [7:0] = rs1_val[31:24];  // All the below 4 lines assume 32 bit architecture 
     rev8_out [15:8] = rs1_val[23:16];
     rev8_out [23:16] = rs1_val[15:8];
     rev8_out [31:24] = rs1_val[7:0];
      
     // Setting the valid flag
     valid_out[23] = 1'b1;
   end //}
   else begin //{
     rev8_out = 0;
     valid_out[23] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// RORI
///////////////////////////////////////////

// Assuming its a 32 bit architecture and hence shift amount is 5 LSB of rs2_val
// Consider rs2_val as shamt

always_comb begin //{
   if (valid_cmd && instr[31:25]==7'b011_0000 && instr[14:12]==3'b101 && instr[6:0]==7'b001_0011) begin //{
     rori_out = (rs1_val >> instr[24:20]) | (rs1_val << (6'd32 - instr[24:20])); // 4:0 only for 32 bit architecture. Otherwise log2(XLEN) bits of rs2_val
     valid_out[24] = 1'b1;
   end //}
   else begin //{
     rori_out = 0;
     valid_out[24] = 1'b0;
   end //}
end //}


///////////////////////////////////////////
// SEXT_B
///////////////////////////////////////////

always_comb begin //{
   if (valid_cmd && instr[31:20]==12'b011_0000_00100 && instr[14:12]==3'b001 && instr[6:0]==7'b001_0011) begin //{
     sext_b_out = {{24{rs1_val[7]}},rs1_val[7:0]};
     valid_out[25] = 1'b1;
   end //}
   else begin //{
     sext_b_out = 0;
     valid_out[25] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// SEXT_H
///////////////////////////////////////////

always_comb begin //{
   if (valid_cmd && instr[31:20]==12'b011_0000_00101 && instr[14:12]==3'b001 && instr[6:0]==7'b001_0011) begin //{
     sext_h_out = {{16{rs1_val[15]}},rs1_val[15:0]};
     valid_out[26] = 1'b1;
   end //}
   else begin //{
     sext_h_out = 0;
     valid_out[26] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// BCLRI
///////////////////////////////////////////

always_comb begin //{
   if (valid_cmd && instr[31:25]==7'b010_0100 && instr[14:12]==3'b001 && instr[6:0]==7'b001_0011) begin //{
     bclri_out = rs1_val & (~(1<<instr[24:20]));  // Assuming its a 32 bit architecture. 
     valid_out[27] = 1'b1;
   end //}
   else begin //{
     bclri_out = 0;
     valid_out[27] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// BEXTI
///////////////////////////////////////////

always_comb begin //{
   if (valid_cmd && instr[31:25]==7'b010_0100 && instr[14:12]==3'b101 && instr[6:0]==7'b001_0011) begin //{
     bexti_out = (rs1_val>>instr[24:20]) & (32'd1);  // Assuming its a 32 bit architecture. 
     valid_out[28] = 1'b1;
   end //}
   else begin //{
     bexti_out = 0;
     valid_out[28] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// BINVI
///////////////////////////////////////////

always_comb begin //{
   if (valid_cmd && instr[31:25]==7'b011_0100 && instr[14:12]==3'b001 && instr[6:0]==7'b001_0011) begin //{
     binvi_out = rs1_val ^ (1<<instr[24:20])  ;  // Assuming its a 32 bit architecture. 
     valid_out[29] = 1'b1;
   end //}
   else begin //{
     binvi_out = 0;
     valid_out[29] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// BSETI
///////////////////////////////////////////

always_comb begin //{
   if (valid_cmd && instr[31:25]==7'b001_0100 && instr[14:12]==3'b001 && instr[6:0]==7'b001_0011) begin //{
     bseti_out = rs1_val | (1<<instr[24:20]);  // Assuming its a 32 bit architecture. 
     valid_out[30] = 1'b1;
   end //}
   else begin //{
     bseti_out = 0;
     valid_out[30] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// 3.) MAJOR OPCODE 001_1011 
///////////////////////////////////////////

///////////////////////////////////////////
// CLZW
///////////////////////////////////////////

//integer i;
logic [31:0] highest_bit_set_clzw; // Although 6 bits will also suffice
logic flag_clzw;

// For a 32 bit architecture, clz and clzw do the same operation but wth different opcodes

always_comb begin //{
   if (valid_cmd && instr[31:20]==12'b011_0000_00000 && instr[14:12]==3'b001 && instr[6:0]==7'b001_1011) begin //{
    highest_bit_set_clzw = 0;
    flag_clzw = 0; 
    
    // Finding out the highest bit set
    for (integer i=31;i>0;i--) begin//{
     if (rs1_val[i] && !flag_clzw) begin //{
      highest_bit_set_clzw = i;
      flag_clzw = 1'b1;
     end //}
     end//}
 
     // Calculating the number of leading zeroes 
     if (!flag_clzw)
     clzw_out = 32'd32;
     else if (highest_bit_set_clzw==32'd31) // Assuming a 32 bit architecture
     clzw_out = 32'd0;
     else
     clzw_out = 32'd31 - highest_bit_set_clzw;  // Assuming a 32 bit architecture
     
     // Setting the valid flag
     valid_out[31] = 1'b1;
   end //}
   else begin //{
     highest_bit_set_clzw = 0;
     flag_clzw = 0; 
     clzw_out = 0;
     valid_out[31] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// CPOPW
///////////////////////////////////////////

//integer i;
logic [31:0] sum_cpopw;

always_comb begin //{
   if (valid_cmd && instr[31:20]==12'b011_0000_00010 && instr[14:12]==3'b001 && instr[6:0]==7'b001_1011) begin //{
     sum_cpopw = 0;
     for (integer i=0;i<32;i++)
      sum_cpopw = sum_cpopw + {31'd0,rs1_val[i]}; // Check if this leads to combo loop #DOUBT
     // Setting the valid flag
     valid_out[32] = 1'b1;
   end //}
   else begin //{
     sum_cpopw = 0;
     valid_out[32] = 1'b0;
   end //}
end //}

assign cpopw_out = sum_cpopw;

///////////////////////////////////////////
// CTZW
///////////////////////////////////////////

//integer i;
logic [31:0] lowest_set_bit_ctzw;
logic flag_ctzw;

always_comb begin //{
   if (valid_cmd && instr[31:20]==12'b011_0000_00001 && instr[14:12]==3'b001 && instr[6:0]==7'b001_1011) begin //{
    lowest_set_bit_ctzw = 0;
    flag_ctzw = 0;  
    // Finding out the lowest set bit 
    for (integer i=0;i<32;i++) begin//{
     if (rs1_val[i] && !flag_ctzw) begin //{
      lowest_set_bit_ctzw = i;
      flag_ctzw = 1'b1;
     end //}
     end//}
 
     // Calculating the number of trailing zeroes 
     if (!flag_ctzw)
     ctzw_out = 32'd32; // Assuming 32 bit architecture
     else
     ctzw_out = lowest_set_bit_ctzw;  
     
     // Setting the valid flag
     valid_out[33] = 1'b1;
   end //}
   else begin //{
     lowest_set_bit_ctzw = 0;
     flag_ctzw = 0;  
     ctzw_out = 0;
     valid_out[33] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// RORIW
///////////////////////////////////////////

// Assuming its a 32 bit architecture and hence shift amount is 5 LSB of rs2_val
// Consider rs2_val as shamt

always_comb begin //{
   if (valid_cmd && instr[31:25]==7'b011_0000 && instr[14:12]==3'b101 && instr[6:0]==7'b001_1011) begin //{
     roriw_out = (rs1_val >> instr[24:20]) | (rs1_val << (6'd32 - instr[24:20])); // 4:0 only for 32 bit architecture. Otherwise log2(XLEN) bits of rs2_val
     valid_out[34] = 1'b1;
   end //}
   else begin //{
     roriw_out = 0;
     valid_out[34] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// SLLI_UW
///////////////////////////////////////////

// Assuming its a 32 bit architecture and hence shift amount is 5 LSB of rs2_val
// Since it is a 32 bit architecture, zero extending the word does not make sense
// since there is no available space to extend into.

always_comb begin //{
   if (valid_cmd && instr[31:26]==6'b00_0010 && instr[14:12]==3'b001 && instr[6:0]==7'b001_1011) begin //{
     slli_uw_out = rs1_val<<instr[25:20]; // 4:0 only for 32 bit architecture. Otherwise log2(XLEN) bits of rs2_val
     valid_out[35] = 1'b1;
   end //}
   else begin //{
     slli_uw_out = 0;
     valid_out[35] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// 4.) MAJOR OPCODE 011_1011
///////////////////////////////////////////

///////////////////////////////////////////
// ADD_UW
///////////////////////////////////////////

// Assuming its a 32 bit architecture and hence shift amount is 5 LSB of rs2_val
// Since it is a 32 bit architecture, zero extending rs1_val does not make sense
// since there is no available space to extend into.

always_comb begin //{
   if (valid_cmd && instr[31:25]==7'b00_00100 && instr[14:12]==3'b000 && instr[6:0]==7'b011_1011) begin //{
     add_uw_out = rs1_val + rs2_val; // 4:0 only for 32 bit architecture. Otherwise log2(XLEN) bits of rs2_val
     valid_out[36] = 1'b1;
   end //}
   else begin //{
     add_uw_out = 0;
     valid_out[36] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// SH1ADD_UW
///////////////////////////////////////////

// Zero extension for 32 bit architecture does not make sense
always_comb begin //{
   if (valid_cmd && instr[31:25]==7'b001_0000 && instr[14:12]==3'b010 && instr[6:0]==7'b011_1011) begin //{
     sh1add_uw_out = rs2_val + (rs1_val<<1); 
     valid_out[37] = 1'b1;
   end //}
   else begin //{
     sh1add_uw_out = 0;
     valid_out[37] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// SH2ADD_UW
///////////////////////////////////////////

// Zero extension for 32 bit architecture does not make sense
always_comb begin //{
   if (valid_cmd && instr[31:25]==7'b001_0000 && instr[14:12]==3'b100 && instr[6:0]==7'b011_1011) begin //{
     sh2add_uw_out = rs2_val + (rs1_val<<2); 
     valid_out[38] = 1'b1;
   end //}
   else begin //{
     sh2add_uw_out = 0;
     valid_out[38] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// SH3ADD_UW
///////////////////////////////////////////

// Zero extension for 32 bit architecture does not make sense
always_comb begin //{
   if (valid_cmd && instr[31:25]==7'b001_0000 && instr[14:12]==3'b110 && instr[6:0]==7'b011_1011) begin //{
     sh3add_uw_out = rs2_val + (rs1_val<<3); 
     valid_out[39] = 1'b1;
   end //}
   else begin //{
     sh3add_uw_out = 0;
     valid_out[39] = 1'b0;
   end //}
end //}

///////////////////////////////////////////
// ZEXT_H
///////////////////////////////////////////

// Zero extension for 32 bit architecture does not make sense
always_comb begin //{
   if (valid_cmd && instr[31:20]==12'b000_0100_00000 && instr[14:12]==3'b100 && instr[6:0]==7'b011_0011) begin //{
     zext_h_out = {16'd0,rs1_val[15:0]}; 
     valid_out[40] = 1'b1;
   end //}
   else begin //{
     zext_h_out = 0;
     valid_out[40] = 1'b0;
   end //}
end //}

endmodule

