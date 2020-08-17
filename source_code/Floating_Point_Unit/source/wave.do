onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_FPU_all/FPUif/n_rst
add wave -noupdate /tb_FPU_all/FPUif/clk
add wave -noupdate /tb_FPU_all/FPUif/f_LW
add wave -noupdate /tb_FPU_all/FPUif/f_SW
add wave -noupdate /tb_FPU_all/FPUif/f_rs1
add wave -noupdate /tb_FPU_all/FPUif/f_rs2
add wave -noupdate /tb_FPU_all/FPUif/f_rd
add wave -noupdate /tb_FPU_all/FPUif/f_frm_in
add wave -noupdate /tb_FPU_all/FPUif/f_flags
add wave -noupdate /tb_FPU_all/FPUif/f_funct_7
add wave -noupdate /tb_FPU_all/FPUif/f_frm_out
add wave -noupdate /tb_FPU_all/FPUif/dload_ext
add wave -noupdate /tb_FPU_all/FPUif/FPU_all_out
add wave -noupdate /tb_FPU_all/FPUif/f_ready
add wave -noupdate /tb_FPU_all/DUT/f_rf/registers
add wave -noupdate /tb_FPU_all/DUT/f_rf/f_wen
add wave -noupdate /tb_FPU_all/DUT/frf_if/n_rst
add wave -noupdate /tb_FPU_all/DUT/frf_if/clk
add wave -noupdate /tb_FPU_all/DUT/frf_if/f_rs1
add wave -noupdate /tb_FPU_all/DUT/frf_if/f_rs2
add wave -noupdate /tb_FPU_all/DUT/frf_if/f_rd
add wave -noupdate /tb_FPU_all/DUT/frf_if/f_LW
add wave -noupdate /tb_FPU_all/DUT/frf_if/f_SW
add wave -noupdate /tb_FPU_all/DUT/frf_if/f_flags
add wave -noupdate /tb_FPU_all/DUT/frf_if/f_frm_out
add wave -noupdate /tb_FPU_all/DUT/frf_if/f_frm_in
add wave -noupdate /tb_FPU_all/DUT/frf_if/f_w_data
add wave -noupdate /tb_FPU_all/DUT/frf_if/f_rs1_data
add wave -noupdate /tb_FPU_all/DUT/frf_if/f_rs2_data
add wave -noupdate /tb_FPU_all/DUT/frf_if/FPU_out
add wave -noupdate /tb_FPU_all/DUT/frf_if/frm
add wave -noupdate /tb_FPU_all/DUT/frf_if/flags
add wave -noupdate /tb_FPU_all/DUT/frf_if/f_ready
add wave -noupdate /tb_FPU_all/DUT/frf_if/funct_7
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {230 ns} 0}
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
WaveRestoreZoom {0 ns} {473 ns}
