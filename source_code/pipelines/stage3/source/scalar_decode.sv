/*
*   Copyright 2023 Purdue University
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
*   Filename:     stage3_uop_stage.sv
*
*   Created by:   Fahad Aloufi
*   Email:        faloufi@purdue.edu
*   Date Created: 11/19/2023
*   Description:  uop stage in pipeline that recieves input from the IF stage and generates output to the EX stage. 
*/
//'include "stage3_types_pkg.sv"

`include "stage3_fetch_execute_if.vh"
`include "stage3_hazard_unit_if.vh"
`include "stage3_forwarding_unit_if.vh"
`include "control_unit_if.vh"
`include "component_selection_defines.vh"
`include "rv32i_reg_file_if.vh"
`include "alu_if.vh"
//`include "prv_pipeline_if.vh"
//`include "risc_mgmt_if.vh"
`include "rv32c_if.vh"

import stage3_types_pkg::*;
import rv32i_types_pkg::*;

module scalar_decode
#(
    parameter type D_TYPE = fetch_ex_t, 
    parameter DISPATCH_SIZE = 1
)
(
    input fetch_ex_t if_stage_in,
    input stall_queue, 

    output D_TYPE[DISPATCH_SIZE-1:0] s_ctrls,
    output logic[$clog2(DISPATCH_SIZE):0] s_num_uops, 

    
    
    rv32c_if.execute rv32cif
);

assign s_ctrls[0].if_out = if_stage_in; 
assign s_num_uops = s_ctrls[0].if_out.valid ? 1 : 0; 



control_unit_if cu_if ();
rv32i_reg_file_if rf_if ();


// RV32C inputs
assign rv32cif.inst16 = fetch_ex_if.fetch_ex_reg.instr[15:0];
assign rv32cif.halt = 1'b0; // TODO: Is this signal necessary? Can't get it right on decode of a halt instruction
assign rv32cif.ex_busy = stall_queue; //cu_if.dren | cu_if.dwen | rm_if.risc_mgmt_start;
assign cu_if.instr = rv32cif.c_ena ? rv32cif.inst32 : if_stage_in.instr;
//assign rm_if.insn = rv32cif.c_ena ? rv32cif.inst32 : fetch_ex_if.fetch_ex_reg.instr;

// Control unit, inputs are post-decompression
control_unit cu (
    .cu_if(cu_if),
    .rf_if(rf_if),
    .rmgmt_rsel_s_0('0),
    .rmgmt_rsel_s_1('0),
    .rmgmt_rsel_d('0),
    .rmgmt_req_reg_r('0),
    .rmgmt_req_reg_w('0)
    //.rmgmt_rsel_s_0(rm_if.rsel_s_0),
    //.rmgmt_rsel_s_1(rm_if.rsel_s_1),
    //.rmgmt_rsel_d(rm_if.rsel_d),
    //.rmgmt_req_reg_r(rm_if.req_reg_r),
    //.rmgmt_req_reg_w(rm_if.req_reg_w)
);

// connect the ports between the interfaces and the struct type
assign s_ctrls[0].ctrl_out.dwen = cu_if.dwen;
assign s_ctrls[0].ctrl_out.dren =  cu_if.dren;
assign s_ctrls[0].ctrl_out.j_sel = cu_if.j_sel; 
assign s_ctrls[0].ctrl_out.branch =  cu_if.branch; 
assign s_ctrls[0].ctrl_out.jump =  cu_if.jump;
assign s_ctrls[0].ctrl_out.ex_pc_sel =  cu_if.ex_pc_sel; 
assign s_ctrls[0].ctrl_out.imm_shamt_sel = cu_if.imm_shamt_sel;
assign s_ctrls[0].ctrl_out.halt = cu_if.halt;
assign s_ctrls[0].ctrl_out.wen =  cu_if.wen; 
assign s_ctrls[0].ctrl_out.ifence =  cu_if.ifence;
assign s_ctrls[0].ctrl_out.wfi =  cu_if.wfi;

assign s_ctrls[0].ctrl_out.alu_op = cu_if.alu_op;
assign s_ctrls[0].ctrl_out.alu_a_sel =  cu_if.alu_a_sel;
assign s_ctrls[0].ctrl_out.alu_b_sel = cu_if.alu_b_sel;
assign s_ctrls[0].ctrl_out.w_sel =  cu_if.w_sel;
assign s_ctrls[0].ctrl_out.shamt =  cu_if.shamt;
assign s_ctrls[0].ctrl_out.rd =  cu_if.rd;
assign s_ctrls[0].ctrl_out.imm_I = cu_if.imm_I;
assign s_ctrls[0].ctrl_out.imm_S = cu_if.imm_S;
assign s_ctrls[0].ctrl_out.imm_UJ =  cu_if.imm_UJ;
assign s_ctrls[0].ctrl_out.imm_SB =  cu_if.imm_SB;
// word_t instr;
assign s_ctrls[0].ctrl_out.imm_U = cu_if.imm_U;
assign s_ctrls[0].ctrl_out.load_type = cu_if.load_type;
assign s_ctrls[0].ctrl_out.branch_type = cu_if.branch_type;
assign s_ctrls[0].ctrl_out.opcode =  cu_if.opcode;

// Privilege ctrl signals
assign s_ctrls[0].ctrl_out.fault_insn = cu_if.fault_insn;
assign s_ctrls[0].ctrl_out.illegal_insn = cu_if.illegal_insn;
assign s_ctrls[0].ctrl_out.ret_insn = cu_if.ret_insn;
assign s_ctrls[0].ctrl_out.breakpoint = cu_if.breakpoint; 
assign s_ctrls[0].ctrl_out.ecall_insn = cu_if.ecall_insn;
assign s_ctrls[0].ctrl_out.csr_swap = cu_if.csr_swap;
assign s_ctrls[0].ctrl_out.csr_set = cu_if.csr_set;
assign s_ctrls[0].ctrl_out.csr_clr = cu_if.csr_clr;
assign s_ctrls[0].ctrl_out.csr_imm = cu_if.csr_imm;
assign s_ctrls[0].ctrl_out.csr_rw_valid = cu_if.csr_rw_valid;
assign s_ctrls[0].ctrl_out.csr_addr = cu_if.csr_addr;
assign s_ctrls[0].ctrl_out.zimm = cu_if.zimm;

// Extension ctrl signals
assign s_ctrls[0].ctrl_out.rv32m_control = cu_if.rv32m_control;


// RF interface signasl
assign s_ctrls[0].ctrl_out.rs1 = rf_if.rs1; 
assign s_ctrls[0].ctrl_out.rs2 = rf_if.rs2; 



endmodule 
