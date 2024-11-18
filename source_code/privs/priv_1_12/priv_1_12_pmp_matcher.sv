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
*   Filename:     priv_1_12_pmp_matcher.sv
*
*   Created by:   Hadi Ahmed
*   Email:        ahmed138@purdue.edu
*   Date Created: 11/08/2022
*   Description:  Internal module used to indicate a PMP
                   configuration match.
*/

`include "component_selection_defines.vh"

import pmp_types_1_12_pkg::*;
import rv32i_types_pkg::*;

module priv_1_12_pmp_matcher(
  input logic[31:0] phys_addr,     // address to check
  input pmpcfg_base_t check_cfg,   // configuration to match
  input pmpaddr_t cfg_addr,        // configuration address
  input pmpaddr_t cfg_addr_before, // configuration address of previous cfg_addr, used for TOR
  output logic match               // did the config match?
);

  localparam NAPOT_ADDR_BITS = PMP_MINIMUM_GRANULARITY == 0 ? 1 : PMP_MINIMUM_GRANULARITY;
  localparam NAPOT_ADDR_GRAN = NAPOT_ADDR_BITS - 1;
  localparam NAPOT_MATCHES   = XLEN - NAPOT_ADDR_GRAN + 1; // 32 - (granularity) + 1 bit for all 1's

  logic  [(NAPOT_MATCHES-1):0] napot_match;
  word_t [(NAPOT_MATCHES-1):0] match_criteria;

  // NAPOT configurable granularity matching -> area optimzied, yields lower area with lower granularity
  genvar i;
  generate
    for (i = 0; i < (NAPOT_MATCHES - 2); i++) begin : g_napot_match
      assign match_criteria[i] = {~(32'b1 << (i + NAPOT_ADDR_GRAN))};
      assign napot_match[i] = cfg_addr[(i + NAPOT_ADDR_GRAN):0] == match_criteria[i][(i + NAPOT_ADDR_GRAN):0] ?
                             phys_addr[31:(i + NAPOT_ADDR_BITS)] == cfg_addr[31:(i + NAPOT_ADDR_BITS)] : 0;
    end
  endgenerate
  assign napot_match[NAPOT_MATCHES-2] = cfg_addr == 32'b01111111111111111111111111111111;
  assign napot_match[NAPOT_MATCHES-1] = cfg_addr == 32'b11111111111111111111111111111111;

  // main logic
  always_comb begin
    match = 1'b0;
    casez(check_cfg.A) 
      NA4: begin
        match = phys_addr == cfg_addr;
      end

      TOR: begin
        if (cfg_addr_before >= cfg_addr) begin
          match = 1'b0; // If the previous address is greater/equal, no match
        end else begin
          match = (phys_addr >= cfg_addr_before) && (phys_addr < cfg_addr);
        end
      end

      NAPOT: begin
         match = |napot_match; // configurable granularity match
      end

      OFF: begin
        match = 1'b0;
      end
    endcase
  end

endmodule
