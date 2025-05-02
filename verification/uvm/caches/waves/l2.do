onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_caches_top/l2_cif/CLK
add wave -noupdate -color Red /tb_caches_top/l2_cif/nRST
add wave -noupdate -expand -group l2_cif /tb_caches_top/l2_cif/clear
add wave -noupdate -expand -group l2_cif -color Goldenrod /tb_caches_top/l2_cif/flush
add wave -noupdate -expand -group l2_cif /tb_caches_top/l2_cif/clear_done
add wave -noupdate -expand -group l2_cif -color Goldenrod /tb_caches_top/l2_cif/flush_done
add wave -noupdate -expand -group arb_l2_bus_if -color Magenta /tb_caches_top/arb_l2_bus_if/addr
add wave -noupdate -expand -group arb_l2_bus_if -color {Spring Green} /tb_caches_top/arb_l2_bus_if/wdata
add wave -noupdate -expand -group arb_l2_bus_if -color Coral /tb_caches_top/arb_l2_bus_if/rdata
add wave -noupdate -expand -group arb_l2_bus_if -color Firebrick /tb_caches_top/arb_l2_bus_if/ren
add wave -noupdate -expand -group arb_l2_bus_if -color {Green Yellow} /tb_caches_top/arb_l2_bus_if/wen
add wave -noupdate -expand -group arb_l2_bus_if -color {Sky Blue} /tb_caches_top/arb_l2_bus_if/busy
add wave -noupdate -expand -group arb_l2_bus_if -color Pink /tb_caches_top/arb_l2_bus_if/byte_en
add wave -noupdate -expand -group mem_bus_if -color Magenta /tb_caches_top/mem_bus_if/addr
add wave -noupdate -expand -group mem_bus_if -color {Spring Green} /tb_caches_top/mem_bus_if/wdata
add wave -noupdate -expand -group mem_bus_if -color Coral /tb_caches_top/mem_bus_if/rdata
add wave -noupdate -expand -group mem_bus_if -color Firebrick /tb_caches_top/mem_bus_if/ren
add wave -noupdate -expand -group mem_bus_if -color {Green Yellow} /tb_caches_top/mem_bus_if/wen
add wave -noupdate -expand -group mem_bus_if -color {Sky Blue} /tb_caches_top/mem_bus_if/busy
add wave -noupdate -expand -group mem_bus_if -color Pink /tb_caches_top/mem_bus_if/byte_en
add wave -noupdate -group l2 -group params -radix decimal /tb_caches_top/l2/CACHE_SIZE
add wave -noupdate -group l2 -group params -radix decimal /tb_caches_top/l2/BLOCK_SIZE
add wave -noupdate -group l2 -group params -radix decimal /tb_caches_top/l2/ASSOC
add wave -noupdate -group l2 -group params /tb_caches_top/l2/NONCACHE_START_ADDR
add wave -noupdate -group l2 -group params -radix decimal /tb_caches_top/l2/N_TOTAL_BYTES
add wave -noupdate -group l2 -group params -radix decimal /tb_caches_top/l2/N_TOTAL_WORDS
add wave -noupdate -group l2 -group params -radix decimal /tb_caches_top/l2/N_TOTAL_FRAMES
add wave -noupdate -group l2 -group params -radix decimal /tb_caches_top/l2/N_SETS
add wave -noupdate -group l2 -group params -radix decimal /tb_caches_top/l2/N_FRAME_BITS
add wave -noupdate -group l2 -group params -radix decimal /tb_caches_top/l2/N_SET_BITS
add wave -noupdate -group l2 -group params -radix decimal /tb_caches_top/l2/N_BLOCK_BITS
add wave -noupdate -group l2 -group params -radix decimal /tb_caches_top/l2/N_TAG_BITS
add wave -noupdate -group l2 -group params /tb_caches_top/l2/FRAME_SIZE
add wave -noupdate -group l2 -group if /tb_caches_top/l2/CLK
add wave -noupdate -group l2 -group if /tb_caches_top/l2/nRST
add wave -noupdate -group l2 -group if /tb_caches_top/l2/clear
add wave -noupdate -group l2 -group if /tb_caches_top/l2/flush
add wave -noupdate -group l2 -group if /tb_caches_top/l2/clear_done
add wave -noupdate -group l2 -group if /tb_caches_top/l2/flush_done
add wave -noupdate -group l2 /tb_caches_top/l2/set_num
add wave -noupdate -group l2 /tb_caches_top/l2/next_set_num
add wave -noupdate -group l2 /tb_caches_top/l2/en_set_ctr
add wave -noupdate -group l2 /tb_caches_top/l2/clr_set_ctr
add wave -noupdate -group l2 /tb_caches_top/l2/frame_num
add wave -noupdate -group l2 /tb_caches_top/l2/next_frame_num
add wave -noupdate -group l2 /tb_caches_top/l2/en_frame_ctr
add wave -noupdate -group l2 /tb_caches_top/l2/clr_frame_ctr
add wave -noupdate -group l2 /tb_caches_top/l2/word_num
add wave -noupdate -group l2 /tb_caches_top/l2/next_word_num
add wave -noupdate -group l2 /tb_caches_top/l2/en_word_ctr
add wave -noupdate -group l2 /tb_caches_top/l2/clr_word_ctr
add wave -noupdate -group l2 /tb_caches_top/l2/finish_word
add wave -noupdate -group l2 /tb_caches_top/l2/finish_frame
add wave -noupdate -group l2 /tb_caches_top/l2/finish_set
add wave -noupdate -group l2 /tb_caches_top/l2/state
add wave -noupdate -group l2 /tb_caches_top/l2/next_state
add wave -noupdate -group l2 /tb_caches_top/l2/cache
add wave -noupdate -group l2 /tb_caches_top/l2/next_cache
add wave -noupdate -group l2 /tb_caches_top/l2/decoded_addr
add wave -noupdate -group l2 /tb_caches_top/l2/hit
add wave -noupdate -group l2 /tb_caches_top/l2/pass_through
add wave -noupdate -group l2 /tb_caches_top/l2/hit_data
add wave -noupdate -group l2 /tb_caches_top/l2/hit_idx
add wave -noupdate -group l2 /tb_caches_top/l2/lru
add wave -noupdate -group l2 /tb_caches_top/l2/nextlru
add wave -noupdate -group l2 /tb_caches_top/l2/ridx
add wave -noupdate -group l2 /tb_caches_top/l2/read_addr
add wave -noupdate -group l2 /tb_caches_top/l2/next_read_addr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1897968 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 206
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
WaveRestoreZoom {0 ps} {4798927 ps}
