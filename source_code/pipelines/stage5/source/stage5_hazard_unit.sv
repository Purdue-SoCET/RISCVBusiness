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
*   Filename:     stage5_hazard_unit.sv
*
*   Created by:   William Cunningham
*   Email:        wrcunnin@purdue.edu
*   Date Created: 01/26/2026
*   Description:  Hazard unit that controls the flushing and stalling of
*                 the stages of the Five Stage Pipeline
*/

`include "stage5_hazard_unit_if.vh"
`include "prv_pipeline_if.vh"

module stage5_hazard_unit (
    stage5_hazard_unit_if.hazard_unit hazard_if,
    prv_pipeline_if.hazard prv_pipe_if
);
    import alu_types_pkg::*;
    import rv32i_types_pkg::*;

    // Pipeline hazard signals
    logic dmem_access;
    logic branch_jump;
    logic wait_for_imem;
    logic wait_for_dmem;
    logic rs1_match_dm, rs2_match_dm;
    logic rs1_match_de, rs2_match_de;
    logic rs_match_dm, rs_match_de;
    logic cannot_forward_e, cannot_forward_m;
    logic mem_use_stall_de, mem_use_stall_dm;
    logic fetch_busy;
    logic execute_busy;
    logic mem_busy;

    // IRQ/Exception hazard signals
    logic ex_flush_hazard;
    logic exception;
    logic intr;
    word_t epc;

    // Hazard detection
    assign rs1_match_dm = (hazard_if.rs1_d == hazard_if.rd_m) && (hazard_if.rd_m != 0);
    assign rs2_match_dm = (hazard_if.rs2_d == hazard_if.rd_m) && (hazard_if.rd_m != 0);
    assign rs1_match_de = (hazard_if.rs1_d == hazard_if.rd_e) && (hazard_if.rd_e != 0);
    assign rs2_match_de = (hazard_if.rs2_d == hazard_if.rd_e) && (hazard_if.rd_e != 0);
    assign rs_match_dm = rs1_match_dm || rs2_match_dm;
    assign rs_match_de = rs1_match_de || rs2_match_de;

    assign dmem_access = (hazard_if.dren || hazard_if.dwen);
    assign branch_jump = (hazard_if.jump || hazard_if.branch) && hazard_if.mispredict;
    assign wait_for_imem = hazard_if.iren && hazard_if.i_mem_busy && !hazard_if.suppress_iren;
    assign wait_for_dmem = dmem_access && hazard_if.d_mem_busy && !hazard_if.suppress_data;
    assign mem_use_stall_de = (hazard_if.reg_write_e && hazard_if.cannot_forward_e && rs_match_de);
    assign mem_use_stall_dm = (hazard_if.reg_write_m && hazard_if.cannot_forward_m && rs_match_dm);
    assign hazard_if.mem_use_stall =  mem_use_stall_de || mem_use_stall_dm;

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

    assign prv_pipe_if.pipe_clear = 1'b1; // TODO: What is this for?

    // I-fence must flush to force re-fetch of in-flight instructions.
    // Flush will happen after stalling for cache response.
     // TODO: more cases for CSRs that affect I-fetch (PMA/PMP registers)
    assign hazard_if.rollback = (hazard_if.ifence || hazard_if.sfence) && !hazard_if.fence_stall;
    assign ex_flush_hazard = ((intr || exception) && !wait_for_dmem)
                          || exception
                          || prv_pipe_if.mret
                          || prv_pipe_if.sret
                          || hazard_if.rollback;

    assign hazard_if.insert_priv_pc = prv_pipe_if.insert_pc;
    assign hazard_if.priv_pc = prv_pipe_if.priv_pc;

    assign hazard_if.iren = 1'b1;
    // prevents a false instruction request from being sent when pipeline flush imminent
    // TODO: Removed intr as cause of suppression -- is this OK?
    assign hazard_if.suppress_iren = branch_jump
                                  || ex_flush_hazard
                                  || prv_pipe_if.insert_pc;
    assign hazard_if.suppress_data = exception; // suppress data transfer on interrupt/exception. Exception case: prevent read/write of faulting location. Interrupt: make symmetric with exceptions for ease


    // EPC priority logic
    assign epc = hazard_if.valid_m && (!intr || branch_jump) ? hazard_if.pc_m :
                (hazard_if.valid_e ? hazard_if.pc_e : hazard_if.pc_f);

    /* Send Exception notifications to Prv Block */
    // TODO: Correct execution of exceptions
    // TODO(wrcunnin): what the fuck?
    assign prv_pipe_if.wb_enable = !hazard_if.dc_ex_stall
                                 | hazard_if.jump
                                 | hazard_if.branch; //Because 2 stages

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
    assign prv_pipe_if.sfence = hazard_if.sfence;

    // When imem is waiting, we're stalling in only the fetch stage
    assign prv_pipe_if.fetch_stall = wait_for_imem;

    // Should be the only case where execute is busy & we're doing something useful
    assign prv_pipe_if.ex_stall = (hazard_if.ex_busy && !ex_flush_hazard && !branch_jump);

    // When dmem is waiting, flushing, or if halted
    assign prv_pipe_if.mem_stall = hazard_if.ex_mem_stall;

    // branch prediction signals
    assign prv_pipe_if.bp_update = hazard_if.update_predictor;
    assign prv_pipe_if.bp_mispredict = hazard_if.mispredict;

    // page fault exceptions
    assign prv_pipe_if.fault_insn_page = ~branch_jump & hazard_if.fault_insn_page;
    assign prv_pipe_if.fault_load_page = hazard_if.fault_load_page;
    assign prv_pipe_if.fault_store_page = hazard_if.fault_store_page;

    assign prv_pipe_if.epc = epc;
    assign prv_pipe_if.badaddr = hazard_if.fault_addr;


    /*
    * Pipeline control signals
    *
    * Control hazard (Exception/Interrupt, Jump, Mispredict): F/D -> Flush, D/E -> Flush, E/M -> Flush
    * Data hazard (unforwardable, load/CSR read):
    *   - in D to E: F/D -> Stall, D/E -> Flush
    *   - in D to M: F/D -> Stall, D/E -> Flush
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
    assign hazard_if.pc_en = (!hazard_if.if_dc_stall && !wait_for_imem) // Normal case: next stage free, not waiting for instruction
                            || branch_jump
                            || ex_flush_hazard
                            || prv_pipe_if.insert_pc
                            || prv_pipe_if.mret
                            || prv_pipe_if.sret;

    // Fetch/Decode Flush on:
    // - exception/interrupt
    // - Mispredicted Branch/Jump
    // - Fetch lagging, but decode not
    assign hazard_if.if_dc_flush = exception || intr
                                || branch_jump
                                || (wait_for_imem && !hazard_if.dc_ex_stall)
                                || ex_flush_hazard;

    // Decode/Execute Flush on:
    // - exception/interrupt
    // - Mispredicted Branch/Jump
    // - Load-Use hazard & the match is not in the excute stage
    assign hazard_if.dc_ex_flush = exception || intr
                                || branch_jump
                                || hazard_if.mem_use_stall
                                || ex_flush_hazard;

    // Execute/Memory Flush on:
    // - exeception/interrupt
    // - Ex/Mem stage is no longer stalled, but Dc/Ex is
    // - or we need to immediately flush the mem stage.
    assign hazard_if.ex_mem_flush = exception || intr
                                 || branch_jump
                                 || (!hazard_if.ex_mem_stall & hazard_if.dc_ex_stall)
                                 || ex_flush_hazard;

    // Fetch/Decode Stall
    // Should only stall if there is an interrupt and Decode/Execute is stalled
    assign hazard_if.if_dc_stall = !intr && (hazard_if.dc_ex_stall)
                                || hazard_if.mem_use_stall && !ex_flush_hazard && !branch_jump;

    // Decode/Execute Stall
    // Should only stall if Execute/Memory is stalled
    // or there is a Load-Use condition
    // or need to flush for control hazards when X busy, but other cases require stalling to take priority to prevent data loss (e.g. slow instruction fetch, valid insn in X, load in M --> giving flush priority would destroy insn in X)
    assign hazard_if.dc_ex_stall = hazard_if.ex_mem_stall
                                || (hazard_if.ex_busy && !ex_flush_hazard && !branch_jump);

    // Execute/Memory Stall
    // Should only stall if Memory/Write Back is stalled
    // or we're waiting for a Load/Store to complete
    // or we're fencing caches or TLBs
    // or the execution stage is busy & we may  forwarding data, TODO: is this okay?
    assign hazard_if.ex_mem_stall = wait_for_dmem
                                 || hazard_if.halt
                                 || hazard_if.fence_stall
                                 || (hazard_if.ex_busy && !ex_flush_hazard && !branch_jump);


endmodule
