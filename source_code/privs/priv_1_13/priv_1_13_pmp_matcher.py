# Generates the NAPOT encoder
#  really only works for 32-bit addresses

XLEN = 32

print("casez(cfg_addr)")

for i in range(1, XLEN+1):
    print("  32'b", end="")
    print(("?" * (XLEN - i)) + ("0" if i != (XLEN+1) else "") + ("1"*(i-1)) + ": ", end="")
    print(f"match = phys_addr[31:{i:02}] == cfg_addr[31:{i:02}];" if i < XLEN-1 else ("match = phys_addr[31] == cfg_addr[31];" if i == XLEN-1 else "match = 1'b1;"))

print("  default: match = 1'b0;")
print("endcase")