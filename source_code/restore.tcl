
# XM-Sim Command File
# TOOL:	xmsim(64)	21.09-s008
#
#
# You can restore this configuration with:
#
#      xrun packages/alu_types_pkg.sv packages/machine_mode_types_1_11_pkg.sv packages/machine_mode_types_1_12_pkg.sv packages/machine_mode_types_1_7_pkg.sv packages/machine_mode_types_pkg.sv packages/pma_types_1_12_pkg.sv packages/pmp_types_1_12_pkg.sv packages/rv32a_pkg.sv packages/rv32i_types_pkg.sv packages/rv32m_pkg.sv caches/l1/l1_cache.sv multicore/coherence_control/coherency_unit.sv standard_core/bus_ctrl.sv tb/tb_cache_coherency.sv standard_core/cache_coh_wrapper.sv caches/sram/sram.sv -incdir include/ -access +rwc -input restore.tcl
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
alias . run
alias quit exit
database -open -shm -into waves.shm waves -default
probe -create -database waves tb_cache_coherency.proc_gen_bus_if.addr tb_cache_coherency.proc_gen_bus_if.busy tb_cache_coherency.proc_gen_bus_if.byte_en tb_cache_coherency.proc_gen_bus_if.rdata tb_cache_coherency.proc_gen_bus_if.ren tb_cache_coherency.proc_gen_bus_if.wdata tb_cache_coherency.proc_gen_bus_if.wen tb_cache_coherency.proc_gen_bus_if.generic_bus.addr tb_cache_coherency.proc_gen_bus_if.generic_bus.busy tb_cache_coherency.proc_gen_bus_if.generic_bus.byte_en tb_cache_coherency.proc_gen_bus_if.generic_bus.rdata tb_cache_coherency.proc_gen_bus_if.generic_bus.ren tb_cache_coherency.proc_gen_bus_if.generic_bus.wdata tb_cache_coherency.proc_gen_bus_if.generic_bus.wen tb_cache_coherency.DUT.dcache.state tb_cache_coherency.DUT.dcache.hit tb_cache_coherency.DUT.dcache.pass_through tb_cache_coherency.DUT.dcache.sramRead tb_cache_coherency.mem_gen_bus_if.generic_bus.addr tb_cache_coherency.mem_gen_bus_if.generic_bus.busy tb_cache_coherency.mem_gen_bus_if.generic_bus.byte_en tb_cache_coherency.mem_gen_bus_if.generic_bus.rdata tb_cache_coherency.mem_gen_bus_if.generic_bus.ren tb_cache_coherency.mem_gen_bus_if.generic_bus.wdata tb_cache_coherency.mem_gen_bus_if.generic_bus.wen tb_cache_coherency.DUT.d_coherence_unit.state
probe -create -database waves tb_cache_coherency.DUT.bus.state tb_cache_coherency.bus_ctrl_if.cc.ccIsPresent tb_cache_coherency.bus_ctrl_if.cc.ccdirty tb_cache_coherency.bus_ctrl_if.cc.ccexclusive tb_cache_coherency.bus_ctrl_if.cc.ccinv tb_cache_coherency.bus_ctrl_if.cc.ccsnoopaddr tb_cache_coherency.bus_ctrl_if.cc.ccsnoopdone tb_cache_coherency.bus_ctrl_if.cc.ccsnoophit tb_cache_coherency.bus_ctrl_if.cc.ccwait tb_cache_coherency.bus_ctrl_if.cc.ccwrite tb_cache_coherency.bus_ctrl_if.cc.dREN tb_cache_coherency.bus_ctrl_if.cc.dWEN tb_cache_coherency.bus_ctrl_if.cc.daddr tb_cache_coherency.bus_ctrl_if.cc.dload tb_cache_coherency.bus_ctrl_if.cc.dstore tb_cache_coherency.bus_ctrl_if.cc.dwait tb_cache_coherency.bus_ctrl_if.cc.l2REN tb_cache_coherency.bus_ctrl_if.cc.l2WEN tb_cache_coherency.bus_ctrl_if.cc.l2addr tb_cache_coherency.bus_ctrl_if.cc.l2load tb_cache_coherency.bus_ctrl_if.cc.l2state tb_cache_coherency.bus_ctrl_if.cc.l2store

simvision -input restore.tcl.svcf
