#! /usr/bin/python3

import subprocess
import glob
import os
import pathlib

utility_files = ["multicore_start.S", "utility.c", "amo_emu.c", "mutex.c", "fast_amo_emu.c"]

compile_cmd = ['riscv64-unknown-elf-gcc', '-march=rv32imac_zicsr', '-mabi=ilp32', '-mcmodel=medany',
                '-static', '-O2', '-Tlink.ld', '-std=c11', '-nostartfiles'] + utility_files

cvt_cmd = ['riscv64-unknown-elf-objcopy', '-O', 'binary']

for utility_file in utility_files:
    if not os.path.isfile(utility_file):
        print(f'Error: Could not find {utility_file} in this directory')
        exit(1)
if not os.path.isfile("link.ld"):
    print(f'Error: Could not find link.ld in this directory')
    exit(1)

for fname in (glob.glob('./*.c') + glob.glob('./*.S')):
    for utility_file in utility_files:
        print(f"{utility_file} {fname}")
        if utility_file in fname:
            print("Skipping {} as top-level file, appears to be a utility".format(fname));
            break
    else:
        print('Compiling {}'.format(fname))
        basename = pathlib.Path(fname).stem

        rv = subprocess.run(compile_cmd + [fname, '-o', basename + '.elf'], stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
        if rv.returncode != 0:
            print('Exited with error {}, printing command, stdout, stderr!'.format(rv.returncode))
            print('Command: {}\n\n'.format(compile_cmd + [fname, '-o', basename + '.elf']))
            print('stdout:\n\n{}'.format(rv.stdout))
            print('stderr:\n\n{}'.format(rv.stderr))
            print('Exiting...')
            exit(1)

        print('Converting {} to binary'.format(fname))
        rv = subprocess.run(cvt_cmd + [basename + '.elf', basename + '.bin'])
        if rv.returncode != 0:
            print('Exited with error {}, printing command, stdout, stderr!'.format(rv.returncode))
            print('Command: {}\n\n'.format(compile_cmd + [fname, '-o', basename + '.elf']))
            print('stdout:\n\n{}'.format(rv.stdout))
            print('stderr:\n\n{}'.format(rv.stderr))
            print('Exiting...')
            exit(1)

print(
'''
   Finished compilation. Now, pass the '.bin' file corresponding to
   the example to run as an argument to 'VbASIC_wrapper' to run an example!
''')
