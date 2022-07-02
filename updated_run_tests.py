#!/usr/bin/python3

#
#   Copyright 2022 Purdue University
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
#   Filename:     updated_run_tests.py
#
#   Created by:   Nicholas Gildenhuys
#   Email:        ngildenh@purdue.edu
#   Date Created: 03/29/2022
#   Description:  A better script for running processor tests


######## Library Imports ########
import argparse
from asyncio.log import logger
import sys
import os
import re
from typing import List, Type
import logging
import subprocess
import pathlib
import glob
import json
import itertools


######## Globals ########
END_COLOR = "\033[0m"
GREEN = "\033[92m"
RED = "\033[31m"
#WAF_LOGFILE = "waf_output.log"
#BUILD_LOGFILE = "build_log.log"
DEFAULT_CONFIG_FILE = "run_tests_config.json"
MEMINIT_HEX_FILE = "meminit.hex"
ELF2HEX_COMAND = "/home/ecegrid/a/socpub/Public/riscv_dev/riscv_installs/RV_current/bin/elf2hex"
FAILED = "Failed"
PASSED = "Passed"

######## Error Code Exception Class ########
class Error(Exception):
    """A custom exception class for raising exceptions from sub processes"""
    def __init__(self, error_string: str):
        self.error_string = error_string
    def __str__(self) -> str:
        return self.error_string

class run_config():
    def __init__(self, config_json:dict):
        # top level info
        self.arch = str(config_json["arch"])
        self.abi = str(config_json["abi"])
        self.xlen = str(config_json["xlen"])
        self.test_type = str(config_json["test_type"])
        self.top_level = str(config_json["top_level"])
        # read directory definitions
        self.build_dir = pathlib.Path(config_json["build_dir"])
        self.verif_dir = pathlib.Path(config_json["verif_dir"])
        self.asm_env = pathlib.Path(config_json["asm_env"])
        # directory of all where the test files are
        self.test_dir = self.verif_dir/self.test_type/self.arch

        # output directories
        self.sim_dir = pathlib.Path(config_json["sim_dir"])
        self.out_dir = self.sim_dir/self.arch

        # file definitions
        self.link_file = self.verif_dir/pathlib.Path("asm-env")/config_json["link_file"]
        # the cache file name, expects it in same as run directory
        self.cache_file = pathlib.Path(config_json["cache_file"])
        # location of the test files
        if(not self.test_dir.exists()):
            raise Error(f"Test Directory: {self.test_dir} does not exists")
        # init for apending later 
        self.test_filepaths = []
        self.test_filenames = config_json["test_filenames"]
        return

######## Bulk Work Functions ########
def run_tests(config: Type[run_config]) -> List[str]:
    """
    Should return the list of tests that were failed
    """
    print(f"Running Strings: {config.test_filepaths}")
    # setup the sim out directory
    if(not config.out_dir.exists()):
        os.makedirs(config.out_dir)

    # setup the loggers
    # the log names don't matter as they will be replaced in the for loop
    build_logger = setup_logger("build_logger", pathlib.Path("./build_log.log"))
    waf_logger = setup_logger("waf_logger", pathlib.Path("./waf_log.log"))

    # setup caching dict mechanism 
    test_status = dict()
    # read in the cached results if possible
    if(pathlib.Path(config.cache_file).exists()):
        with open(config.cache_file, "r") as cache_fp:
            test_status = json.load(cache_fp)

    # run the tests
    try: 
        for file in config.test_filepaths:
            filepath = pathlib.Path(file)
            # check if there is a cached result 
            test_cached_result = FAILED
            if(filepath.stem in test_status):
                test_cached_result = test_status[filepath.stem]

            # skip files that begin with _
            # or files that have already passed
            if(filepath.name[0] == '_' or test_cached_result == PASSED): 
                print(f"Skipping Test: {filepath.name}")
                continue
            print(f"-----------------------------")
            print(f"Running Test: {filepath.name}")
            # setup the test output directory if it is not there
            test_out_dir = config.out_dir/filepath.stem
            # setup the sim out folder
            if(not test_out_dir.exists()):
                os.makedirs(test_out_dir)
            # update the loggers
            build_log_filepath = test_out_dir/str(filepath.stem+"_build.log")
            build_logger = change_logger_file_handlers(build_logger, build_log_filepath)
            waf_log_filepath = test_out_dir/str(filepath.stem+"_waf.log")
            waf_logger = change_logger_file_handlers(waf_logger, waf_log_filepath)

            # compile the assembly file
            print(f"    - Compiling...")
            outpath = test_out_dir/str(filepath.stem+".elf")
            hex_filepath = compile_asm(filepath, outpath, config, build_logger)
            # clean up the hex file - needs writting
            clean_init_hex(hex_filepath)
            print(f"    - Running Waf...")
            # run self sim - basic done
            run_sim(config.top_level, waf_logger)
            waf_log_filepath = pathlib.Path(waf_logger.handlers[0].baseFilename)
            print(f"    - Checking Results...")
            # check results - 
            result = check_self_results(waf_log_filepath, build_logger)
            # cache the result in the dict
            test_status[filepath.stem] = result
            #print(test_status)
    # catch keyboard interrupts to flush the cache file
    except KeyboardInterrupt:
        pass # yes I know that this is not the pest practice

    with open(config.cache_file, "w") as cache_fp:
        json.dump(test_status, cache_fp)

    return


