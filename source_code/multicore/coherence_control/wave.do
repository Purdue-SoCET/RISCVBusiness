onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb_ctrl -color Magenta /bus_ctrl_tb/CLK
add wave -noupdate -expand -group tb_ctrl -color Magenta /bus_ctrl_tb/nRST
add wave -noupdate -expand -group tb_ctrl -color Magenta /bus_ctrl_tb/test_case_num
add wave -noupdate -expand -group tb_ctrl -color Magenta /bus_ctrl_tb/i
add wave -noupdate -expand -group tb_ctrl -color Magenta /bus_ctrl_tb/test_case_info
add wave -noupdate -expand -group tb_ctrl -color Magenta /bus_ctrl_tb/tb_err
add wave -noupdate -expand -group tb_ctrl -color Magenta /bus_ctrl_tb/supplier
add wave -noupdate -expand -group ccif -color Yellow /bus_ctrl_tb/ccif/dREN
add wave -noupdate -expand -group ccif -color Yellow /bus_ctrl_tb/ccif/dWEN
add wave -noupdate -expand -group ccif -color Yellow /bus_ctrl_tb/ccif/dwait
add wave -noupdate -expand -group ccif -color Yellow /bus_ctrl_tb/ccif/dload
add wave -noupdate -expand -group ccif -color Yellow /bus_ctrl_tb/ccif/dstore
add wave -noupdate -expand -group ccif -color {Light Blue} /bus_ctrl_tb/ccif/cctrans
add wave -noupdate -expand -group ccif -color {Light Blue} /bus_ctrl_tb/ccif/ccwrite
add wave -noupdate -expand -group ccif -color {Light Blue} /bus_ctrl_tb/ccif/ccsnoophit
add wave -noupdate -expand -group ccif -color {Light Blue} /bus_ctrl_tb/ccif/ccIsPresent
add wave -noupdate -expand -group ccif -color {Light Blue} /bus_ctrl_tb/ccif/ccdirty
add wave -noupdate -expand -group ccif -color {Light Blue} /bus_ctrl_tb/ccif/ccwait
add wave -noupdate -expand -group ccif -color {Light Blue} /bus_ctrl_tb/ccif/ccinv
add wave -noupdate -expand -group ccif -color {Light Blue} /bus_ctrl_tb/ccif/ccexclusive
add wave -noupdate -expand -group ccif -color {Light Blue} /bus_ctrl_tb/ccif/ccsnoopaddr
add wave -noupdate -expand -group ccif /bus_ctrl_tb/ccif/daddr
add wave -noupdate -expand -group ccif /bus_ctrl_tb/ccif/l2state
add wave -noupdate -expand -group ccif /bus_ctrl_tb/ccif/l2load
add wave -noupdate -expand -group ccif /bus_ctrl_tb/ccif/l2store
add wave -noupdate -expand -group ccif /bus_ctrl_tb/ccif/l2WEN
add wave -noupdate -expand -group ccif /bus_ctrl_tb/ccif/l2REN
add wave -noupdate -expand -group ccif /bus_ctrl_tb/ccif/l2addr
add wave -noupdate -expand -group internal -color Khaki /bus_ctrl_tb/DUT/state
add wave -noupdate -expand -group internal -color Khaki /bus_ctrl_tb/DUT/nstate
add wave -noupdate -expand -group internal -color Khaki /bus_ctrl_tb/DUT/requester_cpu
add wave -noupdate -expand -group internal -color Khaki /bus_ctrl_tb/DUT/supplier_cpu
add wave -noupdate -expand -group internal -color Khaki /bus_ctrl_tb/DUT/exclusiveUpdate
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {201760 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 301
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
WaveRestoreZoom {0 ps} {694750 ps}
