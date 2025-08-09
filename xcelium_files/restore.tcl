
# XM-Sim Command File
# TOOL:	xmsim(64)	23.03-s004
#
#
# You can restore this configuration with:
#
#      xrun -q -f edalize_main.f +xmtimescale+1ns/100ps -access r -top tb_rv32m_enabled -input /home/asicfab/a/ryongtia/RISCVBusiness/xcelium_files/restore.tcl
#

set tcl_prompt1 {puts -nonewline "xcelium> "}
set tcl_prompt2 {puts -nonewline "> "}
set vlog_format %h
set vhdl_format %v
set real_precision 6
set display_unit auto
set time_unit module
set heap_garbage_size -200
set heap_garbage_time 0
set assert_report_level note
set assert_stop_level error
set autoscope yes
set assert_1164_warnings yes
set pack_assert_off {}
set severity_pack_assert_off {note warning}
set assert_output_stop_level failed
set tcl_debug_level 0
set relax_path_name 1
set vhdl_vcdmap XX01ZX01X
set intovf_severity_level ERROR
set probe_screen_format 0
set rangecnst_severity_level ERROR
set textio_severity_level ERROR
set vital_timing_checks_on 1
set vlog_code_show_force 0
set assert_count_attempts 1
set tcl_all64 false
set tcl_runerror_exit false
set assert_report_incompletes 0
set show_force 1
set force_reset_by_reinvoke 0
set tcl_relaxed_literal 0
set probe_exclude_patterns {}
set probe_packed_limit 4k
set probe_unpacked_limit 16k
set assert_internal_msg no
set svseed 1
set assert_reporting_mode 0
set vcd_compact_mode 0
database -open -vcd -into wave.vcd _wave.vcd1 -timescale fs
database -open -evcd -into wave.vcd _wave.vcd -timescale fs
database -open -shm -into waves.shm waves -default
probe -create -database waves tb_rv32m_enabled.tb_nRST tb_rv32m_enabled.tb_CLK tb_rv32m_enabled.tb_test_case_num tb_rv32m_enabled.tb_start tb_rv32m_enabled.tb_finished tb_rv32m_enabled.operation tb_rv32m_enabled.tb_multiplicand tb_rv32m_enabled.tb_multiplier tb_rv32m_enabled.tb_product tb_rv32m_enabled.tb_expected_out tb_rv32m_enabled.rv32m.rv32m_start tb_rv32m_enabled.rv32m.rv32m_out tb_rv32m_enabled.rv32m.rv32m_done tb_rv32m_enabled.rv32m.rv32m_a tb_rv32m_enabled.rv32m.rv32m_b tb_rv32m_enabled.rv32m.product tb_rv32m_enabled.rv32m.overflow tb_rv32m_enabled.rv32m.operation_save tb_rv32m_enabled.rv32m.operation tb_rv32m_enabled.rv32m.operand_diff tb_rv32m_enabled.rv32m.op_b_save tb_rv32m_enabled.rv32m.op_b tb_rv32m_enabled.rv32m.op_a_save tb_rv32m_enabled.rv32m.op_a tb_rv32m_enabled.rv32m.multiplier tb_rv32m_enabled.rv32m.multiplicand tb_rv32m_enabled.rv32m.mul_start tb_rv32m_enabled.rv32m.mul_finished tb_rv32m_enabled.rv32m.is_signed tb_rv32m_enabled.rv32m.is_multiply tb_rv32m_enabled.rv32m.mult_i.start tb_rv32m_enabled.rv32m.mult_i.finished tb_rv32m_enabled.rv32m.mult_i.product tb_rv32m_enabled.rv32m.mult_i.partial_product tb_rv32m_enabled.rv32m.mult_i.multiplier_reg tb_rv32m_enabled.rv32m.mult_i.multiplier_ext tb_rv32m_enabled.rv32m.mult_i.multiplicand_reg tb_rv32m_enabled.rv32m.mult_i.multiplicand_ext tb_rv32m_enabled.rv32m.mult_i.mult_complete tb_rv32m_enabled.rv32m.mult_i.is_signed

simvision -input restore.tcl.svcf
