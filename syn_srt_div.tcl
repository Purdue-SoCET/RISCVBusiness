set_db lib_search_path /package/eda/cells/NanGate_45nm_OCL_v2010_12/pdk_v1.3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12/Front_End/Verilog
set_db library /package/eda/cells/NanGate_45nm_OCL_v2010_12/pdk_v1.3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12/Front_End/Liberty/NLDM/NangateOpenCellLibrary_typical.lib
set_db information_level 6
set_db hdl_error_on_blackbox true

set script_dir [file dirname [file normalize [info script]]]
cd $script_dir

set TOP_MODULE srt_div
set SYN_EFFORT medium
set RUN_SYN_OPT 0

proc get_report_value {file regex_list} {
    if {![file exists $file]} {
        return "N/A"
    }

    set fh [open $file r]
    set txt [read $fh]
    close $fh

    foreach re $regex_list {
        if {[regexp -line -nocase -- $re $txt -> value]} {
            return $value
        }
    }
    return "N/A"
}

set rpt_dir [file join reports $TOP_MODULE]
file mkdir $rpt_dir

puts "[clock format [clock seconds]] INFO: Starting synthesis for top=$TOP_MODULE"
read_hdl -sv source_code/rv32m/srt_qsel_rom_pkg.sv
read_hdl -sv source_code/rv32m/srt_div.sv

elaborate $TOP_MODULE
init_design

set clk_ports [clock_ports]
if {[llength $clk_ports] > 0} {
    set clock1 [define_clock -period 666 -name clock1 $clk_ports]
}

set in_ports [get_ports -quiet {in_valid dividend* divisor* out_ready}]
if {[info exists clock1] && [llength $in_ports] > 0} {
    set_input_delay -max 0 -clock clock1 $in_ports
}

redirect [file join $rpt_dir check_summary.log] "check_design"

syn_generic -effort $SYN_EFFORT
syn_map -effort $SYN_EFFORT
if {$RUN_SYN_OPT} {
    syn_opt -effort $SYN_EFFORT
} else {
    puts "[clock format [clock seconds]] INFO: Skipping syn_opt for top=$TOP_MODULE"
}

redirect [file join $rpt_dir timing-lint.rpt] "report timing -lint"
redirect [file join $rpt_dir timing.rpt] "report timing -max_paths 20"
redirect [file join $rpt_dir gates.rpt] "report gates"
redirect [file join $rpt_dir power.rpt] "report power"
redirect [file join $rpt_dir area.rpt] "report area"

set area [get_report_value [file join $rpt_dir area.rpt] {
    {Total\s+cell\s+area\s*:\s*([-+0-9.eE]+)}
    {Total\s+Area\s*:\s*([-+0-9.eE]+)}
}]
set power [get_report_value [file join $rpt_dir power.rpt] {
    {Total\s+Power\s*=\s*([-+0-9.eE]+)}
    {Total\s+power\s*=\s*([-+0-9.eE]+)}
}]
set slack [get_report_value [file join $rpt_dir timing.rpt] {
    {Slack\s*:?\s*([-+0-9.eE]+)}
    {slack\s*\(.*\)\s*([-+0-9.eE]+)}
}]

set summary_file [file join $rpt_dir summary.rpt]
set out [open $summary_file w]
puts $out [format "Top   : %s" $TOP_MODULE]
puts $out [format "Area  : %s" $area]
puts $out [format "Power : %s" $power]
puts $out [format "Slack : %s" $slack]
close $out

puts "[clock format [clock seconds]] INFO: Reports generated for top=$TOP_MODULE"
exit