#!/usr/bin/python

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
#   Filename:     run_tests.py
#
#   Created by:   Jacob R. Stevens
#   Email:        steven69@purdue.edu
#   Date Created: 06/01/2016
#   Description:  Script for running processor tests

import argparse
import sys
import glob
import subprocess
import os
import re

FNULL = open(os.devnull, 'w')
END_COLOR = "\033[0m"
START_GREEN = "\033[92m"
START_RED = "\033[31m"

FILE_NAME = None
ARCH = "RV32I"
SUPPORTED_ARCHS = []
SUPPORTED_TEST_TYPES = ['asm', 'c', 'selfasm', "sparce", ""]
SPARCE_MODULES = ['sparce_svc', 'sparce_sprf', 'sparce_sasa_table', 'sparce_psru', 'sparce_cfid']
TEST_TYPE = ""
# Change this variable to the filename (minus extension)
# of the top level file for your project. This should
# match the file name given in the top level wscript
TOP_LEVEL = "RISCVBusiness" # NOTE: Adjust this module name to adjust what top level is needed for the Cadence simulation 

def parse_arguments():
    global ARCH, FILE_NAME, SUPPORTED_ARCHS, TEST_TYPE
    parser = argparse.ArgumentParser(description="Run various processor tests. This script expects to be run at the top level of the RISCV Business directory")
    parser.add_argument('--arch', '-a', dest='arch', type=str,
                        default="RV32I",
                        help="Specify the architecture targeted. Option(s): RV32I Default: RV32I")
    parser.add_argument('--test', '-t', dest='test_type', type=str, default="",
                        help="Specify what type of tests to run. Option(s): asm,selfasm,c Default: asm")
    parser.add_argument('file_name', metavar='file_name', type=str,
                        nargs='?',
                        help="Run all tests that begin with this string. Optional")
    args = parser.parse_args()
    ARCH = args.arch
    FILE_NAME = args.file_name
    TEST_TYPE = args.test_type

    if TEST_TYPE not in SUPPORTED_TEST_TYPES:
        print "ERROR: " + TEST_TYPE + " is not a supported test type"
        sys.exit(1)

    if TEST_TYPE == "":
        for test_type in SUPPORTED_TEST_TYPES[:-1]:
            if test_type == 'selfasm':
                test_file_dir = 'self-tests/'
            else:
                test_file_dir = test_type + '-tests/'
        SUPPORTED_ARCHS = glob.glob('./verification/' + test_file_dir + '*')
        SUPPORTED_ARCHS = [a.split('/'+test_file_dir)[1] for a in SUPPORTED_ARCHS]
        if ARCH not in SUPPORTED_ARCHS:
           if test_type != 'sparce':
              print "ERROR: No " + test_type + " tests exist for " + ARCH
              sys.exit(1)
        else:
          if TEST_TYPE == 'sparce':
            pass
          elif TEST_TYPE == 'selfasm':
            test_file_dir = 'self-tests/'
          else:
            test_file_dir = TEST_TYPE + '-tests/'
          SUPPORTED_ARCHS = glob.glob('./verification/' + test_file_dir + '*')
          SUPPORTED_ARCHS = [a.split('/'+test_file_dir)[1] for a in SUPPORTED_ARCHS]
          if ARCH not in SUPPORTED_ARCHS:
            print "ERROR: No " + TEST_TYPE + " tests exist for " + ARCH
            sys.exit(1)

# compile_asm takes a file_name as input and assembles the file pointed
# to by that file name. It also takes the elf file that is the result
# of that compilation and creates a meminit.hex file for it
def compile_asm(file_name):
    # compile all of the files
    short_name = file_name.split(ARCH+'/')[1][:-2]
    output_dir = './sim_out/' + ARCH + '/' + short_name + '/'
    output_name = output_dir + short_name + '.elf'

    # Added 64-bit support
    xlen = 'rv64g' if '64' in ARCH else 'rv32g'
    abi = 'lp64' if '64' in ARCH else 'ilp32'

    if not os.path.exists(os.path.dirname(output_name)):
        os.makedirs(os.path.dirname(output_name))

    cmd_arr = ['riscv64-unknown-elf-gcc', '-march=' + xlen, '-mabi=' + abi, '-static',
                '-mcmodel=medany', '-fvisibility=hidden', '-nostdlib',
                '-nostartfiles', '-T./verification/asm-env/link.ld',
                '-I./verification/asm-env/asm', file_name, '-o', output_name]
    failure = subprocess.call(cmd_arr)
    if failure:
        return -1

    # create an meminit.hex file from the elf file produced above
    cmd_arr = ['elf2hex', '8', '65536', output_name, '2147483648']
    hex_file_loc = output_dir + 'meminit.hex'
    with open(hex_file_loc, 'w') as hex_file:
        failure = subprocess.call(cmd_arr, stdout=hex_file)
    if failure:
        return -2
    else:
        return 0

