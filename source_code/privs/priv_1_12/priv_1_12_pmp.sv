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
        12'b0011_1010_00zz: begin
          // WARL check (reserved)
          new_cfg.cfg0.reserved = '0;
          new_cfg.cfg1.reserved = '0;
          new_cfg.cfg2.reserved = '0;
          new_cfg.cfg3.reserved = '0;
          // WARL check (A)
          if (new_cfg.cfg0.A == TOR) begin
            new_cfg.cfg0.A = OFF;
          end
          if (new_cfg.cfg1.A == TOR) begin
            new_cfg.cfg1.A = OFF;
          end
          if (new_cfg.cfg2.A == TOR) begin
            new_cfg.cfg2.A = OFF;
          end
          if (new_cfg.cfg3.A == TOR) begin
            new_cfg.cfg3.A = OFF;
          end
          // WARL check (R/W)
          if (new_cfg.cfg0.W == 1'b0 && new_cfg.cfg0.R == 1'b1) begin
            new_cfg.cfg0.R = 1'b0;
          end
          if (new_cfg.cfg1.W == 1'b0 && new_cfg.cfg1.R == 1'b1) begin
            new_cfg.cfg1.R = 1'b0;
          end
          if (new_cfg.cfg2.W == 1'b0 && new_cfg.cfg2.R == 1'b1) begin
            new_cfg.cfg2.R = 1'b0;
          end
          if (new_cfg.cfg3.W == 1'b0 && new_cfg.cfg3.R == 1'b1) begin
            new_cfg.cfg3.R = 1'b0;
          end
          // Assign field
          nxt_pmp_cfg[priv_ext_if.csr_addr[1:0]] = priv_ext_if.value_in;
        end
        12'b0011_1011_zzzz: begin
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
        (i%4) == 0 ? pmp_cfg_regs[i>>2].cfg0 : ((i%4) == 1 ? pmp_cfg_regs[i>>2].cfg1 : ((i%4) == 2 ? pmp_cfg_regs[i>>2].cfg2 : pmp_cfg_regs[i>>2].cfg3)),
        pmp_addr_regs[i],
        i == 0 ? '0 : pmp_addr_regs[i-1],
        d_cfg_match[i]
      );
    end
  endgenerate

  /***** Instruction PMP checker unit *****/
  logic [15:0] i_cfg_match;
  genvar j;

  generate
    for (j=0; j<16; j++) begin
      priv_1_12_pmp_matcher matcher (
        {2'b00, prv_intern_if.iaddr[31:2]},
        (j%4) == 0 ? pmp_cfg_regs[j>>2].cfg0 : ((j%4) == 1 ? pmp_cfg_regs[j>>2].cfg1 : ((j%4) == 2 ? pmp_cfg_regs[j>>2].cfg2 : pmp_cfg_regs[j>>2].cfg3)),
        pmp_addr_regs[j],
        j == 0 ? '0 : pmp_addr_regs[j-1],
        d_cfg_match[j]
      );
    end
  endgenerate

endmodule