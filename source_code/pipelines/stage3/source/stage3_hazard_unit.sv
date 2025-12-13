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
*   Filename:     stage3_hazard_unit.sv
*
*   Created by:   Jacob R. Stevens
*   Email:        steven69@purdue.edu
*   Date Created: 06/14/2016
*   Description:  Hazard unit that controls the flushing and stalling of
*                 the stages of the Two Stage Pipeline
*/

`include "stage3_hazard_unit_if.vh"
`include "prv_pipeline_if.vh"

module stage3_hazard_unit (
    stage3_hazard_unit_if.hazard_unit hazard_if,
    prv_pipeline_if.hazard prv_pipe_if
);
    import alu_types_pkg::*;
    import rv32i_types_pkg::*;

    // Pipeline hazard signals
    logic dmem_access;
    logic branch_jump;
    logic wait_for_imem;
    logic wait_for_dmem;
    logic rs1_match;
    logic rs2_match;
    logic cannot_forward;
    logic fetch_busy;
    logic execute_busy;
    logic mem_busy;

    // IRQ/Exception hazard signals
    logic ex_flush_hazard;
    logic exception;
    logic intr;
    word_t epc;

    // Hazard detection
    assign rs1_match = (hazard_if.rs1_e == hazard_if.rd_m) && (hazard_if.rd_m != 0);
    assign rs2_match  = (hazard_if.rs2_e == hazard_if.rd_m) && (hazard_if.rd_m != 0);
    assign cannot_forward = (hazard_if.dren || (hazard_if.dwen && hazard_if.reserve) || hazard_if.csr_read); // cannot forward outputs generated in mem stage

    assign dmem_access = (hazard_if.dren || hazard_if.dwen);
    assign branch_jump = hazard_if.jump || (hazard_if.branch && hazard_if.mispredict);
    assign wait_for_imem = hazard_if.iren && hazard_if.i_mem_busy && !hazard_if.suppress_iren;
    assign wait_for_dmem = dmem_access && hazard_if.d_mem_busy && !hazard_if.suppress_data;
    assign hazard_if.mem_use_stall = hazard_if.reg_write && cannot_forward && (rs1_match || rs2_match);

    assign hazard_if.npc_sel = branch_jump;



    /* Hazards due to Interrupts/Exceptions */
    assign prv_pipe_if.mret = hazard_if.mret;
    assign prv_pipe_if.sret = hazard_if.sret;
    assign exception  = hazard_if.fault_insn | hazard_if.mal_insn // | prv_pipe_if.prot_fault_i
                      | hazard_if.illegal_insn | hazard_if.fault_l | hazard_if.mal_l
                      | hazard_if.fault_s | hazard_if.mal_s | hazard_if.breakpoint
                      | hazard_if.env | prv_pipe_if.prot_fault_l | prv_pipe_if.prot_fault_s
                      | prv_pipe_if.fault_insn_page | prv_pipe_if.fault_load_page
                      | prv_pipe_if.fault_store_page;

    assign intr = ~exception & prv_pipe_if.intr;

    assign prv_pipe_if.pipe_clear = 1'b1; // TODO: What is this for?//exception; //| ~(hazard_if.token_ex | rm_if.active_insn);
    assign ex_flush_hazard = ((intr || exception) && !wait_for_dmem) || exception || prv_pipe_if.mret || prv_pipe_if.sret || (hazard_if.ifence && !hazard_if.fence_stall) || (hazard_if.sfence && !hazard_if.fence_stall); // I-fence must flush to force re-fetch of in-flight instructions. Flush will happen after stallling for cache response.

    assign hazard_if.insert_priv_pc = prv_pipe_if.insert_pc;
    assign hazard_if.priv_pc = prv_pipe_if.priv_pc;

    assign hazard_if.iren = 1'b1;
    // TODO: Removed intr as cause of suppression -- is this OK?
    //assign hazard_if.suppress_iren = branch_jump || exception || prv_pipe_if.ret || prv_pipe_if.insert_pc;  // prevents a false instruction request from being sent when pipeline flush imminent
    assign hazard_if.suppress_iren = branch_jump || ex_flush_hazard || prv_pipe_if.mret || prv_pipe_if.sret || prv_pipe_if.insert_pc;  // prevents a false instruction request from being sent when pipeline flush imminent
    assign hazard_if.suppress_data = exception; // suppress data transfer on interrupt/exception. Exception case: prevent read/write of faulting location. Interrupt: make symmetric with exceptions for ease

    assign hazard_if.rollback = (hazard_if.ifence && !hazard_if.fence_stall) || (hazard_if.sfence && !hazard_if.fence_stall); // TODO: more cases for CSRs that affect I-fetch (PMA/PMP registers)

    // EPC priority logic
    assign epc = hazard_if.valid_m && (!intr || branch_jump) ? hazard_if.pc_m :
                (hazard_if.valid_e ? hazard_if.pc_e : hazard_if.pc_f);

    /* Send Exception notifications to Prv Block */
    // TODO: Correct execution of exceptions
    assign prv_pipe_if.wb_enable = !hazard_if.if_ex_stall |
                                    hazard_if.jump |
                                    hazard_if.branch; //Because 2 stages

    assign prv_pipe_if.fault_insn = ~branch_jump & hazard_if.fault_insn;// | prv_pipe_if.prot_fault_i;
    assign prv_pipe_if.mal_insn = ~branch_jump & hazard_if.mal_insn;
    assign prv_pipe_if.illegal_insn = hazard_if.illegal_insn;
    assign prv_pipe_if.fault_l = hazard_if.fault_l | prv_pipe_if.prot_fault_l;
    assign prv_pipe_if.mal_l = hazard_if.mal_l;
    assign prv_pipe_if.fault_s = hazard_if.fault_s | prv_pipe_if.prot_fault_s;
    assign prv_pipe_if.mal_s = hazard_if.mal_s;
    assign prv_pipe_if.breakpoint = hazard_if.breakpoint;
    assign prv_pipe_if.env = hazard_if.env;
    assign prv_pipe_if.wfi = hazard_if.wfi;
    assign prv_pipe_if.ex_mem_stall = hazard_if.ex_mem_stall;
    assign prv_pipe_if.fault_insn_page = ~branch_jump & hazard_if.fault_insn_page;
    assign prv_pipe_if.fault_load_page = hazard_if.fault_load_page;
    assign prv_pipe_if.fault_store_page = hazard_if.fault_store_page;

    assign prv_pipe_if.epc = epc;
    assign prv_pipe_if.badaddr = hazard_if.fault_addr;


    /*
    * Pipeline control signals
    *
    * Control hazard (Exception, Jump, Mispredict): F/E -> Flush, E/M -> Flush
    *     - Special case: interrupt. Async, don't know where the oldest insn is. Interrupts must assume the memory op will go through, so flush only I/F
    * Data hazard (unforwardable, load/CSR read): F/E -> Stall, E/M -> Flush
    * Waiting (i.e. slow dmem access, fence, etc.):
    *     - If fetch stage slow, flush if_ex so in-flight instructions may finish (insert bubbles)
    *     - If ex stage slow, flush ex_mem so in-flight instruction may finish (insert bubbles). Stall if_ex
    *     - If mem stage slow, stall everyone
    *     - Halt - stall everyone
    * Note: Stall of later stage implies stall of earlier stage.
    * PC should not update if:
    *   - fetch_if is stalling (can't pass instruction on)
    * PC should update if:
    *   - fetch is not stalling
    *   - there is a forced redirect
    */

    // Unforunately, pc_en is negative logic of stalling
    assign hazard_if.pc_en = (!hazard_if.if_ex_stall && !wait_for_imem) // Normal case: next stage free, not waiting for instruction
                            || branch_jump
                            || ex_flush_hazard
                            || prv_pipe_if.insert_pc
                            || prv_pipe_if.mret
                            || prv_pipe_if.sret;//) //&& !wait_for_imem;

    assign hazard_if.if_ex_flush  = ex_flush_hazard // control hazard
                                  || branch_jump    // control hazard
                                  || (wait_for_imem && !hazard_if.ex_mem_stall); // Flush if fetch stage lagging, but ex/mem are moving

    assign hazard_if.ex_mem_flush = ex_flush_hazard // Control hazard
                                  || branch_jump     // Control hazard
                                  //|| (mem_use_stall && !hazard_if.d_mem_busy) // Data hazard -- flush once data memory is no longer busy (request complete)
                                  || (hazard_if.if_ex_stall && !hazard_if.ex_mem_stall); // if_ex_stall covers mem_use stall condition


  assign hazard_if.if_ex_stall  = !intr && (hazard_if.ex_mem_stall // Stall this stage if next stage is stalled
                                  // || (wait_for_imem && !dmem_access) // ???
                                  //& (~ex_flush_hazard | e_ex_stage) // ???
                                  //|| rm_if.execute_stall //
                                  || (hazard_if.ex_busy && !ex_flush_hazard && !branch_jump) // Ugly case -- need to flush for control hazards when X busy, but other cases require stalling to take priority to prevent data loss (e.g. slow instruction fetch, valid insn in X, load in M --> giving flush priority would destroy insn in X)
                                  || hazard_if.mem_use_stall 
                                  || hazard_if.fence_stall); // Data hazard -- stall until dependency clears (from E/M flush after writeback)
     // TODO: Exceptions
    assign hazard_if.ex_mem_stall = wait_for_dmem // Second clause ensures we finish memory op on interrupt condition
                                  || hazard_if.fence_stall
                                  || hazard_if.halt;
                                  //|| branch_jump && wait_for_imem; // This can be removed once there is I$. Solves problem where
                                                                   // stale I-request returns after PC is redirected
    // TODO: Enforce mutual exclusivity of these signals with assertion
endmodule
