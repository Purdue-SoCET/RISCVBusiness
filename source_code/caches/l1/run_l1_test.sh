vlog -sv -work work *.sv +incdir+/home/asicfab/a/socet65/fgmt/RISCVBusiness/source_code/include
vsim -c -voptargs="+acc" work.l1_cache_tb -do "do wave.do; run -all"