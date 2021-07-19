
# NC-Sim Command File
# TOOL:	ncsim(64)	15.20-s030
#
#
# You can restore this configuration with:
#
#      irun -access +rwc +nctimescale+1ns/1ns -incdir /home/ecegridfs/a/socet94/RISCVBusiness/source_code/include/ coherence_ctrl.sv coherence_ctrl_tb.sv -input wave.tcl -input /home/ecegridfs/a/socet94/RISCVBusiness/source_code/coherence_control/wave.tcl
#

set tcl_prompt1 {puts -nonewline "ncsim> "}
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
alias . run
alias iprof profile
alias quit exit
database -open -shm -into waves.shm waves -default
probe -create -database waves cocherence_ctrl_tb.CLK cocherence_ctrl_tb.test_case_info cocherence_ctrl_tb.tb_err cocherence_ctrl_tb.nRST cocherence_ctrl_tb.test_case_num cocherence_ctrl_tb.DUT.s cocherence_ctrl_tb.ccif.ccdirty cocherence_ctrl_tb.ccif.ccexclusive cocherence_ctrl_tb.ccif.cchit cocherence_ctrl_tb.ccif.ccinv cocherence_ctrl_tb.ccif.ccsnpaddr cocherence_ctrl_tb.ccif.cctrans cocherence_ctrl_tb.ccif.ccwait cocherence_ctrl_tb.ccif.ccwrite cocherence_ctrl_tb.ccif.dREN cocherence_ctrl_tb.ccif.dWEN cocherence_ctrl_tb.ccif.daddr cocherence_ctrl_tb.ccif.dload cocherence_ctrl_tb.ccif.dstore cocherence_ctrl_tb.ccif.dwait cocherence_ctrl_tb.ccif.l2REN cocherence_ctrl_tb.ccif.l2WEN cocherence_ctrl_tb.ccif.l2addr cocherence_ctrl_tb.ccif.l2load cocherence_ctrl_tb.ccif.l2state cocherence_ctrl_tb.ccif.l2store
probe -create -database waves cocherence_ctrl_tb.DUT.ns
probe -create -database waves

simvision -input wave.tcl.svcf
