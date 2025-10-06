
import yaml
import argparse
import sys
from math import log2
from functools import reduce

# ---------------------------------------------------------------------
# File output paths
# ---------------------------------------------------------------------
VH_FILE  = "component_selection_defines.vh"   # global defines
C_FILE   = "custom_instruction_calls.h"  # custom instr. macros
PKG_FILE = "core_configuration_pkg.sv"       # new per-core package

# ---------------------------------------------------------------------
# Dictionaries for legal values
# ---------------------------------------------------------------------
# PMP granularity options → encoded as small ints
PMP_MINIMUM_GRANULARITY = {
  "4":0,"8":1,"16":2,"32":3,"64":4,"128":5,"256":6,"512":7,
  "1K":8,"2K":9,"4K":10,"8K":11,"16K":12,"32K":13,"64K":14,"128K":15,
  "256K":16,"512K":17,"1M":18,"2M":19,"4M":20,"8M":21,"16M":22,"32M":23,
  "64M":24,"128M":25,"256M":26,"512M":27,"1G":28,"2G":29,"4G":30,
}

# Allowed ISA-level params
ISA_PARAMS = {
  "xlen":[32],
  "pmp_minimum_granularity":list(PMP_MINIMUM_GRANULARITY.keys()),
  "supervisor_enabled":["enabled","disabled"],
  "address_translation_enabled":["enabled","disabled"],
  "isa":[]  # free-form ISA string, validated later
}

# Allowed microarchitectural params (caches, predictor, etc.)
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

# Allowed multiplier options
MULTIPLIER_PARAMS = {
  "multiplier_select":["pp_mul32","shift_add_multiplier"],
}

# ISA extension flags (set by parse_riscv_isa_string)
RISCV_ISA = {"m":False,"a":False,"c":False,"b":False,"zicond":False,"zifencei":False,"zicsr":False}

# ---------------------------------------------------------------------
# YAML loader
# ---------------------------------------------------------------------
def load_configuration(file_name):
  """Load and parse YAML config file."""
  with open(file_name,"r") as f:
    try:
      return yaml.full_load(f)
    except yaml.parser.ParserError:
      sys.exit("Parse failed. Check YAML syntax.")

# ---------------------------------------------------------------------
# ISA string parsing: "rv32i[a][m][c]..."
# Returns (base ISA, dict of extensions)
# ---------------------------------------------------------------------
def parse_riscv_isa_string(string):
  string = string.lower()
  riscv_isa = RISCV_ISA.copy()

  # Must start with rv32
  if not string.startswith("rv32"):
    sys.exit("Error: must start with rv32")
  string = string[4:]

  # Base ISA: i = RV32I, e = RV32E
  if string[0] == "i":
    base_isa="RV32I"
  elif string[0]=="e":
    base_isa="RV32E"
  else:
    sys.exit("Unknown base ISA")
  string = string[1:]

  # Step through supported extensions
  for ext in RISCV_ISA.keys():
    if string.startswith(ext):
      riscv_isa[ext]=True
      string=string[len(ext):]
      # Trim underscores for z-extensions
      if ext[0]=="z" and string!="" and string[0]=="_":
        string=string[1:]

  # Should consume whole string
  if string!="":
    sys.exit("Unknown ISA extension string remainder: "+string)

  # Require ZIFENCEI + ZICSR
  for req in ["zifencei","zicsr"]:
    if not riscv_isa[req]:
      sys.exit("Missing required extension "+req)

  return base_isa,riscv_isa

