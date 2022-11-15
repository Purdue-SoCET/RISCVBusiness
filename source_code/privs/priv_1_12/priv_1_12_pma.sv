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
  import rv32i_types_pkg::*;

  pma_reg_t [15:0] pma_regs, nxt_pma_regs;
  pma_reg_t active_reg_d, active_reg_i;
  pma_cfg_t pma_cfg_d, pma_cfg_i;
  pma_reg_t new_val;

  // Core State Registers
  always_ff @ (posedge CLK, negedge nRST) begin
    if (~nRST) begin
      pma_regs[00] <= pma_reg_t'({pma_cfg_t'(16'h3BF1), pma_cfg_t'(16'h1BF1)}); // 0 - ROM, 1 - RAM
      pma_regs[01] <= pma_reg_t'({pma_cfg_t'(16'h3BF1), pma_cfg_t'(16'h3BF1)}); // RAM
      pma_regs[02] <= pma_reg_t'({pma_cfg_t'(16'h3BF1), pma_cfg_t'(16'h3BF1)}); // RAM
      pma_regs[03] <= pma_reg_t'({pma_cfg_t'(16'h3BF1), pma_cfg_t'(16'h3BF1)}); // RAM
      pma_regs[04] <= pma_reg_t'({pma_cfg_t'(16'h3BF1), pma_cfg_t'(16'h3BF1)}); // RAM
      pma_regs[05] <= pma_reg_t'({pma_cfg_t'(16'h3BF1), pma_cfg_t'(16'h3BF1)}); // RAM
      pma_regs[06] <= pma_reg_t'({pma_cfg_t'(16'h3BF1), pma_cfg_t'(16'h3BF1)}); // RAM
      pma_regs[07] <= pma_reg_t'({pma_cfg_t'(16'h3BF1), pma_cfg_t'(16'h3BF1)}); // RAM
      pma_regs[08] <= pma_reg_t'({pma_cfg_t'(16'h3B30), pma_cfg_t'(16'h3B30)}); // I/O
      pma_regs[09] <= pma_reg_t'({pma_cfg_t'(16'h3B30), pma_cfg_t'(16'h3B30)}); // I/O
      pma_regs[10] <= pma_reg_t'({pma_cfg_t'(16'h3B30), pma_cfg_t'(16'h3B30)}); // I/O
      pma_regs[11] <= pma_reg_t'({pma_cfg_t'(16'h3B30), pma_cfg_t'(16'h3B30)}); // I/O
      pma_regs[12] <= pma_reg_t'({pma_cfg_t'(16'h3B30), pma_cfg_t'(16'h3B30)}); // I/O
      pma_regs[13] <= pma_reg_t'({pma_cfg_t'(16'h3B30), pma_cfg_t'(16'h3B30)}); // I/O
      pma_regs[14] <= pma_reg_t'({pma_cfg_t'(16'h3B30), pma_cfg_t'(16'h3B30)}); // I/O
      pma_regs[15] <= pma_reg_t'({pma_cfg_t'(16'h3B30), pma_cfg_t'(16'h3B30)}); // I/O
    end else begin
      pma_regs <= nxt_pma_regs;
    end
  end

  // Core State Logic
  always_comb begin
    nxt_pma_regs = pma_regs;
    priv_ext_if.ack = 1'b0;
    new_val = pma_reg_t'(priv_ext_if.value_in);
    if (priv_ext_if.csr_addr[11:4] == 8'b10111100) begin
      priv_ext_if.ack = 1'b1;
      if (priv_ext_if.csr_active) begin
        // WARL checks
        if (new_val.pma_cfg_0.Rsrv == RsrvReserved) begin
          new_val.pma_cfg_0.Rsrv = RsrvNone;
        end
        if (new_val.pma_cfg_1.Rsrv == RsrvReserved) begin
          new_val.pma_cfg_0.Rsrv = RsrvNone;
        end
        if (new_val.pma_cfg_0.AccWidth == AccWidthReserved) begin
          new_val.pma_cfg_0.AccWidth = WordAcc;
        end
        if (new_val.pma_cfg_1.AccWidth == AccWidthReserved) begin
          new_val.pma_cfg_0.AccWidth = WordAcc;
        end

        nxt_pma_regs[priv_ext_if.csr_addr[3:0]] = new_val;
      end
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

    if (prv_intern_if.ren & (~pma_cfg_d.R || (prv_intern_if.d_acc_width > pma_cfg_d.AccWidth))) begin
      prv_intern_if.pma_l_fault = 1'b1;
    end else if (prv_intern_if.wen & (~pma_cfg_d.W || (prv_intern_if.d_acc_width > pma_cfg_d.AccWidth))) begin
      prv_intern_if.pma_s_fault = 1'b1;
    end else if (prv_intern_if.xen & (~pma_cfg_i.X || (prv_intern_if.i_acc_width > pma_cfg_i.AccWidth))) begin
      prv_intern_if.pma_i_fault = 1'b1;
    end
  end

endmodule