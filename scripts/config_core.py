#!/usr/local/bin/python

#
#   Copyright 2016 Purdue University
#   
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#   
#       http://www.apache.org/licenses/LICENSE-2.0
#   
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#
#
#   Filename:     config_core.py
#
#   Created by:   Jacob R. Stevens
#   Email:        steven69@purdue.edu
#   Date Created: 02/14/2017
#   Description:  Configures a RISCV core based on the given YAML config file
import yaml
import argparse 
import sys
from math import log2
from functools import reduce

VH_FILE = 'source_code/include/component_selection_defines.vh'
C_FILE  = 'verification/c-firmware/custom_instruction_calls.h'

# If running PMP tests, the macro G in verification/pmp-tests/utility.h will need to 
# be updated to the corresponding value found in PMP_MINIMUM_GRANULARITY.
PMP_MINIMUM_GRANULARITY = \
  {
    '4'    :  0,
    '8'    :  1,
    '16'   :  2,
    '32'   :  3,
    '64'   :  4,
    '128'  :  5,
    '256'  :  6,
    '512'  :  7,
    '1K'   :  8,
    '2K'   :  9,
    '4K'   : 10,
    '8K'   : 11,
    '16K'  : 12,
    '32K'  : 13,
    '64K'  : 14,
    '128K' : 15,
    '256K' : 16,
    '512K' : 17,
    '1M'   : 18,
    '2M'   : 19,
    '4M'   : 20,
    '8M'   : 21,
    '16M'  : 22,
    '32M'  : 23,
    '64M'  : 24,
    '128M' : 25,
    '256M' : 26,
    '512M' : 27,
    '1G'   : 28,
    '2G'   : 29,
    '4G'   : 30,
  }

ISA_PARAMS = \
  {
    'xlen' : [32],
    'pmp_minimum_granularity' : list(PMP_MINIMUM_GRANULARITY.keys()),
    'supervisor' : [ 'enabled', 'disabled' ],
    'address_translation' : [ 'enabled', 'disabled' ],
    'isa' : []
  }

UARCH_PARAMS = \
  {
    # Multicore configurations
    'num_harts' : [],
    # Branch/Jump Configurations
    'br_predictor_type' : ['not_taken', 'btfnt', 'btb_1', 'btb_2', 'return', 'btb_ghr_pht'],
    'use_ras' : ['true', 'false'],
    # btb has fixed block size of 4B
    'btb_size' : [],
    # Cache Configurations
    'cache_config' : ['separate'],
    'dcache_type' : ['pass_through', 'direct_mapped_tpf', 'l1'],
    'icache_type' : ['pass_through', 'direct_mapped_tpf', 'l1'],
    # Cache Configurations (free_params)
    'noncache_start_addr' : [],
    # Cache Configurations (int_params)
    'dcache_size' : [],
    'dcache_block_size' : [],
    'dcache_assoc' : [],
    'icache_size' : [],
    'icache_block_size' : [],
    'icache_assoc' : [],
    'tlb_entries' : [],
    # Bus Configurations
    'bus_endianness' : ['big', 'little'],
    'bus_interface_type' : ['ahb_if', 'generic_bus_if', 'apb_if'],

    # Halt Enable -- Good for testing, not for tapeout
    'infinite_loop_halts' : ['true', 'false'],
  }


# Multiplier to be used TODO: Make sure it works.
MULTIPLIER_PARAMS = {
  'multiplier_select' : ['pp_mul32', 'shift_add_multiplier'],
}

# Supported ISA extensions. Order matters and should reflect the proper order
# of extensions in an ISA string
RISCV_ISA = {
    "m" : False,
    "a" : False,
    "c" : False,
    "b" : False,
    "zicond" : False,
    "zifencei" : False,
    "zicsr" : False
}

# Returns an object containing the parsed configuration file.
# Currently uses PyYAML and YAML format
def load_configuration(file_name):
  with open(file_name, 'r') as f:
    try:
      config = yaml.full_load(f)
    except yaml.parser.ParserError:
      sys.exit('Parse of '+ file_name + ' failed. Please check yml syntax')
  return config

def add_custom_instruction_header(name, encoding, length, opcode, fptr):
  if encoding == 'R_TYPE':
    for i in range(length):
      funct = format(i, '010b')
      fptr.write("GENERATE_CUSTOM_INSTRUCTION_R_TYPE(" +
        name + "," + opcode + "," + str(i) + "," + funct[0:7] + "," + funct[7:10] + ")\n")
  else:
    err = "Error: Invalid custom instruction encoding: " + encoding
    sys.exit(err)

