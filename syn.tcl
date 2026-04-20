set_db lib_search_path /package/eda/cells/NanGate_45nm_OCL_v2010_12/pdk_v1.3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12/Front_End/Verilog
set_db library /package/eda/cells/NanGate_45nm_OCL_v2010_12/pdk_v1.3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12/Front_End/Liberty/NLDM/NangateOpenCellLibrary_typical.lib
set_db information_level 6
set_db hdl_error_on_blackbox true

# Run from repository root so relative paths are stable.
set script_dir [file dirname [file normalize [info script]]]
cd $script_dir

# Runtime knobs:
# - FAST mode (default): medium effort, skips syn_opt for quick comparisons.
# - FULL mode: set RUN_SYN_OPT to 1 and SYN_EFFORT to high.
set SYN_EFFORT medium
set RUN_SYN_OPT 0

# Compare these tops in one Genus run (sequential in the same process).
set COMPARE_TOPS {srt_div radix4_divider}

proc extract_metric {file regex_list} {
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

proc run_one_top {top effort run_syn_opt} {
    set rpt_dir [file join reports $top]
    file mkdir $rpt_dir

    puts "[clock format [clock seconds]] INFO: Running top=$top"

    if {$top eq "srt_div"} {
        read_hdl -sv source_code/rv32m/srt_qsel_rom_pkg.sv
        read_hdl -sv source_code/rv32m/srt_div.sv
    } elseif {$top eq "radix4_divider"} {
        read_hdl -sv source_code/rv32m/radix4_divider.sv
    } else {
        puts "ERROR: Unsupported top '$top'"
        exit 2
    }

    elaborate $top
    init_design

    set clk_ports [clock_ports]
    if {[llength $clk_ports] > 0} {
        set clock1 [define_clock -period 666 -name clock1 $clk_ports]
    }

    # Cover common divider input names across both implementations.
    set in_ports [get_ports -quiet {in_valid start is_signed dividend* divisor* out_ready}]
    if {[info exists clock1] && [llength $in_ports] > 0} {
        set_input_delay -max 0 -clock clock1 $in_ports
    }

    redirect -file [file join $rpt_dir check_summary.log] {check_design}

    syn_generic -effort $effort
    syn_map -effort $effort
    if {$run_syn_opt} {
        syn_opt -effort $effort
    } else {
        puts "[clock format [clock seconds]] INFO: Skipping syn_opt for top=$top"
    }

    redirect -file [file join $rpt_dir timing-lint.rpt] {report timing -lint}
    redirect -file [file join $rpt_dir timing.rpt] {report timing -max_paths 20}
    redirect -file [file join $rpt_dir gates.rpt] {report gates}
    redirect -file [file join $rpt_dir power.rpt] {report power}
    redirect -file [file join $rpt_dir area.rpt] {report area}

    puts "[clock format [clock seconds]] INFO: Reports generated for top=$top"

    if {[llength [info commands reset_design]] > 0} {
        reset_design
    }
}

puts "[clock format [clock seconds]] INFO: Starting dual-top comparison"
foreach top $COMPARE_TOPS {
    run_one_top $top $SYN_EFFORT $RUN_SYN_OPT
}

set summary_file [file join reports compare_summary.rpt]
set out [open $summary_file w]
puts $out "Top Module Comparison"
puts $out "====================="
puts $out ""
puts $out [format "%-20s %-16s %-16s %-16s" "Top" "Area" "Power" "Slack"]
puts $out [format "%-20s %-16s %-16s %-16s" "---" "----" "-----" "-----"]

foreach top $COMPARE_TOPS {
    set area [extract_metric [file join reports $top area.rpt] {
        {Total\s+cell\s+area\s*:\s*([-+0-9.eE]+)}
        {Total\s+Area\s*:\s*([-+0-9.eE]+)}
    }]
    set power [extract_metric [file join reports $top power.rpt] {
        {Total\s+Power\s*=\s*([-+0-9.eE]+)}
        {Total\s+power\s*=\s*([-+0-9.eE]+)}
    }]
    set slack [extract_metric [file join reports $top timing.rpt] {
        {Slack\s*:?\s*([-+0-9.eE]+)}
        {slack\s*\(.*\)\s*([-+0-9.eE]+)}
    }]

    puts $out [format "%-20s %-16s %-16s %-16s" $top $area $power $slack]
}

close $out
puts "[clock format [clock seconds]] INFO: Wrote comparison to $summary_file"
exit