# compile_asm_for_self is identical to compile_asm but has different
# settings specifically for compiling self tests
def compile_asm_for_self(file_name):
    # compile all of the files
    short_name = file_name.split(ARCH+'/')[1][:-2]
    output_dir = './sim_out/' + ARCH + '/' + short_name + '/'
    output_name = output_dir + short_name + '.elf'

    if not os.path.exists(os.path.dirname(output_name)):
        os.makedirs(os.path.dirname(output_name))

    xlen = 'rv64g' if '64' in ARCH else 'rv32g'
    abi = 'lp64' if '64' in ARCH else 'ilp32'


    cmd_arr = ['riscv64-unknown-elf-gcc', '-march=' + xlen, '-mabi=' + abi,
                '-static', '-mcmodel=medany', '-fvisibility=hidden',
                '-nostdlib', '-nostartfiles', 
                '-T./verification/asm-env/link.ld',
                '-I./verification/asm-env/selfasm', file_name, '-o',
                output_name]
    failure = subprocess.call(cmd_arr)
    if failure:
        return -1

    # create an meminit.hex file from the elf file produced above
    cmd_arr = ['elf2hex', '8', '65536', output_name, '2147483648']
    hex_file_loc = output_dir + 'meminit.hex'
    with open(hex_file_loc, 'w') as hex_file:
        failure = subprocess.call(cmd_arr, stdout=hex_file)
    if failure:
        return -2
    else:
        return 0

def compile_c(file_name):
    # compile all of the files
    short_name = file_name.split(ARCH+'/')[1][:-2]
    output_dir = './sim_out/' + ARCH + '/' + short_name + '/'
    output_name = output_dir + short_name + '.elf'

    if not os.path.exists(os.path.dirname(output_name)):
        os.makedirs(os.path.dirname(output_name))

    xlen = 'rv64g' if '64' in ARCH else 'rv32g'
    abi = 'lp64' if '64' in ARCH else 'ilp32'

    cmd_arr = ['riscv64-unknown-elf-gcc', '-O0', '-march='+xlen, '-mabi='+abi]
    cmd_arr += ['-ffunction-sections', '-Wno-comments']
    cmd_arr += ['-ffreestanding', '-nostdlib', '-o', output_name, 
              '-Wl,-Bstatic,-T,verification/c-firmware/link.ld,--strip-debug']
    cmd_arr += ['-lgcc', 'verification/c-firmware/trap.S']
    cmd_arr += ['-Iverification/c-firmware/']
    cmd_arr += ['verification/c-firmware/trap.c', 'verification/c-firmware/print.c', file_name]
    failure = subprocess.call(cmd_arr)
    if failure:
        return -1

    # create an meminit.hex file from the elf file produced above
    cmd_arr = ['elf2hex', '8', '524288', output_name, '2147483648']
    hex_file_loc = output_dir + 'meminit.hex'
    with open(hex_file_loc, 'w') as hex_file:
        failure = subprocess.call(cmd_arr, stdout=hex_file)
    if failure:
        return -2
    else:
        return 0

def invert_bin_string(bin_string):
    inverted = ''
    while len(bin_string) < 8:
        bin_string = '0' + bin_string
    for bit in bin_string:
        if bit == '0':
            inverted = inverted + '1'
        else:
            inverted = inverted + '0'
    return inverted


# Returns the string representation of the
# checksum for the given data and address values
def calculate_checksum_str(data, addr):
    addr = addr/4
    high_addr = (addr & 0xFF00) >> 8
    low_addr = addr & 0x00FF
    data1 = data & 0x000000FF
    data2 = (data & 0x0000FF00) >> 8
    data3 = (data & 0x00FF0000) >> 16
    data4 = (data & 0xFF000000) >> 24
    checksum = 4 + high_addr + low_addr
    checksum += data1 + data2 + data3 + data4
    checksum = checksum & 0xFF
    checksum = int(invert_bin_string(bin(checksum)[2:]),2)
    checksum += 1
    checksum_lower_byte = hex(checksum)[2:]
    if len(checksum_lower_byte) > 2:
        checksum_lower_byte = checksum_lower_byte[-2:]
    return checksum_lower_byte 

