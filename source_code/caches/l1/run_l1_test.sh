vlog -sv -work work l1_cache_tb.sv l1_cache.sv ../sram/sram.sv +incdir+/home/asicfab/a/socet65/fgmt/RISCVBusiness/source_code/include
vsim -voptargs="+acc" work.l1_cache_tb -do "do wave.do; run -all"