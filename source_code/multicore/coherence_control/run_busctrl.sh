vlog -sv -work work *.sv +incdir+../../include 
vsim -c -voptargs="+acc" work.bus_ctrl_tb -do "do wave.do; run -all" 
