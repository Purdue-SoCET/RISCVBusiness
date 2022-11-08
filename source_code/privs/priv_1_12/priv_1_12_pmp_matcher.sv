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

import pmp_types_1_12_pkg::*;

module priv_1_12_pmp_matcher(
  input logic[31:0] phys_addr,     // address to check
  input pmpcfg_base_t check_cfg,   // configuration to match
  input pmpaddr_t cfg_addr,        // configuration address
  input pmpaddr_t cfg_addr_before, // configuration address of previous cfg_addr, used for TOR
  output logic match               // did the config match?
);

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
        // I highly suggest using the script in this folder to create the table below.
        //  the all 1's case doesn't make sense to me, so I didn't include it here.
        casez(cfg_addr)
          32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz0: match = phys_addr[31:01] == cfg_addr[31:01];
          32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz01: match = phys_addr[31:02] == cfg_addr[31:02];
          32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzz011: match = phys_addr[31:03] == cfg_addr[31:03];
          32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzz0111: match = phys_addr[31:04] == cfg_addr[31:04];
          32'bzzzzzzzzzzzzzzzzzzzzzzzzzzz01111: match = phys_addr[31:05] == cfg_addr[31:05];
          32'bzzzzzzzzzzzzzzzzzzzzzzzzzz011111: match = phys_addr[31:06] == cfg_addr[31:06];
          32'bzzzzzzzzzzzzzzzzzzzzzzzzz0111111: match = phys_addr[31:07] == cfg_addr[31:07];
          32'bzzzzzzzzzzzzzzzzzzzzzzzz01111111: match = phys_addr[31:08] == cfg_addr[31:08];
          32'bzzzzzzzzzzzzzzzzzzzzzzz011111111: match = phys_addr[31:09] == cfg_addr[31:09];
          32'bzzzzzzzzzzzzzzzzzzzzzz0111111111: match = phys_addr[31:10] == cfg_addr[31:10];
          32'bzzzzzzzzzzzzzzzzzzzzz01111111111: match = phys_addr[31:11] == cfg_addr[31:11];
          32'bzzzzzzzzzzzzzzzzzzzz011111111111: match = phys_addr[31:12] == cfg_addr[31:12];
          32'bzzzzzzzzzzzzzzzzzzz0111111111111: match = phys_addr[31:13] == cfg_addr[31:13];
          32'bzzzzzzzzzzzzzzzzzz01111111111111: match = phys_addr[31:14] == cfg_addr[31:14];
          32'bzzzzzzzzzzzzzzzzz011111111111111: match = phys_addr[31:15] == cfg_addr[31:15];
          32'bzzzzzzzzzzzzzzzz0111111111111111: match = phys_addr[31:16] == cfg_addr[31:16];
          32'bzzzzzzzzzzzzzzz01111111111111111: match = phys_addr[31:17] == cfg_addr[31:17];
          32'bzzzzzzzzzzzzzz011111111111111111: match = phys_addr[31:18] == cfg_addr[31:18];
          32'bzzzzzzzzzzzzz0111111111111111111: match = phys_addr[31:19] == cfg_addr[31:19];
          32'bzzzzzzzzzzzz01111111111111111111: match = phys_addr[31:20] == cfg_addr[31:20];
          32'bzzzzzzzzzzz011111111111111111111: match = phys_addr[31:21] == cfg_addr[31:21];
          32'bzzzzzzzzzz0111111111111111111111: match = phys_addr[31:22] == cfg_addr[31:22];
          32'bzzzzzzzzz01111111111111111111111: match = phys_addr[31:23] == cfg_addr[31:23];
          32'bzzzzzzzz011111111111111111111111: match = phys_addr[31:24] == cfg_addr[31:24];
          32'bzzzzzzz0111111111111111111111111: match = phys_addr[31:25] == cfg_addr[31:25];
          32'bzzzzzz01111111111111111111111111: match = phys_addr[31:26] == cfg_addr[31:26];
          32'bzzzzz011111111111111111111111111: match = phys_addr[31:27] == cfg_addr[31:27];
          32'bzzzz0111111111111111111111111111: match = phys_addr[31:28] == cfg_addr[31:28];
          32'bzzz01111111111111111111111111111: match = phys_addr[31:29] == cfg_addr[31:29];
          32'bzz011111111111111111111111111111: match = phys_addr[31:30] == cfg_addr[31:30];
          32'bz0111111111111111111111111111111: match = phys_addr[31] == cfg_addr[31];
          32'b01111111111111111111111111111111: match = 1'b1;
          default: match = 1'b0;
        endcase
      end

      OFF: begin
        match = 1'b0;
      end
    endcase
  end

endmodule