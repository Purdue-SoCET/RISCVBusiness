onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /l1_cache_tb/CLK
add wave -noupdate /l1_cache_tb/nRST
add wave -noupdate -divider {Input Signals}
add wave -noupdate /l1_cache_tb/proc_gen_bus_if/addr
add wave -noupdate /l1_cache_tb/proc_gen_bus_if/wdata
add wave -noupdate /l1_cache_tb/proc_gen_bus_if/wen
add wave -noupdate /l1_cache_tb/mem_gen_bus_if/busy
add wave -noupdate -divider {Output Signals}
add wave -noupdate /l1_cache_tb/mem_gen_bus_if/addr
add wave -noupdate /l1_cache_tb/mem_gen_bus_if/rdata
add wave -noupdate /l1_cache_tb/mem_gen_bus_if/ren
add wave -noupdate /l1_cache_tb/mem_gen_bus_if/wen
add wave -noupdate -divider {Cache State}
add wave -noupdate /l1_cache_tb/DUT/state
add wave -noupdate /l1_cache_tb/DUT/next_state
add wave -noupdate /l1_cache_tb/DUT/flush_idx
add wave -noupdate /l1_cache_tb/DUT/flush_done
add wave -noupdate -divider {Egress Queue}
add wave -noupdate /l1_cache_tb/DUT/enqueue
add wave -noupdate /l1_cache_tb/DUT/eq_datain
add wave -noupdate -expand -subitemconfig {{/l1_cache_tb/DUT/egress_queue[2]} -expand {/l1_cache_tb/DUT/egress_queue[1]} -expand {/l1_cache_tb/DUT/egress_queue[0]} -expand {/l1_cache_tb/DUT/egress_queue[0].pair} -expand} /l1_cache_tb/DUT/egress_queue
add wave -noupdate /l1_cache_tb/DUT/eq_wptr
add wave -noupdate /l1_cache_tb/DUT/eq_rptr
add wave -noupdate /l1_cache_tb/DUT/eq_wordcnt
add wave -noupdate /l1_cache_tb/DUT/eq_wordcntdone
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {234770 ps} 0}
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
WaveRestoreZoom {200210 ps} {289460 ps}
