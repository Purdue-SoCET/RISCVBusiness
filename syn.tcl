set_db lib_search_path /package/eda/cells/NanGate_45nm_OCL_v2010_12/pdk_v1.3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12/Front_End/Verilog
set_db library /package/eda/cells/NanGate_45nm_OCL_v2010_12/pdk_v1.3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12/Front_End/Liberty/NLDM/NangateOpenCellLibrary_typical.lib
set_db information_level 6
set_db hdl_error_on_blackbox true

# Run from repository root so relative paths are stable.
set script_dir [file dirname [file normalize [info script]]]
cd $script_dir

# Set your intended synthesis top here.
set TOP_MODULE srt_div

# Read RTL for the new SRT divider block.
# Add more read_hdl lines here only if your target block depends on more files.
read_hdl -sv source_code/rv32m/srt_qsel_rom_pkg.sv
read_hdl -sv source_code/rv32m/srt_div.sv

elaborate $TOP_MODULE
init_design

# Clock/input constraints.
set clk_ports [clock_ports]
if {[llength $clk_ports] > 0} {
    set clock1 [define_clock -period 666 -name clock1 $clk_ports]
}

# If your module is combinational, remove the next 2 lines.
# For this divider, set input delay on main data/control inputs.
set in_ports [get_ports -quiet {in_valid dividend* divisor* out_ready}]
if {[info exists clock1] && [llength $in_ports] > 0} {
    set_input_delay -max 0 -clock clock1 $in_ports
}

check_design > check_summary.log

syn_generic -effort high
syn_map -effort high
syn_opt -effort high

report timing -lint > timing-lint.rpt
report timing -max_paths 20 > timing.rpt
report gates > gates.rpt
report power > power.rpt
report area > area.rpt