onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_bus_ctrl/bus_ctrl_if/nRST
add wave -noupdate -color Gold /tb_bus_ctrl/bus_ctrl_if/clk
add wave -noupdate -expand -group {Bus_ctrl -> L1} -color {Violet Red} /tb_bus_ctrl/bus_ctrl_if/dwait
add wave -noupdate -expand -group {Bus_ctrl -> L1} -color Coral /tb_bus_ctrl/bus_ctrl_if/dload
add wave -noupdate -expand -group {Bus_ctrl -> L1} -color {Cadet Blue} /tb_bus_ctrl/bus_ctrl_if/ccexclusive
add wave -noupdate -expand -group {L1 -> bus_ctrl} -color Cyan -expand -subitemconfig {{/tb_bus_ctrl/bus_ctrl_if/daddr[1]} {-color Cyan} {/tb_bus_ctrl/bus_ctrl_if/daddr[0]} {-color Cyan}} /tb_bus_ctrl/bus_ctrl_if/daddr
add wave -noupdate -expand -group {L1 -> bus_ctrl} /tb_bus_ctrl/bus_ctrl_if/ccdirty
add wave -noupdate -expand -group {L1 -> bus_ctrl} -color Magenta /tb_bus_ctrl/bus_ctrl_if/dWEN
add wave -noupdate -expand -group {L1 -> bus_ctrl} -color {Light Steel Blue} -subitemconfig {{/tb_bus_ctrl/bus_ctrl_if/dREN[1]} {-color {Light Steel Blue}} {/tb_bus_ctrl/bus_ctrl_if/dREN[0]} {-color {Light Steel Blue}}} /tb_bus_ctrl/bus_ctrl_if/dREN
add wave -noupdate -expand -group {L1 -> bus_ctrl} /tb_bus_ctrl/bus_ctrl_if/ccwrite
add wave -noupdate -expand -group {L1 -> bus_ctrl} /tb_bus_ctrl/bus_ctrl_if/dstore
add wave -noupdate -group {Bus_ctrl <-> L2} /tb_bus_ctrl/bus_ctrl_if/cctrans
add wave -noupdate -group {Bus_ctrl <-> L2} /tb_bus_ctrl/bus_ctrl_if/l2state
add wave -noupdate -group {Bus_ctrl <-> L2} /tb_bus_ctrl/bus_ctrl_if/l2load
add wave -noupdate -group {Bus_ctrl <-> L2} /tb_bus_ctrl/bus_ctrl_if/l2store
add wave -noupdate -group {Bus_ctrl <-> L2} /tb_bus_ctrl/bus_ctrl_if/l2WEN
add wave -noupdate -group {Bus_ctrl <-> L2} /tb_bus_ctrl/bus_ctrl_if/l2REN
add wave -noupdate -group {Bus_ctrl <-> L2} /tb_bus_ctrl/bus_ctrl_if/l2addr
add wave -noupdate -group {Bus_ctrl internal sigs} /tb_bus_ctrl/bus_ctrl_mod/state
add wave -noupdate -group {Bus_ctrl internal sigs} /tb_bus_ctrl/bus_ctrl_mod/nstate
add wave -noupdate -group {Bus_ctrl internal sigs} /tb_bus_ctrl/bus_ctrl_mod/requester_cpu
add wave -noupdate -group {Bus_ctrl internal sigs} /tb_bus_ctrl/bus_ctrl_mod/nrequester_cpu
add wave -noupdate -group {Bus_ctrl internal sigs} /tb_bus_ctrl/bus_ctrl_mod/supplier_cpu
add wave -noupdate -group {Bus_ctrl internal sigs} /tb_bus_ctrl/bus_ctrl_mod/nsupplier_cpu
add wave -noupdate -group {Bus_ctrl internal sigs} /tb_bus_ctrl/bus_ctrl_mod/nccsnoopaddr
add wave -noupdate -group {Bus_ctrl internal sigs} /tb_bus_ctrl/bus_ctrl_mod/nl2_addr
add wave -noupdate -group {Bus_ctrl internal sigs} /tb_bus_ctrl/bus_ctrl_mod/nccwait
add wave -noupdate -group {Bus_ctrl internal sigs} /tb_bus_ctrl/bus_ctrl_mod/nccinv
add wave -noupdate -group {Bus_ctrl internal sigs} /tb_bus_ctrl/bus_ctrl_mod/ndload
add wave -noupdate -group {Bus_ctrl internal sigs} /tb_bus_ctrl/bus_ctrl_mod/nl2_store
add wave -noupdate -group {Bus_ctrl internal sigs} /tb_bus_ctrl/bus_ctrl_mod/exclusiveUpdate
add wave -noupdate -group {Bus_ctrl internal sigs} /tb_bus_ctrl/bus_ctrl_mod/nexclusiveUpdate
add wave -noupdate -group {Bus_ctrl internal sigs} /tb_bus_ctrl/bus_ctrl_mod/wb_needed
add wave -noupdate -group {Bus_ctrl internal sigs} /tb_bus_ctrl/bus_ctrl_mod/nwb_needed
add wave -noupdate /tb_bus_ctrl/bus_ctrl_mod/snoopStatus/snoopStatus
add wave -noupdate /tb_bus_ctrl/bus_ctrl_mod/snoopStatus/requester_cpu
add wave -noupdate -expand -group {Snoop Sigs} /tb_bus_ctrl/bus_ctrl_mod/snoopStatus/snoopDone
add wave -noupdate -expand -group {Snoop Sigs} /tb_bus_ctrl/bus_ctrl_if/ccsnoopdone
add wave -noupdate -expand -group {Snoop Sigs} /tb_bus_ctrl/bus_ctrl_if/ccIsPresent
add wave -noupdate -expand -group {Snoop Sigs} /tb_bus_ctrl/bus_ctrl_if/ccsnoophit
add wave -noupdate -expand -group {Snoop Sigs} -color {Cornflower Blue} -subitemconfig {{/tb_bus_ctrl/bus_ctrl_if/ccinv[1]} {-color {Cornflower Blue}} {/tb_bus_ctrl/bus_ctrl_if/ccinv[0]} {-color {Cornflower Blue}}} /tb_bus_ctrl/bus_ctrl_if/ccinv
add wave -noupdate -expand -group {Snoop Sigs} -color {Medium Spring Green} -subitemconfig {{/tb_bus_ctrl/bus_ctrl_if/ccwait[1]} {-color {Medium Spring Green}} {/tb_bus_ctrl/bus_ctrl_if/ccwait[0]} {-color {Medium Spring Green}}} /tb_bus_ctrl/bus_ctrl_if/ccwait
add wave -noupdate -expand -group {Snoop Sigs} -color Coral -expand -subitemconfig {{/tb_bus_ctrl/bus_ctrl_if/ccsnoopaddr[1]} {-color Coral} {/tb_bus_ctrl/bus_ctrl_if/ccsnoopaddr[0]} {-color Coral}} /tb_bus_ctrl/bus_ctrl_if/ccsnoopaddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {277946 ps} 0}
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1608326 ps}
