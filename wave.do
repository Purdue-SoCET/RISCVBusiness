onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /TOP/top_core/CORE/CLK
add wave -noupdate /TOP/top_core/CORE/pipeline/fetch_out/instr
add wave -noupdate /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vmajoropcode
add wave -noupdate /TOP/top_core/CORE/pipeline/decode/U_VECTOR_DECODE/vmajoropcode_valid
add wave -noupdate /TOP/top_core/CORE/pipeline/decode/vcu_if/stall
add wave -noupdate /TOP/top_core/CORE/pipeline/decode/vcu_if/vbusy
add wave -noupdate /TOP/top_core/CORE/pipeline/decode/vcu_if/vill
add wave -noupdate /TOP/top_core/CORE/pipeline/decode/vcu_if/vl
add wave -noupdate /TOP/top_core/CORE/pipeline/decode/vcu_if/vlmul
add wave -noupdate /TOP/top_core/CORE/pipeline/decode/vcu_if/vsew
add wave -noupdate /TOP/top_core/CORE/pipeline/decode/vcu_if/vvalid
add wave -noupdate /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/sregwen
add wave -noupdate /TOP/top_core/CORE/pipeline/uop_out/ctrl_out/wen
add wave -noupdate /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vbank_offset
add wave -noupdate /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/veew_dest
add wave -noupdate /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/veew_src1
add wave -noupdate /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/veew_src2
add wave -noupdate /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vimm
add wave -noupdate /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vindexed
add wave -noupdate /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vkeepvl
add wave -noupdate /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vlaneactive
add wave -noupdate /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vmemdren
add wave -noupdate /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vmemdwen
add wave -noupdate /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vmemtoreg
add wave -noupdate /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vregwen
add wave -noupdate /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vsetvl_type
add wave -noupdate /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vsignext
add wave -noupdate /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vstrided
add wave -noupdate /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vunitstride
add wave -noupdate /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vuop_num
add wave -noupdate /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vxin1_use_imm
add wave -noupdate /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vxin1_use_rs1
add wave -noupdate /TOP/top_core/CORE/pipeline/uop_out/vctrl_out/vxin2_use_rs2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {47 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {43 ps} {59 ps}
