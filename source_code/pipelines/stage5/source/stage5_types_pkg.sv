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
*   Filename:     stage5_types_pkg.sv
*
*   Created by:   William Cunningham
*   Email:        wrcunnin@purdue.edu
*   Date Created: 01/26/2026
*   Description:  Type definitions commonly used in the Five Stage Pipeline
*/

package stage5_types_pkg;

    import rv32i_types_pkg::*;
    import alu_types_pkg::*;
    import priv_isa_types_pkg::*;
    import rv32a_pkg::*;
    import rv32m_pkg::*;
    import rv32b_pkg::*;
    import rv32zc_pkg::*;

    typedef struct packed {
        logic valid;
        logic token;
        logic mal_insn;
        logic fault_insn;
        logic fault_insn_page;
        word_t pc;
        word_t pc4;
        word_t instr;
        word_t prediction;
        word_t fault_addr;
        word_t predicted_address;
    } fetch_decode_t;

    typedef struct packed {
        // from fetch
        logic valid;
        logic token;
        logic mal_insn;
        logic fault_insn;
        logic fault_insn_page;
        word_t pc;
        word_t pc4;
        word_t prediction;
        word_t fault_addr;
        word_t predicted_address;

        // Functional unit signals
        logic dwen;
        logic dren;
        logic j_sel;
        logic branch;
        logic jump;
        logic ex_pc_sel;
        logic imm_shamt_sel;
        logic halt;
        logic reg_write;
        logic ifence;
        logic sfence;
        logic wfi_insn;
        aluop_t alu_op;
        logic [1:0] alu_a_sel;
        logic [1:0] alu_b_sel;
        w_sel_t w_sel;
        logic [4:0] shamt;
        logic [11:0] imm_I;
        logic [11:0] imm_S;
        logic [20:0] imm_UJ;
        logic [12:0] imm_SB;
        word_t instr;
        word_t imm_U;
        load_t load_type;
        branch_t branch_type;
        opcode_t opcode;
        logic reserve;
        logic exclusive; // Used for reservation set management

        // Privilege control signals
        logic was_compressed; // Determine if PC should advance by 4 or 2, avoid passing PC and PC + (2/4) through pipeline
        logic illegal_insn;
        logic mret_insn;
        logic sret_insn;
        logic breakpoint;
        logic ecall_insn;
        logic fence;
        logic csr_swap;
        logic csr_set;
        logic csr_clr;
        logic csr_imm;
        logic csr_read_only;
        csr_addr_t csr_addr;
        logic [4:0] zimm;

        // Extension control signals
        rv32m_decode_t rv32m_control;
        rv32b_decode_t rv32b_control;
        rv32a_decode_t rv32a_control;
        rv32zc_decode_t rv32zc_control;

        // Reg file signals
        logic [4:0] rs1;
        logic [4:0] rs2;
        logic [4:0] rd;
        word_t rs1_data;
        word_t rs2_data;
    } decode_ex_t;

    typedef struct packed {
        opcode_t opcode;
        logic [12:0] imm_SB;
        logic [11:0] imm_S;
        logic [11:0] imm_I;
        logic [20:0] imm_UJ;
        logic [31:0] imm_U;
    } tracker_ex_mem_t;

    // TODO: Instructions?
    typedef struct packed {
        logic valid;
        logic branch;
        logic prediction;
        logic branch_taken;
        logic dren;
        logic dwen;
        logic reg_write;
        logic ifence;
        logic sfence;
        logic jump;
        logic halt;
        logic csr_swap;
        logic csr_clr;
        logic csr_set;
        logic csr_imm;
        logic csr_read_only;
        logic breakpoint;
        logic ecall_insn;
        logic mret_insn;
        logic sret_insn;
        logic wfi_insn;
        logic was_compressed; // Determine if PC should advance by 4 or 2, avoid passing PC and PC + (2/4) through pipeline
        logic reserve; // Determine if reservation set should be reserved/reservation set should be checked
        logic exclusive; // Determine if reservation set should be locked
        w_sel_t w_sel;
        logic [3:0] byte_en; // TODO: Where should this be generated?
        logic [4:0] zimm;
        logic [4:0] rd;
        logic mal_insn;
        logic fault_insn;
        logic fault_insn_page;
        logic illegal_insn;
        load_t load_type;
        csr_addr_t csr_addr;
        word_t brj_addr;
        word_t port_out;
        logic [4:0] rs1;
        logic [4:0] rs2;
        word_t rs1_data;
        word_t rs2_data;
        word_t instr;
        word_t pc;
        word_t pc4;
        word_t imm_U;
        word_t fault_addr;
        word_t predicted_address;
        tracker_ex_mem_t tracker_signals;
        // TODO: imm_U? Maybe needed
    } ex_mem_t;

    typedef struct packed {
        logic reg_write;
        logic [4:0] rd;
        word_t rd_data;
    } mem_wb_t;

endpackage
