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
*   Filename:     priv_1_12_int_ex_handler.sv
*
*   Created by:   Hadi Ahmed
*   Email:        ahmed138@purdue.edu
*   Date Created: 09/27/2022
*   Description:  Main interrupt and exception handler block
*/

`include "priv_1_12_internal_if.vh"

module priv_1_12_int_ex_handler (
    input CLK, nRST,
    priv_1_12_internal_if.int_ex_handler prv_intern_if
);

    import machine_mode_types_1_12_pkg::*;
    import rv32i_types_pkg::*;

    ex_code_t ex_src;
    logic exception;

    int_code_t int_src;
    logic interrupt, clear_interrupt;
    // NOTE see the bottom for why these signals exist
    logic interrupt_reg, interrupt_fired, update_mie;

    // Determine the source of the interrupt
    always_comb begin
        interrupt = 1'b1;
        int_src = SOFT_INT_S;

        if (prv_intern_if.ext_int_m) begin
            int_src = EXT_INT_M;
        end
        else if (prv_intern_if.soft_int_m) begin
            int_src = SOFT_INT_M;
        end
        else if (prv_intern_if.timer_int_m) begin
            int_src = TIMER_INT_M;
        end
        else if (prv_intern_if.ext_int_s) begin
            int_src = EXT_INT_S;
        end
        else if (prv_intern_if.soft_int_s) begin
            int_src = SOFT_INT_S;
        end
        else if (prv_intern_if.timer_int_s) begin
            int_src = TIMER_INT_S;
        end
        else begin
            interrupt = 1'b0;
        end
    end

    assign clear_interrupt = (prv_intern_if.clear_timer_int_m | prv_intern_if.clear_soft_int_m
                             | prv_intern_if.clear_ext_int_m  | prv_intern_if.clear_timer_int_s
                             | prv_intern_if.clear_soft_int_s | prv_intern_if.clear_ext_int_s);

    // Determine whether an exception occured
    always_comb begin
        exception = 1'b1;
        ex_src = INSN_MAL;

        if (prv_intern_if.breakpoint)
            ex_src = BREAKPOINT;
        else if (prv_intern_if.fault_insn_page)
            ex_src = INSN_PAGE;
        else if (prv_intern_if.fault_insn_access)
            ex_src = INSN_ACCESS;
        else if (prv_intern_if.illegal_insn)
            ex_src = ILLEGAL_INSN;
        else if (prv_intern_if.mal_insn)
            ex_src = INSN_MAL;
        else if (prv_intern_if.env_u)
            ex_src = ENV_CALL_U;
        else if (prv_intern_if.env_s)
            ex_src = ENV_CALL_S;
        else if (prv_intern_if.env_m)
            ex_src = ENV_CALL_M;
        else if (prv_intern_if.mal_s)
            ex_src = S_ADDR_MAL;
        else if (prv_intern_if.mal_l)
            ex_src = L_ADDR_MAL;
        else if (prv_intern_if.fault_store_page)
            ex_src = STORE_PAGE;
        else if (prv_intern_if.fault_load_page)
            ex_src = LOAD_PAGE;
        else if (prv_intern_if.fault_s)
            ex_src = S_FAULT;
        else if (prv_intern_if.fault_l)
            ex_src = L_FAULT;
        else if (prv_intern_if.ex_rmgmt)
            ex_src = ex_code_t'(prv_intern_if.ex_rmgmt_cause);
        else
            exception = 1'b0;
    end

    // Output info to pipe_ctrl
    assign prv_intern_if.intr = exception | interrupt_reg;
    assign interrupt_fired = (prv_intern_if.curr_mstatus.mie &
                                ((prv_intern_if.curr_mie.mtie & prv_intern_if.curr_mip.mtip)
                                    | (prv_intern_if.curr_mie.msie & prv_intern_if.curr_mip.msip)
                                    | (prv_intern_if.curr_mie.meie & prv_intern_if.curr_mip.meip)));

    // Register updates on Interrupts/Exceptions
    /* NOTE a lot of the below code are patterns that exist to solve issues
        on the 2 stage pipeline. This should be reimagined if we change pipelines.
        Most of this is copied verbatim from the priv 1.11 unit */
    assign prv_intern_if.inject_mcause = exception | interrupt;
    assign prv_intern_if.next_mcause.interrupt = ~exception;
    assign prv_intern_if.next_mcause.cause = exception ? ex_src : int_src;

    assign prv_intern_if.inject_mip = interrupt | clear_interrupt;
    always_comb begin
        prv_intern_if.next_mip = prv_intern_if.curr_mip;

        if (prv_intern_if.ext_int_m) prv_intern_if.next_mip.meip = 1'b1;
        else if (prv_intern_if.clear_ext_int_m) prv_intern_if.next_mip.meip = 1'b0;

        if (prv_intern_if.soft_int_m) prv_intern_if.next_mip.msip = 1'b1;
        else if (prv_intern_if.clear_soft_int_m) prv_intern_if.next_mip.msip = 1'b0;

        if (prv_intern_if.timer_int_m) prv_intern_if.next_mip.mtip = 1'b1;
        else if (prv_intern_if.clear_timer_int_m) prv_intern_if.next_mip.mtip = 1'b0;

        if (prv_intern_if.ext_int_s) prv_intern_if.next_mip.seip = 1'b1;
        else if (prv_intern_if.clear_ext_int_s) prv_intern_if.next_mip.seip = 1'b0;

        if (prv_intern_if.soft_int_s) prv_intern_if.next_mip.ssip = 1'b1;
        else if (prv_intern_if.clear_soft_int_s) prv_intern_if.next_mip.ssip = 1'b0;

        if (prv_intern_if.timer_int_s) prv_intern_if.next_mip.stip = 1'b1;
        else if (prv_intern_if.clear_timer_int_s) prv_intern_if.next_mip.stip = 1'b0;
    end

    assign prv_intern_if.inject_mstatus = exception | prv_intern_if.intr | prv_intern_if.mret;

    always_comb begin
        prv_intern_if.next_mstatus = prv_intern_if.curr_mstatus;
        // interrupt has truly been registered and it is time to go to the vector table
        if (update_mie | exception) begin
            // when a trap is taken mpie is set to the current mie
            prv_intern_if.next_mstatus.mpie = prv_intern_if.curr_mstatus.mie;
            prv_intern_if.next_mstatus.mie = 1'b0;
        end else if (prv_intern_if.mret) begin
            prv_intern_if.next_mstatus.mpie = 1'b0; // leaving the vector table
            prv_intern_if.next_mstatus.mie = prv_intern_if.curr_mstatus.mpie;
        end

        // We need to change mstatus bits for mode changes
        if (prv_intern_if.intr) begin // If we are receiving an exception or interrupt
            prv_intern_if.next_mstatus.mpp = prv_intern_if.curr_privilege_level;
        end else if (prv_intern_if.mret) begin // If we are going back from a trap
            prv_intern_if.next_mstatus.mpp = U_MODE; // We must set mpp to the least privileged mode possible
            if (prv_intern_if.curr_mstatus.mpp != M_MODE) begin
                prv_intern_if.next_mstatus.mprv = 1'b0;
            end
        end
    end

    // Update EPC as soon as interrupt or exception is found
    // Note: mepc cannot update immediately, as if the processor is in an interrupt already,
    // the MEPC captured will be within the interrupt (and nested interrupts are not supported).
    // Interrupt fired notes when an interrupt is seen by the processor, i.e. when mstatus.mie is high again.
    // The signal is 2 cycles long, so the update_mie signal is used to clip it down to 1 to prevent MEPC
    // double update which results in skipping an instruction.
    // TODO: Change to interrupt
    assign prv_intern_if.inject_mepc = exception | (interrupt_fired & ~update_mie);
    assign prv_intern_if.next_mepc = prv_intern_if.epc;

    // TODO: May need to insert other exception signals
    assign prv_intern_if.inject_mtval = (prv_intern_if.mal_l | prv_intern_if.fault_l
                                        | prv_intern_if.mal_s | prv_intern_if.fault_s
                                        | prv_intern_if.illegal_insn
                                        | prv_intern_if.fault_insn_access
                                        | prv_intern_if.mal_insn | prv_intern_if.ex_rmgmt)
                                            & prv_intern_if.pipe_clear;
    assign prv_intern_if.next_mtval = prv_intern_if.curr_mtval;

    /* Interrupt needs to be latched until pipeline cleared   */
    /* because mstatus.ie causes the irq to disappear after   */
    /* one cycle. Cannot wait to clear mstatus.ie because     */
    /* then another interrupt can fire during pipeline clear  */
    always_ff @ (posedge CLK, negedge nRST) begin
        if (!nRST)
            interrupt_reg <= '0;
        else if (interrupt_fired)
            interrupt_reg <= 1'b1;
        else if (prv_intern_if.pipe_clear)
            interrupt_reg <= '0;
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
        if(!nRST)
            update_mie <= '0;
        else if(interrupt_fired && ~update_mie)
            update_mie <= 1'b1;
        else if (prv_intern_if.pipe_clear)
            update_mie <= '0;
        else
            update_mie <= '0;
    end

endmodule
