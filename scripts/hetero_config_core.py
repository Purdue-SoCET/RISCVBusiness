"""
Auto-generates:
  - component_selection_defines.vh (global params)
  - custom_instruction_calls.h     (C firmware macros)
  - core_configuration_pkg.sv      (per-core arrays)
"""

import yaml
import argparse
import sys
from functools import reduce

# ---------------------------------------------------------------------
# Output file paths
# ---------------------------------------------------------------------
VH_FILE  = "component_selection_defines.vh"   # Global defines
C_FILE   = "custom_instruction_calls.h"       # Custom instr. header
PKG_FILE = "core_configuration_pkg.sv"        # Per-core SystemVerilog package

# ---------------------------------------------------------------------
# Legal value dictionaries
# ---------------------------------------------------------------------
PMP_MINIMUM_GRANULARITY = {
  "4":0,"8":1,"16":2,"32":3,"64":4,"128":5,"256":6,"512":7,
  "1K":8,"2K":9,"4K":10,"8K":11,"16K":12,"32K":13,"64K":14,"128K":15,
  "256K":16,"512K":17,"1M":18,"2M":19,"4M":20,"8M":21,"16M":22,"32M":23,
  "64M":24,"128M":25,"256M":26,"512M":27,"1G":28,"2G":29,"4G":30,
}

UARCH_PARAMS = {
  "num_harts":[],
  "br_predictor_type":["not_taken","btfnt","btb_1","btb_2","return","btb_ghr_pht"],
  "use_ras":["true","false"],
  "btb_size":[],
  "cache_config":["separate"],
  "dcache_type":["pass_through","direct_mapped_tpf","l1"],
  "icache_type":["pass_through","direct_mapped_tpf","l1"],
  "noncache_start_addr":[],
  "dcache_size":[],"dcache_block_size":[],"dcache_assoc":[],
  "icache_size":[],"icache_block_size":[],"icache_assoc":[],
  "tlb_entries":[],
  "bus_endianness":["big","little"],
  "bus_interface_type":["ahb_if","generic_bus_if","apb_if"],
  "sparce_enabled":["enabled","disabled"],
  "infinite_loop_halts":["true","false"],
}

MULTIPLIER_PARAMS = {
  "multiplier_select":["pp_mul32","shift_add_multiplier"],
}

RISCV_ISA = {"m":False,"a":False,"c":False,"b":False,"zicond":False,"zifencei":False,"zicsr":False}

# ---------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------
def load_configuration(file_name):
    """Load YAML config safely."""
    with open(file_name, "r") as f:
        try:
            return yaml.full_load(f)
        except yaml.parser.ParserError:
            sys.exit("Parse failed: invalid YAML syntax.")

def parse_riscv_isa_string(string):
    """Parse RV32I/E + extensions string."""
    string = string.lower()
    riscv_isa = RISCV_ISA.copy()

    if not string.startswith("rv32"):
        sys.exit("Error: ISA must start with rv32")

    string = string[4:]
    if string[0] == "i":
        base_isa = "RV32I"
    elif string[0] == "e":
        base_isa = "RV32E"
    else:
        sys.exit("Unknown base ISA (must be i or e)")
    string = string[1:]

    # Parse extensions
    while string:
        matched = False
        for ext in RISCV_ISA.keys():
            if string.startswith(ext):
                riscv_isa[ext] = True
                string = string[len(ext):]
                if ext[0] == "z" and string and string[0] == "_":
                    string = string[1:]
                matched = True
                break
        if not matched:
            sys.exit("Unknown extension substring: " + string)

    # Required extensions
    for req in ["zifencei", "zicsr"]:
        if not riscv_isa[req]:
            sys.exit(f"Missing required extension {req}")

    return base_isa, riscv_isa

