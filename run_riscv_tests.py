#! /usr/bin/env python3
from scripts.test_utility import *
import argparse
import io
import os
import queue
import re
import sys
import subprocess
import threading
import pathlib

# RISCV ISA supported
supported_isa = ['i', 'm', 'a', 'c', 'zba', 'zbb', 'zbs']

# For now, only support 'p' & 'v' environments. TODO: Add pm and pt environments.
# No support for 'm' privilege tests
verilator_binary = "./rvb_out/socet_riscv_RISCVBusiness_0.1.1/sim-verilator/Vtop_core"
test_base_dir = pathlib.Path("./riscv-tests/isa")
benchmark_base_dir = pathlib.Path("./riscv-tests/benchmarks")

# Environments
# Technically, the benchmarks are not part of envs.
# Special functionality is required for these, so they are treated as envs.
ENV_P = 'p'
ENV_PM = 'pm'
ENV_PT = 'pt'
ENV_V = 'v'
ENV_BENCHMARK = 'benchmark'

skip_list = [
    'rv32ui-p-ma_data.bin', # requires misaligned load/store, which is optional.
    'rv32ui-pm-ma_data.bin', # requires misaligned load/store, which is optional.
    'rv32ui-v-ma_data.bin', # requires misaligned load/store, which is optional.
    'rv32mi-p-illegal.bin', # requires RV32C illegal instruction detection, which we have not implemented
    'rv32mi-p-breakpoint.bin', # requires some parts of debug spec implemented.
    'rv32mi-p-shamt.bin', # requires full detection of illegal instructions (including RV32 SLL with shamt[5] set)
]

def apply_skips(test):
    if test.name in skip_list:
        info_print(f"Skipping {test} (skip_list)", color=Colors.Bold.YELLOW)
        return False
    
    return True

