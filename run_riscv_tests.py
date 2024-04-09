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
verilator_binary = "./rvb_out/sim-verilator/Vtop_core"
tohost_address = 0x80001000
test_base_dir = pathlib.Path("./riscv-tests/isa")

skip_list = [
    'rv32ui-p-ma_data.bin' # requires misaligned load/store, which is optional.
]

def apply_skips(test):
    if test.name in skip_list:
        print(f"Skipping {test} (skip_list)")
        return False
    
    return True

def run_test(fname):
    res = subprocess.run([verilator_binary, '--tohost-address', str(tohost_address), fname], stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
    if res.returncode != 0:
        print('Verilator failed to run, exiting: ')
        print(res.stderr)
        exit(1)

    if 'PASSED' not in res.stdout:
        print(res.stdout)

    return ('PASSED' in res.stdout)

def run_selected_tests(isa, envs, machine_mode_tests):
    pass_count = 0
    total_count = 0
    global tohost_address

    for env in envs:
        print(f"Running '{env}' TVM tests...")
        for ext in isa:
            print(f"ISA: RV32{ext.capitalize()}")
            # TODO: Add ELF parsing to TB so we can get 'tohost'
            # dynamically. This is a hack.
            if ext == 'c':
                tohost_address = 0x80003000
            else:
                tohost_address = 0x80001000

            tests = test_base_dir.glob(f"rv32u{ext}-{env}-*.bin")
            for test in filter(apply_skips, tests):
                total_count += 1
                status = run_test(test)
                if status:
                    pass_count += 1
                else:
                    print(f"{Colors.RED}[FAILED]: {Colors.END}{test}")

        # machine-mode tests
        if machine_mode_tests:
            tohost_address = 0x80001000
            print(f"Machine Mode tests")
            tests = test_base_dir.glob(f'rv32mi-{env}*.bin')
            for test in filter(apply_skips, tests):
                total_count += 1
                status = run_test(test)
                if status:
                    pass_count += 1
                else:
                    print(f"{Colors.RED}[FAILED]: {Colors.END}{test}")
        
    if pass_count == total_count:
        print(f"{Colors.GREEN}[All tests passed.]{Colors.END}")
    else:
        print(f"{Colors.YELLOW}[Passed {pass_count}/{total_count} tests.]{Colors.END}")


def main():
    parser = argparse.ArgumentParser(prog='RISC-V Tests', description='Runner for RISCVBusiness RISC-V Tests')
    parser.add_argument('--environment', choices=['p', 'pm', 'pt', 'v'], nargs='*', help='riscv-tests "TVM" option. Only \'p\' is supported at this time.', default=['p'])
    parser.add_argument('--isa', choices=supported_isa, nargs='*', help='RISC-V ISA extensions to test. Only user-level ISA supported at this time.', required=True)
    parser.add_argument('--machine', action='store_true', help='Enable M-mode tests. Not currently supported.')
    parser.add_argument('--supervisor', action='store_true', help='Enable S-mode tests. Not currently supported.')
    args = parser.parse_args()

    if 'v' in args.environment or 'pm' in args.environment or 'pt' in args.environment:
        print("Environments 'pt', 'pm' and 'v' are not yet supported.")
        exit(1)
    
    # if args.machine:
    #     print("M-mode tests are not currently supported.")
    #     exit(1)
    
    if args.supervisor:
        print("S-mode not currently supported on RISCVBusiness.")
        exit(1)
    
    run_selected_tests(args.isa, args.environment, args.machine)

if __name__ == "__main__":
    main()