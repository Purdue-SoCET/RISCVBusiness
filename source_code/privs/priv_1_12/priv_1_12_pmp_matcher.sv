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

module priv_1_12_pmp_matcher(
  input logic[31:0] phys_addr,     // address to check
  input pmpcfg_base_t check_cfg,   // configuration to match
  input pmpaddr_t cfg_addr,        // configuration address
  input pmpaddr_t cfg_addr_before, // configuration address of previous cfg_addr, used for TOR
  output logic match               // did the config match?
);
  
  localparam NAPOT_ADDR_BITS = PMP_NAPOT_GRAN == 0 ? 1 : PMP_NAPOT_GRAN;
  localparam NAPOT_ADDR_GRAN = NAPOT_ADDR_BITS - 1;
  localparam NAPOT_MATCHES   = XLEN - NAPOT_ADDR_GRAN + 1; // 32 - (granularity) + 1 bit for all 1's

  // logic [(NAPOT_MATCHES-1):0] napot_match;

  // // NAPOT configurable granularity checking
  // genvar i;
  // generate
  //   for (i = 0; i < (NAPOT_MATCHES - 2); i++) begin
  //     assign napot_match[i] = cfg_addr[(i + NAPOT_ADDR_GRAN):0] == {~(32'b1 << (i + NAPOT_ADDR_GRAN))}[(i + NAPOT_ADDR_GRAN):0] ?
  //                            phys_addr[31:(i + NAPOT_ADDR_BITS)] == cfg_addr[31:(i + NAPOT_ADDR_BITS)] : 0;
  //   end
  // endgenerate
  // assign napot_match[NAPOT_MATCHES-2] = cfg_addr == 32'b01111111111111111111111111111111;
  // assign napot_match[NAPOT_MATCHES-1] = cfg_addr == 32'b11111111111111111111111111111111;

  // NAPOT matching
  logic [(XLEN-1):0] lower_bit_mask;
  logic [(XLEN-1):0] address_comp;
  logic [(XLEN-1):0] match_napot;
  assign address_comp = phys_addr ~^ cfg_addr;
  assign lower_bit_mask = cfg_addr ^ (cfg_addr + 1);
  assign match_napot = address_comp | lower_bit_mask;

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

      // NAPOT: begin
      //   // I highly suggest using the script in this folder to create the table below.
      //   //  the all 1's case doesn't make sense to me, so I didn't include it here.
      //   casez(cfg_addr)
      //     32'b???????????????????????????????0: match = phys_addr[31:01] == cfg_addr[31:01];
      //     32'b??????????????????????????????01: match = phys_addr[31:02] == cfg_addr[31:02];
      //     32'b?????????????????????????????011: match = phys_addr[31:03] == cfg_addr[31:03];
      //     32'b????????????????????????????0111: match = phys_addr[31:04] == cfg_addr[31:04];
      //     32'b???????????????????????????01111: match = phys_addr[31:05] == cfg_addr[31:05];
      //     32'b??????????????????????????011111: match = phys_addr[31:06] == cfg_addr[31:06];
      //     32'b?????????????????????????0111111: match = phys_addr[31:07] == cfg_addr[31:07];
      //     32'b????????????????????????01111111: match = phys_addr[31:08] == cfg_addr[31:08];
      //     32'b???????????????????????011111111: match = phys_addr[31:09] == cfg_addr[31:09];
      //     32'b??????????????????????0111111111: match = phys_addr[31:10] == cfg_addr[31:10];
      //     32'b?????????????????????01111111111: match = phys_addr[31:11] == cfg_addr[31:11];
      //     32'b????????????????????011111111111: match = phys_addr[31:12] == cfg_addr[31:12];
      //     32'b???????????????????0111111111111: match = phys_addr[31:13] == cfg_addr[31:13];
      //     32'b??????????????????01111111111111: match = phys_addr[31:14] == cfg_addr[31:14];
      //     32'b?????????????????011111111111111: match = phys_addr[31:15] == cfg_addr[31:15];
      //     32'b????????????????0111111111111111: match = phys_addr[31:16] == cfg_addr[31:16];
      //     32'b???????????????01111111111111111: match = phys_addr[31:17] == cfg_addr[31:17];
      //     32'b??????????????011111111111111111: match = phys_addr[31:18] == cfg_addr[31:18];
      //     32'b?????????????0111111111111111111: match = phys_addr[31:19] == cfg_addr[31:19];
      //     32'b????????????01111111111111111111: match = phys_addr[31:20] == cfg_addr[31:20];
      //     32'b???????????011111111111111111111: match = phys_addr[31:21] == cfg_addr[31:21];
      //     32'b??????????0111111111111111111111: match = phys_addr[31:22] == cfg_addr[31:22];
      //     32'b?????????01111111111111111111111: match = phys_addr[31:23] == cfg_addr[31:23];
      //     32'b????????011111111111111111111111: match = phys_addr[31:24] == cfg_addr[31:24];
      //     32'b???????0111111111111111111111111: match = phys_addr[31:25] == cfg_addr[31:25];
      //     32'b??????01111111111111111111111111: match = phys_addr[31:26] == cfg_addr[31:26];
      //     32'b?????011111111111111111111111111: match = phys_addr[31:27] == cfg_addr[31:27];
      //     32'b????0111111111111111111111111111: match = phys_addr[31:28] == cfg_addr[31:28];
      //     32'b???01111111111111111111111111111: match = phys_addr[31:29] == cfg_addr[31:29];
      //     32'b??011111111111111111111111111111: match = phys_addr[31:30] == cfg_addr[31:30];
      //     32'b?0111111111111111111111111111111: match = phys_addr[31] == cfg_addr[31];
      //     32'b01111111111111111111111111111111,
      //     32'b11111111111111111111111111111111: match = 1'b1;
      //     default: match = 1'b0;
      //   endcase
      // end

      NAPOT: begin
        //  match = |temp_match;
         match = &match_napot;
      end

      OFF: begin
        match = 1'b0;
      end
    endcase
  end

endmodule