def get_hostaddress(fname, is_benchmark=False):
    # always going to be at address 0x80001000 if using a benchmark
    if is_benchmark:
        return 2147487744  # address 0x80001000
    # Get binary name
    binary = pathlib.Path(fname).with_suffix("")
    with open(binary, "rb") as fp:
        bytes = fp.read()

        # Determine whether to interpret bytes as little or big endian
        ei_data = int(bytes[0x05])
        if ei_data == 1:
            endianness = "little"
        else:
            endianness = "big"

        SECTION_SIZE = 0x28

        # Get start of section headers
        e_shoff_bytes = bytes[0x20:0x24]
        e_shoff = int.from_bytes(e_shoff_bytes, endianness)

        # Get number of sections
        e_shnum_bytes = bytes[0x30:0x32]
        e_shnum = int.from_bytes(e_shnum_bytes, endianness)

        # Get index of the section string table
        e_shstrndx_bytes = bytes[0x32:0x34]
        e_shstrndx = int.from_bytes(e_shstrndx_bytes, endianness)

        # Get section headers
        shdr = bytes[e_shoff:]

        # Get section string table
        sh_strtab_header = shdr[e_shstrndx*SECTION_SIZE:(e_shstrndx + 1)*SECTION_SIZE]
        sh_strtab_offset = int.from_bytes(sh_strtab_header[0x10:0x14], endianness)
        sh_strtab_size = int.from_bytes(sh_strtab_header[0x14:0x18], endianness)
        sh_strtab = bytes[sh_strtab_offset:sh_strtab_offset+sh_strtab_size]

        # Get the symbol table
        SHT_SYMTAB = 0x2
        SHT_STRTAB = 0x3
        symtab = None
        strtab = None
        for i in range(e_shnum):
            section = shdr[i*SECTION_SIZE:(i+1)*SECTION_SIZE]
            sh_type = int.from_bytes(section[0x04:0x08], endianness)
            sh_offset = int.from_bytes(section[0x10:0x14], endianness)
            sh_size = int.from_bytes(section[0x14:0x18], endianness)
            if sh_type == SHT_SYMTAB:
                symtab = bytes[sh_offset:][:sh_size]
            if sh_type == SHT_STRTAB:
                strtab = bytes[sh_offset:][:sh_size]
            if symtab != None and strtab != None:
                break

        # Walk the symbol table looking for tohost
        SYM_ENTR_SIZE = 0x10
        for i in range(1, len(symtab) // SYM_ENTR_SIZE):
            sym_tab_entry = symtab[i*SYM_ENTR_SIZE:(i+1)*SYM_ENTR_SIZE]
            st_name = int.from_bytes(sym_tab_entry[0x00:0x04], endianness)
            st_value = int.from_bytes(sym_tab_entry[0x04:0x08], endianness)
            if str(strtab[st_name:][:len("tohost")], 'utf-8') == "tohost":
                tohost_address = st_value
    return tohost_address

def run_test(fname, env, output=None):
    tohost_address = get_hostaddress(fname, env == ENV_BENCHMARK)
    run_cmd = [verilator_binary, '--tohost-address', str(tohost_address), '--notrace']
    if env == ENV_V:
        run_cmd.extend(['--max-sim-time', '1000000'])
    if env == ENV_BENCHMARK:
        run_cmd.extend(['--max-sim-time', '100000000', '--debug'])
    run_cmd.append(fname)
    res = subprocess.run(run_cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True, errors='replace')

    stdout_str = res.stdout
    status = ('PASSED' in stdout_str)
    if status:
        status_print('\t[PASSED]', color=Colors.Bold.GREEN, end=' ', file=output)
        status_print(f'{fname}', file=output)
    else:
        status_print('\t[FAILED]', color=Colors.Bold.RED, end=' ', file=output)
        status_print(f'{fname}', file=output)
        print(stdout_str, file=output)

    ipc = -1
    if env == ENV_BENCHMARK:
        elapsed_cycles = int(re.findall(r"^Total Cycles: [0-9]+", stdout_str, re.MULTILINE)[0].split(" ")[2], 10)
        elapsed_instrs = int(re.findall(r"^Total Instructions: [0-9]+", stdout_str, re.MULTILINE)[0].split(" ")[2], 10)
        ipc = elapsed_instrs / elapsed_cycles
        print(f'\t\t Instructions: {elapsed_instrs}', file=output)
        print(f'\t\t Clocks: {elapsed_cycles}', file=output)
        print(f'\t\t IPC: {ipc}', file=output)
    

    if res.returncode != 0:
        if output:
            print(output.getvalue(), end='')
        print('Verilator failed to run, exiting: ')
        print(res.stderr)
        sys.exit(1)

    if output:
        print(output.getvalue(), end='')
    return status, ipc

def run_threads(test, env, data_collect_q):
    output = io.StringIO()
    status, ipc = run_test(test, env, output)
    data_collect_q.put_nowait([test, status, ipc, output])

def _run_tests(tests, total_count, pass_count, env, sim_parallel):
    filtered_tests = list(filter(apply_skips, tests))
    total_ipc = 0

    # If parallel simulation is enabled
    if sim_parallel:
        # increase the total test count
        total_count += len(filtered_tests)
        
        # begin a queue to collect test statuses and list to store current threads
        collect_data_q = queue.Queue()
        test_threads = list()

        # launch threads
        for test in filtered_tests:
            curr_thread = threading.Thread(target=run_threads, args=(test, env, collect_data_q))
            test_threads.append(curr_thread)
            curr_thread.start()

        # join each thread
        for thread in test_threads:
            thread.join()
        
        # dump data
        while not collect_data_q.empty():
            [test, status, ipc, output] = collect_data_q.get()
            output.close()
            total_ipc += ipc
            if status:
                pass_count += 1
    else:
        for test in filtered_tests:
            total_count += 1
            status, ipc = run_test(test, env)
            total_ipc += ipc
            if status:
                pass_count += 1

    if env == ENV_BENCHMARK:
        total_ipc /= total_count
        info_print(f'Average Benchmark IPC: {total_ipc}')

    return total_count, pass_count

def run_selected_tests(
        isa=[],
        envs=['p'],
        machine_mode_tests=False,
        supervisor_mode_tests=False,
        benchmark_tests=False,
        sim_parallel=False,
    ):

    pass_count = 0
    total_count = 0
    
    for env in envs:
        info_print(f"Running '{env}' TVM tests...")
        for ext in isa:
            info_print(f"ISA: RV32{ext.capitalize()}")

            tests = test_base_dir.glob(f"rv32u{ext}-{env}-*.bin")
            total_count, pass_count = _run_tests(
                tests, total_count, pass_count, env, sim_parallel
            )

        # machine-mode tests
        if machine_mode_tests:
            info_print(f"Machine Mode tests")
            tests = test_base_dir.glob(f'rv32mi-{env}-*.bin')
            total_count, pass_count = _run_tests(
                tests, total_count, pass_count, env, sim_parallel
            )

        # supervisor-mode tests
        if supervisor_mode_tests:
            info_print(f"Supervisor Mode tests")
            tests = test_base_dir.glob(f'rv32si-{env}-*.bin')
            total_count, pass_count = _run_tests(
                tests, total_count, pass_count, env, sim_parallel
            )

        # benchmarks
        if benchmark_tests:
            info_print(f"Benchmark Tests")
            tests = benchmark_base_dir.glob(f'*.bin')
            total_count, pass_count = _run_tests(
                tests, total_count, pass_count, ENV_BENCHMARK, sim_parallel
            )

    if pass_count == total_count:
        info_print(f'All {pass_count} tests passed.', color=Colors.Bold.GREEN, end='\n\n')
    else:
        info_print(f'Failed {total_count - pass_count} tests.', color=Colors.Bold.RED, end='\n\n')


def main():
    parser = argparse.ArgumentParser(
        prog='RISC-V Tests',
        description='Runner for RISCVBusiness RISC-V Tests'
    )
    parser.add_argument(
        '--environment',
        choices=[ENV_P, ENV_PM, ENV_PT, ENV_V],
        nargs='*',
        help=f'riscv-tests "TVM" option. Only \'{ENV_P}\' and \'{ENV_V}\' are supported at this time.',
        default=[ENV_P]
    )
    parser.add_argument(
        '--isa',
        choices=supported_isa,
        nargs='*',
        help='RISC-V ISA extensions to test. Supports i, m, zba, zbb, zbs for `p` and `v`. Additionally a for `p`.',
        default=[])
    parser.add_argument(
        '--machine',
        action='store_true',
        help='Enable M-mode tests.'
    )
    parser.add_argument(
        '--supervisor',
        action='store_true',
        help='Enable S-mode tests.'
    )
    parser.add_argument(
        '--benchmarks',
        action='store_true',
        help='Enable running benchmarks.'
    )
    parser.add_argument(
        '--sim-parallel',
        action='store_true',
        help='Enable parallel simulation of tests.'
    )
    args = parser.parse_args()

    if not args.isa and not args.machine and not args.supervisor and not args.benchmarks:
        print("Must supply at least one of --isa, --machine, or --supervisor")
        sys.exit(1)

    if 'pt' in args.environment:
        print("Environment 'pt' is not yet supported.")
        sys.exit(1)
    
    info_print("Running selected tests...")
    run_selected_tests(
        isa=args.isa,
        envs=args.environment,
        machine_mode_tests=args.machine,
        supervisor_mode_tests=args.supervisor,
        benchmark_tests=args.benchmarks,
        sim_parallel=args.sim_parallel,
    )

if __name__ == "__main__":
    main()
