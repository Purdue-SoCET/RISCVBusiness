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
*   Filename:     tspp_hazard_unit.sv
*
*   Created by:   Jacob R. Stevens
*   Email:        steven69@purdue.edu
*   Date Created: 06/14/2016
*   Description:  Hazard unit that controls the flushing and stalling of
*                 the stages of the Two Stage Pipeline
*/

`include "tspp_hazard_unit_if.vh"
`include "prv_pipeline_if.vh"
`include "risc_mgmt_if.vh"

module tspp_hazard_unit (
    tspp_hazard_unit_if.hazard_unit hazard_if,
    prv_pipeline_if.hazard prv_pipe_if,
    risc_mgmt_if.ts_hazard rm_if,
    sparce_pipeline_if.hazard sparce_if
);
    import alu_types_pkg::*;
    import rv32i_types_pkg::*;

    // Pipeline hazard signals
    logic dmem_access;
    logic branch_jump;
    logic wait_for_imem;
    logic wait_for_dmem;

    // IRQ/Exception hazard signals
    logic ex_flush_hazard;
    logic e_ex_stage;
    logic e_f_stage;
    logic intr;

    logic rmgmt_stall;

    assign rm_if.if_ex_enable = ~hazard_if.if_ex_stall;
    assign rmgmt_stall = rm_if.memory_stall | rm_if.execute_stall;

    assign dmem_access = (hazard_if.dren || hazard_if.dwen);
    assign branch_jump = hazard_if.jump || (hazard_if.branch && hazard_if.mispredict);
    assign wait_for_imem = hazard_if.iren & hazard_if.i_mem_busy;
    assign wait_for_dmem = dmem_access & hazard_if.d_mem_busy;

    assign hazard_if.npc_sel = branch_jump;

    assign hazard_if.pc_en = (~wait_for_dmem&~wait_for_imem&~hazard_if.halt&~ex_flush_hazard&~rmgmt_stall&~hazard_if.fence_stall) |
                            branch_jump | prv_pipe_if.insert_pc | prv_pipe_if.ret;

    assign hazard_if.if_ex_flush = ex_flush_hazard | branch_jump |
                                 (wait_for_imem & dmem_access &
                                    ~hazard_if.d_mem_busy);

    assign hazard_if.if_ex_stall = (wait_for_dmem ||
                                 (wait_for_imem & ~dmem_access) ||
                                 hazard_if.halt) & (~ex_flush_hazard | e_ex_stage) ||
                                 hazard_if.fence_stall ||
                                 rm_if.execute_stall;

    /* Hazards due to Interrupts/Exceptions */
    assign prv_pipe_if.ret = hazard_if.ret;
    assign e_ex_stage = hazard_if.illegal_insn | hazard_if.fault_l | hazard_if.mal_l |
                      hazard_if.fault_s | hazard_if.mal_s | hazard_if.breakpoint |
                      hazard_if.env_m;
    assign e_f_stage = hazard_if.fault_insn | hazard_if.mal_insn;
    assign intr = ~e_ex_stage & ~e_f_stage & prv_pipe_if.intr;

    assign prv_pipe_if.pipe_clear = e_ex_stage | ~(hazard_if.token_ex | rm_if.active_insn);
    assign ex_flush_hazard = ((intr | e_f_stage) & ~wait_for_dmem) | e_ex_stage | prv_pipe_if.ret;

    assign hazard_if.insert_priv_pc = prv_pipe_if.insert_pc;
    assign hazard_if.priv_pc = prv_pipe_if.priv_pc;

    assign hazard_if.iren = !intr;  // prevents a false instruction request from being sent

    /* Send Exception notifications to Prv Block */

    assign prv_pipe_if.wb_enable    = !hazard_if.if_ex_stall |
                                    hazard_if.jump |
                                    hazard_if.branch; //Because 2 stages
    assign prv_pipe_if.fault_insn = hazard_if.fault_insn;
    assign prv_pipe_if.mal_insn = hazard_if.mal_insn;
    assign prv_pipe_if.illegal_insn = hazard_if.illegal_insn;
    assign prv_pipe_if.fault_l = hazard_if.fault_l;
    assign prv_pipe_if.mal_l = hazard_if.mal_l;
    assign prv_pipe_if.fault_s = hazard_if.fault_s;
    assign prv_pipe_if.mal_s = hazard_if.mal_s;
    assign prv_pipe_if.breakpoint = hazard_if.breakpoint;
    assign prv_pipe_if.env_m = hazard_if.env_m;
    assign prv_pipe_if.ex_rmgmt = rm_if.exception;

    assign prv_pipe_if.ex_rmgmt_cause = rm_if.ex_cause;
    assign prv_pipe_if.epc = (e_ex_stage | rm_if.exception) ? hazard_if.epc_e : hazard_if.epc_f;
    assign prv_pipe_if.badaddr = (hazard_if.mal_insn | hazard_if.fault_insn) ? hazard_if.badaddr_f :
                              (rm_if.exception ? rm_if.mem_addr : hazard_if.badaddr_e);

    /*********************************************************
  *** SparCE Module Logic
  *********************************************************/
    assign sparce_if.if_ex_enable = rm_if.if_ex_enable;

endmodule