def parse_riscv_isa_string(string):
    string = string.lower()
    riscv_isa = RISCV_ISA.copy()

    # Skip past rv32{i,e}
    if string[0:4] != "rv32":
        print("Error: 32-bit RISC-V ISA string must begin with rv32")
    string = string[4:]

    # Determine base ISA
    if string[0] == "i":
        base_isa = "RV32I"
    elif string[0] == "e":
        base_isa = "RV32E"
    else:
        err = "Unknown base ISA " + string
        sys.exit(err)
    string = string[1:]

    # Determine extensions
    for ext in RISCV_ISA.keys():
        if string[0:len(ext)] == ext:
            riscv_isa[ext] = True
            string = string[len(ext):]
            # If we're at 'z' extensions, trim off the underscore if there's
            # anything left in the string
            if ext[0] == 'z' and string != "":
                if string[0] == "_":
                    string = string[1:]
                else:
                    err = "Error: Expected '_' between 'z' extensions! Found " + string
                    sys.exit(err)
    if string != "":
        err = "Error: Unknown extension: " + string + ". Double check that your isa string is valid!"
        sys.exit(err)

    require = ["zifencei", "zicsr"]

    for ext in require:
        if not riscv_isa[ext]:
            err = "Error: Extension " + ext + " is a required extension. Please add it to your ISA string"
            sys.exit(err)
    return base_isa, riscv_isa

