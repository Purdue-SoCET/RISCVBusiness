onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /TOP/top_core/CORE/CLK
add wave -noupdate /TOP/top_core/CORE/RESET_PC
add wave -noupdate /TOP/top_core/CORE/halt
add wave -noupdate /TOP/top_core/CORE/mtime
add wave -noupdate /TOP/top_core/CORE/nRST
add wave -noupdate /TOP/top_core/CORE/wfi
add wave -noupdate -divider {Fetch Stage}
add wave -noupdate /TOP/top_core/CORE/hazard_if/if_ex_flush
add wave -noupdate /TOP/top_core/CORE/hazard_if/if_ex_stall
add wave -noupdate -divider {Decode out}
add wave -noupdate /TOP/top_core/CORE/pipeline/hazard_unit_i/stall_vsetvl
add wave -noupdate /TOP/top_core/CORE/pipeline/shadow_if/flush_decode
add wave -noupdate /TOP/top_core/CORE/pipeline/shadow_if/vl_shadow
add wave -noupdate /TOP/top_core/CORE/pipeline/shadow_if/vlmul_shadow
add wave -noupdate /TOP/top_core/CORE/pipeline/shadow_if/vsew_shadow
add wave -noupdate -group fetch_out /TOP/top_core/CORE/pipeline/uop_out/if_out/badaddr
add wave -noupdate -group fetch_out /TOP/top_core/CORE/pipeline/uop_out/if_out/fault_insn
add wave -noupdate -group fetch_out /TOP/top_core/CORE/pipeline/uop_out/if_out/instr
add wave -noupdate -group fetch_out /TOP/top_core/CORE/pipeline/uop_out/if_out/mal_insn
add wave -noupdate -group fetch_out /TOP/top_core/CORE/pipeline/uop_out/if_out/pc
add wave -noupdate -group fetch_out /TOP/top_core/CORE/pipeline/uop_out/if_out/pc4
add wave -noupdate -group fetch_out /TOP/top_core/CORE/pipeline/uop_out/if_out/prediction
add wave -noupdate -group fetch_out /TOP/top_core/CORE/pipeline/uop_out/if_out/token
add wave -noupdate -group fetch_out /TOP/top_core/CORE/pipeline/uop_out/if_out/valid
add wave -noupdate /TOP/top_core/CORE/pipeline/decode/queue_wen
add wave -noupdate /TOP/top_core/CORE/pipeline/hazard_if/stall_decode
add wave -noupdate /TOP/top_core/CORE/pipeline/hazard_if/flush_decode
add wave -noupdate -group {Scalar decode out} -group rs1 /TOP/top_core/CORE/pipeline/decode/vcu_if/rs1/regclass
add wave -noupdate -group {Scalar decode out} -group rs1 /TOP/top_core/CORE/pipeline/decode/vcu_if/rs1/regidx
add wave -noupdate -group {Scalar decode out} -group rs2 /TOP/top_core/CORE/pipeline/decode/uop_out/ctrl_out/rs2/regclass
add wave -noupdate -group {Scalar decode out} -group rs2 /TOP/top_core/CORE/pipeline/decode/uop_out/ctrl_out/rs2/regidx
add wave -noupdate -group {Scalar decode out} -group rd /TOP/top_core/CORE/pipeline/decode/vcu_if/rd/regclass
add wave -noupdate -group {Scalar decode out} -group rd /TOP/top_core/CORE/pipeline/decode/vcu_if/rd/regidx
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/alu_a_sel
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/alu_b_sel
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/alu_op
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/branch
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/branch_type
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/breakpoint
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/csr_addr
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/csr_clr
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/csr_imm
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/csr_rw_valid
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/csr_set
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/csr_swap
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/dren
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/dwen
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/ecall_insn
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/ex_pc_sel
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/fault_insn
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/halt
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/ifence
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/illegal_insn
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/imm_I
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/imm_S
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/imm_SB
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/imm_U
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/imm_UJ
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/imm_shamt_sel
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/j_sel
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/jump
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/load_type
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/opcode
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/ret_insn
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/shamt
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/w_sel
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/wen
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/wfi
add wave -noupdate -group {Scalar decode out} /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/zimm
add wave -noupdate -group {Vector decode out} /TOP/top_core/CORE/pipeline/decode/vcu_if/vvalid
add wave -noupdate -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/sregwen
add wave -noupdate -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vbank_offset
add wave -noupdate -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/veew_dest
add wave -noupdate -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/veew_src1
add wave -noupdate -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/veew_src2
add wave -noupdate -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vimm
add wave -noupdate -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vindexed
add wave -noupdate -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vkeepvl
add wave -noupdate -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vlaneactive
add wave -noupdate -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vmemdren
add wave -noupdate -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vmemdwen
add wave -noupdate -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vmemtoreg
add wave -noupdate -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vregwen
add wave -noupdate -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vsetvl_type
add wave -noupdate -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vsignext
add wave -noupdate -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vstrided
add wave -noupdate -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vunitstride
add wave -noupdate -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vuop_num
add wave -noupdate -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vxin1_use_imm
add wave -noupdate -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vxin1_use_rs1
add wave -noupdate -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vxin2_use_rs2
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/lumop
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/mask_evl
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/mem_evl
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/mop
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/nf
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/rd
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/rs1
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/rs2
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/sregwen
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/twice_vsew
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vd
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/veew_dest
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/veew_src1
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/veew_src2
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vexecute_valid
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vfunct3
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vfunct6
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vindexed
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vlby8
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vmajoropcode
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vmajoropcode_valid
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vmaskldst
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vmem_eew
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vmem_width
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vmemdren
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vmemdwen
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vmeminstr
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vnarrowing
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vopi
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vopi_valid
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vopm
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vopm_valid
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vreg_offset
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vs1
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vs2
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vs3
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vstrided
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vunitstride
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vwholereg
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vwidening
add wave -noupdate -expand -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/wholereg_evl
add wave -noupdate -expand -group {Uop gen unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vug_if/busy
add wave -noupdate -expand -group {Uop gen unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vug_if/gen
add wave -noupdate -expand -group {Uop gen unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vug_if/stall
add wave -noupdate -expand -group {Uop gen unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vug_if/vbank_offset
add wave -noupdate -expand -group {Uop gen unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vug_if/veew
add wave -noupdate -expand -group {Uop gen unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vug_if/vl
add wave -noupdate -expand -group {Uop gen unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vug_if/vlane_active
add wave -noupdate -expand -group {Uop gen unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vug_if/vreg_offset
add wave -noupdate -expand -group {Uop gen unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vug_if/vuop_num
add wave -noupdate -expand -group {Uop gen unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/U_UOPGEN/advance
add wave -noupdate -expand -group {Uop gen unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/U_UOPGEN/eew_bytes
add wave -noupdate -expand -group {Uop gen unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/U_UOPGEN/elements_left
add wave -noupdate -expand -group {Uop gen unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/U_UOPGEN/refresh
add wave -noupdate -divider {Queue out}
add wave -noupdate /TOP/top_core/CORE/pipeline/hazard_if/stall_queue
add wave -noupdate /TOP/top_core/CORE/pipeline/hazard_if/flush_queue
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/alu_a_sel
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/alu_b_sel
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/alu_op
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/branch
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/branch_type
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/breakpoint
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/csr_addr
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/csr_clr
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/csr_imm
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/csr_rw_valid
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/csr_set
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/csr_swap
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/dren
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/dwen
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/ecall_insn
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/ex_pc_sel
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/fault_insn
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/halt
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/ifence
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/illegal_insn
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/imm_I
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/imm_S
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/imm_SB
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/imm_U
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/imm_UJ
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/imm_shamt_sel
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/j_sel
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/jump
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/load_type
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/opcode
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/ret_insn
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/shamt
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/w_sel
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/wen
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/wfi
add wave -noupdate -group {Scalar queue out} /TOP/top_core/CORE/pipeline/ex_in/ctrl_out/zimm
add wave -noupdate -expand -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/sregwen
add wave -noupdate -expand -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vbank_offset
add wave -noupdate -expand -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/veew_dest
add wave -noupdate -expand -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/veew_src1
add wave -noupdate -expand -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/veew_src2
add wave -noupdate -expand -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vimm
add wave -noupdate -expand -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vindexed
add wave -noupdate -expand -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vkeepvl
add wave -noupdate -expand -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vlaneactive
add wave -noupdate -expand -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vmemdren
add wave -noupdate -expand -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vmemdwen
add wave -noupdate -expand -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vmemtoreg
add wave -noupdate -expand -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vregwen
add wave -noupdate -expand -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vsetvl_type
add wave -noupdate -expand -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vsignext
add wave -noupdate -expand -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vstrided
add wave -noupdate -expand -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vunitstride
add wave -noupdate -expand -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vuop_num
add wave -noupdate -expand -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vxin1_use_imm
add wave -noupdate -expand -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vxin1_use_rs1
add wave -noupdate -expand -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vxin2_use_rs2
add wave -noupdate -divider {Ex Stage}
add wave -noupdate /TOP/top_core/CORE/pipeline/hazard_if/ex_mem_flush
add wave -noupdate /TOP/top_core/CORE/pipeline/hazard_if/ex_mem_stall
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/ex_in/if_out/pc
add wave -noupdate -group shadow_if /TOP/top_core/CORE/pipeline/shadow_if/vsetvl
add wave -noupdate -group shadow_if /TOP/top_core/CORE/pipeline/shadow_if/vkeepvl
add wave -noupdate -group shadow_if /TOP/top_core/CORE/pipeline/shadow_if/avl_spec
add wave -noupdate -group shadow_if -group vtype_spec /TOP/top_core/CORE/pipeline/shadow_if/vtype_spec/vill
add wave -noupdate -group shadow_if -group vtype_spec /TOP/top_core/CORE/pipeline/shadow_if/vtype_spec/vlmul
add wave -noupdate -group shadow_if -group vtype_spec /TOP/top_core/CORE/pipeline/shadow_if/vtype_spec/vsew
add wave -noupdate -group shadow_if -group vtype_spec /TOP/top_core/CORE/pipeline/shadow_if/vtype_spec/vta
add wave -noupdate -group shadow_if -group vtype_spec /TOP/top_core/CORE/pipeline/shadow_if/vtype_spec/vma
add wave -noupdate -expand -group VEX_datapath /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vxin1_use_imm
add wave -noupdate -expand -group VEX_datapath /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vxin1_use_rs1
add wave -noupdate -expand -group VEX_datapath /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vxin2_use_rs2
add wave -noupdate -expand -group VEX_datapath /TOP/top_core/CORE/pipeline/execute_stage_i/vex_out/sregwen
add wave -noupdate -expand -group VEX_datapath /TOP/top_core/CORE/pipeline/execute_stage_i/vex_out/vbank_offset
add wave -noupdate -expand -group VEX_datapath /TOP/top_core/CORE/pipeline/execute_stage_i/vex_out/veew
add wave -noupdate -expand -group VEX_datapath /TOP/top_core/CORE/pipeline/execute_stage_i/vex_out/vindexed
add wave -noupdate -expand -group VEX_datapath /TOP/top_core/CORE/pipeline/execute_stage_i/vex_out/vkeepvl
add wave -noupdate -expand -group VEX_datapath /TOP/top_core/CORE/pipeline/execute_stage_i/vex_out/vlane_mask
add wave -noupdate -expand -group VEX_datapath /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/msku_lane_mask
add wave -noupdate -expand -group VEX_datapath /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSKSET_LAYER/vmskset_lane_mask
add wave -noupdate -expand -group VEX_datapath /TOP/top_core/CORE/pipeline/execute_stage_i/vex_out/vmemdren
add wave -noupdate -expand -group VEX_datapath /TOP/top_core/CORE/pipeline/execute_stage_i/vex_out/vmemdwen
add wave -noupdate -expand -group VEX_datapath /TOP/top_core/CORE/pipeline/execute_stage_i/vex_out/vregwen
add wave -noupdate -expand -group VEX_datapath /TOP/top_core/CORE/pipeline/execute_stage_i/vex_out/vsetvl
add wave -noupdate -expand -group VEX_datapath -radix unsigned /TOP/top_core/CORE/pipeline/execute_stage_i/vex_out/vuop_num
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/ex_in/vctrl_out/vimm
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/ext_imm
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/vctrls/vs2_sel/regclass
add wave -noupdate -label vs2_sel /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/vctrls/vs2_sel/regidx
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/vopA
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/vopB
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/vex_out/vres
add wave -noupdate -label vd_sel -radix unsigned /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/vctrls/vd_sel/regidx
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/vctrls/vregwen
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/vctrls/veew_dest
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/vex_out/vbank_offset
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/vex_out/vlane_mask
add wave -noupdate -group scalar_rf /TOP/top_core/CORE/pipeline/execute_stage_i/rf_if/rs1_data
add wave -noupdate -group scalar_rf /TOP/top_core/CORE/pipeline/execute_stage_i/rf_if/rs2_data
add wave -noupdate -group scalar_rf /TOP/top_core/CORE/pipeline/execute_stage_i/rf_if/w_data
add wave -noupdate -group scalar_rf /TOP/top_core/CORE/pipeline/execute_stage_i/rf_if/wen
add wave -noupdate -group scalar_rf -expand -group rd /TOP/top_core/CORE/pipeline/execute_stage_i/rf_if/rd/regclass
add wave -noupdate -group scalar_rf -expand -group rd /TOP/top_core/CORE/pipeline/execute_stage_i/rf_if/rd/regidx
add wave -noupdate -group scalar_rf -expand -group rs1 /TOP/top_core/CORE/pipeline/execute_stage_i/rf_if/rs1/regclass
add wave -noupdate -group scalar_rf -expand -group rs1 -radix unsigned /TOP/top_core/CORE/pipeline/execute_stage_i/rf_if/rs1/regidx
add wave -noupdate -group scalar_rf -expand -group rs2 /TOP/top_core/CORE/pipeline/execute_stage_i/rf_if/rs2/regclass
add wave -noupdate -group scalar_rf -expand -group rs2 /TOP/top_core/CORE/pipeline/execute_stage_i/rf_if/rs2/regidx
add wave -noupdate -divider {Mem In}
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/ex_mem_if/vexmem/vres
add wave -noupdate /TOP/top_core/CORE/pipeline/mem_stage_i/ex_mem_if/ex_mem_reg/pc
add wave -noupdate /TOP/top_core/CORE/pipeline/mem_stage_i/ex_mem_if/ex_mem_reg/rs1_data
add wave -noupdate /TOP/top_core/CORE/pipeline/mem_stage_i/ex_mem_if/ex_mem_reg/rs2_data
add wave -noupdate /TOP/top_core/CORE/pipeline/mem_stage_i/ex_mem_if/vexmem/vkeepvl
add wave -noupdate /TOP/top_core/CORE/pipeline/mem_stage_i/ex_mem_if/vexmem/vsetvl
add wave -noupdate -group vtype /TOP/top_core/CORE/pipeline/mem_stage_i/prv_pipe_if/vtype/reserved
add wave -noupdate -group vtype /TOP/top_core/CORE/pipeline/mem_stage_i/prv_pipe_if/vtype/vill
add wave -noupdate -group vtype /TOP/top_core/CORE/pipeline/mem_stage_i/prv_pipe_if/vtype/vlmul
add wave -noupdate -group vtype /TOP/top_core/CORE/pipeline/mem_stage_i/prv_pipe_if/vtype/vma
add wave -noupdate -group vtype /TOP/top_core/CORE/pipeline/mem_stage_i/prv_pipe_if/vtype/vsew
add wave -noupdate -group vtype /TOP/top_core/CORE/pipeline/mem_stage_i/prv_pipe_if/vtype/vta
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/badaddr
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/branch
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/branch_taken
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/breakpoint
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/brj_addr
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/byte_en
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/csr_addr
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/csr_clr
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/csr_imm
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/csr_read_only
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/csr_set
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/csr_swap
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/dren
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/dwen
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/ecall_insn
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/fault_insn
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/halt
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/ifence
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/illegal_insn
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/imm_U
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/instr
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/jump
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/load_type
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/mal_insn
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/pc
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/pc4
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/port_out
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/prediction
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/reg_write
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/ret_insn
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/rs1_data
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/rs2_data
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/valid
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/w_sel
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/was_compressed
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/wfi_insn
add wave -noupdate -group {Scalar execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/ex_mem_reg/zimm
add wave -noupdate -expand -group {Vector execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/vexmem/vbank_offset
add wave -noupdate -expand -group {Vector execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/vexmem/veew
add wave -noupdate -expand -group {Vector execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/vexmem/vindexed
add wave -noupdate -expand -group {Vector execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/vexmem/vkeepvl
add wave -noupdate -expand -group {Vector execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/vexmem/vlane_mask
add wave -noupdate -expand -group {Vector execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/vexmem/vmemdren
add wave -noupdate -expand -group {Vector execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/vexmem/vmemdwen
add wave -noupdate -expand -group {Vector execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/vexmem/vregwen
add wave -noupdate -expand -group {Vector execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/vexmem/vsetvl
add wave -noupdate -expand -group {Vector execute out} /TOP/top_core/CORE/pipeline/mem_pipe_if/vexmem/vuop_num
add wave -noupdate -divider Memory
add wave -noupdate -group {Mem to PC} /TOP/top_core/CORE/pipeline/mem_pipe_if/brj_addr
add wave -noupdate -group {Mem to PC} /TOP/top_core/CORE/pipeline/mem_pipe_if/pc4
add wave -noupdate -group {Mem to scalar RF} /TOP/top_core/CORE/pipeline/mem_pipe_if/reg_wdata
add wave -noupdate -group {Mem to scalar RF} /TOP/top_core/CORE/pipeline/mem_pipe_if/reg_write
add wave -noupdate -group {Mem to scalar RF} /TOP/top_core/CORE/pipeline/mem_pipe_if/rd_m/regclass
add wave -noupdate -group {Mem to scalar RF} /TOP/top_core/CORE/pipeline/mem_pipe_if/rd_m/regidx
add wave -noupdate -expand -group {Mem to vector RF} /TOP/top_core/CORE/pipeline/mem_stage_i/vlane_wen
add wave -noupdate -expand -group {Mem to vector RF} /TOP/top_core/CORE/pipeline/mem_pipe_if/vwb/vbyte_wen
add wave -noupdate -expand -group {Mem to vector RF} /TOP/top_core/CORE/pipeline/mem_pipe_if/vwb/vd
add wave -noupdate -expand -group {Mem to vector RF} /TOP/top_core/CORE/pipeline/mem_pipe_if/vwb/vwdata
add wave -noupdate -expand -group {Mem to D$} /TOP/top_core/CORE/pipeline/dgen_bus_if/addr
add wave -noupdate -expand -group {Mem to D$} /TOP/top_core/CORE/pipeline/dgen_bus_if/busy
add wave -noupdate -expand -group {Mem to D$} /TOP/top_core/CORE/pipeline/dgen_bus_if/byte_en
add wave -noupdate -expand -group {Mem to D$} /TOP/top_core/CORE/pipeline/dgen_bus_if/error
add wave -noupdate -expand -group {Mem to D$} /TOP/top_core/CORE/pipeline/dgen_bus_if/rdata
add wave -noupdate -expand -group {Mem to D$} /TOP/top_core/CORE/pipeline/dgen_bus_if/ren
add wave -noupdate -expand -group {Mem to D$} /TOP/top_core/CORE/pipeline/dgen_bus_if/wdata
add wave -noupdate -expand -group {Mem to D$} /TOP/top_core/CORE/pipeline/dgen_bus_if/wen
add wave -noupdate -group {Mem serializer} /TOP/top_core/CORE/pipeline/mem_stage_i/serial_if/base
add wave -noupdate -group {Mem serializer} /TOP/top_core/CORE/pipeline/mem_stage_i/serial_if/lsc_ready
add wave -noupdate -group {Mem serializer} /TOP/top_core/CORE/pipeline/mem_stage_i/serial_if/stride
add wave -noupdate -group {Mem serializer} /TOP/top_core/CORE/pipeline/mem_stage_i/serial_if/vaddr_lsc
add wave -noupdate -group {Mem serializer} /TOP/top_core/CORE/pipeline/mem_stage_i/serial_if/vcurr_lane
add wave -noupdate -group {Mem serializer} /TOP/top_core/CORE/pipeline/mem_stage_i/serial_if/vdata_store_lsc
add wave -noupdate -group {Mem serializer} /TOP/top_core/CORE/pipeline/mem_stage_i/serial_if/veew
add wave -noupdate -group {Mem serializer} /TOP/top_core/CORE/pipeline/mem_stage_i/serial_if/vindexed
add wave -noupdate -group {Mem serializer} /TOP/top_core/CORE/pipeline/mem_stage_i/serial_if/vlane_addr
add wave -noupdate -group {Mem serializer} /TOP/top_core/CORE/pipeline/mem_stage_i/serial_if/vlane_addr
add wave -noupdate -group {Mem serializer} /TOP/top_core/CORE/pipeline/mem_stage_i/serial_if/vlane_addr
add wave -noupdate -group {Mem serializer} /TOP/top_core/CORE/pipeline/mem_stage_i/serial_if/vlane_addr
add wave -noupdate -group {Mem serializer} /TOP/top_core/CORE/pipeline/mem_stage_i/serial_if/vlane_mask
add wave -noupdate -group {Mem serializer} /TOP/top_core/CORE/pipeline/mem_stage_i/serial_if/vlane_store_data
add wave -noupdate -group {Mem serializer} /TOP/top_core/CORE/pipeline/mem_stage_i/serial_if/vlane_store_data
add wave -noupdate -group {Mem serializer} /TOP/top_core/CORE/pipeline/mem_stage_i/serial_if/vlane_store_data
add wave -noupdate -group {Mem serializer} /TOP/top_core/CORE/pipeline/mem_stage_i/serial_if/vlane_store_data
add wave -noupdate -group {Mem serializer} /TOP/top_core/CORE/pipeline/mem_stage_i/serial_if/vload_type
add wave -noupdate -group {Mem serializer} /TOP/top_core/CORE/pipeline/mem_stage_i/serial_if/vmemdren
add wave -noupdate -group {Mem serializer} /TOP/top_core/CORE/pipeline/mem_stage_i/serial_if/vmemdren_lsc
add wave -noupdate -group {Mem serializer} /TOP/top_core/CORE/pipeline/mem_stage_i/serial_if/vmemdwen
add wave -noupdate -group {Mem serializer} /TOP/top_core/CORE/pipeline/mem_stage_i/serial_if/vmemdwen_lsc
add wave -noupdate -group {Mem serializer} /TOP/top_core/CORE/pipeline/mem_stage_i/serial_if/vuop_num
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {260 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 166
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {230 ps} {264 ps}
