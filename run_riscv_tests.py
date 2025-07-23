#! /usr/bin/env python3
import os
import argparse
import sys
import subprocess
import pathlib

class Colors:
    RED = '\033[1;31;48m'
    YELLOW = '\033[1;33;48m'
    GREEN = '\033[1;32;48m'
    END = '\033[1;37;0m'

# RISCV ISA supported
supported_isa = ['i', 'm', 'a', 'c', 'f', 'd', 'zba', 'zbb', 'zbs', 'zfh']

# For now, only support 'p' environment. TODO: Add pm and pt environments.
# No support for 'm' privilege tests
# verilator_binary = "./rvb_out/socet_riscv_RISCVBusiness_0.1.1/sim-verilator/Vtop_core"
verilator_binary = "./rvb_out/sim-verilator/Vtop_core"
test_base_dir = pathlib.Path("./riscv-tests/isa")

skip_list = [
    'rv32ui-p-ma_data.bin', # requires misaligned load/store, which is optional.
    'rv32mi-p-illegal.bin', # requires RV32C illegal instruction detection, which we have not implemented
    'rv32mi-p-breakpoint.bin', # requires some parts of debug spec implemented.
    'rv32mi-p-shamt.bin', # requires full detection of illegal instructions (including RV32 SLL with shamt[5] set)
    'rv32ui-v-ma_data.bin', # requires misaligned load/store, which is optional.
]

def apply_skips(test):
    if test.name in skip_list:
        print(f"Skipping {test} (skip_list)")
        return False
    
    return True

def get_hostaddress(fname):
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

def run_test(fname, env):
    tohost_address = get_hostaddress(fname)
    run_cmd = [verilator_binary, '--tohost-address', str(tohost_address), fname]
    if env == 'v':
        run_cmd = [verilator_binary, '--tohost-address', str(tohost_address), '--max-sim-time', '1000000', '--virtual', fname, '--notrace']
    res = subprocess.run(run_cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
    if res.returncode != 0:
        print('Verilator failed to run, exiting: ')
        print(res.stderr)
        exit(1)

    if 'PASSED' not in res.stdout:
        print(res.stdout)

    return ('PASSED' in res.stdout)

def run_selected_tests(isa, envs, machine_mode_tests, supervisor_mode_tests):
    pass_count = 0
    total_count = 0
    
    for env in envs:
        print(f"Running '{env}' TVM tests...")
        for ext in isa:
            print(f"ISA: RV32{ext.capitalize()}")

            tests = test_base_dir.glob(f"rv32u{ext}-{env}-*.bin")
            for test in filter(apply_skips, tests):
                total_count += 1
                status = run_test(test, env)
                if status:
                    pass_count += 1
                else:
                    print(f"{Colors.RED}[FAILED]: {Colors.END}{test}")

        # machine-mode tests
        if machine_mode_tests:
            print(f"Machine Mode tests")
            tests = test_base_dir.glob(f'rv32mi-{env}*.bin')
            for test in filter(apply_skips, tests):
                total_count += 1
                status = run_test(test, env)
                if status:
                    pass_count += 1
                else:
                    print(f"{Colors.RED}[FAILED]: {Colors.END}{test}")

        # supervisor-mode tests
        if supervisor_mode_tests:
            print(f"Supervisor Mode tests")
            tests = test_base_dir.glob(f'rv32si-{env}*.bin')
            for test in filter(apply_skips, tests):
                total_count += 1
                status = run_test(test, env)
                if status:
                    pass_count += 1
                else:
                    print(f"{Colors.RED}[FAILED]: {Colors.END}{test}")
        
    if pass_count == total_count:
        print(f"{Colors.GREEN}[All {pass_count} tests passed.]{Colors.END}")
    else:
        print(f"{Colors.YELLOW}[Passed {pass_count}/{total_count} tests.]{Colors.END}")


def main():
    parser = argparse.ArgumentParser(prog='RISC-V Tests', description='Runner for RISCVBusiness RISC-V Tests')
    parser.add_argument('--environment', choices=['p', 'pm', 'pt', 'v'], nargs='*', help='riscv-tests "TVM" option. Only \'p\' and \'v\' are supported at this time.', default=['p'])
    parser.add_argument('--isa', choices=supported_isa, nargs='*', help='RISC-V ISA extensions to test. Only user-level ISA supported at this time.', default=[])
    parser.add_argument('--machine', action='store_true', help='Enable M-mode tests. Not currently supported.')
    parser.add_argument('--supervisor', action='store_true', help='Enable S-mode tests. Not currently supported.')
    args = parser.parse_args()

    if not args.machine and not args.isa and not args.supervisor:
        print("Must supply at least one of --isa, --machine, or --supervisor")
        exit(1)

    if 'pm' in args.environment or 'pt' in args.environment:
        print("Environments 'pt' and 'pm' are not yet supported.")
        exit(1)
    
    print("Running selected tests...")
    run_selected_tests(args.isa, args.environment, args.machine, args.supervisor)

if __name__ == "__main__":
    main()