# ---------------------------------------------------------------------
# Builds core_configuration_pkg.sv with arrays of per-core params
# ---------------------------------------------------------------------
def create_pkg(config):
  microarch=config["microarch_params"]
  num_harts=microarch["num_harts"]

  with open(PKG_FILE,"w") as pkg:
    pkg.write("package core_configuration_pkg;\n\n")
    pkg.write(f"  localparam NUM_HARTS = {num_harts};\n\n")

    # Struct for ISA extension bits
    pkg.write("""  typedef struct packed {
    bit RV32ZICSR;
    bit RV32ZIFENCEI;
    bit RV32ZICOND;
    bit RV32B;
    bit RV32C;
    bit RV32A;
    bit RV32M;
  } isa_extension_t;\n\n""")

    # Optional enum (index mapping)
    pkg.write("  typedef enum int { M,A,C,B,ZICOND,ZIFENCEI,ZICSR } extension_idx_t;\n\n")

    # Collect per-core values into Python lists
    base_isas=[]; core_exts=[]; br_pred=[]; btb_sizes=[]; use_ras=[]
    cache_config=[]; dcache_type=[]; dcache_size=[]; dcache_block_size=[]; dcache_assoc=[]
    icache_type=[]; icache_size=[]; icache_block_size=[]; icache_assoc=[]
    tlb_entries=[]; mults=[]; smode=[]; sup=[]; at=[]

    for i in range(num_harts):
      core=microarch[f"core{i}_params"]
      base,exts=parse_riscv_isa_string(core["isa"])

      # ISA
      base_isas.append(f"\"{base}\"")
      core_exts.append(
        "'{RV32M:%d,RV32A:%d,RV32C:%d,RV32B:%d,RV32ZICOND:%d,RV32ZIFENCEI:%d,RV32ZICSR:%d}" %
        (exts["m"],exts["a"],exts["c"],exts["b"],exts["zicond"],exts["zifencei"],exts["zicsr"])
      )

      # Branch + caches + misc
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

      # Supervisor / address translation
      smode.append("1" if core["supervisor_enabled"]=="enabled" else "0")
      sup.append(f"\"{core['supervisor_enabled']}\"")
      at.append(f"\"{core['address_translation_enabled']}\"")

    # Small helper to pretty-print arrays
    def arr(name,vals,typ="string"):
      inner=",".join(vals)
      return f"  localparam {typ} {name}[NUM_HARTS] = '{{{inner}}};\n"

    # Emit arrays
    pkg.write(arr("BASE_ISA",base_isas,"string"))
    pkg.write(f"  localparam isa_extension_t CORE_CONFIG[NUM_HARTS] = '{{{','.join(core_exts)}}};\n")
    pkg.write(arr("BR_PREDICTOR_TYPE",br_pred))
    pkg.write(arr("BTB_SIZE",btb_sizes,"int"))
    pkg.write(arr("USE_RAS",use_ras))
    pkg.write(arr("CACHE_CONFIG",cache_config))
    pkg.write(arr("DCACHE_TYPE",dcache_type))
    pkg.write(arr("DCACHE_SIZE",dcache_size,"int"))
    pkg.write(arr("DCACHE_BLOCK_SIZE",dcache_block_size,"int"))
    pkg.write(arr("DCACHE_ASSOC",dcache_assoc,"int"))
    pkg.write(arr("ICACHE_TYPE",icache_type))
    pkg.write(arr("ICACHE_SIZE",icache_size,"int"))
    pkg.write(arr("ICACHE_BLOCK_SIZE",icache_block_size,"int"))
    pkg.write(arr("ICACHE_ASSOC",icache_assoc,"int"))
    pkg.write(arr("TLB_ENTRIES",tlb_entries,"int"))
    pkg.write("\n  localparam int NONCACHE_START_ADDR = 32'hF000_0000;\n")
    pkg.write(arr("MULTIPLIER_TYPE",mults))
    pkg.write(arr("SMODE_ENABLED",smode,"int"))
    pkg.write(arr("SUPERVISOR_ENABLED",sup))
    pkg.write(arr("ADDRESS_TRANSLATION_ENABLED",at))
    pkg.write("\nendpackage\n")


# Creates the include file from the config object (globals only)
def create_include(config):
  include_file = open(VH_FILE, 'w')
  c_file = open(C_FILE, 'w')

  # Write include header to file
  header = '/*\nWARNING: THIS FILE WAS AUTOMATICALLY GENERATED BY\n'
  header += 'CONFIG_CORE. DO NOT MAKE CHANGES TO THIS FILE. ANY CHANGES\n'
  header += 'MAY BE OVERWRITTEN. DO NOT VERSION CONTROL THIS FILE.\n*/\n'
  header += '`ifndef COMPONENT_SELECTION_DEFINES_VH\n'
  header += '`define COMPONENT_SELECTION_DEFINES_VH\n\n\n'
  include_file.write(header)

  # Write include to C file
  c_header = '/*\nWARNING: THIS FILE WAS AUTOMATICALLY GENERATED BY\n'
  c_header += 'CONFIG_CORE. DO NOT MAKE CHANGES TO THIS FILE. ANY CHANGES\n'
  c_header += 'MAY BE OVERWRITTEN. DO NOT VERSION CONTROL THIS FILE.\n*/\n'
  c_header += '#ifndef CUSTOM_INSTRUCTION_CALLS_H\n'
  c_header += '#define CUSTOM_INSTRUCTION_CALLS_H\n\n\n'
  c_header += '#include "custom_instruction_macros.h"\n\n'
  c_header += '// Custom Instruction Usage:\n'
  c_header += '// CALL_CUSTOM_INSTRUCTION_R_TYPE(<ext_name>, <insn_offset>, <operand_a>, <operand_b>, <result>)\n\n'
  c_file.write(c_header)

  # ==== GLOBAL PARAMS ONLY ====
  uarch_params = config['microarch_params']
  globals_keep = ['num_harts', 'xlen', 'bus_endianness', 
                  'bus_interface_type', 'infinite_loop_halts']

  include_file.write('// Global Microarch Params:\n')
  for g in globals_keep:
    if g in uarch_params:
      val = uarch_params[g]
      if isinstance(val, int):
        include_file.write(f'localparam {g.upper()} = {val};\n')
      else:
        include_file.write(f'localparam {g.upper()} = "{val}";\n')

  # Add bus interface macro
  if 'bus_interface_type' in uarch_params:
    bus_type = uarch_params['bus_interface_type'].split('_if')[0]
    include_file.write(f'`define BUS_INTERFACE_{bus_type.upper()}\n')

  # Close files with footers
  footer = '\n`endif // COMPONENT_SELECTION_DEFINES_VH\n'
  include_file.write(footer)
  include_file.close()

  footer = '\n#endif // CUSTOM_INSTRUCTION_CALLS_H\n'
  c_file.write(footer)
  c_file.close()


if __name__ == "__main__":
  parser = argparse.ArgumentParser(
      description="Configure a RISC-V multicore system from YAML input"
  )
  parser.add_argument("file_name", type=str, help="YAML configuration file")
  args = parser.parse_args()

  # Load YAML config
  config = load_configuration(args.file_name)

  # === Generate outputs ===
  # Global parameters (.vh + C macros)
  create_include(config)

  # Per-core parameters (pkg arrays)
  create_pkg(config)

  print("Configuration files generated:")
  print(f" - {VH_FILE}")
  print(f" - {C_FILE}")
  print(f" - {PKG_FILE}")
