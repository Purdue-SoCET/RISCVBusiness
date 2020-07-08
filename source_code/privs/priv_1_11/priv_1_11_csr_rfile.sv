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
*   Filename:     priv_1_11_csr_rfile.sv
*
*   Created by:   Jacob R. Stevens
*   Email:        steven69@purdue.edu
*   Date Created: 08/13/2019
*   Description:  CSR Registers for Machine Mode Implementation RV32
*/


`include "priv_1_11_internal_if.vh"
`include "component_selection_defines.vh"

module priv_1_11_csr_rfile (
  input CLK, nRST,
  priv_1_11_internal_if.csr prv_intern_if
);
  import machine_mode_types_1_11_pkg::*;
  import rv32i_types_pkg::*;
 
  /* Machine Information Registers */

  mvendorid_t   mvendorid;
  marchid_t     marchid;
  mimpid_t      mimpid;
  mhartid_t     mhartid;
  misaid_t      misaid;

  assign misaid.base          = BASE_RV32;
  assign misaid.zero          = '0;
  assign misaid.extensions  = MISAID_EXT_I `ifdef         RV32M_SUPPORTED |
                              MISAID_EXT_M `endif `ifdef  RV32C_SUPPORTED |
                              MISAID_EXT_C `endif `ifdef  RV32F_SUPPORTED | 
                              MISAID_EXT_F `endif `ifdef  CUSTOM_SUPPORTED |
                              MISAID_EXT_X `endif;

  //TODO: Version Numbering Convention
  assign mvendorid        = '0;
  assign marchid          = '0;
  assign mimpid           = '0;
  assign mhartid          = '0; 

  
  /* Machine Trap Setup Registers */

  mstatus_t mstatus, mstatus_next;
  medeleg_t medeleg;
  mideleg_t mideleg;
  mie_t     mie, mie_next;
  mtvec_t   mtvec, mtvec_next;

  // Privilege and Global Interrupt-Enable Stack
  assign mstatus.uie          = 1'b0;
  assign mstatus.sie   	      = 1'b0;
  assign mstatus.reserved_0   = 1'b0;
  assign mstatus.upie	      = 1'b0;
  assign mstatus.spie	      = 1'b0;
  assign mstatus.reserved_1   = 1'b0;
  assign mstatus.spp	      = 1'b0;
  assign mstatus.reserved_2   = 2'b0;
  assign mstatus.mpp          = M_LEVEL;

  // No memory protection
  assign mstatus.mprv   = 1'b0;
  assign mstatus.sum    = 1'b0;
  assign mstatus.mxr    = 1'b0;

  // No virtualization protection
  assign mstatus.tvm = 1'b0;
  assign mstatus.tw = 1'b0;
  assign mstatus.tsr = 1'b0;

  // No FPU or Extensions
  assign mstatus.xs     = XS_ALL_OFF;
  assign mstatus.fs     = FS_OFF;
  assign mstatus.sd     = (mstatus.fs == FS_DIRTY) | (mstatus.xs == XS_SOME_D);
  assign mstatus.reserved_3 = '0;



  // Deleg Register Zero in Machine Mode Only (Should be removed)
  assign medeleg = '0;
  assign mideleg = '0;

  assign mie.reserved_0 = '0;
  assign mie.reserved_1 = '0;
  assign mie.reserved_2 = '0;
  assign mie.reserved_3 = '0;
  assign mie.utie = 1'b0;
  assign mie.stie = 1'b0;
  assign mie.usie = 1'b0;
  assign mie.ssie = 1'b0;
  assign mie.ueie = 1'b0;
  assign mie.seie = 1'b0;

 /* Machine Trap Handling */
 
  mscratch_t  mscratch, mscratch_next;
  mepc_t      mepc, mepc_next;
  mcause_t    mcause, mcause_next;
  mtval_t     mtval, mtval_next;
  mip_t       mip, mip_next;
 
  assign mip.reserved_0 = '0;
  assign mip.reserved_1 = '0;
  assign mip.reserved_2 = '0;
  assign mip.reserved_3 = '0;
  assign mip.utip = 1'b0;
  assign mip.stip = 1'b0;
  assign mip.usip = 1'b0;
  assign mip.ssip = 1'b0;
  assign mip.ueip = 1'b0;
  assign mip.seip = 1'b0;

  /* Machine Counter Delta Registers */
  // Unimplemented, only Machine Mode Supported

  /* Performance User Level Registers */
  cycle_t cycle, cycleh, cycle_next, cycleh_next;
  time_t  _time, timeh, time_next, timeh_next;
  instret_t instret, instreth, instret_next, isntreth_next;
  logic [63:0] instretfull, instretfull_next, cyclefull, cyclefull_next;
  logic [63:0] timefull, timefull_next;
  //TODO: Difference between time and cycle?
  assign _time = timefull[31:0];
  assign timeh = timefull[63:32];
  assign timefull_next = timefull + 1;
  assign cycle = cyclefull[31:0];
  assign cycleh = cyclefull[63:32];
  assign cyclefull_next = cyclefull + 1;
  assign instret = instretfull[31:0];
  assign instreth = instretfull[63:32];
  assign instretfull_next = (prv_intern_if.instr_retired == 1'b1) ?
                            instretfull + 1 : instretfull;

  //Non Standard Extensions, used for testing 
  //mtohost_t   mtohost, mtohost_next;
  mfromhost_t mfromhost, mfromhost_next;

 
  always_ff @ (posedge CLK, negedge nRST) begin
    if (~nRST) begin
      mstatus.mie <= 1'b0;
      mstatus.mpie <= 1'b0;
      mie.mtie    <= 1'b0;
      mie.msie    <= 1'b0;
      mip.msip    <= 1'b0;
      mip.mtip    <= 1'b0;
      mie.meie    <= 1'b0;
      mip.meip    <= 1'b0;
      mtvec       <= '0;
      mcause      <= '0;
      mepc        <= '0;
      mtval       <= '0;
      mscratch    <= '0;
      //mtohost     <= '0;
      mfromhost   <= '0;
      timefull    <= '0;
      cyclefull   <= '0;
      instretfull <= '0;
    end else begin      
      mstatus.mie  <= mstatus_next.mie;
      mstatus.mpie <= mstatus_next.mpie;
      mie.mtie    <= mie_next.mtie;
      mie.msie    <= mie_next.msie;
      mie.meie    <= mie_next.meie;
      mip.msip    <= mip_next.msip;
      mip.mtip    <= mip_next.mtip;
      mip.meip    <= mip_next.meip;
      mtvec       <= mtvec_next;
      mcause      <= mcause_next;
      mepc        <= mepc_next;
      mtval       <= mtval_next;
      mscratch    <= mscratch_next;
      //mtohost     <= mtohost_next;
      mfromhost   <= mfromhost_next;
      timefull    <= timefull_next;
      cyclefull   <= cyclefull_next;
      instretfull <= instretfull_next;
    end
  end


  /* Pipeline Read/Write Interface */

  logic valid_csr_addr;
  logic csr_op;
  logic swap, clr, set;
  word_t rup_data;


  assign csr_op = prv_intern_if.swap | prv_intern_if.clr | prv_intern_if.set;
  assign prv_intern_if.invalid_csr = csr_op & ~valid_csr_addr;
  // Should not update data if the csr addr is invalid
  assign swap = prv_intern_if.swap & valid_csr_addr & prv_intern_if.valid_write;
  assign clr = prv_intern_if.clr & valid_csr_addr & prv_intern_if.valid_write;
  assign set = prv_intern_if.set & valid_csr_addr & prv_intern_if.valid_write;
  assign rup_data = swap ? prv_intern_if.wdata : (
                      clr ? prv_intern_if.rdata & ~prv_intern_if.wdata :
                      set ? prv_intern_if.rdata | prv_intern_if.wdata :
                      prv_intern_if.rdata
                      );

  // Readonly by pipeline, rw by prv, controlled by hardware
  assign mip_next       = prv_intern_if.mip_rup ? prv_intern_if.mip_next : mip;
  assign mtval_next     = prv_intern_if.mtval_rup ? prv_intern_if.mtval_next : mtval;
  assign mcause_next    = prv_intern_if.mcause_rup ? prv_intern_if.mcause_next : mcause;

  // Read and write by pipeline and prv
  assign mstatus_next   = (prv_intern_if.addr == MSTATUS_ADDR) ? mstatus_t'(rup_data) : (
                            prv_intern_if.mstatus_rup ? prv_intern_if.mstatus_next :
                            mstatus
                          );
  assign mepc_next      = (prv_intern_if.addr == MEPC_ADDR)  ? mepc_t'(rup_data) : (
                            prv_intern_if.mepc_rup ? prv_intern_if.mepc_next : 
                            mepc
                          );


  // Readonly by priv, rw by pipeline, assigned based on csr instructions
  assign mie_next       = (prv_intern_if.addr == MIE_ADDR) ? mie_t'(rup_data) : mie;
  assign mtvec_next     = (prv_intern_if.addr == MTVEC_ADDR) ? mtvec_t'(rup_data) : mtvec;
  assign mscratch_next  = (prv_intern_if.addr == MSCRATCH_ADDR) ? mscratch_t'(rup_data) : mscratch;
  //assign mtohost_next   = (prv_intern_if.addr == MTOHOST_ADDR) ? mtohost_t'(rup_data) : mtohost;

  always_comb begin // register to send to pipeline based on the address
    valid_csr_addr = 1'b1;
    casez (prv_intern_if.addr)
      MVENDORID_ADDR  : prv_intern_if.rdata = mvendorid;
      MARCHID_ADDR    : prv_intern_if.rdata = marchid;
      MIMPID_ADDR     : prv_intern_if.rdata = mimpid;
      MHARTID_ADDR    : prv_intern_if.rdata = mhartid;
      MISA_ADDR       : prv_intern_if.rdata = misaid; 

      MSTATUS_ADDR    : prv_intern_if.rdata = mstatus;
      MTVEC_ADDR      : prv_intern_if.rdata = mtvec;
      MEDELEG_ADDR    : prv_intern_if.rdata = medeleg; 
      MIDELEG_ADDR    : prv_intern_if.rdata = mideleg; 
      MIE_ADDR        : prv_intern_if.rdata = mie;

      MSCRATCH_ADDR   : prv_intern_if.rdata = mscratch;
      MEPC_ADDR       : prv_intern_if.rdata = mepc;
      MCAUSE_ADDR     : prv_intern_if.rdata = mcause;
      MTVAL_ADDR      : prv_intern_if.rdata = mtval;
      MIP_ADDR        : prv_intern_if.rdata = mip; 

      // Performance counters
      MCYCLE_ADDR      : prv_intern_if.rdata = cycle;
      MINSTRET_ADDR    : prv_intern_if.rdata = instret;
      MCYCLEH_ADDR     : prv_intern_if.rdata = cycleh;
      MINSTRETH_ADDR   : prv_intern_if.rdata = instreth;

      default : begin
        valid_csr_addr = 1'b0;
        prv_intern_if.rdata = '0;
      end
    endcase
  end

  assign prv_intern_if.mtvec     = mtvec;
  assign prv_intern_if.mepc      = mepc;
  assign prv_intern_if.mie       = mie;
  assign prv_intern_if.mstatus   = mstatus;
  assign prv_intern_if.mcause    = mcause;
  assign prv_intern_if.mip       = mip;


endmodule
