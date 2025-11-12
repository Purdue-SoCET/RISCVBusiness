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
*   Filename:     priv_csr.sv
*
*   Created by:   William Cunningham
*   Email:        wrcunnin@purdue.edu
*   Date Created: 09/26/2024
*   Description:  CSR File for Priv Unit 1.13
*/

`include "priv_internal_if.vh"
`include "priv_ext_if.vh"
`include "component_selection_defines.vh"

`define UPDATE_HPM_COUNTER(hpm_id)                                       \
    if (!mcounterinhibit.hpm[hpm_id]) begin                            \
        hpm_next[hpm_id] = hpm[hpm_id] + prv_intern_if.hpm_inc[hpm_id];  \
    end

`define READ_HPM_COUNTER(hpm_id)                               \
  HPMCOUNTER``hpm_id``_ADDR : begin                            \
    if (check_bad_mcounteren(mcounteren.hpm[hpm_id])) begin  \
      invalid_csr_addr = 1'b1;                                 \
    end else begin                                             \
      prv_intern_if.old_csr_val = hpm[hpm_id];                 \
    end                                                        \
  end

module priv_csr #(
  parameter int HART_ID
)(
  input CLK,
  input nRST,
  input logic [63:0] mtime,
  priv_internal_if.csr prv_intern_if,
  priv_ext_if.priv priv_ext_pma_if,
  priv_ext_if.priv priv_ext_pmp_if
  `ifdef RV32F_SUPPORTED
  , priv_ext_if.priv priv_ext_f_if
  `endif // RV32F_SUPPORTED
  `ifdef RV32V_SUPPORTED
  , priv_ext_if.priv priv_ext_v_if
  `endif // RV32V_SUPPORTED
);


  import priv_isa_types_pkg::*;
  import rv32i_types_pkg::*;

  /* Machine Information */
  csr_reg_t         mvendorid;
  csr_reg_t         marchid;
  csr_reg_t         mimpid;
  csr_reg_t         mhartid;
  csr_reg_t         mconfigptr;
  /* Machine Trap Setup */
  mstatus_t         mstatus, mstatus_next;
  misa_t            misa;
  `ifdef SMODE_SUPPORTED
  long_csr_t        medeleg, medeleg_next;
  csr_reg_t         mideleg, mideleg_next;
  `endif // SMODE_SUPPORTED
  mie_t             mie, mie_next;
  mtvec_t           mtvec, mtvec_next;
  mstatush_t        mstatush;
  /* Machine Trap Handling */
  csr_reg_t         mscratch, mscratch_next;
  csr_reg_t         mepc, mepc_next;
  mcause_t          mcause, mcause_next;
  csr_reg_t         mtval, mtval_next;
  mip_t             mip, mip_next;
  /* Machine Counters/Timers */
  mcounteren_t      mcounteren, mcounteren_next;
  mcountinhibit_t   mcounterinhibit, mcounterinhibit_next;
  csr_reg_t         mcycle;
  csr_reg_t         minstret;
  csr_reg_t         mcycleh;
  csr_reg_t         minstreth;
  long_csr_t        cycles_full, cf_next;
  long_csr_t        instret_full, if_next;
  csr_reg_t [WORD_SIZE-1:0] hpm, hpm_next;
  /* Supervisor environment configuration */
  long_csr_t        menvcfg, menvcfg_next;
  `ifdef SMODE_SUPPORTED
  /* Supervisor Protection and Translation */
  satp_t            satp, satp_next;
  /* Supervisor Trap Setup */
  sstatus_t         sstatus, sstatus_next;
  sie_t             sie, sie_next;
  stvec_t           stvec, stvec_next;
  /* Supervisor Trap Handling */
  csr_reg_t         sscratch, sscratch_next;
  csr_reg_t         sepc, sepc_next;
  scause_t          scause, scause_next;
  csr_reg_t         stval, stval_next;
  sip_t             sip, sip_next;
  /* Supervisor Counters/Timers */
  scounteren_t      scounteren, scounteren_next;
  // scountinhibit_t   scountinhibit, scountinhibit_next; // No effect without Smcdeleg/Ssccfg
  /* Supervisor environment configuration */
  senvcfg_t         senvcfg, senvcfg_next; // unused, we zero it out. may be important for future!
  `endif // SMODE_SUPPORTED

  logic isUSMode;
  assign isUSMode = prv_intern_if.isUMode | prv_intern_if.isSMode;

  csr_reg_t nxt_csr_val;

  // invalid_csr flags
  logic invalid_csr_priv, invalid_csr_addr;
  assign prv_intern_if.invalid_csr = invalid_csr_priv | invalid_csr_addr;

  // csr operation flag
  logic csr_operation;
  assign csr_operation = prv_intern_if.csr_write | prv_intern_if.csr_set | prv_intern_if.csr_clear;

  // Extension Broadcast Signals
  // - PMA
  assign priv_ext_pma_if.csr_addr = prv_intern_if.csr_addr;
  assign priv_ext_pma_if.value_in = nxt_csr_val;
  assign priv_ext_pma_if.csr_active = ~invalid_csr_priv & prv_intern_if.valid_write & (csr_operation);
  // - PMP
  assign priv_ext_pmp_if.csr_addr = prv_intern_if.csr_addr;
  assign priv_ext_pmp_if.value_in = nxt_csr_val;
  assign priv_ext_pmp_if.csr_active = ~invalid_csr_priv & prv_intern_if.valid_write & (csr_operation);
  `ifdef RV32F_SUPPORTED
    assign priv_ext_f_if.csr_addr = prv_intern_if.csr_addr;
    assign priv_ext_f_if.value_in = nxt_csr_val;
    assign priv_ext_f_if.csr_active = ~invalid_csr_priv & prv_intern_if.valid_write & (csr_operation);