# compile the assembly file - done
def compile_asm(filepath: Type[pathlib.Path], outpath: Type[pathlib.Path],\
    config: Type[run_config], logger: Type[logging.Logger])\
    -> Type[pathlib.Path]:
    # main compile arguments
    # notes: need to parameratize the .T, .I, abi, and xlen flags
    # also probably pass the filepath too
    compile_cmd_arr = ["riscv64-unknown-elf-gcc", 
                "-march=" + config.xlen, "-mabi=" + config.abi,
                "-static", "-mcmodel=medany", "-fvisibility=hidden",
                "-nostdlib", "-nostartfiles",
                "-T"+str(config.link_file),
                "-I"+str(config.asm_env), str(filepath), "-o",
                str(outpath)]

    log_header("riscv64-unknown-elf-gcc", logger)
    try:
        compile_process: Type[subprocess.CompletedProcess] = subprocess.run(compile_cmd_arr, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    except subprocess.CalledProcessError as p_error:
        compile_process = p_error
    finally:
        log_subprocess(compile_process, logger)


    # create the mem init file
    # NOTE: Hard coded values here that I am too lazy to config
    elf_2_hex_cmd_arr = [ELF2HEX_COMAND, "8", "65536", str(outpath), "2147483648"]
    # hex file return this for cleaning
    hex_filepath = outpath.parent/MEMINIT_HEX_FILE

    log_header("elf2hex", logger)
    elf_2_hex_process: Type[subprocess.CompletedProcess] = subprocess.run(elf_2_hex_cmd_arr, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    log_subprocess(elf_2_hex_process, logger, level=logging.ERROR)
    with open(hex_filepath, "w") as hex_file:
        hex_file.write(str(elf_2_hex_process.stdout, encoding="utf-8"))

    logger.info(f"Finished {filepath.name} Compilation")

    return hex_filepath

# run the simulation
def run_sim(top_level: str, logger: Type[logging.Logger]) -> None:

    config_cmd_arr = ["waf", "configure", "--top_level=" + top_level]
    log_header("waf configure", logger)
    config_process = subprocess.run(config_cmd_arr, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    log_subprocess(config_process, logger) 

    sim_cmd_arr = ["waf", "verify_source"]
    log_header("waf verify_source", logger)
    sim_process = subprocess.run(sim_cmd_arr, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    log_subprocess(sim_process, logger) 

    return

def run_spike_asm(filepath: str) -> None:
    return
# compare the results
def compare_results(filepath: str) -> bool:
    return False
# compare spike results
def compare_spike_results():
    return
# just check selfasm results
def check_self_results(filepath: Type[pathlib.Path],\
    logger: Type[logging.Logger]) -> str:
    # filepath should be path to the waf_output.log 
    short_name = filepath.parent.stem
    pass_msg = '{0:<10}{1}'.format(short_name,GREEN + '[PASSED]' + END_COLOR)
    fail_msg = '{0:<10}{1}'.format(short_name,RED + '[FAILED]' + END_COLOR)
    with open(filepath, 'r') as waf_output:
        waf_output_text = waf_output.read()
        match = re.search(r'SUCCESS', waf_output_text)
        if match:
            print(pass_msg)
            logger.info(pass_msg)
            return PASSED
        else:
            match = re.search(r'(ERROR:)\s+(.*)', waf_output_text)
            print(match.group(2))
            print(fail_msg)
            logger.error(fail_msg)
            return FAILED

######## Side Helper Function ########
def log_subprocess(complete_proc: Type[subprocess.CompletedProcess],\
    logger: Type[logging.Logger], level=logging.NOTSET) -> None:
    """ Logs the std output to the logfile, then if there is an error
        it raises an exception that prints out the output from stderr
    """
    # this is mainly for the elf2hex so we dont get the hexdump in the log
    # but we can still get errors
    if(level <= logging.INFO): 
        logger.info(str(complete_proc.stdout, encoding="utf-8"))
    # put in error if there are any and raise an exception
    if(complete_proc.returncode):
        error_string = str(complete_proc.stderr, encoding="utf-8")
        logger.error(error_string)
        raise Error(error_string=error_string) 
    return
def log_header(process: str, logger: Type[logging.Logger]) -> None:
    logger.info(f"============ Starting {process} Process ============")
    return

# Create a temp file that consists of the Intel HEX format
# version of the meminit.hex file, delete the original log file
# and rename the temp file to the original's name
def clean_init_hex(filepath: Type[pathlib.Path]) -> None:
    # filepath is the path object to the dirty meminit.hex file 
    # the one that was generated by the elf to hex
    #short_name = file_name.split(ARCH+'/')[1][:-2]
    #short_name = filepath.stem
    #output_dir = './sim_out/' + ARCH + '/' + short_name + '/'
    #output_dir = filepath.parent
    #init_output = output_dir + 'meminit.hex'
    init_output = filepath
    build_dir = pathlib.Path("./build/")

    #cleaned_location = init_output[:len(file_name)-4] + "_clean.hex"
    cleaned_location = filepath.parent/"meminit_clean.hex"
    addr = 0x00
    with open(init_output, 'r') as init_file:
        with open(cleaned_location, 'w')as cleaned_file:
            for line in init_file:
                stripped_line = line[:len(line)-1]
                for i in range(len(stripped_line), 0, -8):
                    data_word = stripped_line[i-8:i]
                    new_data_word = data_word[6:8] + data_word[4:6]
                    new_data_word += data_word[2:4] + data_word[0:2]
                    checksum = calculate_checksum_str(int(new_data_word, 16), addr)
                    if len(checksum) < 2:
                        checksum = '0' + checksum
                    addr_str = hex(addr//4)[2:]
                    #left pad the string with 0s until 4 hex digits
                    while len(addr_str) < 4:
                        addr_str = '0' + addr_str
                    if new_data_word != "00000000":
                        out = ":04" + addr_str + "00" + new_data_word + checksum + '\n'
                        cleaned_file.write(out)
                    addr += 0x4
            # add the EOL record to the file
            cleaned_file.write(":00000001FF")


    subprocess.call(['mv', str(init_output), str(init_output.parent/"meminit_dirty.hex")])
    subprocess.call(['mv', str(cleaned_location), str(init_output)])
    if not os.path.exists(build_dir):
        os.makedirs(build_dir)
    subprocess.call(['cp', str(init_output), str(build_dir/"meminit.hex")])
    return

# Returns the string representation of the
# checksum for the given data and address values
def calculate_checksum_str(data: int, addr: int) -> str:
    addr = addr//4
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

def invert_bin_string(bin_string: str) -> str:
    inverted = ''
    while len(bin_string) < 8:
        bin_string = '0' + bin_string
    for bit in bin_string:
        if bit == '0':
            inverted = inverted + '1'
        else:
            inverted = inverted + '0'
    return inverted

######## Logger Related Functions ########
def setup_logger(name: str, log_filepath: Type[pathlib.Path],\
    level=logging.DEBUG) -> Type[logging.Logger]:
    handler = logging.FileHandler(filename=log_filepath, mode="w")        
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    handler.setFormatter(formatter)
    logger = logging.getLogger(name)
    logger.setLevel(level)
    logger.addHandler(handler)
    return logger

def change_logger_file_handlers(logger: Type[logging.Logger],\
    new_filepath: Type[pathlib.Path]) -> Type[logging.Logger]:
    """ Removes all old file handlers and replaces it with a new one """
    # remove all old handlers
    for handler in logger.handlers:
        logger.removeHandler(handler)
        handler.close()
    # add the new one
    new_handler = logging.FileHandler(filename=new_filepath, mode="w")
    formatter = logging.Formatter('[%(asctime)s] %(levelname)-4s: %(message)s')
    new_handler.setFormatter(formatter)

    logger.addHandler(new_handler)
    return logger

######## Main Function ########
def main():
    return

def parse_args()-> Type[run_config]:
    parser = argparse.ArgumentParser(description="Run various processor tests at the top level of RISCVBusisness")
    parser.add_argument("--config_file", "-c", dest="config_file",
        type=str, default=DEFAULT_CONFIG_FILE, 
        help="Specify the config file path")
    parser.add_argument("--arch", "-a", dest="arch",
        type=str, default=None, 
        help="Specify the architecture targeted. Option(s): RV32I Default: RV32I")
    parser.add_argument("--test_type", "-t", dest="test_type",
        type=str, default=None, 
        help="Specify what type of tests to run. Option(s): asm, selfasm,c Default: selfasm")
    parser.add_argument("file_names", metavar="file_names",
        type=str, nargs="*", 
        help="Run all tests that begin with this string. Optional")
    parser.add_argument("--clean", action="store_true", dest="clean",
        help="Clean the cache file before running")
    args = parser.parse_args()

    conf_dict = dict()
    with open(args.config_file, "r") as conf_fp:
        conf_dict = json.load(conf_fp)

    config = run_config(conf_dict)
    if(args.arch):
        config.arch = args.arch
    if(args.test_type):
        config.test_type = args.test_type
    if(args.file_names):
        # find all the files that match the pattern
        print(args.file_names)
        config.test_filenames = args.file_names
    # get the list of test files
    test_files =[]
    for filename in config.test_filenames:
        test_files.append(glob.glob(str(config.test_dir/filename)))
    config.test_filepaths = list(itertools.chain(*test_files))

    # process the clean flag, remove the cache file if want a clean run
    if(args.clean):
        try:
            os.remove(config.cache_file)
        except FileNotFoundError:
            pass # ignore if the file is not there


    return config

######## Main Function ########
if __name__ == "__main__":
    print("Running Main...")
    # setup the logfile
    #logging.basicConfig(filename=log_filepath, mode="w", level=logging.DEBUG)
    config = parse_args()
    run_tests(config)
    # shutdown any remaining loggers
    logging.shutdown()
