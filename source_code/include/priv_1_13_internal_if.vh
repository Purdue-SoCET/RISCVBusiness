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
*   Filename:     priv_1_13_internal_if.vh
*
*   Created by:   William Cunningham
*   Email:        wrcunnin@purdue.edu
*   Date Created: 09/26/2024
*   Description:  Interface for components within the privilege block v1.13
*/

`ifndef PRIV_1_13_INTERNAL_IF_VH
`define PRIV_1_13_INTERNAL_IF_VH

`include "component_selection_defines.vh"

interface priv_1_13_internal_if;
    import machine_mode_types_1_13_pkg::*;
    import pma_types_1_13_pkg::*;
    import rv32i_types_pkg::*;

    // RISC-MGMT?
    //  not sure what these are for, part of priv 1.11
    logic ex_rmgmt;
    logic [$clog2(`NUM_EXTENSIONS)-1:0] ex_rmgmt_cause;

    priv_level_t curr_privilege_level; // Current process privilege

    // CSR block values
    csr_addr_t csr_addr; // CSR address to read
    logic csr_write, csr_set, csr_clear, csr_read_only; // Is the CSR currently being modified?
    logic invalid_csr; // Bad CSR address
    logic inst_ret; // signal when an instruction is retired
    logic hpm3_inc; // counter for icache misses
    logic hpm4_inc; // counter for dcache misses
    word_t new_csr_val, old_csr_val; // new and old CSR values (atomically swapped)
    logic valid_write; // valid write occurs with an r type instruction that does not have any pipeline stalls

    // Sources for interrupts
    logic timer_int_u, timer_int_s, timer_int_m;
    logic soft_int_u, soft_int_s, soft_int_m;
    logic ext_int_u, ext_int_s, ext_int_m;

    // Sources to clear the pending interrupt
    logic clear_timer_int_u, clear_timer_int_s, clear_timer_int_m;
    logic clear_soft_int_u, clear_soft_int_s, clear_soft_int_m;
    logic clear_ext_int_u, clear_ext_int_s, clear_ext_int_m;

    // Sources for exceptions
    logic mal_insn, fault_insn_access, illegal_insn, breakpoint, fault_l, mal_l, fault_s, mal_s;
    logic env_u, env_s, env_m, fault_insn_page, fault_load_page, fault_store_page;

    // Values involving CSR file for ex/int handling
    long_csr_t curr_medeleg;
    csr_reg_t curr_mideleg;
    mip_t curr_mip, next_mip;
    mie_t curr_mie, next_mie;
    mcause_t curr_mcause, next_mcause;
    csr_reg_t curr_mepc, next_mepc;
    mstatus_t curr_mstatus, next_mstatus;
    mtvec_t curr_mtvec;
    csr_reg_t curr_mtval, next_mtval;
    scause_t curr_scause, next_scause;
    csr_reg_t curr_sepc, next_sepc;
    stvec_t curr_stvec;
    csr_reg_t curr_stval, next_stval;
    satp_t curr_satp;
    logic inject_mip, inject_mcause, inject_mepc, inject_mstatus, inject_mtval, inject_scause, inject_sepc, inject_stval;
    logic isUMode, isSMode, isMMode;

    // Things from the pipe we care about
    word_t epc; // pc of the instruction prior to the exception
    word_t priv_pc; // pc to handle the interrupt/exception
    logic pipe_clear; // is the pipeline clear of hazards
    logic insert_pc; // inform pipeline that we are changing the PC
    logic mret, sret; // returning from a trap instruction
    logic intr; // Did something trigger an interrupt or exception?
    logic intr_to_s; // Is this trapping into s-mode?
    logic ex_mem_stall; // Is the pipe stalled?

    // Addresses and memory access info for memory protection
    logic [RAM_ADDR_SIZE-1:0] daddr, iaddr; // Address to check
    logic ren, wen, xen; // RWX access type

    // PMA comm variables
    pma_accwidth_t d_acc_width, i_acc_width; // Width of memory access
    logic pma_s_fault, pma_l_fault, pma_i_fault; // PMA store fault, load fault, instruction fault

    // PMP variables
    logic pmp_s_fault, pmp_l_fault, pmp_i_fault; // PMP store fault, load fault, instruction fault

    modport csr (
        input csr_addr, curr_privilege_level, csr_write, csr_set, csr_clear, csr_read_only, new_csr_val, inst_ret, hpm3_inc, hpm4_inc,
            valid_write, inject_mcause, inject_mepc, inject_mip, inject_mstatus, inject_mtval, inject_scause, inject_sepc, inject_stval,
            next_mcause, next_mepc, next_mie, next_mip, next_mstatus, next_mtval, next_scause, next_sepc, next_stval,
            isUMode, isSMode, isMMode,
        output old_csr_val, invalid_csr,
            curr_medeleg, curr_mideleg, curr_mcause, curr_mepc, curr_mie, curr_mip, curr_mstatus, curr_mtvec, curr_scause, curr_sepc, curr_stvec, curr_satp
    );

    modport int_ex_handler (
        input timer_int_u, timer_int_s, timer_int_m, soft_int_u, soft_int_s, soft_int_m, ext_int_u, ext_int_s, ext_int_m,
            clear_timer_int_u, clear_timer_int_s, clear_timer_int_m, clear_soft_int_u, clear_soft_int_s, clear_soft_int_m,
            clear_ext_int_u, clear_ext_int_s, clear_ext_int_m, mal_insn, fault_insn_access, illegal_insn, breakpoint, fault_l, mal_l, fault_s, mal_s,
            env_u, env_s, env_m, fault_insn_page, fault_load_page, fault_store_page, curr_medeleg, curr_mideleg, curr_mcause, curr_mepc, curr_mie,
            curr_mip, curr_mstatus, curr_mtval, curr_scause, curr_sepc, curr_stval, mret, sret, pipe_clear, ex_rmgmt, ex_rmgmt_cause, epc, curr_privilege_level, ex_mem_stall,
            isUMode, isSMode, isMMode,
        output inject_mcause, inject_mepc, inject_mip, inject_mstatus, inject_mtval, inject_scause, inject_sepc, inject_stval,
            next_mcause, next_mepc, next_mie, next_mip, next_mstatus, next_mtval, next_scause, next_sepc, next_stval, intr,
            intr_to_s
    );

    modport pipe_ctrl (
        input intr, intr_to_s, pipe_clear, mret, sret, curr_mtvec, curr_mepc, next_mcause,
            curr_stvec, curr_sepc, next_scause,
        output insert_pc, priv_pc
    );

    modport pma (
        input iaddr, daddr, ren, wen, xen, d_acc_width, i_acc_width,
        output pma_s_fault, pma_i_fault, pma_l_fault
    );

    modport pmp (
        input iaddr, daddr, ren, wen, xen, curr_privilege_level, curr_mstatus, isUMode, isSMode, isMMode,
        output pmp_s_fault, pmp_i_fault, pmp_l_fault
    );

    modport mode (
        input mret, sret, curr_mstatus, intr, intr_to_s,
        output curr_privilege_level, isUMode, isSMode, isMMode
    );

endinterface

`endif  // PRIV_1_13_INTERNAL_IF_VH