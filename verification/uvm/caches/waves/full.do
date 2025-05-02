onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_caches_top/i_cif/CLK
add wave -noupdate -color Salmon /tb_caches_top/i_cif/nRST
add wave -noupdate -group i_cpu_bus_if /tb_caches_top/i_cpu_bus_if/addr
add wave -noupdate -group i_cpu_bus_if -color Salmon /tb_caches_top/i_cpu_bus_if/wdata
add wave -noupdate -group i_cpu_bus_if /tb_caches_top/i_cpu_bus_if/rdata
add wave -noupdate -group i_cpu_bus_if -color Cyan /tb_caches_top/i_cpu_bus_if/ren
add wave -noupdate -group i_cpu_bus_if -color Violet /tb_caches_top/i_cpu_bus_if/wen
add wave -noupdate -group i_cpu_bus_if -color Orange /tb_caches_top/i_cpu_bus_if/busy
add wave -noupdate -group i_cpu_bus_if /tb_caches_top/i_cpu_bus_if/byte_en
add wave -noupdate -expand -group d_cpu_bus_if /tb_caches_top/d_cpu_bus_if/addr
add wave -noupdate -expand -group d_cpu_bus_if -color Salmon /tb_caches_top/d_cpu_bus_if/wdata
add wave -noupdate -expand -group d_cpu_bus_if /tb_caches_top/d_cpu_bus_if/rdata
add wave -noupdate -expand -group d_cpu_bus_if -color Cyan /tb_caches_top/d_cpu_bus_if/ren
add wave -noupdate -expand -group d_cpu_bus_if -color Violet /tb_caches_top/d_cpu_bus_if/wen
add wave -noupdate -expand -group d_cpu_bus_if -color Orange /tb_caches_top/d_cpu_bus_if/busy
add wave -noupdate -expand -group d_cpu_bus_if /tb_caches_top/d_cpu_bus_if/byte_en
add wave -noupdate -group i_l1_arb_bus_if /tb_caches_top/i_l1_arb_bus_if/addr
add wave -noupdate -group i_l1_arb_bus_if -color Salmon /tb_caches_top/i_l1_arb_bus_if/wdata
add wave -noupdate -group i_l1_arb_bus_if /tb_caches_top/i_l1_arb_bus_if/rdata
add wave -noupdate -group i_l1_arb_bus_if -color Cyan /tb_caches_top/i_l1_arb_bus_if/ren
add wave -noupdate -group i_l1_arb_bus_if -color Violet /tb_caches_top/i_l1_arb_bus_if/wen
add wave -noupdate -group i_l1_arb_bus_if -color Orange /tb_caches_top/i_l1_arb_bus_if/busy
add wave -noupdate -group i_l1_arb_bus_if /tb_caches_top/i_l1_arb_bus_if/byte_en
add wave -noupdate -expand -group d_l1_arb_bus_if /tb_caches_top/d_l1_arb_bus_if/addr
add wave -noupdate -expand -group d_l1_arb_bus_if -color Salmon /tb_caches_top/d_l1_arb_bus_if/wdata
add wave -noupdate -expand -group d_l1_arb_bus_if /tb_caches_top/d_l1_arb_bus_if/rdata
add wave -noupdate -expand -group d_l1_arb_bus_if -color Cyan /tb_caches_top/d_l1_arb_bus_if/ren
add wave -noupdate -expand -group d_l1_arb_bus_if -color Violet /tb_caches_top/d_l1_arb_bus_if/wen
add wave -noupdate -expand -group d_l1_arb_bus_if -color Orange /tb_caches_top/d_l1_arb_bus_if/busy
add wave -noupdate -expand -group d_l1_arb_bus_if /tb_caches_top/d_l1_arb_bus_if/byte_en
add wave -noupdate -expand -group arb_l2_bus_if /tb_caches_top/arb_l2_bus_if/addr
add wave -noupdate -expand -group arb_l2_bus_if -color Salmon /tb_caches_top/arb_l2_bus_if/wdata
add wave -noupdate -expand -group arb_l2_bus_if /tb_caches_top/arb_l2_bus_if/rdata
add wave -noupdate -expand -group arb_l2_bus_if -color Cyan /tb_caches_top/arb_l2_bus_if/ren
add wave -noupdate -expand -group arb_l2_bus_if -color Violet /tb_caches_top/arb_l2_bus_if/wen
add wave -noupdate -expand -group arb_l2_bus_if -color Orange /tb_caches_top/arb_l2_bus_if/busy
add wave -noupdate -expand -group arb_l2_bus_if /tb_caches_top/arb_l2_bus_if/byte_en
add wave -noupdate -expand -group mem_bus_if /tb_caches_top/mem_bus_if/addr
add wave -noupdate -expand -group mem_bus_if -color Salmon /tb_caches_top/mem_bus_if/wdata
add wave -noupdate -expand -group mem_bus_if /tb_caches_top/mem_bus_if/rdata
add wave -noupdate -expand -group mem_bus_if -color Cyan /tb_caches_top/mem_bus_if/ren
add wave -noupdate -expand -group mem_bus_if -color Violet /tb_caches_top/mem_bus_if/wen
add wave -noupdate -expand -group mem_bus_if -color Orange /tb_caches_top/mem_bus_if/busy
add wave -noupdate -expand -group mem_bus_if /tb_caches_top/mem_bus_if/byte_en
add wave -noupdate -group i_l1 -group params /tb_caches_top/i_l1/CACHE_SIZE
add wave -noupdate -group i_l1 -group params /tb_caches_top/i_l1/BLOCK_SIZE
add wave -noupdate -group i_l1 -group params /tb_caches_top/i_l1/ASSOC
add wave -noupdate -group i_l1 -group params /tb_caches_top/i_l1/NONCACHE_START_ADDR
add wave -noupdate -group i_l1 -group params /tb_caches_top/i_l1/N_TOTAL_FRAMES
add wave -noupdate -group i_l1 -group params /tb_caches_top/i_l1/N_SETS
add wave -noupdate -group i_l1 -group params /tb_caches_top/i_l1/N_FRAME_BITS
add wave -noupdate -group i_l1 -group params /tb_caches_top/i_l1/N_SET_BITS
add wave -noupdate -group i_l1 -group params /tb_caches_top/i_l1/N_BLOCK_BITS
add wave -noupdate -group i_l1 -group params /tb_caches_top/i_l1/N_TAG_BITS
add wave -noupdate -group i_l1 -group params /tb_caches_top/i_l1/FRAME_SIZE
add wave -noupdate -group i_l1 -group if /tb_caches_top/i_l1/CLK
add wave -noupdate -group i_l1 -group if /tb_caches_top/i_l1/nRST
add wave -noupdate -group i_l1 -group if /tb_caches_top/i_l1/clear
add wave -noupdate -group i_l1 -group if /tb_caches_top/i_l1/flush
add wave -noupdate -group i_l1 -group if /tb_caches_top/i_l1/clear_done
add wave -noupdate -group i_l1 -group if /tb_caches_top/i_l1/flush_done
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/set_num
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/next_set_num
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/en_set_ctr
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/clr_set_ctr
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/frame_num
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/next_frame_num
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/en_frame_ctr
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/clr_frame_ctr
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/word_num
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/next_word_num
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/en_word_ctr
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/clr_word_ctr
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/finish_word
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/finish_frame
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/finish_set
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/state
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/next_state
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/cache
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/next_cache
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/ridx
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/last_used
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/next_last_used
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/read_addr
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/next_read_addr
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/decoded_addr
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/hit
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/pass_through
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/hit_data
add wave -noupdate -group i_l1 /tb_caches_top/i_l1/hit_idx
add wave -noupdate -group d_l1 -group params /tb_caches_top/d_l1/CACHE_SIZE
add wave -noupdate -group d_l1 -group params /tb_caches_top/d_l1/BLOCK_SIZE
add wave -noupdate -group d_l1 -group params /tb_caches_top/d_l1/ASSOC
add wave -noupdate -group d_l1 -group params /tb_caches_top/d_l1/NONCACHE_START_ADDR
add wave -noupdate -group d_l1 -group params /tb_caches_top/d_l1/N_TOTAL_FRAMES
add wave -noupdate -group d_l1 -group params /tb_caches_top/d_l1/N_SETS
add wave -noupdate -group d_l1 -group params /tb_caches_top/d_l1/N_FRAME_BITS
add wave -noupdate -group d_l1 -group params /tb_caches_top/d_l1/N_SET_BITS
add wave -noupdate -group d_l1 -group params /tb_caches_top/d_l1/N_BLOCK_BITS
add wave -noupdate -group d_l1 -group params /tb_caches_top/d_l1/N_TAG_BITS
add wave -noupdate -group d_l1 -group params /tb_caches_top/d_l1/FRAME_SIZE
add wave -noupdate -group d_l1 -group if /tb_caches_top/d_l1/CLK
add wave -noupdate -group d_l1 -group if /tb_caches_top/d_l1/nRST
add wave -noupdate -group d_l1 -group if /tb_caches_top/d_l1/clear
add wave -noupdate -group d_l1 -group if /tb_caches_top/d_l1/flush
add wave -noupdate -group d_l1 -group if /tb_caches_top/d_l1/clear_done
add wave -noupdate -group d_l1 -group if /tb_caches_top/d_l1/flush_done
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/set_num
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/next_set_num
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/en_set_ctr
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/clr_set_ctr
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/frame_num
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/next_frame_num
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/en_frame_ctr
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/clr_frame_ctr
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/word_num
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/next_word_num
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/en_word_ctr
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/clr_word_ctr
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/finish_word
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/finish_frame
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/finish_set
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/state
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/next_state
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/cache
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/next_cache
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/ridx
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/last_used
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/next_last_used
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/read_addr
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/next_read_addr
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/decoded_addr
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/hit
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/pass_through
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/hit_data
add wave -noupdate -group d_l1 /tb_caches_top/d_l1/hit_idx
add wave -noupdate -group mem_arb /tb_caches_top/mem_arb/CLK
add wave -noupdate -group mem_arb /tb_caches_top/mem_arb/nRST
add wave -noupdate -group mem_arb /tb_caches_top/mem_arb/state
add wave -noupdate -group mem_arb /tb_caches_top/mem_arb/next_state
add wave -noupdate -group l2 -group params -radix decimal /tb_caches_top/l2/CACHE_SIZE
add wave -noupdate -group l2 -group params -radix decimal /tb_caches_top/l2/BLOCK_SIZE
add wave -noupdate -group l2 -group params -radix decimal /tb_caches_top/l2/ASSOC
add wave -noupdate -group l2 -group params /tb_caches_top/l2/NONCACHE_START_ADDR
add wave -noupdate -group l2 -group params -radix decimal /tb_caches_top/l2/N_TOTAL_FRAMES
add wave -noupdate -group l2 -group params -radix decimal /tb_caches_top/l2/N_SETS
add wave -noupdate -group l2 -group params -radix decimal /tb_caches_top/l2/N_FRAME_BITS
add wave -noupdate -group l2 -group params -radix decimal /tb_caches_top/l2/N_SET_BITS
add wave -noupdate -group l2 -group params -radix decimal /tb_caches_top/l2/N_BLOCK_BITS
add wave -noupdate -group l2 -group params -radix decimal /tb_caches_top/l2/N_TAG_BITS
add wave -noupdate -group l2 -group params -radix decimal /tb_caches_top/l2/FRAME_SIZE
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
WaveRestoreCursors {{Cursor 1} {198037 ps} 0}
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
WaveRestoreZoom {14943475 ps} {15163975 ps}
