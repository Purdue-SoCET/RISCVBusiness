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

VH_FILE = 'source_code/include/component_selection_defines.vh'
C_FILE  = 'verification/c-firmware/custom_instruction_calls.h'

ISA_PARAMS = \
  {
    'xlen' : [32]
  }

UARCH_PARAMS = \
  {
    # Branch/Jump Configurations
    'br_predictor_type' : ['not_taken', 'btfnt', 'btb_1', 'btb_2', 'return'],
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
    # Bus Configurations
    'bus_endianness' : ['big', 'little'],
    'bus_interface_type' : ['ahb_if', 'generic_bus_if', 'apb_if'],
    # Sparisty Optimizations
    'sparce_enabled' : [ 'enabled', 'disabled' ],
    # RV32C
    'rv32c_enabled' : [ 'enabled', 'disabled' ],
    # base ISA Configurations
    'base_isa': ['RV32I', 'RV32E'], 
    
    # Halt Enable -- Good for testing, not for tapeout
    'infinite_loop_halts' : ['true', 'false']
  }

RISC_MGMT_PARAMS = \
  {
    # Valid standard extensions
    'standard_extensions' : {'name' : ['rv32m']},
    # Valid nonstandard extensions
    'nonstandard_extensions' : {'encoding' : ['R_TYPE', 'M_TYPE', 'J_TYPE', 'BR_TYPE', 'G_TYPE']}
  }

NONSTANDARD_OPCODES = [ '0001011',
                        '0101011',
                        '1011011',
                        '1111011']

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
  elif encoding in RISC_MGMT_PARAMS['nonstandard_extensions']['encoding']:
    print("Warning: Generation of C Macros for the encoding " + encoding + " is not supported.")
  else:
    err = "Error: Invalid custom instruction encoding: " + encoding
    sys.exit(err)

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
  free_params = ['noncache_start_addr']
  int_params = ['dcache_size', 'dcache_block_size', 'dcache_assoc', 'icache_size', 'icache_block_size', 'icache_assoc']
  include_file.write('// ISA Params:\n') 
  for isa_param in isa_params:
    try:
      if isa_params[isa_param] not in ISA_PARAMS[isa_param]:
        err = 'Illegal configuration. ' + isa_params[isa_param]
        err += ' is not a valid configuration for ' + isa_param
        sys.exit(err)
      else:
        line = 'localparam '
        # xlen will be an integer in include file, so no quotes needed
        if 'xlen' == isa_param:
          line += isa_param.upper() + ' = ' + str(isa_params[isa_param])
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
      if uarch_params['dcache_size'] % (uarch_params['dcache_block_size'] * uarch_params['dcache_assoc']) != 0:
        err = 'Invalid dcache_size. Not divisible by block_size * assoc.'
        sys.exit(err)
      if uarch_params['icache_size'] % (uarch_params['icache_block_size'] * uarch_params['icache_assoc']) != 0:
        err = 'Invalid icache_size. Not divisible by block_size * assoc.'
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

  # Handle bus interface define
  bus_type = uarch_params['bus_interface_type'].split('_if')[0]
  bus_define = '`define BUS_INTERFACE_' + bus_type.upper() + '\n'
  include_file.write(bus_define)

  # Handling of RISC-MGMT Extensions
  rmgmt_extensions = []
  try:
    if 'risc_mgmt_params' in config:
      rmgmt_params = config['risc_mgmt_params']
      if rmgmt_params != None:
        for rmgmt_param in rmgmt_params:
          extensions = rmgmt_params[rmgmt_param]
          if extensions != None:
            for extension in extensions:
              if rmgmt_param == "standard_extensions" and extension['name'] not in RISC_MGMT_PARAMS[rmgmt_param]['name']:
                err = 'Unsupported extension: ' + extension['name']
                sys.exit(err)
              else:
                rmgmt_extensions.append([extension, rmgmt_param])
  except:
    err = "Error Parsing RISC-MGMT extension configuration."
    sys.exit(err) 

  # Need to at least have the nop extension
  if(len(rmgmt_extensions) == 0):
    rmgmt_extensions.append([{'name':'template', 'encoding' : 'R_TYPE', 'length':1}, 'nonstandard_extension'])

  include_file.write('\n// RISC-MGMT Extensions:\n') 
  include_file.write('`define NUM_EXTENSIONS ' + str(len(rmgmt_extensions)) + '\n')
  include_file.write('`define RISC_MGMT_EXTENSIONS\t\\\n')
  ext_num = 0
  nonstandard_num = 0
  for extension in rmgmt_extensions:
    if(extension[1] == 'standard_extensions'):
      include_file.write('\t`ADD_EXTENSION('+extension[0]['name']+','+str(ext_num)+")")
    elif (nonstandard_num < len(NONSTANDARD_OPCODES)):
      include_file.write('\t`ADD_EXTENSION_WITH_OPCODE('+extension[0]['name']+','+
        str(ext_num)+','+ "7'b" + NONSTANDARD_OPCODES[nonstandard_num]+")")
      if 'encoding' in extension[0].keys() and 'length' in extension[0].keys():
        add_custom_instruction_header(extension[0]['name'], extension[0]['encoding'], 
          extension[0]['length'], NONSTANDARD_OPCODES[nonstandard_num], c_file)
      else:
        err = "Error: Missing the encoding or lenght field for nonstandard extension"
        sys.exit(err)
      nonstandard_num = nonstandard_num + 1
    ext_num = ext_num + 1
    if(ext_num != len(rmgmt_extensions)):
      include_file.write('\t\\\n')
    else:
      include_file.write('\n')

  #set defines to indicate what ISA support is present
  include_file.write('\n')
  for extension in rmgmt_extensions:
    if(extension[1] == 'standard_extensions'):
      include_file.write('`define ' + extension[0]['name'].upper() + '_SUPPORTED\t1\n')

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
