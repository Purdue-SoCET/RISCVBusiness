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
*   Filename:    page_perm_check.sv
*
*   Created by:   William Cunningham
*   Email:        wrcunnin@purdue.edu
*   Date Created: 1/16/2025
*   Description: Used by TLB and Pagewalker to check page permissions
*/

`ifdef XCELIUM
`timescale 1ns/100ps
`endif

`include "prv_pipeline_if.vh"
`include "address_translation_if.vh"

import rv32i_types_pkg::*;
import machine_mode_types_1_13_pkg::*;

module page_perm_check (
  input logic check,
  input logic [2:0] level,
  input access_t access,
  input pte_sv32_t pte_sv32,
  output logic fault_load_page, fault_store_page, fault_insn_page, leaf_pte,
  prv_pipeline_if.cache prv_pipe_if,
  address_translation_if.cache at_if
);

pte_perms_t pte_perms = pte_sv32.perms;

// leaf page permission checking
always_comb begin    
  fault_load_page  = 0;
  fault_store_page = 0;
  fault_insn_page  = 0;
  leaf_pte         = 0;

  // need to check for normal/super pages as well as r/w/x
  if (check) begin
    // may need to add pma and pmp checks here

    // fault if pte.v = 0 or if pte.r = 0 and pte.w = 1 or if any reserved bits are set
    if (~pte_perms.valid | (~pte_perms.readable & pte_perms.writable) | (|pte_perms.reserved_0)) begin
      fault_load_page  = access == ACCESS_LOAD;
      fault_store_page = access == ACCESS_STORE;
      fault_insn_page  = access == ACCESS_INSN;
    end
    // fault if level == 0 and r/w/x are NOT set (means leaf pte is marked as a pointer to page level)
    else if (level == '0 & ~(pte_perms.readable | pte_perms.writable | pte_perms.executable)) begin
      fault_load_page  = access == ACCESS_LOAD;
      fault_store_page = access == ACCESS_STORE;
      fault_insn_page  = access == ACCESS_INSN;
    end
    // check if pte.r = 1 or pte.x = 1, means this is a leaf node
    else if (pte_perms.readable | pte_perms.executable) begin
      leaf_pte = 1;

      // fault if load access and pte.r = 0
      if (access == ACCESS_LOAD & ~pte_perms.readable & ~prv_pipe_if.mstatus.mxr) begin
        fault_load_page = 1;
      end
      // fault if instruction access and pte.x = 0
      else if (access == ACCESS_INSN & ~pte_perms.executable) begin
        fault_insn_page = 1;
      end
      // fault if store access and pte.w = 0
      else if (access == ACCESS_STORE & ~pte_perms.writable) begin
        fault_store_page = 1;
      end
      // fault if U = 1 and is S-mode or U = 0 and is U-mode
      else if ((pte_perms.user & prv_pipe_if.curr_privilege_level == S_MODE & ~prv_pipe_if.mstatus.sum) |
              (~pte_perms.user & prv_pipe_if.curr_privilege_level == U_MODE)) begin
        fault_load_page  = access == ACCESS_LOAD;
        fault_store_page = access == ACCESS_STORE;
        fault_insn_page  = access == ACCESS_INSN;
      end
      // superpage checking
      // need to add RV64 superpage checking for RV64 implementation
      else if (level != 0) begin
        if (at_if.sv32 & |pte_sv32.ppn[9:0]) begin
          fault_load_page  = access == ACCESS_LOAD;
          fault_store_page = access == ACCESS_STORE;
          fault_insn_page  = access == ACCESS_INSN;
        end
      end
    end
  end
end

endmodule