# Create a temp file that consists of the Intel HEX format
# version of the meminit.hex file, delete the original log file
# and rename the temp file to the original's name
def clean_init_hex(file_name):
    short_name = file_name.split(ARCH+'/')[1][:-2]
    output_dir = './sim_out/' + ARCH + '/' + short_name + '/'
    init_output = output_dir + 'meminit.hex'
    build_dir = './build/meminit.hex'

    cleaned_location = init_output[:len(file_name)-4] + "_clean.hex"
    addr = 0x00
    with open(init_output, 'r') as init_file:
        cleaned_file = open(cleaned_location, 'w')

        for line in init_file:
            stripped_line = line[:len(line)-1]
            for i in range(len(stripped_line), 0, -8):
                data_word = stripped_line[i-8:i]
                new_data_word = data_word[6:8] + data_word[4:6]
                new_data_word += data_word[2:4] + data_word[0:2]
                checksum = calculate_checksum_str(int(new_data_word, 16), addr)
                if len(checksum) < 2:
                    checksum = '0' + checksum
                addr_str = hex(addr/4)[2:]
                #left pad the string with 0s until 4 hex digits
                while len(addr_str) < 4:
                    addr_str = '0' + addr_str
                if new_data_word != "00000000":
                    out = ":04" + addr_str + "00" + new_data_word + checksum + '\n'
                    cleaned_file.write(out)
                addr += 0x4
        # add the EOL record to the file
        cleaned_file.write(":00000001FF")
        cleaned_file.close()
    subprocess.call(['rm', init_output])
    subprocess.call(['mv', cleaned_location, init_output])
    if not os.path.exists(os.path.dirname(build_dir)):
        os.makedirs(os.path.dirname(build_dir))
    subprocess.call(['cp', init_output, build_dir])
    return

# Create a temp file that consists of the Intel HEX format
# version of the meminit.hex file, delete the original log file
# and rename the temp file to the original's name
def clean_init_hex_for_self(file_name):
    short_name = file_name.split(ARCH+'/')[1][:-2]
    output_dir = './sim_out/' + ARCH + '/' + short_name + '/'
    init_output = output_dir + 'meminit.hex'
    build_dir = './build/meminit.hex'

    cleaned_location = init_output[:len(file_name)-4] + "_clean.hex"
    addr = 0x00
    with open(init_output, 'r') as init_file:
        cleaned_file = open(cleaned_location, 'w')

        for line in init_file:
            stripped_line = line[:len(line)-1]
            for i in range(len(stripped_line), 0, -8):
                data_word = stripped_line[i-8:i]
                new_data_word = data_word[6:8] + data_word[4:6]
                new_data_word += data_word[2:4] + data_word[0:2]
                checksum = calculate_checksum_str(int(new_data_word, 16), addr)
                if len(checksum) < 2:
                    checksum = '0' + checksum
                addr_str = hex(addr/4)[2:]
                #left pad the string with 0s until 4 hex digits
                while len(addr_str) < 4:
                    addr_str = '0' + addr_str
                if new_data_word != "00000000":
                    out = ":04" + addr_str + "00" + new_data_word + checksum + '\n'
                    cleaned_file.write(out)
                addr += 0x4
        # add the EOL record to the file
        cleaned_file.write(":00000001FF")
        cleaned_file.close()
    subprocess.call(['rm', init_output])
    subprocess.call(['mv', cleaned_location, init_output])
    if not os.path.exists(os.path.dirname(build_dir)):
        os.makedirs(os.path.dirname(build_dir))
    subprocess.call(['cp', init_output, build_dir])
    return

