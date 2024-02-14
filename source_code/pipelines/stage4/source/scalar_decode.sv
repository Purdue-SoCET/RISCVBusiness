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
*   Filename:     scalar_decode.sv
*
*   Created by:   Fahad Aloufi
*   Email:        faloufi@purdue.edu
*   Date Created: 11/19/2023
*   Description: scalar decode block for non-vector instructions
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
( 
    input word_t instr,
    output control_t control_out
);


control_unit_if cu_if ();
rv32i_reg_file_if rf_if ();

assign cu_if.instr = instr; 

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
assign control_out.dwen = cu_if.dwen;
assign control_out.dren =  cu_if.dren;
assign control_out.j_sel = cu_if.j_sel; 
assign control_out.branch =  cu_if.branch; 
assign control_out.jump =  cu_if.jump;
assign control_out.ex_pc_sel =  cu_if.ex_pc_sel; 
assign control_out.imm_shamt_sel = cu_if.imm_shamt_sel;
assign control_out.halt = cu_if.halt;
assign control_out.wen =  cu_if.wen; 
assign control_out.ifence =  cu_if.ifence;
assign control_out.wfi =  cu_if.wfi;

assign control_out.alu_op = cu_if.alu_op;
assign control_out.alu_a_sel =  cu_if.alu_a_sel;
assign control_out.alu_b_sel = cu_if.alu_b_sel;
assign control_out.w_sel =  cu_if.w_sel;
assign control_out.shamt =  cu_if.shamt;
assign control_out.rd =  cu_if.rd;
assign control_out.imm_I = cu_if.imm_I;
assign control_out.imm_S = cu_if.imm_S;
assign control_out.imm_UJ =  cu_if.imm_UJ;
assign control_out.imm_SB =  cu_if.imm_SB;
// word_t instr;
assign control_out.imm_U = cu_if.imm_U;
assign control_out.load_type = cu_if.load_type;
assign control_out.branch_type = cu_if.branch_type;
assign control_out.opcode =  cu_if.opcode;

// Privilege ctrl signals
assign control_out.fault_insn = cu_if.fault_insn;
assign control_out.illegal_insn = cu_if.illegal_insn;
assign control_out.ret_insn = cu_if.ret_insn;
assign control_out.breakpoint = cu_if.breakpoint; 
assign control_out.ecall_insn = cu_if.ecall_insn;
assign control_out.csr_swap = cu_if.csr_swap;
assign control_out.csr_set = cu_if.csr_set;
assign control_out.csr_clr = cu_if.csr_clr;
assign control_out.csr_imm = cu_if.csr_imm;
assign control_out.csr_rw_valid = cu_if.csr_rw_valid;
assign control_out.csr_addr = cu_if.csr_addr;
assign control_out.zimm = cu_if.zimm;

// Extension ctrl signals
assign control_out.rv32m_control = cu_if.rv32m_control;


// RF interface signasl
assign control_out.rs1 = rf_if.rs1; 
assign control_out.rs2 = rf_if.rs2; 



endmodule 