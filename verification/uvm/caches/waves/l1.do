onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_caches_top/d_cif/CLK
add wave -noupdate -color Firebrick /tb_caches_top/d_cif/nRST
add wave -noupdate -expand -group cif /tb_caches_top/d_cif/clear
add wave -noupdate -expand -group cif -color {Medium Spring Green} /tb_caches_top/d_cif/flush
add wave -noupdate -expand -group cif /tb_caches_top/d_cif/clear_done
add wave -noupdate -expand -group cif -color {Medium Spring Green} /tb_caches_top/d_cif/flush_done
add wave -noupdate -expand -group cpu_bus_if -color Magenta /tb_caches_top/d_cpu_bus_if/addr
add wave -noupdate -expand -group cpu_bus_if -color Cyan /tb_caches_top/d_cpu_bus_if/wdata
add wave -noupdate -expand -group cpu_bus_if /tb_caches_top/d_cpu_bus_if/rdata
add wave -noupdate -expand -group cpu_bus_if -color {Indian Red} /tb_caches_top/d_cpu_bus_if/ren
add wave -noupdate -expand -group cpu_bus_if -color {Green Yellow} /tb_caches_top/d_cpu_bus_if/wen
add wave -noupdate -expand -group cpu_bus_if -color Red /tb_caches_top/d_cpu_bus_if/busy
add wave -noupdate -expand -group cpu_bus_if -color Gold /tb_caches_top/d_cpu_bus_if/byte_en
add wave -noupdate -expand -group mem_bus_if -color Magenta /tb_caches_top/mem_bus_if/addr
add wave -noupdate -expand -group mem_bus_if -color Cyan /tb_caches_top/mem_bus_if/wdata
add wave -noupdate -expand -group mem_bus_if /tb_caches_top/mem_bus_if/rdata
add wave -noupdate -expand -group mem_bus_if -color {Indian Red} /tb_caches_top/mem_bus_if/ren
add wave -noupdate -expand -group mem_bus_if -color {Green Yellow} /tb_caches_top/mem_bus_if/wen
add wave -noupdate -expand -group mem_bus_if -color Red /tb_caches_top/mem_bus_if/busy
add wave -noupdate -expand -group mem_bus_if -color Gold /tb_caches_top/mem_bus_if/byte_en
add wave -noupdate -expand -group l1 -group params /tb_caches_top/l1/CACHE_SIZE
add wave -noupdate -expand -group l1 -group params /tb_caches_top/l1/BLOCK_SIZE
add wave -noupdate -expand -group l1 -group params /tb_caches_top/l1/ASSOC
add wave -noupdate -expand -group l1 -group params /tb_caches_top/l1/NONCACHE_START_ADDR
add wave -noupdate -expand -group l1 -group params /tb_caches_top/l1/N_TOTAL_FRAMES
add wave -noupdate -expand -group l1 -group params /tb_caches_top/l1/N_SETS
add wave -noupdate -expand -group l1 -group params /tb_caches_top/l1/N_FRAME_BITS
add wave -noupdate -expand -group l1 -group params /tb_caches_top/l1/N_SET_BITS
add wave -noupdate -expand -group l1 -group params /tb_caches_top/l1/N_BLOCK_BITS
add wave -noupdate -expand -group l1 -group params /tb_caches_top/l1/N_TAG_BITS
add wave -noupdate -expand -group l1 -group params /tb_caches_top/l1/FRAME_SIZE
add wave -noupdate -expand -group l1 -group if /tb_caches_top/l1/CLK
add wave -noupdate -expand -group l1 -group if /tb_caches_top/l1/nRST
add wave -noupdate -expand -group l1 -group if /tb_caches_top/l1/clear
add wave -noupdate -expand -group l1 -group if /tb_caches_top/l1/flush
add wave -noupdate -expand -group l1 -group if /tb_caches_top/l1/clear_done
add wave -noupdate -expand -group l1 -group if /tb_caches_top/l1/flush_done
add wave -noupdate -expand -group l1 /tb_caches_top/l1/set_num
add wave -noupdate -expand -group l1 /tb_caches_top/l1/next_set_num
add wave -noupdate -expand -group l1 /tb_caches_top/l1/en_set_ctr
add wave -noupdate -expand -group l1 /tb_caches_top/l1/clr_set_ctr
add wave -noupdate -expand -group l1 /tb_caches_top/l1/frame_num
add wave -noupdate -expand -group l1 /tb_caches_top/l1/next_frame_num
add wave -noupdate -expand -group l1 /tb_caches_top/l1/en_frame_ctr
add wave -noupdate -expand -group l1 /tb_caches_top/l1/clr_frame_ctr
add wave -noupdate -expand -group l1 /tb_caches_top/l1/word_num
add wave -noupdate -expand -group l1 /tb_caches_top/l1/next_word_num
add wave -noupdate -expand -group l1 /tb_caches_top/l1/en_word_ctr
add wave -noupdate -expand -group l1 /tb_caches_top/l1/clr_word_ctr
add wave -noupdate -expand -group l1 /tb_caches_top/l1/finish_word
add wave -noupdate -expand -group l1 /tb_caches_top/l1/finish_frame
add wave -noupdate -expand -group l1 /tb_caches_top/l1/finish_set
add wave -noupdate -expand -group l1 /tb_caches_top/l1/abort
add wave -noupdate -expand -group l1 /tb_caches_top/l1/state
add wave -noupdate -expand -group l1 /tb_caches_top/l1/next_state
add wave -noupdate -expand -group l1 /tb_caches_top/l1/ridx
add wave -noupdate -expand -group l1 /tb_caches_top/l1/last_used
add wave -noupdate -expand -group l1 /tb_caches_top/l1/next_last_used
add wave -noupdate -expand -group l1 /tb_caches_top/l1/read_addr
add wave -noupdate -expand -group l1 /tb_caches_top/l1/next_read_addr
add wave -noupdate -expand -group l1 /tb_caches_top/l1/decoded_req_addr
add wave -noupdate -expand -group l1 /tb_caches_top/l1/decoded_addr
add wave -noupdate -expand -group l1 /tb_caches_top/l1/hit
add wave -noupdate -expand -group l1 /tb_caches_top/l1/pass_through
add wave -noupdate -expand -group l1 /tb_caches_top/l1/hit_data
add wave -noupdate -expand -group l1 /tb_caches_top/l1/hit_idx
add wave -noupdate /tb_caches_top/l1/SRAM/CLK
add wave -noupdate /tb_caches_top/l1/SRAM/nRST
add wave -noupdate /tb_caches_top/l1/SRAM/wVal
add wave -noupdate /tb_caches_top/l1/SRAM/rVal
add wave -noupdate /tb_caches_top/l1/SRAM/REN
add wave -noupdate /tb_caches_top/l1/SRAM/WEN
add wave -noupdate -expand /tb_caches_top/l1/SRAM/SEL
add wave -noupdate /tb_caches_top/l1/SRAM/sramMemory
add wave -noupdate /tb_caches_top/l1/SRAM/n_sramMemory
add wave -noupdate /tb_caches_top/l1/sramWrite
add wave -noupdate /tb_caches_top/l1/sramRead
add wave -noupdate /tb_caches_top/l1/sramREN
add wave -noupdate /tb_caches_top/l1/sramWEN
add wave -noupdate /tb_caches_top/l1/sramSEL
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {158676 ps} 0}
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
WaveRestoreZoom {0 ps} {450840 ps}
