
# XM-Sim Command File
# TOOL:	xmsim(64)	23.03-s004
#
#
# You can restore this configuration with:
#
#      xrun -q -f edalize_main.f +xmtimescale+1ns/100ps -input /home/asicfab/a/socet136/AFTx07/RISCVBusiness/source_code/caches/wave.tcl -top tb_caches -access rwc
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
probe -create -database waves tb_caches.nRST tb_caches.test tb_caches.CLK tb_caches.DUT_bus_if.addr tb_caches.DUT_bus_if.busy tb_caches.DUT_bus_if.byte_en tb_caches.DUT_bus_if.error tb_caches.DUT_bus_if.rdata tb_caches.DUT_bus_if.ren tb_caches.DUT_bus_if.wdata tb_caches.DUT_bus_if.wen tb_caches.mem_ctrl tb_caches.cache_2_ram_if.addr tb_caches.cache_2_ram_if.busy tb_caches.cache_2_ram_if.byte_en tb_caches.cache_2_ram_if.error tb_caches.cache_2_ram_if.rdata tb_caches.cache_2_ram_if.ren tb_caches.cache_2_ram_if.wdata tb_caches.cache_2_ram_if.wen tb_caches.tb_bus_if.addr tb_caches.tb_bus_if.busy tb_caches.tb_bus_if.byte_en tb_caches.tb_bus_if.error tb_caches.tb_bus_if.rdata tb_caches.tb_bus_if.ren tb_caches.tb_bus_if.wdata tb_caches.tb_bus_if.wen tb_caches.DUT.next_state tb_caches.DUT.curr_state tb_caches.DUT.req_addr tb_caches.DUT.hit tb_caches.DUT.frame_buffer tb_caches.DUT.frame_buffer_next tb_caches.DUT.direct_mem_req tb_caches.gold_bus_if.addr tb_caches.gold_bus_if.busy tb_caches.gold_bus_if.byte_en tb_caches.gold_bus_if.error tb_caches.gold_bus_if.rdata tb_caches.gold_bus_if.ren tb_caches.gold_bus_if.wdata tb_caches.gold_bus_if.wen tb_caches.DUT_ram_if.addr tb_caches.DUT_ram_if.busy tb_caches.DUT_ram_if.byte_en tb_caches.DUT_ram_if.error tb_caches.DUT_ram_if.rdata tb_caches.DUT_ram_if.ren tb_caches.DUT_ram_if.wdata tb_caches.DUT_ram_if.wen tb_caches.DUT_ram.v_lat_ram.memory tb_caches.DUT_ram.v_lat_ram.wdata_in tb_caches.DUT_ram.v_lat_ram.addr_in tb_caches.DUT_ram.v_lat_ram.byte_en_in tb_caches.DUT_ram.v_lat_ram.wen_in tb_caches.DUT_ram.v_lat_ram.ren_in tb_caches.DUT_ram.v_lat_ram.rdata_out tb_caches.DUT_ram.v_lat_ram.busy_out tb_caches.DUT.cache_mem.v_lat_ram.memory tb_caches.DUT.cache_mem.wdata tb_caches.DUT.cache_mem.addr tb_caches.DUT.cache_mem.byte_en tb_caches.DUT.cache_mem.wen tb_caches.DUT.cache_mem.ren tb_caches.DUT.cache_mem.rdata tb_caches.DUT.cache_mem.busy
probe -create -database waves tb_caches.DUT.clear_flag tb_caches.DUT.flush_flag tb_caches.DUT.cache_busy tb_caches.DUT.request
probe -create -database waves tb_caches.DUT.flush tb_caches.DUT.flush_reg tb_caches.DUT.init_flag tb_caches.DUT.clear tb_caches.DUT.clear_reg
probe -create -database waves tb_caches.DUT.flush_cnt tb_caches.DUT.flush_done
probe -create -database waves tb_caches.DUT.req_byte_en tb_caches.DUT.req_byte_en_expand
probe -create -database waves tb_caches.gold_ram.v_lat_ram.memory
probe -create -database waves

simvision -input wave.tcl.svcf
