#! /usr/bin/python3

import subprocess
import glob
import os
import pathlib


compile_cmd = ['riscv64-unknown-elf-gcc', '-march=rv32i', '-mabi=ilp32', '-mcmodel=medany',
                '-static', '-nostdlib', '-O2', '-Tlink.ld', 'start.S', 'utility.c']

cvt_cmd = ['riscv64-unknown-elf-objcopy', '-O', 'binary']


if not os.path.isfile('./start.S') or not os.path.isfile('link.ld'):
    print('Error: Could not find AFTx06.S or link.ld in this directory')
    exit(1)


for fname in (glob.glob('./*.c') + glob.glob('./*.S')):
    if 'start' in fname or 'utility' in fname:
        print("Skipping {} as top-level file, appears to be a utility".format(fname));
        continue
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
