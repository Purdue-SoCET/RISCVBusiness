# OpenSTA script for RISCVBusiness CI timing report.
#
# synth.sh exports:
#   STA_TOP
#   STA_LIBERTY
#   STA_NETLIST
#   STA_SDC
#   STA_TIMING_REPORT

read_liberty $env(STA_LIBERTY)
read_verilog $env(STA_NETLIST)
link_design $env(STA_TOP)
read_sdc $env(STA_SDC)

report_checks -path_delay max -fields {slew cap input nets fanout} -digits 4 > $env(STA_TIMING_REPORT)
report_wns >> $env(STA_TIMING_REPORT)
report_tns >> $env(STA_TIMING_REPORT)