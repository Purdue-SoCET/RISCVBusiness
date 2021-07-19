vlog -sv -work work *.sv +incdir+../../include 
vsim -c -voptargs="+acc" work.sram_tb -do "do wave.do; run -all" 