# Create a temp file that consists of the Intel HEX format
# version of the spike log file, delete the original log file
# and rename the temp file to the original's name
def clean_spike_output(file_name):
    short_name = file_name.split(ARCH+'/')[1][:-2]
    output_dir = './sim_out/' + ARCH + '/' + short_name + '/'

    # clean the hex memory dump
    spike_output = output_dir + short_name + '_spike.hex'
    cleaned_location = output_dir + short_name + '_spike_clean.hex'
    addr = 0x00
    with open(spike_output, 'r') as spike_file:
        cleaned_file = open(cleaned_location, 'w')
        for line in spike_file:
            stripped_line = line[:len(line)-1]
            for i in range(len(stripped_line), 0, -8):
                data_word = stripped_line[i-8:i]
                new_data_word = data_word[6:8] + data_word[4:6]
                new_data_word += data_word[2:4] + data_word[0:2]
                checksum = calculate_checksum_str(int(new_data_word, 16), addr)
                if len(checksum) < 2:
                    checksum = '0' + checksum
                addr_str = hex(addr/4)[2:]
                #left pad the string with 0s until 4 hex digits
                while len(addr_str) < 4:
                    addr_str = '0' + addr_str
                if new_data_word != "00000000":
                    out = ":04" + addr_str + "00" + new_data_word + checksum + '\n'
                    cleaned_file.write(out)
                addr += 0x4
        # add the EOL record to the file
        cleaned_file.write(":00000001FF")
        cleaned_file.close()
    subprocess.call(['rm', spike_output])
    subprocess.call(['mv', cleaned_location, spike_output])

    # clean the trace 
    trace_output = output_dir + short_name + '_spike.trace'
    cleaned_output = '' 
    with open(trace_output, 'r') as trace_file:
        for line in trace_file:
            line = line.strip()
            broken_line_arr = line.split()
            # there is now a weird line after exceptions in spike
            if len(broken_line_arr) == 4 and broken_line_arr[2] == 'tval':
                continue
            elif len(broken_line_arr) >= 5 and 'csrwi' == broken_line_arr[4]:
                break
            elif len(broken_line_arr) > 6 and '0x' == broken_line_arr[6][0:2]:
                imm = int(broken_line_arr[6], 16)
                broken_line_arr[6] = str(imm)
            elif len(broken_line_arr) > 8 and '0x' == broken_line_arr[8][0:2]:
                imm = int(broken_line_arr[8], 16)
                broken_line_arr[8] = str(imm)

            new_line = ' '.join(broken_line_arr) + '\n'
            cleaned_output += new_line
    with open(trace_output, 'w') as trace_file:
        trace_file.write(cleaned_output) 

    return

def clean_sim_trace(file_name):
    short_name = file_name.split(ARCH+'/')[1][:-2]
    output_dir = './sim_out/' + ARCH + '/' + short_name + '/'

    # clean the trace
    trace_output = output_dir + short_name + '_sim.trace'
    cleaned_output = ''
    with open('build/trace.log', 'r') as trace_file:
        for line in trace_file:
            broken_line_arr = line.split()
            if 'csrwi' == broken_line_arr[4]:
                break
            new_line = ' '.join(broken_line_arr) + '\n'
            cleaned_output += new_line
    with open(trace_output, 'w') as trace_file:
        trace_file.write(cleaned_output) 
    return

def run_sim(file_name):
    short_name = file_name.split(ARCH+'/')[1][:-2]
    output_dir = './sim_out/' + ARCH + '/' + short_name + '/'

    cmd_arr = ['waf', 'configure', '--top_level=' + TOP_LEVEL]
    failure = subprocess.call(cmd_arr, stdout=FNULL)
    if failure:
        return -1
    cmd_arr = ['waf', 'verify_source']
    log = open(output_dir + 'waf_output.log', 'w')
    log.write('Now running ' + file_name)
    failure = subprocess.call(cmd_arr, stdout=log)
    if failure:
        log.close()
        log = open(output_dir + 'waf_output.log', 'r')
        for line in log:
            print line
        return -2
    subprocess.call(['mv', 'build/cpu.hex', output_dir + 'cpu.hex'])
    if(os.path.exists('build/stats.txt')):
        subprocess.call(['mv', 'build/stats.txt', output_dir + 'stats.txt'])
    return 0

def run_self_sim(file_name):
    short_name = file_name.split(ARCH+'/')[1][:-2]
    output_dir = './sim_out/' + ARCH + '/' + short_name + '/'

    cmd_arr = ['waf', 'configure', '--top_level=' + TOP_LEVEL + "_self_test"]
    failure = subprocess.call(cmd_arr, stdout=FNULL)
    if failure:
        return -1
    cmd_arr = ['waf', 'verify_source']
    log = open(output_dir + 'waf_output.log', 'w')
    log.write('Now running ' + file_name)
    failure = subprocess.call(cmd_arr, stdout=log)
    if failure:
        log.close()
        log = open(output_dir + 'waf_output.log', 'r')
        for line in log:
            print line
        return -2
    if(os.path.exists('build/stats.txt')):
        subprocess.call(['mv', 'build/stats.txt', output_dir + 'stats.txt'])
    return 0

