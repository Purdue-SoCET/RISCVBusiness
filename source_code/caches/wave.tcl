
# XM-Sim Command File
# TOOL:	xmsim(64)	23.03-s004
#
#
# You can restore this configuration with:
#
#      xrun -q -f edalize_main.f +xmtimescale+1ns/100ps -input ./wave.tcl -top tb_caches -access rwc -input /home/asicfab/a/socet136/AFTx07/RISCVBusiness/source_code/caches/wave.tcl
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
database -open -shm -into waves.shm waves -default
probe -create -database waves tb_caches.DUT.state tb_caches.DUT.word_count_done tb_caches.DUT.word_num tb_caches.DUT.idle_done tb_caches.test tb_caches.CLK tb_caches.cache_2_ram_if.request.addr tb_caches.cache_2_ram_if.request.burst_length tb_caches.cache_2_ram_if.request.busy tb_caches.cache_2_ram_if.request.error tb_caches.cache_2_ram_if.request.rdata tb_caches.cache_2_ram_if.request.size tb_caches.cache_2_ram_if.request.trans tb_caches.cache_2_ram_if.request.wdata tb_caches.cache_2_ram_if.request.write_enable tb_caches.DUT_bus_if.response.addr tb_caches.DUT_bus_if.response.burst_length tb_caches.DUT_bus_if.response.busy tb_caches.DUT_bus_if.response.error tb_caches.DUT_bus_if.response.rdata tb_caches.DUT_bus_if.response.size tb_caches.DUT_bus_if.response.trans tb_caches.DUT_bus_if.response.wdata tb_caches.DUT_bus_if.response.write_enable tb_caches.tb_bus_if.addr tb_caches.tb_bus_if.burst_length tb_caches.tb_bus_if.busy tb_caches.tb_bus_if.error tb_caches.tb_bus_if.rdata tb_caches.tb_bus_if.req_ready tb_caches.tb_bus_if.size tb_caches.tb_bus_if.trans tb_caches.tb_bus_if.wdata tb_caches.tb_bus_if.write_enable tb_caches.DUT.hit_idx tb_caches.DUT.hit_data tb_caches.DUT.hit tb_caches.DUT.flush_req tb_caches.DUT.flush_idx tb_caches.DUT.flush_done tb_caches.DUT.flush tb_caches.DUT.sramWrite tb_caches.DUT.sramWEN tb_caches.DUT.sramSEL tb_caches.DUT.sramRead tb_caches.DUT.sramMask tb_caches.DUT.SRAM.sramMemory
probe -create -database waves tb_caches.DUT_ram.v_lat_ram.memory
probe -create -database waves tb_caches.DUT_ram_if.addr tb_caches.DUT_ram_if.burst_length tb_caches.DUT_ram_if.busy tb_caches.DUT_ram_if.error tb_caches.DUT_ram_if.rdata tb_caches.DUT_ram_if.req_ready tb_caches.DUT_ram_if.size tb_caches.DUT_ram_if.trans tb_caches.DUT_ram_if.wdata tb_caches.DUT_ram_if.write_enable
probe -create -database waves tb_caches.DUT.SRAM.rVal tb_caches.DUT.SRAM.wVal tb_caches.DUT_ram.mask
probe -create -database waves tb_caches.DUT.decoded_addr tb_caches.DUT.decoded_req_addr
probe -create -database waves

simvision -input wave.tcl.svcf
