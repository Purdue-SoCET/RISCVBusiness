/*
*   Copyright 2019 Purdue University
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
*   Filename:     sparce_sasa_table.sv
*
*   Created by:   Vadim V. Nikiforov
*   Email:        vnikifor@purdue.edu
*   Date Created: 04/6/2019
*   Description:  The file containing the SASA table
*/

`include "sparce_internal_if.vh"

// defined because $clog2 is not universally supported
`define CLOG2(x) \
   (((x) <= 1) ? 0 : \
   ((x) <= 2) ? 1 : \
   ((x) <= 4) ? 2 : \
   ((x) <= 8) ? 3 : \
   ((x) <= 16) ? 4 : \
   ((x) <= 32) ? 5 : \
   ((x) <= 64) ? 6 : \
   -1)

//  modport sasa_table (
//    output sasa_rs1, sasa_rs2, insts_to_skip, preceding_pc, condition, valid,
//    input  pc, sasa_addr, sasa_data, sasa_wen
//  );


// struct for the data read from memory
typedef struct packed {
  logic [15:0] prev_pc;
  logic [4:0]  rs1;
  logic [4:0]  rs2;
  sasa_cond_t  sasa_cond;
  logic [4:0]  insts_to_skip;
} sasa_input_t;


module sparce_sasa_table #(parameter SASA_ENTRIES = 16, parameter SASA_SETS = 1, parameter SASA_ADDR = 32'h90000000) (input logic CLK, nRST, sparce_internal_if.sasa_table sasa_if);

  // struct for each entry in the SASA table
  typedef struct packed {
    logic [1:0]  usage;
    logic        valid;
    logic [15:0] tag;
    logic [4:0]  rs1;
    logic [4:0]  rs2;
    sasa_cond_t  sasa_cond;
    logic [4:0]  insts_to_skip;
  } sasa_entry_t;

  logic [SASA_SETS-1:0][(SASA_ENTRIES/SASA_SETS)-1:0][`CLOG2(SASA_SETS) - 1 :0] usage;
  logic [SASA_SETS-1:0][(SASA_ENTRIES/SASA_SETS)-1:0]     valid;
  logic [SASA_SETS-1:0][(SASA_ENTRIES/SASA_SETS)-1:0][15- `CLOG2(SASA_SETS) :0] tag;
  logic [SASA_SETS-1:0][(SASA_ENTRIES/SASA_SETS)-1:0][4:0] rs1;
  logic [SASA_SETS-1:0][(SASA_ENTRIES/SASA_SETS)-1:0][4:0] rs2;
  sasa_cond_t [SASA_SETS-1:0][(SASA_ENTRIES/SASA_SETS)-1:0] sasa_cond;
  logic [SASA_SETS-1:0][(SASA_ENTRIES/SASA_SETS)-1:0][4:0] insts_to_skip;
  sasa_input_t input_data;

  logic [`CLOG2(SASA_ENTRIES/SASA_SETS)-1:0] input_idx;
  logic [`CLOG2(SASA_ENTRIES/SASA_SETS)-1:0] pc_idx;
  logic [15-`CLOG2(SASA_ENTRIES/SASA_SETS):0] pc_tag;
  logic sasa_match;
  logic existing_entry;
  logic [`CLOG2(SASA_SETS)-1:0] existing_entry_set;

  logic [SASA_SETS:0] sasa_hits;
  logic sasa_config, sasa_config_match;

  // sasa table configuration register
  assign sasa_config_match = sasa_if.sasa_enable && sasa_if.sasa_wen && (sasa_if.sasa_addr == SASA_ADDR + 4);

  always_ff @(posedge CLK, negedge nRST) begin : sasa_configuration
    if (!nRST) begin
      sasa_config <= '0;
    end
    else begin
      sasa_config <= sasa_config;
      if (sasa_config_match) begin
        sasa_config <= sasa_if.sasa_data;
      end
    end
  end

  // wiring for indexing of the cache arrays
  assign input_idx = (SASA_ENTRIES == SASA_SETS) ? 0 : input_data.prev_pc;
  assign pc_idx = (SASA_ENTRIES == SASA_SETS) ? 0 : (sasa_if.pc >> 2); // ignore byte addressed aspect
  assign pc_tag = sasa_if.pc >> (`CLOG2(SASA_ENTRIES/SASA_SETS) + 2);
  assign sasa_match = sasa_if.sasa_enable && sasa_if.sasa_wen && (sasa_if.sasa_addr == SASA_ADDR);


  always_comb begin : sasa_input_conversion
    input_data.prev_pc       = sasa_if.sasa_data[31:16];
    input_data.rs1           = sasa_if.sasa_data[15:11];
    input_data.rs2           = sasa_if.sasa_data[10:6];
    input_data.sasa_cond     = sasa_cond_t'(sasa_if.sasa_data[5]);
    input_data.insts_to_skip = sasa_if.sasa_data[4:0];
  end

  always_ff @(posedge CLK, negedge nRST) begin : sasa_table_entries
    if (!nRST) begin
      // for loops just to set different usage values per entry
      for(int i = 0; i < SASA_SETS; i++) begin
        for(int j = 0; j < SASA_ENTRIES/SASA_SETS; j++) begin
          // set default usage values to 0, 1, 2, 3 for LRU
          usage[i][j]<= (SASA_SETS-1)-i;
          valid[i][j]<= 1'b0;
          tag[i][j]<= '0;
          rs1[i][j]<= '0;
          rs2[i][j]<= '0;
          sasa_cond[i][j]<= SASA_COND_OR;
          insts_to_skip[i][j]<= '0;
        end
      end
    end else begin
      usage <= usage;
      valid <= valid;
      tag <= tag;
      rs1 <= rs1;
      rs2 <= rs2;
      sasa_cond <= sasa_cond;
      insts_to_skip <= insts_to_skip;
      // If the software is attempting to write to the SASA table, write in
      // the data and then update the LRU usage
      if(sasa_match) begin
        if(!existing_entry) begin
          for (int i = 0; i < SASA_SETS; i++) begin
            if (usage[i][input_idx]== '1 || SASA_SETS == 1) begin
              valid[i][input_idx]<= 1;
              tag[i][input_idx]<= input_data.prev_pc >> (`CLOG2(SASA_ENTRIES/SASA_SETS));
              rs1[i][input_idx]<= input_data.rs1;
              rs2[i][input_idx]<= input_data.rs2;
              sasa_cond[i][input_idx]<= input_data.sasa_cond;
              insts_to_skip[i][input_idx]<= input_data.insts_to_skip;
            end
            usage[i][input_idx]<= (usage[i][input_idx]+ 1) % SASA_SETS;
          end
        end else begin
          valid[existing_entry_set][input_idx]<= 1;
          tag[existing_entry_set][input_idx]<= input_data.prev_pc >> (`CLOG2(SASA_ENTRIES/SASA_SETS));
          rs1[existing_entry_set][input_idx]<= input_data.rs1;
          rs2[existing_entry_set][input_idx]<= input_data.rs2;
          sasa_cond[existing_entry_set][input_idx]<= input_data.sasa_cond;
          insts_to_skip[existing_entry_set][input_idx]<= input_data.insts_to_skip;
          for (int i = 0; i < SASA_SETS; i++) begin
            if (usage[i][input_idx]  <  usage[existing_entry_set][input_idx]) begin
              usage[i][input_idx]<= (usage[i][input_idx]+ 1) % SASA_SETS;
            end
          end
        end
      end
      // If the PC matches in the SASA table, update the LRU usage
      else if (sasa_hits != 0) begin
        for (int i = 0; i < SASA_SETS; i++) begin
          if(usage[i][pc_idx] < usage[sasa_hits-1][pc_idx]) begin
            usage[i][pc_idx]<= (usage[i][pc_idx]+ 1) % SASA_SETS;
          end else if (i == sasa_hits - 1) begin
            usage[i][pc_idx] <= '0;
          end
        end
      end
    end
  end

  always_comb begin : sasa_outputs
    sasa_if.sasa_rs1 = '0;
    sasa_if.sasa_rs2 = '0;
    sasa_if.insts_to_skip = '0;
    sasa_if.preceding_pc = sasa_if.pc;
    sasa_if.condition = SASA_COND_OR;
    sasa_if.valid = 1'b0;
    sasa_hits = '0;
    existing_entry = 0;
    for (int i = 0; i < SASA_SETS; i++) begin
      if (valid[i][pc_idx]&& (tag[i][pc_idx]== pc_tag)) begin
        sasa_hits             = i+1;
        // ensure skipping is only valid for PC < 'hFFFF FFFC
        //sasa_if.valid         = (sasa_config == '0);
        sasa_if.valid         = (sasa_config == '0) && (sasa_if.pc[31:18] == '0);
        sasa_if.sasa_rs1      = rs1[i][pc_idx];
        sasa_if.sasa_rs2      = rs2[i][pc_idx];
        sasa_if.condition     = sasa_cond[i][pc_idx];
        sasa_if.insts_to_skip = insts_to_skip[i][pc_idx];
      end
      if (valid[i][input_idx]&& (tag[i][input_idx] == input_data.prev_pc >> (`CLOG2(SASA_ENTRIES/SASA_SETS)))) begin
              existing_entry = 1;
              existing_entry_set = i;
      end
    end
  end

endmodule