def run_spike_asm(file_name):
    # the object file should already exist from calling compile_asm
    short_name = file_name.split(ARCH+'/')[1][:-2]
    output_dir = './sim_out/' + ARCH + '/' + short_name + '/'

    elf_name = output_dir + short_name + '.elf'
    log_name = output_dir + short_name + '_spike.hex'
    cmd_arr = ['spike', '-l', '--isa=RV32IM', '+signature=' + log_name, elf_name]
    print(cmd_arr)
    spike_log = open(output_dir + short_name + '_spike.trace', 'w')
    failure = subprocess.call(cmd_arr, stdout = spike_log, stderr = spike_log)
    spike_log.close()
    if failure:
        return -1
    return 0

def compare_results(f):
    short_name = f.split(ARCH+'/')[1][:-2]
    output_dir = './sim_out/' + ARCH + '/' + short_name + '/'

    sim_name =  output_dir + 'cpu.hex'
    spike_name = output_dir + short_name + '_spike.hex'
    pass_msg = '{0:<40}{1:>20}'.format(short_name,START_GREEN + '[PASSED]' + END_COLOR)
    fail_msg = '{0:<40}{1:>20}'.format(short_name,START_RED + '[FAILED]' + END_COLOR)
    failure = subprocess.call(['diff', sim_name, spike_name],
                stdout=FNULL, stderr=subprocess.STDOUT)
    cmd_arr = ['diff', output_dir + short_name + '_spike.trace']
    cmd_arr += [output_dir + short_name + '_sim.trace']
    #subprocess.call(cmd_arr)
    if failure:
        print fail_msg
        return 1
    else:
        print pass_msg
        return 0

def check_results(f):
    short_name = f.split(ARCH+'/')[1][:-2]
    output_dir = './sim_out/' + ARCH + '/' + short_name + '/'

    pass_msg = '{0:<40}{1:>20}'.format(short_name,START_GREEN + '[PASSED]' + END_COLOR)
    fail_msg = '{0:<40}{1:>20}'.format(short_name,START_RED + '[FAILED]' + END_COLOR)

    pattern = r'SUCCESS'
    with open(output_dir + '/waf_output.log', 'r') as waf_output:
        waf_output_text = waf_output.read()
        match = re.search(pattern, waf_output_text)
        if match:
            print pass_msg
            return 0
        else:
            print fail_msg
            return 1

def run_asm():
    failures = 0
    if FILE_NAME is None:
        files = glob.glob("./verification/"+"asm"+"-tests/"+ARCH+"/*.S")
    else:
        files = glob.glob("./verification/"+"asm"+"-tests/"+ARCH+"/"+FILE_NAME+"*.S")
    print "Starting asm tests..."
    for f in files:
        if 'asicfab' in os.environ['HOSTNAME']:
            # Need to do the work on EE256
            test_name = f.split('/')[-1][:-2]
            output_dir = './sim_out/' + ARCH + '/' + test_name + '/'
            elf_name = output_dir + test_name + '.elf'
            log_name = output_dir + test_name + '_spike.hex'
            ee256_cmd = '#!/bin/sh\nexport RISCV=~/riscv-toolchain\nexport PATH='
            ee256_cmd += '~/riscv-toolchain/bin:$PATH\ncd '
            ee256_cmd += 'RISCVBusiness \npython compile_asm.py ' + f + '\n'
            ee256_cmd += 'spike -l --isa=RV32IM +signature=' + log_name + ' '
            ee256_cmd += elf_name + ' &>> ' + output_dir + test_name + '_spike.trace'

            with open('compile256.cmd', 'w') as cmd_f:
                cmd_f.write(ee256_cmd)
            asic_fab_cmd = "#!/bin/sh\nssh socetlnx03@128.46.75.147 'bash -s'  < compile256.cmd"
            with open('compile_asicfab.cmd', 'w') as cmd_f:
                cmd_f.write(asic_fab_cmd)
            ret = subprocess.call(['chmod', '+x', 'compile_asicfab.cmd'])
            if ret != 0:
                print('Could not make executable')
            ret = subprocess.call(['compile_asicfab.cmd'])

            # Now bring the Spike trace and hex files over to asicfab
            if not os.path.exists('./sim_out/' + ARCH + '/' + test_name):
                os.makedirs('./sim_out/' + ARCH + '/' + test_name)
            scp_cmd = 'scp -q socetlnx03@128.46.75.147:~/'
            scp_cmd += 'RISCVBusiness/sim_out/' + ARCH + '/' + test_name
            scp_cmd += '/* ./sim_out/' + ARCH + '/' + test_name
            ret = subprocess.call(scp_cmd.split())
            if ret != 0:
                print('Could not transfer to asicfab')
        else:
            # RISCV tools correct, compile as usual
            ret = compile_asm(f)
            if ret != 0:
                if ret == -1:
                    print "An error has occured during GCC compilation"
                elif ret == -2:
                    print "An error has occured converting elf to hex"
                sys.exit(1)
            clean_init_hex(f)
            ret = run_spike_asm(f)
            if ret != 0:
                print "An error has occurred during running Spike"
                sys.exit(ret)

        clean_spike_output(f)
        clean_init_hex(f)
        ret = run_sim(f)
        if ret != 0:
            if ret == -1:
              print "An error has occurred while setting waf's top level"
            elif ret == -2:
                print "An error has occurred while running " + f
            sys.exit(ret)
        clean_sim_trace(f)
        failures += compare_results(f)

    return failures