`endif // RV32F_SUPPORTED
`ifdef RV32V_SUPPORTED
    assign priv_ext_v_if.csr_addr = prv_intern_if.csr_addr;
    assign priv_ext_v_if.value_in = nxt_csr_val;
    assign priv_ext_v_if.csr_active = ~invalid_csr_priv & prv_intern_if.valid_write & (csr_operation);
`endif // RV32V_SUPPORTED

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
  assign mhartid = HART_ID;

  /* These registers are RO fields */
  assign misa.zero = '0;
  assign misa.base = BASE_RV32;
  // NOTE: Per the v1.12 spec, both I and E CANNOT be high - If supporting E, I must be disabled
  assign misa.extensions =   MISA_EXT_U
                            `ifdef RV32B_SUPPORTED
                                | MISA_EXT_B
                            `endif `ifdef RV32C_SUPPORTED
                                | MISA_EXT_C
                            `endif `ifdef RV32D_SUPPORTED
                                | MISA_EXT_D
                            `endif `ifdef RV32E_SUPPORTED
                                | MISA_EXT_E
                            `endif `ifdef RV32F_SUPPORTED
                                | MISA_EXT_F
                            `endif `ifdef HMODE_SUPPORTED
                                | MISA_EXT_H
                            `endif `ifdef RV32I_SUPPORTED
                                | MISA_EXT_I
                            `endif `ifdef RV32M_SUPPORTED
                                | MISA_EXT_M
                            `endif `ifdef SMODE_SUPPORTED
                                | MISA_EXT_S
                            `endif `ifdef RV32V_SUPPORTED
                                | MISA_EXT_V
                            `endif `ifdef CUSTOM_SUPPORTED
                                | MISA_EXT_X
                            `endif;

  assign mstatush.reserved_0 = '0;
  assign mstatush.sbe = 1'b0;
  assign mstatush.mbe = 1'b0;
  assign mstatush.reserved_1 = '0;



  // Control and Status Registers
  always_ff @ (posedge CLK, negedge nRST) begin
    if (~nRST) begin
      /* mstatus reset */
      mstatus.mie <= 1'b0;
      mstatus.mpie <= 1'b0;
      mstatus.mpp <= U_MODE;
      mstatus.mprv <= 1'b0;
      mstatus.tw <= 1'b1;
      mstatus.reserved_0 <= '0;
      mstatus.reserved_1 <= '0;
      mstatus.reserved_2 <= '0;
      mstatus.reserved_3 <= '0;
      mstatus.sie <= 1'b0;
      mstatus.spie <= 1'b0;
      mstatus.ube <= 1'b0;
      mstatus.spp <= 1'b0;
      mstatus.sum <= 1'b0;
      mstatus.mxr <= 1'b0;
      mstatus.tvm <= 1'b0;
      mstatus.tsr <= 1'b0;
      mstatus.sd <= 1'b0;
      `ifdef RV32V_SUPPORTED
        mstatus.vs <= VS_INITIAL;
      `else
        mstatus.vs <= VS_OFF;
      `endif
      `ifdef RV32F_SUPPORTED
        mstatus.fs <= FS_INITIAL;
      `else
        mstatus.fs <= FS_OFF;
      `endif
      `ifdef CUSTOM_SUPPORTED
        mstatus.xs <= XS_NONE_D;
      `else
        mstatus.xs <= XS_ALL_OFF;
      `endif

      /* mtvec reset */
      mtvec.mode <= DIRECT;
      mtvec.base <= '0;

      `ifdef SMODE_SUPPORTED
      /* medeleg reset */
      medeleg <= medeleg_next;

      /* mideleg reset */
      mideleg <= mideleg_next;
      `endif // SMODE_SUPPORTED

      /* mie reset */
      mie <= '0;

      /* mip reset */
      mip <= '0;

      /* msratch reset */
      mscratch <= '0;

      /* mepc reset */
      mepc <= '0;

      /* mtval reset */
      mtval <= '0;

      /* mcounter reset */
      mcounteren <= '1;
      mcounterinhibit <= '0;

      /* perf mon reset */
      cycles_full <= '0;
      instret_full <= '0;
      hpm <= '0;

      /* mcause reset */
      mcause <= '0;

      /* menvcfg reset */
      menvcfg <= '0;

      `ifdef SMODE_SUPPORTED
      /* satp reset */
      satp <= '0;

      /* sstatus reset */
      sstatus.reserved_0 <= '0;
      sstatus.reserved_1 <= '0;
      sstatus.reserved_2 <= '0;
      sstatus.reserved_3 <= '0;
      sstatus.reserved_4 <= '0;
      sstatus.reserved_5 <= '0;
      sstatus.sie <= 1'b0;
      sstatus.spie <= 1'b0;
      sstatus.ube <= 1'b0;
      sstatus.spp <= 1'b0;
      sstatus.sum <= 1'b0;
      sstatus.mxr <= 1'b0;
      sstatus.sd <= 1'b0;
      `ifdef RV32V_SUPPORTED
        sstatus.vs <= VS_INITIAL;
      `else
        sstatus.vs <= VS_OFF;
      `endif
      `ifdef RV32F_SUPPORTED
        sstatus.fs <= FS_INITIAL;
      `else
        sstatus.fs <= FS_OFF;
      `endif
      `ifdef CUSTOM_SUPPORTED
        sstatus.xs <= XS_NONE_D;
      `else
        sstatus.xs <= XS_ALL_OFF;
      `endif

      /* sie reset */
      sie <= '0;

      /* stvec reset */
      stvec.mode <= DIRECT;
      stvec.base <= '0;
      
      /* sscratch reset */
      sscratch <= '0;
      
      /* sepc reset */
      sepc <= '0;
      
      /* scause reset */
      scause <= '0;
      
      /* stval reset */
      stval <= '0;
      
      /* sip reset */
      sip <= '0;
      
      /* scounteren reset */
      scounteren <= '0;

      /* senvcfg reset */
      senvcfg <= '0;
      `endif // SMODE_SUPPORTED
    end else begin
      mstatus <= mstatus_next;
      mtvec <= mtvec_next;
      `ifdef SMODE_SUPPORTED
      medeleg <= medeleg_next;
      mideleg <= mideleg_next;
      `endif // SMODE_SUPPORTED
      mie <= mie_next;
      mip <= mip_next;
      mscratch <= mscratch_next;
      mepc <= mepc_next;
      mtval <= mtval_next;
      mcounteren <= mcounteren_next;
      mcounterinhibit <= mcounterinhibit_next;
      mcause <= mcause_next;
      cycles_full <= cf_next;
      instret_full <= if_next;
      hpm <= hpm_next;
      menvcfg <= menvcfg_next;
      `ifdef SMODE_SUPPORTED
      satp <= satp_next;
      sstatus <= sstatus_next;
      sie <= sie_next;
      stvec <= stvec_next;
      sscratch <= sscratch_next;
      sepc <= sepc_next;
      scause <= scause_next;
      stval <= stval_next;
      sip <= sip_next;
      scounteren <= scounteren_next;
      senvcfg <= senvcfg_next;
      `endif // SMODE_SUPPORTED
    end
  end

  // Privilege Check and Legal Value Check
  logic inject_mcycle, inject_minstret, inject_mcycleh, inject_minstreth;
  always_comb begin
    mstatus_next = mstatus;
    mtvec_next = mtvec;
    mie_next = mie;
    mip_next = mip;
    mscratch_next = mscratch;
    mepc_next = mepc;
    mtval_next = mtval;
    mcounteren_next = mcounteren;
    mcounterinhibit_next = mcounterinhibit;
    mcause_next = mcause;
    menvcfg_next = menvcfg;
    `ifdef SMODE_SUPPORTED
    satp_next = satp;
    sstatus_next = sstatus;
    sie_next = sie;
    stvec_next = stvec;
    sscratch_next = sscratch;
    sepc_next = sepc;
    scause_next = scause;
    stval_next = stval;
    sip_next = sip;
    scounteren_next = scounteren;
    senvcfg_next = senvcfg;
    `endif // SMODE_SUPPORTED

    inject_mcycle = 1'b0;
    inject_mcycleh = 1'b0;
    inject_minstret = 1'b0;
    inject_minstreth = 1'b0;

    nxt_csr_val = (prv_intern_if.csr_write) ? prv_intern_if.new_csr_val :
                  (prv_intern_if.csr_set)   ? prv_intern_if.new_csr_val | prv_intern_if.old_csr_val :
                  (prv_intern_if.csr_clear) ? ~prv_intern_if.new_csr_val & prv_intern_if.old_csr_val :
                  prv_intern_if.new_csr_val;
    invalid_csr_priv = 1'b0;

    if (prv_intern_if.csr_addr[11:10] == 2'b11 && !prv_intern_if.csr_read_only) begin
      if (csr_operation) begin
        invalid_csr_priv = 1'b1; // Attempting to modify a R/O CSR
      end
    end else if (prv_intern_if.csr_addr[9:8] > prv_intern_if.curr_privilege_level) begin
      if (csr_operation) begin
        invalid_csr_priv = 1'b1; // Not enough privilege
      end
    end else begin
      if (prv_intern_if.valid_write) begin
        casez(prv_intern_if.csr_addr)
          MSTATUS_ADDR: begin
            if (prv_intern_if.new_csr_val[12:11] == RESERVED_MODE || (prv_intern_if.new_csr_val[12:11] == S_MODE && SUPERVISOR == "disabled")) begin
              assert(SUPERVISOR == "enabled");
              mstatus_next.mpp = U_MODE; // If invalid privilege level, dump at 0
            end else begin
              mstatus_next.mpp = priv_level_t'(nxt_csr_val[12:11]);
            end
            mstatus_next.sie = nxt_csr_val[1] && SUPERVISOR == "enabled";
            mstatus_next.mie = nxt_csr_val[3];
            mstatus_next.spie = nxt_csr_val[5] && SUPERVISOR == "enabled";
            mstatus_next.mpie = nxt_csr_val[7];
            mstatus_next.spp = nxt_csr_val[8] && SUPERVISOR == "enabled";
            mstatus_next.mprv = nxt_csr_val[17];
            mstatus_next.sum = nxt_csr_val[18] && SUPERVISOR == "enabled" && ADDRESS_TRANSLATION == "enabled";
            mstatus_next.mxr = nxt_csr_val[19] && SUPERVISOR == "enabled";
            mstatus_next.tvm = nxt_csr_val[20] && SUPERVISOR == "enabled";
            mstatus_next.tw = nxt_csr_val[21]; // RO-zero if no less privileged modes other than M-mode (we have U-mode regardless!)
            mstatus_next.tsr = nxt_csr_val[22] && SUPERVISOR == "enabled";
            
            `ifdef SMODE_SUPPORTED
            // Update sstatus
            sstatus_next.sie = mstatus_next.sie;
            sstatus_next.spie = mstatus_next.spie;
            sstatus_next.spp = mstatus_next.spp;
            sstatus_next.sum = mstatus_next.sum && ADDRESS_TRANSLATION == "enabled";
            sstatus_next.mxr = mstatus_next.mxr;
            `endif // SMODE_SUPPORTED
          end

          MTVEC_ADDR: begin
            if (prv_intern_if.new_csr_val[1:0] > 2'b01) begin
              mtvec_next.mode = DIRECT;
            end else begin
              mtvec_next.mode = vector_modes_t'(nxt_csr_val[1:0]);
            end
            mtvec_next.base = nxt_csr_val[31:2];
          end
          `ifdef SMODE_SUPPORTED
          MEDELEG_ADDR: begin
            medeleg_next[31:0] = nxt_csr_val;
          end

          MEDELEGH_ADDR: begin
            medeleg_next[63:32] = '0; // Grounded for now. No use for it at the moment.
          end

          MIDELEG_ADDR: begin
            mideleg_next[1] = nxt_csr_val[1];
            mideleg_next[3] = nxt_csr_val[3];
            mideleg_next[5] = nxt_csr_val[5];
            mideleg_next[7] = nxt_csr_val[7];
            mideleg_next[9] = nxt_csr_val[9];
            mideleg_next[11] = nxt_csr_val[11];
            mideleg_next[13] = nxt_csr_val[13];
          end
          `endif // SMODE_SUPPORTED
          MIE_ADDR: begin
            mie_next.ssie = nxt_csr_val[1] && SUPERVISOR == "enabled";
            mie_next.msie = nxt_csr_val[3];
            mie_next.stie = nxt_csr_val[5] && SUPERVISOR == "enabled";
            mie_next.mtie = nxt_csr_val[7];
            mie_next.seie = nxt_csr_val[9] && SUPERVISOR == "enabled";
            mie_next.meie = nxt_csr_val[11];

            `ifdef SMODE_SUPPORTED
            // Update sie
            sie_next.ssie = mie_next.ssie;
            sie_next.stie = mie_next.stie;
            sie_next.seie = mie_next.seie;
            `endif // SMODE_SUPPORTED
          end

          MIP_ADDR: begin
            mip_next.ssip = nxt_csr_val[1] && SUPERVISOR == "enabled";
            mip_next.msip = nxt_csr_val[3];
            mip_next.stip = nxt_csr_val[5] && SUPERVISOR == "enabled";
            mip_next.mtip = nxt_csr_val[7];
            mip_next.seip = nxt_csr_val[9] && SUPERVISOR == "enabled";
            mip_next.meip = nxt_csr_val[11];

            `ifdef SMODE_SUPPORTED
            // Update sip
            sip_next.ssip = mip_next.ssip;
            sip_next.stip = mip_next.stip;
            sip_next.seip = mip_next.seip;
            `endif // SMODE_SUPPORTED
          end
          MSCRATCH_ADDR: begin
            mscratch_next = nxt_csr_val;
          end
          MEPC_ADDR: begin
            mepc_next = nxt_csr_val;
          end
          MTVAL_ADDR: begin
            mtval_next = nxt_csr_val;
          end
          MCOUNTEREN_ADDR: begin
            mcounteren_next = nxt_csr_val;
            mcounteren_next.cy = nxt_csr_val[0];
            mcounteren_next.ir = nxt_csr_val[2];
            mcounteren_next.hpm = nxt_csr_val[31:3];
          end
          MCOUNTINHIBIT_ADDR: begin
            mcounterinhibit_next.cy = nxt_csr_val[0];
            mcounterinhibit_next.ir = nxt_csr_val[2];
            mcounterinhibit_next.hpm = nxt_csr_val[31:3];
          end
          MCAUSE_ADDR: begin
            mcause_next = nxt_csr_val;
          end
          MCYCLE_ADDR: begin
            inject_mcycle = 1'b1;
          end
          MINSTRET_ADDR: begin
            inject_minstret = 1'b1;
          end
          MCYCLEH_ADDR: begin
            inject_mcycleh = 1'b1;
          end
          MINSTRETH_ADDR: begin
            inject_minstreth = 1'b1;
          end
          MENVCFG_ADDR: begin
            menvcfg_next[31:0] = '0;
          end
          MENVCFGH_ADDR: begin
            menvcfg_next[63:32] = '0;
          end
          `ifdef SMODE_SUPPORTED
          SATP_ADDR: begin
            satp_next.ppn = nxt_csr_val[21:0];
            satp_next.asid = nxt_csr_val[30:22];
            satp_next.mode = ADDRESS_TRANSLATION == "enabled" ? nxt_csr_val[31] : 0;
          end
          SSTATUS_ADDR: begin
            sstatus_next.sie = nxt_csr_val[1];
            sstatus_next.spie = nxt_csr_val[5];
            sstatus_next.spp = nxt_csr_val[8];
            sstatus_next.sum = nxt_csr_val[18];
            sstatus_next.mxr = nxt_csr_val[19];
            
            // Update mstatus
            mstatus_next.sie = sstatus_next.sie;
            mstatus_next.spie = sstatus_next.spie;
            mstatus_next.spp = sstatus_next.spp;
            mstatus_next.sum = sstatus_next.sum;
            mstatus_next.mxr = sstatus_next.mxr;
          end
          SIE_ADDR: begin
            sie_next.ssie = nxt_csr_val[1];
            sie_next.stie = nxt_csr_val[5];
            sie_next.seie = nxt_csr_val[9];

            // Update mie
            mie_next.ssie = sie_next.ssie;
            mie_next.stie = sie_next.stie;
            mie_next.seie = sie_next.seie;
          end
          SIP_ADDR: begin
            sip_next.ssip = nxt_csr_val[1];
            sip_next.stip = nxt_csr_val[5];
            sip_next.seip = nxt_csr_val[9];

            // Update mip
            mip_next.ssip = sip_next.ssip;
            mip_next.stip = sip_next.stip;
            mip_next.seip = sip_next.seip;
          end
          STVEC_ADDR: begin
            if (prv_intern_if.new_csr_val[1:0] > 2'b01) begin
              stvec_next.mode = DIRECT;
            end else begin
              stvec_next.mode = vector_modes_t'(nxt_csr_val[1:0]);
            end
            stvec_next.base = nxt_csr_val[31:2];
          end
          SSCRATCH_ADDR: begin
            sscratch_next = nxt_csr_val;
          end
          SEPC_ADDR: begin
            sepc_next = nxt_csr_val;
          end
          SCAUSE_ADDR: begin
            scause_next.cause = nxt_csr_val[(SXLEN-2):0];
            scause_next.interrupt = nxt_csr_val[SXLEN-1];
          end
          STVAL_ADDR: begin
            stval_next = nxt_csr_val;
          end
          SCOUNTEREN_ADDR: begin
            scounteren_next = nxt_csr_val;
          end
          SENVCFG_ADDR: begin
            senvcfg_next = '0;
          end
          `endif // SMODE_SUPPORTED
        endcase
      end
    end

    // inject values
    // Note: injections to sstatus/sip inject mstatus/mip and vice versa
    //       see priv_int_ex_handler for why
    if (prv_intern_if.inject_mstatus) begin
      mstatus_next = prv_intern_if.next_mstatus;
      
      `ifdef SMODE_SUPPORTED
      sstatus_next = sstatus_t'(prv_intern_if.next_mstatus & SSTATUS_MASK);
      `endif
    end
    if (prv_intern_if.inject_mtval) begin
      mtval_next = prv_intern_if.next_mtval;
    end
    if (prv_intern_if.inject_mepc) begin
      mepc_next = prv_intern_if.next_mepc;
    end
    if (prv_intern_if.inject_mcause) begin
      mcause_next = prv_intern_if.next_mcause;
    end
    if (prv_intern_if.inject_mip) begin
      mip_next = prv_intern_if.next_mip;
      `ifdef SMODE_SUPPORTED
      sip_next = sip_t'(prv_intern_if.next_mip & SIE_MASK);
      `endif
    end
    `ifdef SMODE_SUPPORTED
    if (prv_intern_if.inject_scause) begin
      scause_next = prv_intern_if.next_scause;
    end
    if (prv_intern_if.inject_stval) begin
      stval_next = prv_intern_if.next_stval;
    end
    if (prv_intern_if.inject_sepc) begin
      sepc_next = prv_intern_if.next_sepc;
    end
    `endif // SMODE_SUPPORTED

    mstatus_next.sd = &(mstatus_next.vs) | &(mstatus_next.fs) | &(mstatus_next.xs);
    
    `ifdef SMODE_SUPPORTED
    sstatus_next.sd = mstatus_next.sd;
    `endif
  end

  // hw perf mon
  always_comb begin
    cf_next = cycles_full;
    if_next = instret_full;
    hpm_next = hpm;

    if (~mcounterinhibit.cy) begin
      cf_next = cycles_full + 1;
    end
    if (~mcounterinhibit.ir) begin
      if_next = instret_full + prv_intern_if.inst_ret;
    end
    `UPDATE_HPM_COUNTER(3)
    `UPDATE_HPM_COUNTER(4)

    if (inject_mcycle) begin
      cf_next = {mcycleh, nxt_csr_val};
    end
    if (inject_mcycleh) begin
      cf_next = {nxt_csr_val, mcycle};
    end

    if (inject_minstret) begin
      if_next = {minstreth, nxt_csr_val};
    end
    if (inject_minstreth) begin
      if_next = {nxt_csr_val, minstret};
    end
  end

  // Return proper values to CPU
  always_comb begin
    /* CPU return */
    prv_intern_if.old_csr_val = '0;
    invalid_csr_addr = 1'b0;
    casez(prv_intern_if.csr_addr)
      /* Machine Mode Addresses */
      MVENDORID_ADDR: prv_intern_if.old_csr_val = mvendorid;
      MARCHID_ADDR: prv_intern_if.old_csr_val = marchid;
      MIMPID_ADDR: prv_intern_if.old_csr_val = mimpid;
      MHARTID_ADDR: prv_intern_if.old_csr_val = mhartid;
      MCONFIGPTR_ADDR: prv_intern_if.old_csr_val = mconfigptr;
      MSTATUS_ADDR: prv_intern_if.old_csr_val = mstatus;
      MISA_ADDR: prv_intern_if.old_csr_val = misa;
      `ifdef SMODE_SUPPORTED
      MEDELEG_ADDR: prv_intern_if.old_csr_val = medeleg[31:0];
      MEDELEGH_ADDR: prv_intern_if.old_csr_val = medeleg[63:32];
      MIDELEG_ADDR: prv_intern_if.old_csr_val = mideleg;
      `endif // SMODE_SUPPORTED
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
      `ifdef SMODE_SUPPORTED
      /* Supervisor Mode Addresses */
      SATP_ADDR: prv_intern_if.old_csr_val = satp;
      SSTATUS_ADDR: prv_intern_if.old_csr_val = sstatus;
      SIE_ADDR: prv_intern_if.old_csr_val = sie;
      SIP_ADDR: prv_intern_if.old_csr_val = sip;
      STVEC_ADDR: prv_intern_if.old_csr_val = stvec;
      SSCRATCH_ADDR: prv_intern_if.old_csr_val = sscratch;
      SEPC_ADDR: prv_intern_if.old_csr_val = sepc;
      SCAUSE_ADDR: prv_intern_if.old_csr_val = scause;
      STVAL_ADDR: prv_intern_if.old_csr_val = stval;
      SCOUNTEREN_ADDR: prv_intern_if.old_csr_val = scounteren;
      `endif // SMODE_SUPPORTED
      /* Unprivileged Addresses */
      CYCLE_ADDR: begin
        if (check_bad_mcounteren(mcounteren.cy)) begin
          invalid_csr_addr = 1'b1;
        end else begin
          prv_intern_if.old_csr_val = mcycle;
        end
      end
      CYCLEH_ADDR: begin
        if (check_bad_mcounteren(mcounteren.cy)) begin
          invalid_csr_addr = 1'b1;
        end else begin
          prv_intern_if.old_csr_val = mcycleh;
        end
      end
      INSTRET_ADDR: begin
        if (check_bad_mcounteren(mcounteren.ir)) begin
          invalid_csr_addr = 1'b1;
        end else begin
          prv_intern_if.old_csr_val = minstret;
        end
      end
      INSTRETH_ADDR: begin
        if (check_bad_mcounteren(mcounteren.ir)) begin
          invalid_csr_addr = 1'b1;
        end else begin
          prv_intern_if.old_csr_val = minstreth;
        end
      end
      TIME_ADDR: begin
        if (check_bad_mcounteren(mcounteren.tm)) begin
          invalid_csr_addr = 1'b1;
        end else begin
          prv_intern_if.old_csr_val = /* TODO get mtime */ mtime[31:0];
        end
      end
      TIMEH_ADDR: begin
        if (check_bad_mcounteren(mcounteren.tm)) begin
          invalid_csr_addr = 1'b1;
        end else begin
          prv_intern_if.old_csr_val = /* TODO get mtimeh */ mtime[63:32];
        end
      end
      `READ_HPM_COUNTER(3)
      `READ_HPM_COUNTER(4)
      /* Extension Addresses */
      default: begin
        if (csr_operation) begin
          if (priv_ext_pma_if.ack) begin
            prv_intern_if.old_csr_val = priv_ext_pma_if.value_out;
          end else if (priv_ext_pmp_if.ack) begin
            prv_intern_if.old_csr_val = priv_ext_pmp_if.value_out;
          end
          `ifdef RV32F_SUPPORTED
            else if (priv_ext_f_if.ack) begin
              prv_intern_if.old_csr_val = priv_ext_f_if.value_out;
            end
          `endif // RV32F_SUPPORTED
          `ifdef RV32V_SUPPORTED
            else if (priv_ext_v_if.ack) begin
              prv_intern_if.old_csr_val = priv_ext_v_if.value_out;
            end
          `endif // RV32V_SUPPORTED

          // CSR address doesn't exist
          invalid_csr_addr = 1'b1
                          & (~priv_ext_pma_if.ack) & (~priv_ext_pma_if.invalid_csr)
                          & (~priv_ext_pmp_if.ack) & (~priv_ext_pmp_if.invalid_csr)
                          `ifdef RV32F_SUPPORTED
                            & (~priv_ext_f_if.ack) & (~priv_ext_f_if.invalid_csr)
                          `endif // RV32F_SUPPORTED
                          `ifdef RV32V_SUPPORTED
                            & (~priv_ext_v_if.ack) & (~priv_ext_v_if.invalid_csr)
                          `endif // RV32V_SUPPORTED
                        ;
        end
      end
    endcase
  end

  /* Priv control return */
  `ifdef SMODE_SUPPORTED
  assign prv_intern_if.curr_medeleg = medeleg;
  assign prv_intern_if.curr_mideleg = mideleg;
  `endif // SMODE_SUPPORTED
  assign prv_intern_if.curr_mip = mip; // reflects sip
  assign prv_intern_if.curr_mie = mie; // reflects sie
  assign prv_intern_if.curr_mcause = mcause;
  assign prv_intern_if.curr_mepc = mepc;
  assign prv_intern_if.curr_mstatus = mstatus; // reflects sstatus
  assign prv_intern_if.curr_mtvec = mtvec;
  `ifdef SMODE_SUPPORTED
  assign prv_intern_if.curr_scause = scause;
  assign prv_intern_if.curr_sepc = sepc;
  assign prv_intern_if.curr_stvec = stvec;
  assign prv_intern_if.curr_satp = satp;
  `endif // SMODE_SUPPORTED

  // function to obtain all non requesters
  function logic check_bad_mcounteren;
      input logic mcounteren_bit;
      check_bad_mcounteren = (
          (csr_operation) &
          (
              (isUSMode & ~mcounteren_bit) |
              (SUPERVISOR == "enabled" & prv_intern_if.isUMode & mcounteren_bit)
          )
      );
  endfunction
endmodule
