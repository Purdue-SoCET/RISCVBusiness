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
*   Filename:     priv_1_12_pmp.sv
*
*   Created by:   Hadi Ahmed
*   Email:        ahmed138@purdue.edu
*   Date Created: 10/31/2022
*   Description:  PMP Unit, version 1.12
*/

`include "priv_1_12_internal_if.vh"
`include "priv_ext_if.vh"

module priv_1_12_pmp (
  input logic CLK, nRST,
  priv_1_12_internal_if.pmp prv_intern_if,
  priv_ext_if.ext priv_ext_if
);

  import pmp_types_1_12_pkg::*;
  import machine_mode_types_1_12_pkg::*;
  import rv32i_types_pkg::*;

  pmpcfg_t [1:0] pmp_cfg_regs, nxt_pmp_cfg;
  pmpaddr_t [15:0] pmp_addr_regs, nxt_pmp_addr;
  pmpcfg_t new_cfg;

  // Core State Registers
  always_ff @ (posedge CLK, negedge nRST) begin
    if (~nRST) begin
      pmp_cfg_regs <= '0;
      pmp_addr_regs <= '0;
    end else begin
      pmp_cfg_regs <= nxt_pmp_cfg;
      pmp_addr_regs <= nxt_pmp_addr;
    end
  end

  // Core State Logic
  always_comb begin
    nxt_pmp_addr = pmp_addr_regs;
    nxt_pmp_cfg = pmp_cfg_regs;
    new_cfg = pmpcfg_t'(priv_ext_if.value_in);
    if (priv_ext_if.csr_active) begin
      casez(priv_ext_if.csr_addr)
        12'b0011_1010_00zz: begin // 0x3A0
          // WARL check (reserved)
          new_cfg[0].reserved = '0;
          new_cfg[1].reserved = '0;
          new_cfg[2].reserved = '0;
          new_cfg[3].reserved = '0;
          // WARL check (R/W)
          if (new_cfg[0].W == 1'b0 && new_cfg[0].R == 1'b1) begin
            new_cfg[0].R = 1'b0;
          end
          if (new_cfg[1].W == 1'b0 && new_cfg[1].R == 1'b1) begin
            new_cfg[1].R = 1'b0;
          end
          if (new_cfg[2].W == 1'b0 && new_cfg[2].R == 1'b1) begin
            new_cfg[2].R = 1'b0;
          end
          if (new_cfg[3].W == 1'b0 && new_cfg[3].R == 1'b1) begin
            new_cfg[3].R = 1'b0;
          end
          // Assign field
          nxt_pmp_cfg[priv_ext_if.csr_addr[1:0]] = priv_ext_if.value_in;
        end
        12'b0011_1011_zzzz: begin // 0x3B0
          nxt_pmp_addr[priv_ext_if.csr_addr[3:0]] = new_cfg;
        end
      endcase
    end
  end

  assign priv_ext_if.invalid_csr = 1'b0;

  // Return the right value back
  always_comb begin
    priv_ext_if.value_out = '0;
    priv_ext_if.ack = 1'b1;
    casez(priv_ext_if.csr_addr)
      12'b0011_1010_00zz: begin
        priv_ext_if.value_out = pmp_cfg_regs[priv_ext_if.csr_addr[1:0]];
      end
      12'b0011_1011_zzzz: begin
        priv_ext_if.value_out = pmp_addr_regs[priv_ext_if.csr_addr[3:0]];
      end
      default: begin
        priv_ext_if.ack = 1'b0;
      end
    endcase
  end

  /***** Data PMP checker unit *****/
  logic [15:0] d_cfg_match;
  genvar i;

  generate
    for (i=0; i<16; i++) begin
      priv_1_12_pmp_matcher matcher (
        {2'b00, prv_intern_if.daddr[31:2]},
        pmp_cfg_regs[i>>2][i%4],
        pmp_addr_regs[i],
        i == 0 ? '0 : pmp_addr_regs[i-1],
        d_cfg_match[i]
      );
    end
  endgenerate

  // time to use the matches
  pmpcfg_base_t d_match;
  logic d_match_found;
  logic d_prot_fault;
  always_comb begin
    d_match = '0;
    d_match_found = 1'b1;
    d_prot_fault = 1'b0;
    casez(d_cfg_match)
      16'bzzzz_zzzz_zzzz_zzz1: d_match = pmp_cfg_regs[0][0];
      16'bzzzz_zzzz_zzzz_zz1z: d_match = pmp_cfg_regs[0][1];
      16'bzzzz_zzzz_zzzz_z1zz: d_match = pmp_cfg_regs[0][2];
      16'bzzzz_zzzz_zzzz_1zzz: d_match = pmp_cfg_regs[0][3];
      16'bzzzz_zzzz_zzz1_zzzz: d_match = pmp_cfg_regs[1][0];
      16'bzzzz_zzzz_zz1z_zzzz: d_match = pmp_cfg_regs[1][1];
      16'bzzzz_zzzz_z1zz_zzzz: d_match = pmp_cfg_regs[1][2];
      16'bzzzz_zzzz_1zzz_zzzz: d_match = pmp_cfg_regs[1][3];
      16'bzzzz_zzz1_zzzz_zzzz: d_match = pmp_cfg_regs[2][0];
      16'bzzzz_zz1z_zzzz_zzzz: d_match = pmp_cfg_regs[2][1];
      16'bzzzz_z1zz_zzzz_zzzz: d_match = pmp_cfg_regs[2][2];
      16'bzzzz_1zzz_zzzz_zzzz: d_match = pmp_cfg_regs[2][3];
      16'bzzz1_zzzz_zzzz_zzzz: d_match = pmp_cfg_regs[3][0];
      16'bzz1z_zzzz_zzzz_zzzz: d_match = pmp_cfg_regs[3][1];
      16'bz1zz_zzzz_zzzz_zzzz: d_match = pmp_cfg_regs[3][2];
      16'b1zzz_zzzz_zzzz_zzzz: d_match = pmp_cfg_regs[3][3];
      default: d_match_found = 1'b0;
    endcase

    if (prv_intern_if.curr_priv != M_MODE || (prv_intern_if.curr_mstatus.mprv && prv_intern_if.curr_mstatus.mpp != M_MODE)) begin  // Core is in an unprivileged state or needs privilege checks
      if (~d_match_found) begin
        d_prot_fault = 1'b1;
      end else begin
        if ((prv_intern_if.ren & ~d_match.R) || (prv_intern_if.wen & ~d_match.W)) begin
          d_prot_fault = 1'b1;
        end
      end
    end else begin // Core is in M_MODE with no privilege check requirements
      if (d_match_found & d_match.L) begin
        if ((prv_intern_if.ren & ~d_match.R) || (prv_intern_if.wen & ~d_match.W)) begin
          d_prot_fault = 1'b1;
        end
      end
    end
  end

  /***** Instruction PMP checker unit *****/
  logic [15:0] i_cfg_match;
  genvar j;

  generate
    for (j=0; j<16; j++) begin
      priv_1_12_pmp_matcher matcher (
        {2'b00, prv_intern_if.iaddr[31:2]},
        pmp_cfg_regs[j>>2][j%4],
        pmp_addr_regs[j],
        j == 0 ? '0 : pmp_addr_regs[j-1],
        i_cfg_match[j]
      );
    end
  endgenerate

  // time to use the matches
  pmpcfg_base_t i_match;
  logic i_match_found;
  logic i_prot_fault;
  always_comb begin
    i_match = '0;
    i_match_found = 1'b1;
    i_prot_fault = 1'b0;
    casez(i_cfg_match)
      16'bzzzz_zzzz_zzzz_zzz1: i_match = pmp_cfg_regs[0][0];
      16'bzzzz_zzzz_zzzz_zz1z: i_match = pmp_cfg_regs[0][1];
      16'bzzzz_zzzz_zzzz_z1zz: i_match = pmp_cfg_regs[0][2];
      16'bzzzz_zzzz_zzzz_1zzz: i_match = pmp_cfg_regs[0][3];
      16'bzzzz_zzzz_zzz1_zzzz: i_match = pmp_cfg_regs[1][0];
      16'bzzzz_zzzz_zz1z_zzzz: i_match = pmp_cfg_regs[1][1];
      16'bzzzz_zzzz_z1zz_zzzz: i_match = pmp_cfg_regs[1][2];
      16'bzzzz_zzzz_1zzz_zzzz: i_match = pmp_cfg_regs[1][3];
      16'bzzzz_zzz1_zzzz_zzzz: i_match = pmp_cfg_regs[2][0];
      16'bzzzz_zz1z_zzzz_zzzz: i_match = pmp_cfg_regs[2][1];
      16'bzzzz_z1zz_zzzz_zzzz: i_match = pmp_cfg_regs[2][2];
      16'bzzzz_1zzz_zzzz_zzzz: i_match = pmp_cfg_regs[2][3];
      16'bzzz1_zzzz_zzzz_zzzz: i_match = pmp_cfg_regs[3][0];
      16'bzz1z_zzzz_zzzz_zzzz: i_match = pmp_cfg_regs[3][1];
      16'bz1zz_zzzz_zzzz_zzzz: i_match = pmp_cfg_regs[3][2];
      16'b1zzz_zzzz_zzzz_zzzz: i_match = pmp_cfg_regs[3][3];
      default: i_match_found = 1'b0;
    endcase

    if (prv_intern_if.curr_priv != M_MODE || (prv_intern_if.curr_mstatus.mprv && prv_intern_if.curr_mstatus.mpp != M_MODE)) begin  // Core is in an unprivileged state or needs privilege checks
      if (~i_match_found) begin
        i_prot_fault = 1'b1;
      end else begin
        if ((prv_intern_if.ren & ~i_match.R) || (prv_intern_if.wen & ~i_match.W)) begin
          i_prot_fault = 1'b1;
        end
      end
    end else begin // Core is in M_MODE with no privilege check requirements
      if (d_match_found & i_match.L) begin
        if ((prv_intern_if.ren & ~i_match.R) || (prv_intern_if.wen & ~i_match.W)) begin
          i_prot_fault = 1'b1;
        end
      end
    end
  end

  /***** Resolve and output D and I faults *****/
  always_comb begin
    prv_intern_if.pmp_s_fault = 1'b0;
    prv_intern_if.pmp_l_fault = 1'b0;
    prv_intern_if.pmp_i_fault = 1'b0;
    if (d_prot_fault) begin
      prv_intern_if.pmp_s_fault = prv_intern_if.wen;
      prv_intern_if.pmp_l_fault = prv_intern_if.ren;
    end else if (i_prot_fault) begin
      prv_intern_if.pmp_i_fault = prv_intern_if.xen;
    end
  end

endmodule