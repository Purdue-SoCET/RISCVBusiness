
package stage3_types_pkg;

    import rv32i_types_pkg::*;
    import machine_mode_types_1_12_pkg::*;

    typedef struct packed {
        logic valid;
        logic token;
        logic mal_insn;
        logic fault_insn;
        word_t pc;
        word_t pc4;
        word_t instr;
        word_t prediction;
        word_t badaddr;
    } fetch_ex_t;

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
        logic jump;
        logic halt;
        logic csr_swap;
        logic csr_clr;
        logic csr_set;
        logic csr_imm;
        logic csr_read_only;
        logic breakpoint;
        logic ecall_insn;
        logic ret_insn;
        logic wfi_insn;
        logic was_compressed; // Determine if PC should advance by 4 or 2, avoid passing PC and PC + (2/4) through pipeline
        logic [2:0] w_sel;
        logic [3:0] byte_en; // TODO: Where should this be generated?
        logic [4:0] zimm;
        logic [4:0] rd_m;
        logic mal_insn;
        logic fault_insn;
        logic illegal_insn;
        load_t load_type;
        csr_addr_t csr_addr;
        word_t brj_addr;
        word_t port_out;
        word_t rs1_data;
        word_t rs2_data;
        word_t instr;
        word_t pc;
        word_t pc4;
        word_t imm_U;
        word_t badaddr;
        tracker_ex_mem_t tracker_signals;
        // TODO: imm_U? Maybe needed
    } ex_mem_t;

endpackage
