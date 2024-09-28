#! /usr/bin/python3

import subprocess
import glob
import os
import pathlib

utility_files = ["start.S", "utility.c", "amo_emu.c", "mutex.c", "fast_amo_emu.c"]

cvt_cmd = ['riscv64-unknown-elf-objcopy', '-O', 'binary']

dump_cmd = ['riscv64-unknown-elf-objdump', '-d']

vector_files = ["./matmul_vector.c"]

for utility_file in utility_files:
    if not os.path.isfile(utility_file):
        print(f'Error: Could not find {utility_file} in this directory')
        exit(1)
if not os.path.isfile("link.ld"):
    print(f'Error: Could not find link.ld in this directory')
    exit(1)

def generate_compile_cmd(vector: bool) -> [str]:
    compiler = "clang" if vector else "riscv64-unknown-elf-gcc"
    # correct march for clang 16.0 which hadn't moved icsr out of i spec yet. Add back in if necessary
    march = ["--target=riscv64", "-march=rv32imac_zve32x"] if vector else ["-march=rv32imac_zicsr"]
    mabi = "" if vector else "-mabi=ilp32"
    clang_flags = ["-nostdlib"] if vector else []
    rest_flags = ["-mcmodel=medany", "-static", "-O2", "-Tlink.ld", "-std=c11", "-nostartfiles"]
    return [compiler,  mabi] + march + clang_flags + rest_flags + utility_files

for fname in (glob.glob('./*.c') + glob.glob('./*.S')):
    for utility_file in utility_files:
        if utility_file in fname:
            print("Skipping {} as top-level file, appears to be a utility".format(fname));
            break
    else:
        print('Compiling {}'.format(fname))
        basename = pathlib.Path(fname).stem

        # GCC 13.2 seems to not autovectorize very well, clang seems much better (at least 16.0+)
        if fname in vector_files:
            compile_cmd = generate_compile_cmd(True)
        else:
            compile_cmd = generate_compile_cmd(False)

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

        # Check that we actually got vector instructions
        if fname in vector_files:
            print('Checking that {} contains vector instructions'.format(fname))
            rv = subprocess.run(dump_cmd + [basename + '.elf'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            if rv.returncode != 0:
                print('Exited with error {}, printing command, stdout, stderr!'.format(rv.returncode))
                print('Command: {}\n\n'.format(dump_cmd + [basename + '.elf']))
                print('stdout:\n\n{}'.format(rv.stdout))
                print('stderr:\n\n{}'.format(rv.stderr))
                print('Exiting...')
                exit(1)
            elif not rv.stdout.decode("utf-8").find("vset"):
                print('Vector file {} did not successfully vectorize!'.format(fname))
                print('Exiting...')
                exit(1)
            else:
                print('Vector instructions found in file {}'.format(fname))

print(
'''
   Finished compilation. Now, pass the '.bin' file corresponding to
   the example to run as an argument to 'VbASIC_wrapper' to run an example!
''')
