# Minimal placeholder SDC for open-source CI synthesis smoke test.
# Replace with real clock/timing constraints for actual FPGA/ASIC timing.

create_clock -name CLK -period 10.000 [get_ports CLK]