# Creates the include file from the config object
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
 
  # Write include to c file
  c_header = '/*\nWARNING: THIS FILE WAS AUTOMATICALLY GENERATED BY\n'
  c_header += 'CONFIG_CORE. DO NOT MAKE CHANGES TO THIS FILE. ANY CHANGES\n'
  c_header += 'MAY BE OVERWRITTEN. DO NOT VERSION CONTROL THIS FILE.\n*/\n'
  c_header += '#ifndef CUSTOM_INSTRUCTION_CALLS_H\n'
  c_header += '#define CUSTOM_INSTRUCTION_CALLS_H\n\n\n'
  c_header += '#include "custom_instruction_macros.h"\n\n'
  c_header += '// Custom Instruction Usage:\n// CALL_CUSTOM_INSTRUCTION_R_TYPE(<ext_name>, <insn_offset>, <operand_a>, <operand_b>, <result>)\n\n'
  c_file.write(c_header)

  # Handle localparam configurations
  isa_params = config['isa_params']
  free_params = ['isa', 'num_harts', 'noncache_start_addr', ]
  int_params = ['num_harts', 'btb_size', 'dcache_size', 'dcache_block_size', 'dcache_assoc', 'icache_size', 'icache_block_size', 'icache_assoc', 'tlb_entries']
  include_file.write('// ISA Params:\n') 

  base_isa = None
  riscv_ext = None
  for isa_param in ISA_PARAMS:
    try:
      if isa_param not in free_params and isa_params[isa_param] not in ISA_PARAMS[isa_param]:
        err = 'Illegal configuration. ' + isa_params[isa_param]
        err += ' is not a valid configuration for ' + isa_param
        sys.exit(err)
      else:
        line = 'localparam '
        # xlen & pmp_minimum_granularity will be an integer in include file, so no quotes needed
        if 'xlen' == isa_param:
          line += isa_param.upper() + ' = ' + str(isa_params[isa_param])
        elif 'pmp_minimum_granularity' == isa_param:
          line += isa_param.upper() + ' = ' + str(PMP_MINIMUM_GRANULARITY[isa_params[isa_param]])
        elif 'supervisor' == isa_param and isa_params[isa_param] == 'enabled':
          line  = '`define SMODE_SUPPORTED\n'
          line += 'localparam ' + isa_param.upper() + ' = "' + isa_params[isa_param] + '"'
        elif 'address_translation' == isa_param:
          # supervisor should be enabled if address translation is on
          if isa_params[isa_param] == 'enabled' and isa_params['supervisor'] == 'disabled':
            err = 'Illegal configuration. ' + isa_param  + ' == ' + isa_params[isa_param]
            err += ' is not a valid configuration with supervisor == disabled'
            sys.exit(err)
          line = ''
          if isa_params[isa_param] == 'enabled' and isa_params['supervisor'] == 'enabled':
            line = f'`define {isa_param.upper()}\n'
          line += 'localparam ' + isa_param.upper() + ' = "' + (str(isa_params[isa_param]) if isa_params['supervisor'] == 'enabled' else 'disabled') + '"'
        elif 'isa' == isa_param:
          base_isa, riscv_ext = parse_riscv_isa_string(isa_params[isa_param])
          continue
        else:
          line += isa_param.upper() + ' = "' + isa_params[isa_param] + '"'
        line += ';\n'
      include_file.write(line)
    except TypeError:
      sys.exit('Type Error. Please check to make sure .yml file is correct.')
  include_file.write('\n// Microarch Params:\n') 
  uarch_params = config['microarch_params']
  for uarch_param in uarch_params:
    # errors
    if uarch_param in int_params or uarch_param in free_params:
      if uarch_param not in free_params and not isinstance(uarch_params[uarch_param], int):
        err = 'Illegal configuration of incorrect type for ' + uarch_param
        sys.exit(err)
      if uarch_params['btb_size'] % 4 != 0:
          err = 'Invalid btb size, not divisible by 4'
          sys.exit(err)
      if uarch_params['dcache_size'] % (uarch_params['dcache_block_size'] * uarch_params['dcache_assoc']) != 0:
        err = 'Invalid dcache_size. Not divisible by block_size * assoc.'
        sys.exit(err)
      if uarch_params['icache_size'] % (uarch_params['icache_block_size'] * uarch_params['icache_assoc']) != 0:
        err = 'Invalid icache_size. Not divisible by block_size * assoc.'
        sys.exit(err)
      if uarch_params['dcache_size'] / (8 * uarch_params['dcache_assoc']) > 4096 and isa_params['address_translation'] == 'enabled': # will need to change if we adjust cache_size to be in bytes rather than bits
        err = 'Invalid dcache_size. Sets are not less than or equal to the virtual page size of 4KB.'
        sys.exit(err)
      if uarch_params['icache_size'] / (8 * uarch_params['icache_assoc']) > 4096 and isa_params['address_translation'] == 'enabled': # will need to change if we adjust cache_size to be in bytes rather than bits
        err = 'Invalid icache_size. Sets are not less than or equal to the virtual page size of 4KB.'
        sys.exit(err)
      if riscv_ext["c"] & (uarch_params['br_predictor_type'] != 'not_taken'):
        err = 'RV32C and advanced branch prediction cannot be enabled simultaneously.'
        sys.exit(err)
      if(uarch_params['br_predictor_type'] == 'btb_ghr_pht'):
        print('Warning: GHR predictor is experimental and may not work as expected!',
                'BTB parameters are currently ignored for this, using default size')
      if uarch_params['tlb_entries'] not in [1, 2, 4, 8, 16, 32, 64]:
        err = 'Invalid tlb_entries. Not a multiple of two and/or less than or equal to 64.'
        sys.exit(err)
    elif uarch_params[uarch_param] not in UARCH_PARAMS[uarch_param]:
      err = 'Illegal configuration. ' + uarch_params[uarch_param]
      err += ' is not a valid configuration for ' + uarch_param
      sys.exit(err)
    # write to parameter file
    if uarch_param in free_params or uarch_param in int_params:
      line = 'localparam ' + uarch_param.upper() + ' = ' + str(uarch_params[uarch_param]) + ';\n'
    else:
      line = 'localparam '
      if isinstance(uarch_params[uarch_param], str): # deal with integer params
        line += uarch_param.upper() + ' = "' + uarch_params[uarch_param] + '"'
      else:
        line += uarch_param.upper() + ' = ' + str(uarch_params[uarch_param])
      line += ';\n'
    include_file.write(line)
  
  # Multiplier parameters
  include_file.write("// Multiplier parameters\n")
  mul_params = config['multiplier_params']
  multiplier_select = mul_params.get('multiplier_select', None)
  if not multiplier_select or not (multiplier_select in MULTIPLIER_PARAMS['multiplier_select']):
    err = "Invalid multiplier_select configuration."
    sys.exit(err)

  if multiplier_select == 'pp_mul32':
    include_file.write(f"`define PP_MUL32\n")
  elif multiplier_select == 'shift_add_multiplier':
    include_file.write(f"`define SHIFT_ADD_MULTIPLIER\n")
  else:
    err = "Invalid multiplier_select configuration. How did we get here?"
    sys.exit(err)

  # Add base ISA
  include_file.write(f"localparam BASE_ISA = \"{base_isa}\";\n")

  # Handle bus interface define
  # print("Handle bus interface define")
  bus_type = uarch_params['bus_interface_type'].split('_if')[0]
  bus_define = '`define BUS_INTERFACE_' + bus_type.upper() + '\n'
  include_file.write(bus_define)

  #set defines to indicate what ISA support is present
  include_file.write('\n// RISC-V Extensions:\n')
  for extension in riscv_ext:
    if riscv_ext[extension]:
      include_file.write('`define RV32' + extension.upper() + '_SUPPORTED\t1\n')

  # Write include footer to file
  footer = '\n`endif // COMPONENT_SELECTION_DEFINES_VH\n'
  include_file.write(footer)
  include_file.close()

  footer = '\n#endif // CUSTOM_INSTRUCTION_CALLS_H\n'
  c_file.write(footer)
  c_file.close()

if __name__ == '__main__':
  description = 'Configure a processor. This script takes a .yml'
  description += ' configuration file as input and creates the file '
  description += 'component_selection_defines.vh in source_code/include.'
  description += 'Caution: if this file already exists, it is overwritten.'
  parser = argparse.ArgumentParser(description=description)
  parser.add_argument('file_name', metavar='file_name', type=str,
                      help='The config file name')
  args = parser.parse_args()

  #TODO: Check for .yaml/.yml
  config = load_configuration(args.file_name)
  create_include(config)