def run_sparce():
   failures = 0
   print "starting sparce module tests..."
   for module in SPARCE_MODULES:
      
      pass_msg = '{0:<40}{1:>20}'.format(module,START_GREEN + '[PASSED]' + END_COLOR)
      fail_msg = '{0:<40}{1:>20}'.format(module,START_RED + '[FAILED]' + END_COLOR)

      output_dir = './sim_out/sparce/' + module + '/'
      if not os.path.exists(output_dir):
         try:
            os.makedirs(output_dir)
         except OSError as exc: # Guard against race condition
            if exc.errno != errno.EEXIST:
               raise
      cmd_arr = ['waf', 'configure', '--top_level=' + module]
      failure = subprocess.call(cmd_arr, stdout=FNULL)
      if failure:
         print "Error configuring test for " + module
         failures += 1
      else:
         cmd_arr = ['waf', 'verify_source']
         log = open(output_dir + 'waf_output.log', 'w')
         log.write('Now running ' + module)
         failure = subprocess.call(cmd_arr, stdout=log)
         if failure:
            log.close()
            log = open(output_dir + 'waf_output.log', 'r')
            for line in log:
                print line
            failures += 1
            print fail_msg
         else:
            print pass_msg

   return failures

def run_selfasm():
    failures = 0
    if FILE_NAME is None:
        files = glob.glob("./verification/self-tests/" + ARCH + "/*.S")
    else:
        loc = "./verification/self-tests/" + ARCH + "/" + FILE_NAME + "*.S"
        files = glob.glob(loc)
    print "Starting self tests..."
    for f in files:
        # TODO: Fix timer error
        #if 'timer2' in f: continue

        if 'asicfab' in os.environ['HOSTNAME']:
            # Do work remotely
            test_name = f.split('/')[-1][:-2]
            ee256_cmd = '#!/bin/sh\nexport RISCV=~/riscv-toolchain\nexport PATH='
            ee256_cmd += '~/riscv-toolchain/bin:$PATH\ncd '
            ee256_cmd += 'RISCVBusiness \npython compile_asm_for_self.py ' + f

            with open('compile256.cmd', 'w') as cmd_f:
                cmd_f.write(ee256_cmd)
            asic_fab_cmd = "#!/bin/sh\nssh socetlnx03@128.46.75.147 'bash -s'  < compile256.cmd"
            with open('compile_asicfab.cmd', 'w') as cmd_f:
                cmd_f.write(asic_fab_cmd)
            ret = subprocess.call(['chmod', '+x', 'compile_asicfab.cmd'])
            if ret != 0:
                print('Could not make executable')
                sys.exit()
            ret = subprocess.call(['compile_asicfab.cmd'])
            if ret != 0:
                print('Failed compiling on EE256')
                sys.exit()

            # Now bring the hex file over to asicfab
            if not os.path.exists('./sim_out/' + ARCH + '/' + test_name):
                os.makedirs('./sim_out/' + ARCH + '/' + test_name)
            scp_cmd = 'scp -q socetlnx03@128.46.75.147:~/'
            scp_cmd += 'RISCVBusiness/sim_out/' + ARCH + '/' + test_name
            scp_cmd += '/* ./sim_out/' + ARCH + '/' + test_name
            ret = subprocess.call(scp_cmd.split())
            if ret != 0:
                print('Could not transfer to asicfab')
        else:
            # Do the work locally
            ret = compile_asm_for_self(f)
            if ret != 0:
                if ret == -1:
                    print "An error has occured during GCC compilation"
                elif ret == -2:
                    print "An error has occured converting elf to hex"
                sys.exit(ret)

        clean_init_hex_for_self(f)
        ret = run_self_sim(f)
        if ret != 0:
            if ret == -1:
                print "An error has occured while seting waf's top level"
            elif ret == -2:
                print "An error has occured while running " + f
            sys.exit(ret)
        failures += check_results(f)
    return failures

