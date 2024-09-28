/*
*   Copyright 2024 Purdue University
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
*   Filename:     include/rv32v_uop_gen_if.vh
*
*   Created by:   Om Gupta
*   Email:        guptao@purdue.edu
*   Date Created: 02/06/2024
*   Description:  Interface for the vector uop generation block
*/

`ifndef RV32V_UOP_GEN_IF_VH
`define RV32V_UOP_GEN_IF_VH

interface rv32v_uop_gen_if();

  import rv32i_types_pkg::*;
  import rv32v_types_pkg::*;

  parameter VREG_WIDTH_BYTES = 16;
  parameter VREG_COUNT = 32;
  parameter VLMUL_MAX = 8;
  parameter VLANE_COUNT = 4;

  localparam VUOP_NUM_MAX = (VREG_WIDTH_BYTES*VLMUL_MAX)/VLANE_COUNT;
  localparam VUOP_NUM_WIDTH = $clog2(VUOP_NUM_MAX);

  localparam VLANE_WIDTH = $clog2(VLANE_COUNT);
  localparam VREG_OFFSET_WIDTH = $clog2(VLMUL_MAX);

  // Input flag to indicate that uop generation is needed for this instr
  logic gen;

  // Input flag to indicate that uop generation needs to stall
  logic stall;

  // CSR input values
  //vsew_t veew;
  vsew_t veew_dest, veew_src1, veew_src2; 
  word_t vl;

  // The sequence number of the uop of a particular instruction
  logic [VUOP_NUM_WIDTH-1:0] vuop_num;

  // The register bank containing the first element of this uop
  logic [VLANE_WIDTH-1:0] vbank_offset; 

  // The offset to be added to the architectural register numbers
  // to account for extended registers from LMUL > 1
  logic [VREG_OFFSET_WIDTH-1:0] vreg_offset_dest;
  logic [VREG_OFFSET_WIDTH-1:0] vreg_offset_src1;
  logic [VREG_OFFSET_WIDTH-1:0] vreg_offset_src2;


  // Per-lane active signals to indicate that valid data is present
  logic [VLANE_COUNT-1:0] vlane_active;

  // Output flag to indicate that uop generation is in progress
  logic busy;

  // Output flag to indicate that last uop of an instruction is being generated
  logic vuop_last;


  // segmented decoding signals 
  logic is_seg_op;  
  logic[2:0] nf_seg; // number of fields in seg instr
  logic[2:0] nf_counter; // used for indexed instr
  vlmul_t emul_dest, emul_src1;   
  logic new_seg; 

  modport vug(
    input gen, stall, veew_dest, veew_src1, veew_src2, vl, is_seg_op, nf_seg,  emul_dest, emul_src1, 
    output vuop_num, vbank_offset, vreg_offset_src1, vreg_offset_src2, vreg_offset_dest, vlane_active, busy, vuop_last, new_seg, nf_counter
  );

endinterface

`endif //RV32V_UOP_GEN_IF_VH
