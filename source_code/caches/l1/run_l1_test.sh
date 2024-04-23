vlog -sv -work work l1_cache_tb.sv l1_cache.sv ../sram/sram.sv +incdir+../../include
vsim -voptargs="+acc" work.l1_cache_tb -do "do wave.do; run -all"