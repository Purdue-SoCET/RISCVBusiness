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
*   Filename:     priv_1_12_csr.sv
*
*   Created by:   Hadi Ahmed
*   Email:        ahmed138@purdue.edu
*   Date Created: 03/28/2022
*   Description:  CSR File for Priv Unit 1.12
*/

`include "priv_1_12_internal_if.vh"
`include "component_selection_defins.vh"

module priv_1_12_csr # (
  HARTID = 0 ) (
  input CLK, nRST,
  priv_1_12_internal_if.csr prv_intern_if
);


  import machine_mode_types_1_12_pkg::*;
  import rv32i_types_pkg::*;

  /* Machine Information */
  csr_reg_t         mvendorid;
  csr_reg_t         marchid;
  csr_reg_t         mimpid;
  csr_reg_t         mhartid;
  csr_reg_t         mconfigptr;
  /* Machine Trap Setup */
  mstatus_t         mstatus;
  misaid_t          misaid;
  mie_t             mie;
  mtvec_t           mtvec;
  mstatush_t        mstatush;
  /* Machine Trap Handling */
  csr_reg_t         mscratch;
  csr_reg_t         mepc;
  mcause_t          mcause;
  csr_reg_t         mtval;
  mip_t             mip;
  /* Machine Counters/Timers */
  mcounteren_t      mcounteren;
  mcounterinhibit_t mcounterinhibit;
  csr_reg_t         mcycle;
  csr_reg_t         minstret;
  csr_reg_t         mcycleh;
  csr_reg_t         minstreth;

  csr_reg_t nxt_csr_val;

  /* These info registers are always just tied to certain values */
  assign mvendorid = '0;
  assign marchid = '0;
  assign mimpid = '0;
  assign mconfigptr = '0;
  assign mhartid = HARTID;

  /* These registers have some RO fields */
  assign misaid.zero = '0;
  assign misaid.base = BASE_RV32;
  assign misaid.extensions =      MISAID_EXT_I
                            `ifdef RV32C_SUPPORTED
                                | MISAID_EXT_C
                            `endif `ifdef RV32E_SUPPORTED
                                | MISAID_EXT_E
                            `endif `ifdef RV32F_SUPPORTED
                                | MISAID_EXT_F
                            `endif `ifdef RV32M_SUPPORTED
                                | MISAID_EXT_M
                            `endif `ifdef RV32U_SUPPORTED
                                | MISAID_EXT_U
                            `endif `ifdef RV32V_SUPPORTED
                                | MISAID_EXT_V
                            `endif `ifdef CUSTOM_SUPPORTED
                                | MISAID_EXT_X
                            `endif;

  assign mstatus.reserved_0 = '0;
  assign mstatus.reserved_1 = '0;
  assign mstatus.reserved_2 = '0;
  assign mstatus.reserved_3 = '0;
  assign mstatus.sie = 1'b0;
  assign mstatus.spie = 1'b0;
  assign mstatus.ube = 1'b0;
  assign mstatus.spp = 1'b0;
  assign mstatus.sum = 1'b0;
  assign mstatus.mxr = 1'b0;
  assign mstatus.tvm = 1'b0;
  assign mstatus.tsr = 1'b0;
  assign mstatus.sd = (mstatus.vs == VS_DIRTY) | (mstatus.fs == FS_DIRTY) | (mstatus.xs == XS_SOME_D);
  `ifdef RV32V_SUPPORTED
    assign mstatus.vs = VS_INITIAL;
  `else
    assign mstatus.vs = VS_OFF;
  `endif
  `ifdef RV32F_SUPPORTED
    assign mstatus.fs = FS_INITIAL;
  `else
    assign mstatus.fs = FS_OFF;
  `endif
  `ifdef CUSTOM_SUPPORTED
    assign mstatus.xs = XS_NONE_D;
  `else
    assign mstatus.xs = XS_ALL_OFF;
  `endif

  assign mstatush.reserved_0 = '0;
  assign mstatush.sbe = 1'b0;
  assign mstatush.mbe = 1'b0;
  assign mstatush.reserved_1 = '0;

  assign mip.zero_0 = '0;
  assign mip.zero_1 = '0;
  assign mip.zero_2 = '0;
  assign mip.zero_3 = '0;
  assign mip.zero_4 = '0;
  assign mip.zero_5 = '0;
  assign mip.zero_6 = '0;
  assign mip.ssip = 1'b0;
  assign mip.stip = 1'b0;
  assign mip.seip = 1'b0;
  assign mip.impl_defined = '0; // TODO do we want to define others?

  assign mie.zero_0 = '0;
  assign mie.zero_1 = '0;
  assign mie.zero_2 = '0;
  assign mie.zero_3 = '0;
  assign mie.zero_4 = '0;
  assign mie.zero_5 = '0;
  assign mie.zero_6 = '0;
  assign mie.ssie = 1'b0;
  assign mie.stie = 1'b0;
  assign mie.seie = 1'b0;
  assign mip.impl_defined = '0; // TODO do we want to define others?

  always_ff @ (posedge CLK, negedge nRST) begin
    if (~nRST) begin
      /* mstatus reset */
      mstatus.mie <= 1'b1;
      mstatus.mpie <= 1'b0;
      mstatus.mpp <= M_MODE;
      mstatus.mprv <= 1'b0;
      mstatus.tw <= 1'b1;

      /* mtvec reset */
      mtvec.mode <= DIRECT; // TODO talk with cole about defaults
      mtvec.base <= '0;     // TODO talk with cole about defaults

      /* mie reset */
      mie.msie <= 1'b0;
      mie.mtie <= 1'b0;
      mie.meie <= 1'b0;

      /* mip reset */
      mip.msip <= 1'b0;
      mip.mtip <= 1'b0;
      mip.meip <= 1'b0;

      /* msratch reset */
      mscratch <= '0;

      /* mepc reset */
      mepc <= '0;

      /* mtval reset */
      mtval <= '0;

      /* mcounter reset */
      mcounteren <= '1;
      mcounterinhibit <= '1;

      /* perf mon reset */
      mcycle <= '0;
      mcycleh <= '0;
      minstret <= '0;
      minstreth <= '0;

      /* mcause reset */
      mcause <= '0;

    end else begin

    end
  end



endmodule
