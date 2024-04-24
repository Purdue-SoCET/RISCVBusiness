onerror {resume}
quietly virtual function -install /l1_cache_tb/mem_gen_bus_if -env /l1_cache_tb/mem_gen_bus_if { &{/l1_cache_tb/mem_gen_bus_if/busy, /l1_cache_tb/mem_gen_bus_if/rdata }} MemSide
quietly WaveActivateNextPane {} 0
add wave -noupdate /l1_cache_tb/CLK
add wave -noupdate /l1_cache_tb/nRST
add wave -noupdate /l1_cache_tb/test
add wave -noupdate -divider {Input Signals}
add wave -noupdate -expand -group ProcSide /l1_cache_tb/proc_gen_bus_if/addr
add wave -noupdate -expand -group ProcSide /l1_cache_tb/proc_gen_bus_if/wdata
add wave -noupdate -expand -group ProcSide /l1_cache_tb/proc_gen_bus_if/wen
add wave -noupdate -expand -group MemSide /l1_cache_tb/mem_gen_bus_if/busy
add wave -noupdate -expand -group MemSide /l1_cache_tb/mem_gen_bus_if/rdata
add wave -noupdate -divider {Output Signals}
add wave -noupdate /l1_cache_tb/mem_gen_bus_if/addr
add wave -noupdate /l1_cache_tb/mem_gen_bus_if/ren
add wave -noupdate /l1_cache_tb/mem_gen_bus_if/wen
add wave -noupdate -divider {Cache State}
add wave -noupdate -group {Cache State} /l1_cache_tb/DUT/state
add wave -noupdate -group {Cache State} /l1_cache_tb/DUT/next_state
add wave -noupdate -group {Cache State} /l1_cache_tb/DUT/flush_idx
add wave -noupdate -group {Cache State} /l1_cache_tb/DUT/flush_done
add wave -noupdate /l1_cache_tb/DUT/ustate
add wave -noupdate /l1_cache_tb/DUT/next_ustate
add wave -noupdate -expand /l1_cache_tb/DUT/SRAM/sramMemory
add wave -noupdate -expand /l1_cache_tb/DUT/SRAM/n_sramMemory
add wave -noupdate -divider {Egress Queue}
add wave -noupdate -expand -group {Egress Queue} /l1_cache_tb/DUT/enqueue
add wave -noupdate -expand -group {Egress Queue} -expand -subitemconfig {/l1_cache_tb/DUT/eq_datain.pair -expand} /l1_cache_tb/DUT/eq_datain
add wave -noupdate -expand -group {Egress Queue} -expand -subitemconfig {{/l1_cache_tb/DUT/egress_queue[1]} -expand {/l1_cache_tb/DUT/egress_queue[0]} -expand} /l1_cache_tb/DUT/egress_queue
add wave -noupdate -expand -group {Egress Queue} /l1_cache_tb/DUT/eq_wptr
add wave -noupdate -expand -group {Egress Queue} /l1_cache_tb/DUT/eq_rptr
add wave -noupdate -expand -group {Egress Queue} /l1_cache_tb/DUT/eq_wordcnt
add wave -noupdate -expand -group {Egress Queue} /l1_cache_tb/DUT/eq_wordcntdone
add wave -noupdate -divider {Ingress Queue}
add wave -noupdate -expand -group {Ingress Queue} -expand -subitemconfig {{/l1_cache_tb/DUT/ingress_queue[0]} -expand} /l1_cache_tb/DUT/ingress_queue
add wave -noupdate -expand -group {Ingress Queue} -expand /l1_cache_tb/DUT/iq_datain
add wave -noupdate -expand -group {Ingress Queue} /l1_cache_tb/DUT/iq_dataout
add wave -noupdate -expand -group {Ingress Queue} /l1_cache_tb/DUT/iq_empty
add wave -noupdate -expand -group {Ingress Queue} /l1_cache_tb/DUT/iq_ren
add wave -noupdate -expand -group {Ingress Queue} /l1_cache_tb/DUT/iq_rptr
add wave -noupdate -expand -group {Ingress Queue} /l1_cache_tb/DUT/iq_wen
add wave -noupdate -expand -group {Ingress Queue} /l1_cache_tb/DUT/iq_wordcnt
add wave -noupdate -expand -group {Ingress Queue} /l1_cache_tb/DUT/iq_wordcntdone
add wave -noupdate -expand -group {Ingress Queue} /l1_cache_tb/DUT/iq_wptr
add wave -noupdate -divider {Address Queue}
add wave -noupdate -expand -group {Address Queue} /l1_cache_tb/DUT/addr_queue
add wave -noupdate -expand -group {Address Queue} /l1_cache_tb/DUT/aq_datain
add wave -noupdate -expand -group {Address Queue} /l1_cache_tb/DUT/aq_dataout
add wave -noupdate -expand -group {Address Queue} /l1_cache_tb/DUT/aq_decoded
add wave -noupdate -expand -group {Address Queue} /l1_cache_tb/DUT/aq_rptr
add wave -noupdate -expand -group {Address Queue} /l1_cache_tb/DUT/aq_wptr
add wave -noupdate -expand -group {Address Queue} -divider SRAM
add wave -noupdate /l1_cache_tb/DUT/sramWrite
add wave -noupdate /l1_cache_tb/DUT/sramRead
add wave -noupdate /l1_cache_tb/DUT/sramMask
add wave -noupdate /l1_cache_tb/DUT/sramWEN
add wave -noupdate /l1_cache_tb/DUT/sramSEL
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {242200 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {32530 ps} {435140 ps}