def run_c():
    failures = 0
    if FILE_NAME is None:
        files = glob.glob("./verification/c-tests/" + ARCH + "/*.c")
    else:
        loc = "./verification/c-tests/" + ARCH + "/" + FILE_NAME + "*.c"
        files = glob.glob(loc)
    print "Starting c tests..."
    for f in files:
        if 'asicfab' in os.environ['HOSTNAME']:
            # Do work remotely
            test_name = f.split('/')[-1][:-2]
            output_dir = './sim_out/' + ARCH + '/' + test_name + '/'
            elf_name = output_dir + test_name + '.elf'
            log_name = output_dir + test_name + '_spike.hex'
            ee256_cmd = '#!/bin/sh\nexport RISCV=~/riscv-toolchain\nexport PATH='
            ee256_cmd += '~/riscv-toolchain/bin:$PATH\ncd '
            ee256_cmd += 'RISCVBusiness \npython compile_c.py ' + f + '\n'

            with open('compile256.cmd', 'w') as cmd_f:
                cmd_f.write(ee256_cmd)
            asic_fab_cmd = "#!/bin/sh\nssh socetlnx03@128.46.75.147 'bash -s'  < compile256.cmd"
            with open('compile_asicfab.cmd', 'w') as cmd_f:
                cmd_f.write(asic_fab_cmd)
            ret = subprocess.call(['chmod', '+x', 'compile_asicfab.cmd'])
            if ret != 0:
                print('Could not make executable')
            ret = subprocess.call(['compile_asicfab.cmd'])

            # Now bring the hex files over to asicfab
            if not os.path.exists('./sim_out/' + ARCH + '/' + test_name):
                os.makedirs('./sim_out/' + ARCH + '/' + test_name)
            scp_cmd = 'scp -q socetlnx03@128.46.75.147:~/'
            scp_cmd += 'RISCVBusiness/sim_out/' + ARCH + '/' + test_name
            scp_cmd += '/* ./sim_out/' + ARCH + '/' + test_name
            ret = subprocess.call(scp_cmd.split())
            if ret != 0:
                print('Could not transfer to asicfab')
        else:
            ret = compile_c(f)
            if ret != 0:
                if ret == -1:
                    print "An error has occured during GCC compilation"
                elif ret == -2:
                    print "An error has occured converting elf to hex"
                sys.exit(ret)
        clean_init_hex_for_self(f)
        ret = run_self_sim(f)
        if ret != 0:
            if ret == -1:
                print "An error has occured while seting waf's top level"
            elif ret == -2:
                print "An error has occured while running " + f
            sys.exit(ret)
        failures += check_results(f)
    return failures

if __name__ == '__main__':
    parse_arguments()
    failures = 0
    # asm comparison testing
    if TEST_TYPE == "asm":
        failures = run_asm()
    # C comparison testing
    elif TEST_TYPE == "c":
        failures = run_c()
    # self tests
    elif TEST_TYPE == "selfasm":
      failures = run_selfasm()
    # sparce tests
    elif TEST_TYPE == "sparce":
      failures = run_sparce()
    elif TEST_TYPE == "":
      failures += run_asm()
      failures += run_selfasm()
      failures += run_c()
      failures += run_sparce()
    else:
        print "To be implemented"
    sys.exit(failures)
