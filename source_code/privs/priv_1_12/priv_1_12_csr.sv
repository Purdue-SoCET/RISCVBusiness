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
`include "component_selection_defines.vh"

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
  mcountinhibit_t   mcounterinhibit;
  csr_reg_t         mcycle;
  csr_reg_t         minstret;
  csr_reg_t         mcycleh;
  csr_reg_t         minstreth;
  long_csr_t        cycles_full, cf_next;
  long_csr_t        instret_full, if_next;

  csr_reg_t nxt_csr_val;

  /* Save some logic with this */
  assign mcycle = cycles_full[31:0];
  assign mcycleh = cycles_full[63:32];
  assign minstret = instret_full[31:0];
  assign minstreth = instret_full[63:32];

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
                             `endif /* `ifdef RV32E_SUPPORTED
                                | MISAID_EXT_E
                            `endif */ `ifdef RV32F_SUPPORTED
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
  assign mstatus.sd = &(mstatus.vs) | &(mstatus.fs) | &(mstatus.xs);
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
  assign mie.impl_defined = '0; // TODO do we want to define others?

  // Control and Status Registers
  always_ff @ (posedge CLK, negedge nRST) begin
    if (~nRST) begin
      /* mstatus reset */
      mstatus.mie <= 1'b0;
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
      cycles_full <= '0;
      instret_full <= '0;

      /* mcause reset */
      mcause <= '0;

    end else begin
      // Only write if it is a valid write and no perm error
      if (prv_intern_if.csr_mod && ~prv_intern_if.invalid_csr) begin
        casez (prv_intern_if.csr_addr)
          MSTATUS_ADDR: begin
            mstatus.mie <= nxt_csr_val[3];
            mstatus.mpie <= nxt_csr_val[7];
            mstatus.mpp <= priv_level_t'(nxt_csr_val[12:11]);
            mstatus.mprv <= nxt_csr_val[17];
            mstatus.tw <= nxt_csr_val[21];
          end
          MTVEC_ADDR: begin
            mtvec.mode <= vector_modes_t'(nxt_csr_val[1:0]);
            mtvec.base <= nxt_csr_val[31:2];
          end
          MIE_ADDR: begin
            mie.msie <= nxt_csr_val[3];
            mie.mtie <= nxt_csr_val[7];
            mie.meie <= nxt_csr_val[11];
          end
          MIP_ADDR: begin
            mip.msip <= nxt_csr_val[3];
            mip.mtip <= nxt_csr_val[7];
            mip.meip <= nxt_csr_val[11];
          end
          MSCRATCH_ADDR: begin
            mscratch <= nxt_csr_val;
          end
          MEPC_ADDR: begin
            mepc <= nxt_csr_val;
          end
          MCOUNTEREN_ADDR: begin
            mcounteren <= nxt_csr_val;
          end
          MCOUNTINHIBIT_ADDR: begin
            mcounterinhibit <= nxt_csr_val;
          end
          MCAUSE_ADDR: begin
            mcause <= nxt_csr_val;
          end
        endcase
      end

      cycles_full <= cf_next;
      instret_full <= if_next;
    end
  end

  // Privilege Check and Legal Value Check
  always_comb begin
    nxt_csr_val = prv_intern_if.new_csr_val;
    prv_intern_if.invalid_csr = 1'b0;

    if (prv_intern_if.csr_addr[9:8] & prv_intern_if.curr_priv != 2'b11) begin
      prv_intern_if.invalid_csr = 1'b1; // Not enough privilege
    end else begin
      casez(prv_intern_if.csr_addr)
        MSTATUS_ADDR: begin
          if (prv_intern_if.new_csr_val[12:11] == 2'b10) begin
            nxt_csr_val[12:11] = 2'b00; // If invalid privilege level, dump at 0
          end
        end

        MTVEC_ADDR: begin
          if (prv_intern_if.new_csr_val[1:0] > 2'b01) begin
            nxt_csr_val[1:0] = 2'b00;
          end
        end

        /* Below have no values to check or are R/O */
        MVENDORID_ADDR, MARCHID_ADDR, MIMPID_ADDR, MHARTID_ADDR, MCONFIGPTR_ADDR,
        MISA_ADDR, MIE_ADDR, MTVEC_ADDR, MSTATUSH_ADDR, MSCRATCH_ADDR, MEPC_ADDR,
        MCAUSE_ADDR, MTVAL_ADDR, MIP_ADDR, MCOUNTEREN_ADDR, MCOUNTINHIBIT_ADDR,
        MCYCLE_ADDR, MINSTRET_ADDR, MCYCLEH_ADDR, MINSTRETH_ADDR: begin
            nxt_csr_val = prv_intern_if.curr_priv;
        end


        default: prv_intern_if.invalid_csr = 1'b1; // CSR address doesn't exist
      endcase
    end
  end

  // hw perf mon
  always_comb begin
    cf_next = cycles_full;
    if_next = instret_full;

    if (~mcounterinhibit.cy) begin
      cf_next = cycles_full + 1;
    end
    if (~mcounterinhibit.ir) begin
      if_next = instret_full + prv_intern_if.inst_ret;
    end
  end

  // Return proper values to CPU, PMP, PMA
  always_comb begin
    prv_intern_if.old_csr_val = '0;
    /* CPU return */
    casez(prv_intern_if.csr_addr)
      MVENDORID_ADDR: prv_intern_if.old_csr_val = mvendorid;
      MARCHID_ADDR: prv_intern_if.old_csr_val = marchid;
      MIMPID_ADDR: prv_intern_if.old_csr_val = mimpid;
      MHARTID_ADDR: prv_intern_if.old_csr_val = mhartid;
      MCONFIGPTR_ADDR: prv_intern_if.old_csr_val = mconfigptr;
      MSTATUS_ADDR: prv_intern_if.old_csr_val = mstatus;
      MISA_ADDR: prv_intern_if.old_csr_val = misaid;
      MIE_ADDR: prv_intern_if.old_csr_val = mie;
      MTVEC_ADDR: prv_intern_if.old_csr_val = mtvec;
      MSTATUSH_ADDR: prv_intern_if.old_csr_val = mstatush;
      MSCRATCH_ADDR: prv_intern_if.old_csr_val = mscratch;
      MEPC_ADDR: prv_intern_if.old_csr_val = mepc;
      MCAUSE_ADDR: prv_intern_if.old_csr_val = mcause;
      MTVAL_ADDR: prv_intern_if.old_csr_val = mtval;
      MIP_ADDR: prv_intern_if.old_csr_val = mip;
      MCOUNTEREN_ADDR: prv_intern_if.old_csr_val = mcounteren;
      MCOUNTINHIBIT_ADDR: prv_intern_if.old_csr_val = mcounterinhibit;
      MCYCLE_ADDR: prv_intern_if.old_csr_val = mcycle;
      MINSTRET_ADDR: prv_intern_if.old_csr_val = minstret;
      MCYCLEH_ADDR: prv_intern_if.old_csr_val = mcycleh;
      MINSTRETH_ADDR: prv_intern_if.old_csr_val = minstreth;
    endcase
  end

endmodule
