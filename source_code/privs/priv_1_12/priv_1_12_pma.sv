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
*   Filename:     priv_1_12_pma.sv
*
*   Created by:   Hadi Ahmed
*   Email:        ahmed138@purdue.edu
*   Date Created: 04/05/2022
*   Description:  PMA Checker, version 1.12
*/

`include "priv_1_12_internal_if.vh"
`include "priv_ext_if.vh"

module priv_1_12_pma (
  input logic CLK, nRST,
  priv_1_12_internal_if.pma prv_intern_if,
  priv_ext_if.ext priv_ext_if
);

import pma_types_1_12_pkg::*;

  pma_reg_t [15:0] pma_regs, nxt_pma_regs;
  pma_reg_t active_reg_d, active_reg_i;
  pma_cfg_t pma_cfg_d, pma_cfg_i;

  // Core State Registers
  always_ff @ (posedge CLK, negedge nRST) begin
    if (~nRST) begin
      // TODO figure out defaults
      pma_regs[00] <= '0;
      pma_regs[01] <= '0;
      pma_regs[02] <= '0;
      pma_regs[03] <= '0;
      pma_regs[04] <= '0;
      pma_regs[05] <= '0;
      pma_regs[06] <= '0;
      pma_regs[07] <= '0;
      pma_regs[08] <= '0;
      pma_regs[09] <= '0;
      pma_regs[10] <= '0;
      pma_regs[11] <= '0;
      pma_regs[12] <= '0;
      pma_regs[13] <= '0;
      pma_regs[14] <= '0;
      pma_regs[15] <= '0;
    end else begin
      pma_regs <= nxt_pma_regs;
    end
  end

  // Core State Logic
  always_comb begin
    nxt_pma_regs = pma_regs;
    priv_ext_if.ack = 1'b0;
    if (priv_ext_if.csr_addr[11:4] == 8'b10111100) begin
      priv_ext_if.ack = 1'b1;
      // TODO should these be writable?
      // if (priv_ext_if.csr_active) begin
      //   nxt_pma_regs[priv_ext_if.csr_addr[3:0]] = priv_ext_if.value_in;
      // end
    end
  end

  assign priv_ext_if.invalid_csr = 1'b0;
  assign priv_ext_if.value_out = pma_regs[priv_ext_if.csr_addr[3:0]];

  // PMA Logic Block
  always_comb begin
    prv_intern_if.pma_l_fault = 1'b0;
    prv_intern_if.pma_s_fault = 1'b0;
    prv_intern_if.pma_i_fault = 1'b0;

    active_reg_d = pma_regs[prv_intern_if.daddr[31:28]];
    active_reg_i = pma_regs[prv_intern_if.iaddr[31:28]];

    if (~prv_intern_if.daddr[27]) begin
      pma_cfg_d = active_reg_d.pma_cfg_0;
    end else begin
      pma_cfg_d = active_reg_d.pma_cfg_1;
    end

    if (~prv_intern_if.iaddr[27]) begin
      pma_cfg_i = active_reg_i.pma_cfg_0;
    end else begin
      pma_cfg_i = active_reg_i.pma_cfg_1;
    end

    if (prv_intern_if.ren & ~pma_cfg_d.R) begin
      prv_intern_if.pma_l_fault = 1'b1;
    end else if (prv_intern_if.wen & ~pma_cfg_d.W) begin
      prv_intern_if.pma_s_fault = 1'b1;
    end else if (prv_intern_if.xen & ~pma_cfg_i.X) begin
      prv_intern_if.pma_i_fault = 1'b1;
    end

    if (prv_intern_if.acc_width_type > pma_cfg_d.AccWidth) begin
      if (prv_intern_if.ren) begin
        prv_intern_if.pma_l_fault = 1'b1;
      end else if (prv_intern_if.wen) begin
        prv_intern_if.pma_s_fault = 1'b1;
      end else if (prv_intern_if.xen) begin
        prv_intern_if.pma_i_fault = 1'b1;
      end
    end
  end

endmodule