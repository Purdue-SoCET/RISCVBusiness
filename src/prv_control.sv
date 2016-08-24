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
*   Filename:     prv_control.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 08/17/2016
*   Description:  Main control for the priv isa block 
*/

`include "prv_ex_int_if.vh"
`include "csr_prv_if.vh"

module prv_control (
  prv_ex_int_if.prv  ex_int_if,
  csr_prv_if.prv      csr_pr_if
);
  import rv32i_types_pkg::*;
  import machine_mode_types_pkg::*;

  ex_code_t ex_src;
  logic exception;
  
  int_code_t intr_src;
  logic interrupt;

  always_comb begin
    interrupt = 1'b1;
    intr_src = SOFT_INT;

    if (ex_int_if.timer_int) begin
      intr_src = TIMER_INT;
    end
    else if (ex_int_if.soft_int) begin
      intr_src = SOFT_INT;
    end
    else if (ex_int_if.ext_int) begin
      intr_src = EXT_INT;
    end
    else
      interrupt = 1'b0;
  end

  assign csr_pr_if.mip_rup = interrupt;
  always_comb begin
    csr_pr_if.mip_next = csr_pr_if.mip;
    if (ex_int_if.timer_int) csr_pr_if.mip_next.mtip = 1'b1;
    if (ex_int_if.soft_int) csr_pr_if.mip_next.msip = 1'b1;
    if (ex_int_if.ext_int) csr_pr_if.mip_next.msip = 1'b1; //external interrupts not specified in 1.7
  end

  always_comb begin
    exception = 1'b1;
    ex_src = INSN_MAL;

    if (ex_int_if.fault_l)
      ex_src = L_FAULT;
    else if (ex_int_if.mal_l)
      ex_src = L_ADDR_MAL;
    else if (ex_int_if.fault_s) 
      ex_src = S_FAULT;
    else if (ex_int_if.mal_s) 
      ex_src = S_ADDR_MAL;
    else if (ex_int_if.breakpoint)
      ex_src = BREAKPOINT;
    else if (ex_int_if.env_m) 
      ex_src = ENV_CALL_M;
    else if (ex_int_if.illegal_insn) 
      ex_src = ILLEGAL_INSN;
    else if (ex_int_if.fault_insn)
      ex_src = INSN_FAULT;
    else if (ex_int_if.mal_insn)
      ex_src = INSN_MAL;
    else 
      exception = 1'b0;
  end

  //output to pipeline control
  assign ex_int_if.intr = exception | (csr_pr_if.mstatus.ie &   ((csr_pr_if.mie.mtie & csr_pr_if.mip.mtip) | 
                                                              (csr_pr_if.mie.msie & csr_pr_if.mip.msip)));
  assign ex_int_if.intr_prv = M_MODE;
 
  // Register Updates on Interrupt/Exception
  assign csr_pr_if.mcause_rup = ex_int_if.intr;
  assign csr_pr_if.mcause_next.interrupt = ~exception;
  assign csr_pr_if.mcause_next.cause = exception ? ex_src : intr_src;

  assign csr_pr_if.mstatus_rup = ex_int_if.intr;

  always_comb begin
    if (ex_int_if.intr) begin
      csr_pr_if.mstatus_next.ie = 1'b0; 
    end else if (ex_int_if.ret) begin
      csr_pr_if.mstatus_next.ie = 1'b1;
    end
    else begin
      csr_pr_if.mstatus_next.ie = csr_pr_if.mstatus.ie;
    end
  end

  assign csr_pr_if.mepc_rup = ex_int_if.intr;
  assign csr_pr_if.mepc_next = (exception & (ex_int_if.breakpoint | ex_int_if.env_m)) ? ex_int_if.curr_epc_p4 : ex_int_if.curr_epc;

  assign csr_pr_if.mbadaddr_rup = (ex_int_if.mal_l | ex_int_if.fault_l | ex_int_if.mal_s | ex_int_if.fault_s | 
                                    ex_int_if.illegal_insn | ex_int_if.fault_insn | ex_int_if.mal_insn);
endmodule