# ---------------------------------------------------------------------
# Create per-core package (core_configuration_pkg.sv)
# ---------------------------------------------------------------------
def create_pkg(config):
    microarch = config["microarch_params"]
    num_harts = microarch["num_harts"]

    with open(PKG_FILE, "w") as pkg:
        pkg.write("package core_configuration_pkg;\n\n")
        pkg.write(f"localparam NUM_HARTS = {num_harts}; // Included to use it as array declaration\n\n")

        # Base ISA array
        base_isas, core_exts = [], []
        br_pred, btb_sizes, use_ras = [], [], []
        cache_config, dcache_type, dcache_size, dcache_block_size, dcache_assoc = [], [], [], [], []
        icache_type, icache_size, icache_block_size, icache_assoc = [], [], [], []
        tlb_entries, mults, smode, sup, at = [], [], [], [], []

        for i in range(num_harts):
            core = microarch[f"core{i}_params"]
            base, exts = parse_riscv_isa_string(core["isa"])

            base_isas.append(f"\"{base}\"")
            core_exts.append(
                "'{RV32M:%d,RV32A:%d,RV32C:%d,RV32B:%d,RV32ZICOND:%d,RV32ZIFENCEI:%d,RV32ZICSR:%d}" %
                (exts["m"], exts["a"], exts["c"], exts["b"], exts["zicond"], exts["zifencei"], exts["zicsr"])
            )

            br_pred.append(f"\"{core['br_predictor_type']}\"")
            btb_sizes.append(str(core["btb_size"]))
            use_ras.append(f"\"{core['use_ras']}\"")
            cache_config.append(f"\"{core['cache_config']}\"")
            dcache_type.append(f"\"{core['dcache_type']}\"")
            dcache_size.append(str(core["dcache_size"]))
            dcache_block_size.append(str(core["dcache_block_size"]))
            dcache_assoc.append(str(core["dcache_assoc"]))
            icache_type.append(f"\"{core['icache_type']}\"")
            icache_size.append(str(core["icache_size"]))
            icache_block_size.append(str(core["icache_block_size"]))
            icache_assoc.append(str(core["icache_assoc"]))
            tlb_entries.append(str(core["tlb_entries"]))
            mults.append(f"\"{core['multiplier_params']['multiplier_select']}\"")
            smode.append("1" if core["supervisor_enabled"] == "enabled" else "0")
            sup.append(f"\"{core['supervisor_enabled']}\"")
            at.append(f"\"{core['address_translation_enabled']}\"")

        # Typedefs
        pkg.write("// Packed struct is MSB - LSB\n")
        pkg.write("typedef struct packed {\n")
        pkg.write("    bit RV32ZICSR;\n    bit RV32ZIFENCEI;\n    bit RV32ZICOND;\n")
        pkg.write("    bit RV32B;\n    bit RV32C;\n    bit RV32A;\n    bit RV32M;\n")
        pkg.write("} isa_extension_t;\n\n")

        pkg.write("typedef enum int {\n    M,\n    A,\n    C,\n    B,\n    ZICOND,\n    ZIFENCEI,\n    ZICSR\n} extension_idx_t;\n\n")

        def arr(name, vals, typ="int"):
            inner = ",".join(vals)
            return f"localparam {typ} {name}[NUM_HARTS] = {{{inner}}};\n"

        # Emit arrays matching your new order
        pkg.write(f"// ISA extensions\nlocalparam string BASE_ISA[NUM_HARTS] = {{{','.join(base_isas)}}};\n\n")
        pkg.write(f"localparam isa_extension_t CORE_CONFIG[NUM_HARTS] = '{{{','.join(core_exts)}}};\n\n")

        pkg.write("// Branch configurations\n")
        pkg.write(arr("BR_PREDICTOR_TYPE", br_pred, "string"))
        pkg.write(arr("BTB_SIZE", btb_sizes))
        pkg.write(arr("USE_RAS", use_ras, "string"))
        pkg.write("\n// Cache configurations\n")
        pkg.write(arr("CACHE_CONFIG", cache_config, "string"))
        pkg.write(arr("DCACHE_TYPE", dcache_type, "string"))
        pkg.write(arr("DCACHE_SIZE", dcache_size))
        pkg.write(arr("DCACHE_BLOCK_SIZE", dcache_block_size))
        pkg.write(arr("DCACHE_ASSOC", dcache_assoc))
        pkg.write(arr("ICACHE_TYPE", icache_type, "string"))
        pkg.write(arr("ICACHE_SIZE", icache_size))
        pkg.write(arr("ICACHE_BLOCK_SIZE", icache_block_size))
        pkg.write(arr("ICACHE_ASSOC", icache_assoc))
        pkg.write(arr("TLB_ENTRIES", tlb_entries))
        pkg.write("\nlocalparam NONCACHE_START_ADDR = 32'hF000_0000;\n\n")

        pkg.write("// Multiplier settings\n")
        pkg.write(arr("MULTIPLIER_TYPE", mults, "string"))
        pkg.write("\n// Supervisor settings\n")
        pkg.write(arr("SMODE_ENABLED", smode))
        pkg.write(arr("SUPERVISOR_ENABLED", sup, "string"))
        pkg.write(arr("ADDRESS_TRANSLATION_ENABLED", at, "string"))

        pkg.write("\nendpackage\n")

# ---------------------------------------------------------------------
# Create include files (.vh + .h)
# ---------------------------------------------------------------------
def create_include(config):
    uarch_params = config["microarch_params"]
    globals_keep = ["num_harts", "xlen", "bus_endianness",
                    "bus_interface_type", "infinite_loop_halts"]

    with open(VH_FILE, "w") as include_file, open(C_FILE, "w") as c_file:
        # Headers
        include_file.write("/*\nWARNING: Auto-generated. Do not edit.\n*/\n")
        include_file.write("`ifndef COMPONENT_SELECTION_DEFINES_VH\n`define COMPONENT_SELECTION_DEFINES_VH\n\n")
        include_file.write("// Global Microarch Params:\n")

        for g in globals_keep:
            if g in uarch_params:
                val = uarch_params[g]
                if isinstance(val, int):
                    include_file.write(f"localparam {g.upper()} = {val};\n")
                else:
                    include_file.write(f"localparam {g.upper()} = \"{val}\";\n")

        # Add bus interface macro
        if "bus_interface_type" in uarch_params:
            bus_type = uarch_params["bus_interface_type"].split("_if")[0]
            include_file.write(f"`define BUS_INTERFACE_{bus_type.upper()}\n")

        include_file.write("\n`endif // COMPONENT_SELECTION_DEFINES_VH\n")

        # .h file
        c_file.write("/* Auto-generated. Do not edit. */\n")
        c_file.write("#ifndef CUSTOM_INSTRUCTION_CALLS_H\n#define CUSTOM_INSTRUCTION_CALLS_H\n\n")
        c_file.write('#include "custom_instruction_macros.h"\n\n')
        c_file.write("// CALL_CUSTOM_INSTRUCTION_R_TYPE(<ext_name>, <insn_offset>, <operand_a>, <operand_b>, <result>)\n")
        c_file.write("\n#endif // CUSTOM_INSTRUCTION_CALLS_H\n")

# ---------------------------------------------------------------------
# Main entry point
# ---------------------------------------------------------------------
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate multicore configuration files")
    parser.add_argument("file_name", type=str, help="YAML configuration file")
    args = parser.parse_args()

    config = load_configuration(args.file_name)
    create_include(config)
    create_pkg(config)

    print("Configuration files generated:")
    print(f" - {VH_FILE}")
    print(f" - {C_FILE}")
    print(f" - {PKG_FILE}")
