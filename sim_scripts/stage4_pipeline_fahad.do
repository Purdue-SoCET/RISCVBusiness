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
add wave -noupdate -expand -group fetch_out /TOP/top_core/CORE/pipeline/uop_out/if_out/badaddr
add wave -noupdate -expand -group fetch_out /TOP/top_core/CORE/pipeline/uop_out/if_out/fault_insn
add wave -noupdate -expand -group fetch_out /TOP/top_core/CORE/pipeline/uop_out/if_out/instr
add wave -noupdate -expand -group fetch_out /TOP/top_core/CORE/pipeline/uop_out/if_out/mal_insn
add wave -noupdate -expand -group fetch_out /TOP/top_core/CORE/pipeline/uop_out/if_out/pc
add wave -noupdate -expand -group fetch_out /TOP/top_core/CORE/pipeline/uop_out/if_out/pc4
add wave -noupdate -expand -group fetch_out /TOP/top_core/CORE/pipeline/uop_out/if_out/prediction
add wave -noupdate -expand -group fetch_out /TOP/top_core/CORE/pipeline/uop_out/if_out/token
add wave -noupdate -expand -group fetch_out /TOP/top_core/CORE/pipeline/uop_out/if_out/valid
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
add wave -noupdate -expand -group {Vector decode out} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/U_UOPGEN/vug_if/nf_seg
add wave -noupdate -expand -group {Vector decode out} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vcu_if/vcontrol/nf_counter
add wave -noupdate -expand -group {Vector decode out} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vcu_if/vcontrol/vnew_seg
add wave -noupdate -expand -group {Vector decode out} /TOP/top_core/CORE/pipeline/decode/vcu_if/vvalid
add wave -noupdate -expand -group {Vector decode out} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vcu_if/vcontrol/vseg_op
add wave -noupdate -expand -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/sregwen
add wave -noupdate -expand -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vbank_offset
add wave -noupdate -expand -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/veew_dest
add wave -noupdate -expand -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/veew_src1
add wave -noupdate -expand -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/veew_src2
add wave -noupdate -expand -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vimm
add wave -noupdate -expand -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vindexed
add wave -noupdate -expand -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vkeepvl
add wave -noupdate -expand -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vlaneactive
add wave -noupdate -expand -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vmemdren
add wave -noupdate -expand -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vmemdwen
add wave -noupdate -expand -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vmemtoreg
add wave -noupdate -expand -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vregwen
add wave -noupdate -expand -group {Vector decode out} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vcu_if/vcontrol/vmask_en
add wave -noupdate -expand -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vsetvl_type
add wave -noupdate -expand -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vsignext
add wave -noupdate -expand -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vstrided
add wave -noupdate -expand -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vunitstride
add wave -noupdate -expand -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vuop_num
add wave -noupdate -expand -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vxin1_use_imm
add wave -noupdate -expand -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vxin1_use_rs1
add wave -noupdate -expand -group {Vector decode out} /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vxin2_use_rs2
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/lumop
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/mask_evl
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/mem_evl
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/mop
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/nf
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/rd
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/rs1
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/rs2
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/sregwen
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/twice_vsew
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vd
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/veew_dest
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/veew_src1
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/veew_src2
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vexecute_valid
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vfunct3
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vfunct6
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vindexed
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vlby8
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vmajoropcode
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vmajoropcode_valid
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vmaskldst
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vmem_eew
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vmem_width
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vmemdren
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vmemdwen
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vmeminstr
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vnarrowing
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vopi
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vopi_valid
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vopm
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vopm_valid
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vreg_offset
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vs1
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vs2
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vs3
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vstrided
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vunitstride
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vwholereg
add wave -noupdate -group {Vector decode unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vwidening
add wave -noupdate -expand -group {Uop gen unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vug_if/busy
add wave -noupdate -expand -group {Uop gen unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vug_if/gen
add wave -noupdate -expand -group {Uop gen unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vug_if/stall
add wave -noupdate -expand -group {Uop gen unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vug_if/vbank_offset
add wave -noupdate -expand -group {Uop gen unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vug_if/vl
add wave -noupdate -expand -group {Uop gen unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vug_if/vlane_active
add wave -noupdate -expand -group {Uop gen unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vug_if/vuop_num
add wave -noupdate -expand -group {Uop gen unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/U_UOPGEN/advance
add wave -noupdate -expand -group {Uop gen unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/U_UOPGEN/elements_left
add wave -noupdate -expand -group {Uop gen unit} /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/U_UOPGEN/refresh
add wave -noupdate /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/U_UOPGEN/vug_if/nf_counter
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
add wave -noupdate -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/sregwen
add wave -noupdate -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vbank_offset
add wave -noupdate -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/veew_dest
add wave -noupdate -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/veew_src1
add wave -noupdate -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/veew_src2
add wave -noupdate -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vimm
add wave -noupdate -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vindexed
add wave -noupdate -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vkeepvl
add wave -noupdate -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vlaneactive
add wave -noupdate -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vmemdren
add wave -noupdate -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vmemdwen
add wave -noupdate -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vmemtoreg
add wave -noupdate -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vregwen
add wave -noupdate -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vsetvl_type
add wave -noupdate -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vsignext
add wave -noupdate -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vstrided
add wave -noupdate -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vunitstride
add wave -noupdate -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vuop_num
add wave -noupdate -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vxin1_use_imm
add wave -noupdate -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vxin1_use_rs1
add wave -noupdate -group {Vector queue out} /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vxin2_use_rs2
add wave -noupdate -divider {Ex Stage}
add wave -noupdate /TOP/top_core/CORE/pipeline/hazard_unit_i/ex_flush_hazard
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/vctrls/vseg_op
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/vctrls/nf_counter
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/vctrls/vnew_seg
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
add wave -noupdate -group VEX_datapath /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vxin1_use_imm
add wave -noupdate -group VEX_datapath /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vxin1_use_rs1
add wave -noupdate -group VEX_datapath /TOP/top_core/CORE/pipeline/ex_in/vctrl_out/vxin2_use_rs2
add wave -noupdate -group VEX_datapath /TOP/top_core/CORE/pipeline/execute_stage_i/vex_out/sregwen
add wave -noupdate -group VEX_datapath /TOP/top_core/CORE/pipeline/execute_stage_i/vex_out/vbank_offset
add wave -noupdate -group VEX_datapath /TOP/top_core/CORE/pipeline/execute_stage_i/vex_out/veew
add wave -noupdate -group VEX_datapath /TOP/top_core/CORE/pipeline/execute_stage_i/vex_out/vindexed
add wave -noupdate -group VEX_datapath /TOP/top_core/CORE/pipeline/execute_stage_i/vex_out/vkeepvl
add wave -noupdate -group VEX_datapath /TOP/top_core/CORE/pipeline/execute_stage_i/vex_out/vlane_mask
add wave -noupdate -group VEX_datapath /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/msku_lane_mask
add wave -noupdate -group VEX_datapath /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSKSET_LAYER/vmskset_lane_mask
add wave -noupdate -group VEX_datapath /TOP/top_core/CORE/pipeline/execute_stage_i/vex_out/vmemdren
add wave -noupdate -group VEX_datapath /TOP/top_core/CORE/pipeline/execute_stage_i/vex_out/vmemdwen
add wave -noupdate -group VEX_datapath /TOP/top_core/CORE/pipeline/execute_stage_i/vex_out/vregwen
add wave -noupdate -group VEX_datapath /TOP/top_core/CORE/pipeline/execute_stage_i/vex_out/vsetvl
add wave -noupdate -group VEX_datapath -radix unsigned /TOP/top_core/CORE/pipeline/execute_stage_i/vex_out/vuop_num
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/ex_in/vctrl_out/vimm
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/ext_imm
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/vctrls/vs2_sel/regclass
add wave -noupdate -label vs2_sel /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/vctrls/vs2_sel/regidx
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/vopA
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/vopB
add wave -noupdate -label vres_0 /TOP/top_core/CORE/pipeline/execute_stage_i/vex_out/vres
add wave -noupdate -label vd_sel -radix unsigned /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/vctrls/vd_sel/regidx
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/vctrls/vregwen
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/vctrls/veew_dest
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/vex_out/vbank_offset
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/vex_out/vlane_mask
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/curr_state
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/nxt_state
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/active_bits
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/vpopc_out
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/vfirst_out
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/nxt_vpopc_out
add wave -noupdate -radix hexadecimal -childformat {{{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[127]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[126]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[125]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[124]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[123]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[122]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[121]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[120]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[119]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[118]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[117]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[116]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[115]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[114]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[113]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[112]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[111]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[110]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[109]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[108]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[107]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[106]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[105]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[104]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[103]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[102]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[101]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[100]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[99]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[98]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[97]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[96]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[95]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[94]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[93]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[92]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[91]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[90]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[89]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[88]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[87]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[86]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[85]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[84]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[83]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[82]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[81]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[80]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[79]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[78]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[77]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[76]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[75]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[74]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[73]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[72]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[71]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[70]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[69]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[68]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[67]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[66]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[65]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[64]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[63]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[62]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[61]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[60]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[59]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[58]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[57]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[56]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[55]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[54]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[53]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[52]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[51]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[50]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[49]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[48]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[47]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[46]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[45]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[44]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[43]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[42]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[41]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[40]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[39]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[38]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[37]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[36]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[35]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[34]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[33]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[32]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[31]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[30]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[29]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[28]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[27]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[26]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[25]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[24]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[23]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[22]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[21]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[20]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[19]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[18]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[17]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[16]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[15]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[14]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[13]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[12]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[11]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[10]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[9]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[8]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[7]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[6]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[5]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[4]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[3]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[2]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[1]} -radix unsigned} {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[0]} -radix unsigned}} -subitemconfig {{/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[127]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[126]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[125]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[124]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[123]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[122]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[121]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[120]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[119]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[118]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[117]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[116]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[115]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[114]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[113]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[112]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[111]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[110]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[109]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[108]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[107]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[106]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[105]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[104]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[103]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[102]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[101]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[100]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[99]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[98]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[97]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[96]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[95]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[94]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[93]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[92]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[91]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[90]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[89]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[88]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[87]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[86]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[85]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[84]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[83]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[82]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[81]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[80]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[79]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[78]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[77]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[76]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[75]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[74]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[73]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[72]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[71]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[70]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[69]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[68]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[67]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[66]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[65]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[64]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[63]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[62]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[61]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[60]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[59]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[58]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[57]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[56]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[55]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[54]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[53]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[52]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[51]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[50]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[49]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[48]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[47]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[46]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[45]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[44]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[43]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[42]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[41]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[40]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[39]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[38]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[37]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[36]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[35]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[34]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[33]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[32]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[31]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[30]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[29]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[28]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[27]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[26]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[25]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[24]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[23]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[22]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[21]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[20]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[19]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[18]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[17]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[16]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[15]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[14]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[13]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[12]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[11]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[10]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[9]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[8]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[7]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[6]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[5]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[4]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[3]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[2]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[1]} {-height 16 -radix unsigned} {/TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out[0]} {-height 16 -radix unsigned}} /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_calc_out
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_dest
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/viota_mask_src
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/viota_start_idx
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_en
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_src
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/mask_src_masked
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/vms_out
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/v0_mask
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/VMSK_CALC_UNIT/uop_num
add wave -noupdate /TOP/top_core/CORE/pipeline/execute_stage_i/RVV_DATAPATH/is_mask_calc_instr
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
add wave -noupdate /TOP/top_core/CORE/pipeline/mem_stage_i/ex_mem_if/vexmem/vuop_num
add wave -noupdate /TOP/top_core/CORE/pipeline/mem_stage_i/ex_mem_if/vexmem/vnew_seg
add wave -noupdate /TOP/top_core/CORE/pipeline/mem_stage_i/ex_mem_if/vexmem/vseg_op
add wave -noupdate /TOP/top_core/CORE/pipeline/mem_stage_i/ex_mem_if/vexmem/vunitstride
add wave -noupdate /TOP/top_core/CORE/pipeline/mem_stage_i/ex_mem_if/vexmem/vstrided
add wave -noupdate /TOP/top_core/CORE/pipeline/mem_stage_i/SLZR/seg_addr
add wave -noupdate /TOP/top_core/CORE/pipeline/mem_stage_i/SLZR/next_addr
add wave -noupdate /TOP/top_core/CORE/pipeline/mem_stage_i/SLZR/serial_if/vaddr_lsc
add wave -noupdate /TOP/top_core/CORE/pipeline/mem_stage_i/SLZR/serial_if/lsc_ready
add wave -noupdate /TOP/top_core/CORE/pipeline/mem_stage_i/SLZR/serial_if/vlane_mask
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
WaveRestoreCursors {{Cursor 1} {97 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 166
configure wave -valuecolwidth 133
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
WaveRestoreZoom {71 ps} {130 ps}
