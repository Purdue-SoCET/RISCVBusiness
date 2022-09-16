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
*   Filename:     priv_1_11_control.sv
*
*   Created by:   Jacob R. Stevens
*   Email:        steven69@purdue.edu
*   Date Created: 08/13/2019
*   Description:  Main control for the priv isa block version 1.11
*/

`include "priv_1_11_internal_if.vh"

module priv_1_11_control (
    input CLK,
    nRST,
    priv_1_11_internal_if.prv_control prv_intern_if
);
    import rv32i_types_pkg::*;
    import machine_mode_types_1_11_pkg::*;

    ex_code_t ex_src;
    logic exception;

    int_code_t intr_src;
    logic interrupt, clear_interrupt;
    logic interrupt_reg, interrupt_fired, update_mie;

    always_comb begin  // determine the source of the interrupt to be stored in the mcause register
        interrupt = 1'b1;
        intr_src  = SOFT_INT_M;

        if (prv_intern_if.ext_int_m) begin
            intr_src = EXT_INT_M;
        end else if (prv_intern_if.soft_int_m) begin
            intr_src = SOFT_INT_M;
        end else if (prv_intern_if.timer_int_m) begin
            intr_src = TIMER_INT_M;
        end else if (prv_intern_if.ext_int_s) begin
            intr_src = EXT_INT_S;
        end else if (prv_intern_if.soft_int_s) begin
            intr_src = SOFT_INT_S;
        end else if (prv_intern_if.timer_int_s) begin
            intr_src = TIMER_INT_S;
        end else if (prv_intern_if.ext_int_u) begin
            intr_src = EXT_INT_U;
        end else if (prv_intern_if.soft_int_u) begin
            intr_src = SOFT_INT_U;
        end else if (prv_intern_if.timer_int_u) begin
            intr_src = TIMER_INT_U;
        end else interrupt = 1'b0;
    end

    assign clear_interrupt = (prv_intern_if.clear_timer_int_m || prv_intern_if.clear_soft_int_m || prv_intern_if.clear_ext_int_m || prv_intern_if.clear_timer_int_u || prv_intern_if.clear_soft_int_u || prv_intern_if.clear_ext_int_u || prv_intern_if.clear_timer_int_s || prv_intern_if.clear_soft_int_s || prv_intern_if.clear_ext_int_s);

    assign prv_intern_if.mip_rup = interrupt || clear_interrupt;

    always_comb begin  // modify the pending status register
        prv_intern_if.mip_next = prv_intern_if.mip;

        if (prv_intern_if.ext_int_m) prv_intern_if.mip_next.meip = 1'b1;
        else if (prv_intern_if.clear_ext_int_m) prv_intern_if.mip_next.meip = 1'b0;
        else if (prv_intern_if.soft_int_m) prv_intern_if.mip_next.msip = 1'b1;
        else if (prv_intern_if.clear_soft_int_m) prv_intern_if.mip_next.msip = 1'b0;
        else if (prv_intern_if.timer_int_m) prv_intern_if.mip_next.mtip = 1'b1;
        else if (prv_intern_if.clear_timer_int_m) prv_intern_if.mip_next.mtip = 1'b0;
        else if (prv_intern_if.ext_int_s) prv_intern_if.mip_next.seip = 1'b1;
        else if (prv_intern_if.clear_ext_int_s) prv_intern_if.mip_next.seip = 1'b0;
        else if (prv_intern_if.soft_int_s) prv_intern_if.mip_next.ssip = 1'b1;
        else if (prv_intern_if.clear_soft_int_s) prv_intern_if.mip_next.ssip = 1'b0;
        else if (prv_intern_if.timer_int_s) prv_intern_if.mip_next.stip = 1'b1;
        else if (prv_intern_if.clear_timer_int_s) prv_intern_if.mip_next.stip = 1'b0;
        else if (prv_intern_if.ext_int_u) prv_intern_if.mip_next.ueip = 1'b1;
        else if (prv_intern_if.clear_ext_int_u) prv_intern_if.mip_next.ueip = 1'b0;
        else if (prv_intern_if.soft_int_u) prv_intern_if.mip_next.usip = 1'b1;
        else if (prv_intern_if.clear_soft_int_u) prv_intern_if.mip_next.usip = 1'b0;
        else if (prv_intern_if.timer_int_u) prv_intern_if.mip_next.utip = 1'b1;
        else if (prv_intern_if.clear_timer_int_u) prv_intern_if.mip_next.utip = 1'b0;

    end

    always_comb begin // determine whether or not an exception occured, as well as the source of the exception
        exception = 1'b1;
        ex_src = INSN_MAL;

        if (prv_intern_if.breakpoint) ex_src = BREAKPOINT;
        else if (prv_intern_if.fault_insn_page) ex_src = INSN_PAGE;
        else if (prv_intern_if.fault_insn_access) ex_src = INSN_ACCESS;
        else if (prv_intern_if.illegal_insn) ex_src = ILLEGAL_INSN;
        else if (prv_intern_if.mal_insn) ex_src = INSN_MAL;
        else if (prv_intern_if.env_u) ex_src = ENV_CALL_U;
        else if (prv_intern_if.env_s) ex_src = ENV_CALL_S;
        else if (prv_intern_if.env_m) ex_src = ENV_CALL_M;
        else if (prv_intern_if.mal_s) ex_src = S_ADDR_MAL;
        else if (prv_intern_if.mal_l) ex_src = L_ADDR_MAL;
        else if (prv_intern_if.fault_store_page) ex_src = STORE_PAGE;
        else if (prv_intern_if.fault_load_page) ex_src = LOAD_PAGE;
        else if (prv_intern_if.fault_s) ex_src = S_FAULT;
        else if (prv_intern_if.fault_l) ex_src = L_FAULT;
        else if (prv_intern_if.ex_rmgmt) ex_src = ex_code_t'(prv_intern_if.ex_rmgmt_cause);
        else exception = 1'b0;
    end

    //output to pipeline control
    assign prv_intern_if.intr = exception | interrupt_reg;
    assign interrupt_fired = (prv_intern_if.mstatus.mie & ((prv_intern_if.mie.mtie & prv_intern_if.mip.mtip) |
                     (prv_intern_if.mie.msie & prv_intern_if.mip.msip) | (prv_intern_if.mie.meie & prv_intern_if.mip.meip)));

    // Register Updates on Interrupt/Exception
    assign prv_intern_if.mcause_rup = exception | interrupt;  // TODO: Change to interrupt
    assign prv_intern_if.mcause_next.interrupt = ~exception;
    assign prv_intern_if.mcause_next.cause = exception ? ex_src : intr_src;

    assign prv_intern_if.mstatus_rup = exception | prv_intern_if.intr | prv_intern_if.mret; // TODO: Change to prv_intern_if.intr

    always_comb begin
        prv_intern_if.mstatus_next.mie  = prv_intern_if.mstatus.mie;
        prv_intern_if.mstatus_next.mpie = prv_intern_if.mstatus.mpie;
        //changed from intr
        if (update_mie) begin // interrupt has truly been registered and it is time to go to the vector table
            prv_intern_if.mstatus_next.mpie = prv_intern_if.mstatus.mie; // when a trap is taken mpie is set to the current mie
            prv_intern_if.mstatus_next.mie = 1'b0; // disable the interrupt once it enters the handler

        end else if (prv_intern_if.mret) begin  // leaving the vector table
            prv_intern_if.mstatus_next.mpie = 1'b1;
            prv_intern_if.mstatus_next.mie  = prv_intern_if.mstatus.mpie;
        end
    end


    // Update EPC as soon as interrupt or exception is found
    // Note: mepc cannot update immediately, as if the processor is in an interrupt already,
    // the MEPC captured will be within the interrupt (and nested interrupts are not supported).
    // Interrupt fired notes when an interrupt is seen by the processor, i.e. when mstatus.mie is high again.
    // The signal is 2 cycles long, so the update_mie signal is used to clip it down to 1 to prevent MEPC
    // double update which results in skipping an instruction.
    assign prv_intern_if.mepc_rup = exception | (interrupt_fired & ~update_mie); // TODO: Change to interrupt
    assign prv_intern_if.mepc_next = prv_intern_if.epc;

    assign prv_intern_if.mtval_rup = (prv_intern_if.mal_l | prv_intern_if.fault_l | prv_intern_if.mal_s | prv_intern_if.fault_s |
                                  prv_intern_if.illegal_insn | prv_intern_if.fault_insn_access | prv_intern_if.mal_insn | prv_intern_if.ex_rmgmt)
                                  & prv_intern_if.pipe_clear; // TODO: May need to insert other exception signals
    assign prv_intern_if.mtval_next = prv_intern_if.mtval;

    /* Interrupt needs to be latched until pipeline cleared   */
    /* because mstatus.ie causes the irq to disappear after   */
    /* one cycle. Cannot wait to clear mstatus.ie because     */
    /* then another interrupt can fire during pipeline clear  */
    always_ff @(posedge CLK, negedge nRST) begin
        if (!nRST) interrupt_reg <= '0;
        else if (interrupt_fired) interrupt_reg <= 1'b1;
        else if (prv_intern_if.pipe_clear) interrupt_reg <= '0;
    end

    /*
   * Fix for MIE/MPIE issue. This used to be the same as 'interrupt_reg' above,
   * but the above stays high for 2+ cycles (i.e. waiting for pipe_clear).
   * This caused MPIE to update twice; the first update would set MPIE to 1,
   * and the second would cause MPIE to return to 0. Then, after an MRET,
   * MIE would not be restored since MPIE was lost. Additionally, shortening
   * interrupt_reg was not an option since pipe_clear must be asserted for the
   * PC to be inserted into the pipeline from the priv unit, so creating this
   * extra register was the cleanest solution to ensuring MPIE updates exactly
   * once.
   */
    always_ff @(posedge CLK, negedge nRST) begin
        if (!nRST) update_mie <= '0;
        else if (interrupt_fired && ~update_mie) update_mie <= 1'b1;
        else if (prv_intern_if.pipe_clear) update_mie <= '0;
        else update_mie <= '0;
    end

endmodule
