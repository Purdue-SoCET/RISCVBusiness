#!/usr/bin/python3

#
#   Copyright 2024 Purdue University
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
#   Filename:     gen_ldst_test.py
#
#   Created by:   Om Gupta
#   Email:        guptao@purdue.edu
#   Date Created: 02/21/2024
#   Description:  Script for generating RV32V load/store unit tests

from argparse import ArgumentParser
from enum import Enum
from math import ceil

class IndexingMode(Enum):
    UNIT_STRIDE = "unit_stride"
    MASK_LDST = 'mask_ldst'
    WHOLE_REG = 'whole_reg'
    STRIDED = "strided"
    INDEXED = "indexed"

class VSEW(Enum):
    SEW_8 = "e8"
    SEW_16 = "e16"
    SEW_32 = "e32"
    SEW_64 = "e64"

class VLMUL(Enum):
    LMUL_1 = "m1"
    LMUL_2 = "m2"
    LMUL_4 = "m4"
    LMUL_8 = "m8"
    LMUL_HALF = "mf2"
    LMUL_FOURTH = "mf4"
    LMUL_EIGHTH = "mf8"

class VCSR:
    def __init__(self, vl: int, vsew: VSEW, vlmul: VLMUL):
        self.vl = vl
        self.vsew = vsew
        self.vlmul = vlmul

def _str_to_enum(enum_class, string):
    # Ugly but this is a one time thing so performance is not a problem
    for member in enum_class:
        if member.value == string:
            return member
    raise ValueError(f"Invalid argument {string} for {enum_class}")

def _vsew_to_bytes(vsew: VSEW) -> int:
    if vsew == VSEW.SEW_8:
        return 1
    elif vsew == VSEW.SEW_16:
        return 2
    elif vsew == VSEW.SEW_32:
        return 4
    elif vsew == VSEW.SEW_64:
        return 8
    else:
        raise ValueError("Invalid SEW")

def _vlmul_to_multiplier(vlmul: VLMUL):
    if vlmul == VLMUL.LMUL_1:
        return 1.
    if vlmul == VLMUL.LMUL_2:
        return 2.
    if vlmul == VLMUL.LMUL_4:
        return 4.
    if vlmul == VLMUL.LMUL_8:
        return 8.
    if vlmul == VLMUL.LMUL_HALF:
        return .5
    if vlmul == VLMUL.LMUL_FOURTH:
        return .25
    if vlmul == VLMUL.LMUL_EIGHTH:
        return .125

##############################################################################

VSETVLI_VL_REG = "x7"
VSETVLI_TGT_REG = "x8"

VLDST_TGT_REG = "v8"

INPUT_DATA_PTR_REG = "x1"
OUTPUT_DATA_PTR_REG = "x2"

INPUT_DATA_PTR_LABEL = "in_data"
OUTPUT_DATA_PTR_LABEL = "out_data"

STRIDE_REG = "x3"

INPUT_DATA_CMP_REG = "x11"
OUTPUT_DATA_CMP_REG = "x12"

OUTPUT_REGION_FILL_BYTE = 0x55

TEST_FAIL_LABEL = "fail"

TEST_DATA_WORDS = 64

NUM_NOPS = 3

VLEN = 128
VLEN_BYTES = VLEN//8

##############################################################################

def gen_test_preamble(test_name: str, test_desc: str) -> str:
    return f"""# See LICENSE for license details.

#*****************************************************************************
# {test_name}
#-----------------------------------------------------------------------------
#
# {test_desc}
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
"""

def gen_setup_code(vcsr: VCSR) -> str:
    return f"""# Setup tasks
    li {VSETVLI_VL_REG}, {vcsr.vl}
    vsetvli {VSETVLI_TGT_REG}, {VSETVLI_VL_REG}, {vcsr.vsew.value}, {vcsr.vlmul.value}

    la {INPUT_DATA_PTR_REG}, {INPUT_DATA_PTR_LABEL}
    la {OUTPUT_DATA_PTR_REG}, {OUTPUT_DATA_PTR_LABEL}
"""


def gen_unit_strided_ldst(enc_width: VSEW) -> str:
    nops = '    nop\n'*NUM_NOPS
    return f"""# Vector load/store instructions
    vl{enc_width.value}.v {VLDST_TGT_REG}, ({INPUT_DATA_PTR_REG})
{nops}
    vs{enc_width.value}.v {VLDST_TGT_REG}, ({OUTPUT_DATA_PTR_REG})
{nops}
"""


def gen_mask_ldst() -> str:
    nops = '    nop\n'*NUM_NOPS
    return f"""# Vector load/store instructions
    vlm.v {VLDST_TGT_REG}, ({INPUT_DATA_PTR_REG})
{nops}
    vsm.v {VLDST_TGT_REG}, ({OUTPUT_DATA_PTR_REG})
{nops}
"""


def gen_whole_reg_ldst(enc_width: VSEW, nfields: int) -> str:
    nops = '    nop\n'*NUM_NOPS
    return f"""# Vector load/store instructions
    vl{nfields}r{enc_width.value}.v {VLDST_TGT_REG}, ({INPUT_DATA_PTR_REG})
{nops}
    vs{nfields}r.v {VLDST_TGT_REG}, ({OUTPUT_DATA_PTR_REG})
{nops}
"""


def gen_strided_ldst(enc_width: VSEW, stride: int) -> str:
    nops = '    nop\n'*NUM_NOPS
    return f"""# Vector load/store instructions
    li {STRIDE_REG}, {stride}
{nops}
    vls{enc_width.value}.v {VLDST_TGT_REG}, ({INPUT_DATA_PTR_REG}), {STRIDE_REG}
{nops}
    vss{enc_width.value}.v {VLDST_TGT_REG}, ({OUTPUT_DATA_PTR_REG}), {STRIDE_REG}
{nops}
""" 


def gen_scalar_ld_and_check(lb_offset: int) -> str:
    return f"""# Check data at byte offset {lb_offset}
    lb {INPUT_DATA_CMP_REG}, {lb_offset}({INPUT_DATA_PTR_REG})
    lb {OUTPUT_DATA_CMP_REG}, {lb_offset}({OUTPUT_DATA_PTR_REG})
    li TESTNUM, {lb_offset}
    bne {INPUT_DATA_CMP_REG}, {OUTPUT_DATA_CMP_REG}, fail
"""


def gen_scalar_check_safe(lb_offset: int) -> str:
        return f"""# Check clean at byte offset {lb_offset}
    li {INPUT_DATA_CMP_REG}, 0x{OUTPUT_REGION_FILL_BYTE:02x}
    lb {OUTPUT_DATA_CMP_REG}, {lb_offset}({OUTPUT_DATA_PTR_REG})
    li TESTNUM, {lb_offset}
    bne {INPUT_DATA_CMP_REG}, {OUTPUT_DATA_CMP_REG}, fail
"""


def gen_strided_check(vl: int, data_width: int, stride: int, base_offset: int) -> str:
    code = ""

    total_offset = base_offset
    bytes_to_check = set()
    for elem_num in range(vl):
        for byte_num in range(data_width):
            bytes_to_check.add(total_offset + byte_num)
        total_offset += stride
    
    for offset in bytes_to_check:
        code += gen_scalar_ld_and_check(offset - base_offset)
    
    all_bytes = set(range(4*TEST_DATA_WORDS))
    unchecked_bytes = all_bytes.difference(bytes_to_check)

    for offset in unchecked_bytes:
        code += gen_scalar_check_safe(offset - base_offset)
    
    return code


def gen_test_code(
        vcsr: VCSR,
        enc_width: VSEW,
        indexing_mode: IndexingMode,
        base_offset: int,
        stride: int,
        nfields: int,
) -> str:
    code = "RVTEST_CODE_BEGIN\n"

    code += gen_setup_code(vcsr)

    if base_offset > 0:
        code += f"    addi {INPUT_DATA_PTR_REG}, {INPUT_DATA_PTR_REG}, {base_offset}\n"
        code += f"    addi {OUTPUT_DATA_PTR_REG}, {OUTPUT_DATA_PTR_REG}, {base_offset}\n"
    
    data_width = _vsew_to_bytes(enc_width)

    if indexing_mode == IndexingMode.UNIT_STRIDE:
        code += gen_unit_strided_ldst(enc_width)
        code += gen_strided_check(vcsr.vl, data_width, data_width, base_offset)
    elif indexing_mode == IndexingMode.MASK_LDST:
        code += gen_mask_ldst()
        code += gen_strided_check(ceil(vcsr.vl/8), 1, 1, base_offset)
    elif indexing_mode == IndexingMode.WHOLE_REG:
        code += gen_whole_reg_ldst(enc_width, nfields)
        code += gen_strided_check((nfields*VLEN_BYTES)//data_width, data_width, data_width, base_offset)
    elif indexing_mode == IndexingMode.STRIDED:
        code += gen_strided_ldst(enc_width, stride)
        code += gen_strided_check(vcsr.vl, data_width, stride, base_offset)
    else:
        raise NotImplementedError(f"{indexing_mode} indexing not implemented")

    return code + "\nTEST_PASSFAIL\nRVTEST_CODE_END\n"


def gen_test_data() -> str:
    code = "    .data\nRVTEST_DATA_BEGIN\nTEST_DATA\n"

    # Generate input data (each byte numbered by its position)
    code += f"\n    .align 8\n{INPUT_DATA_PTR_LABEL}:\n"
    for word_num in range(TEST_DATA_WORDS):
        word_data = 0
        for byte_offset in range(4):
            byte_num = word_num*4 + byte_offset
            word_data += byte_num << (byte_offset*8)
        code += f"    .word 0x{word_data:08x}\n"
    
    # Generate space for output data
    code += f"\n    .align 8\n{OUTPUT_DATA_PTR_LABEL}:\n"
    for word_num in range(TEST_DATA_WORDS):
        code += f"    .word 0x55555555\n"

    return code + "\nRVTEST_DATA_END\n"


def parse_args():
    parser = ArgumentParser(description='Process input parameters.')
    
    parser.add_argument('out_filename', type=str, help='Output filename')

    parser.add_argument('--enc_width', type=str, choices=['e8', 'e16', 'e32'], default='e32',
                        help='Encoded data width (one of "e8", "e16", or "e32")')
    parser.add_argument('--indexing_mode', type=str, choices=[mode.value for mode in IndexingMode],
                        default='unit_stride', help='Indexing mode (one of "unit_stride" or "strided")')
    parser.add_argument('--vl', type=int, default=16,
                        help='Vector length (integer)')
    parser.add_argument('--vsew', choices=['e8', 'e16', 'e32'], default='e32',
                        help='VSEW parameter')
    parser.add_argument('--vlmul', choices=['m1', 'm2', 'm4', 'm8', 'mf2', 'mf4', 'mf8'], default='m1',
                        help='VLMUL parameter')
    parser.add_argument('--base_offset', type=int, default=0,
                        help='Bytes to offset base data pointer by')
    parser.add_argument('--stride', type=int, default=4,
                        help='Byte stride for strided load/stores')
    parser.add_argument('--nfields', type=int, default=1,
                        help='Number of vector registers for whole reg load/stores')


    return parser.parse_args()

def main():
    args = parse_args()

    test_name = f"Test load/store {args.indexing_mode}, {args.enc_width}, vl{args.vl}"
    test_desc = "Generated using gen_ldst_test.py"

    enc_width = _str_to_enum(VSEW, args.enc_width)
    indexing_mode = _str_to_enum(IndexingMode, args.indexing_mode)

    vcsr = VCSR(
        int(args.vl),
        _str_to_enum(VSEW, args.vsew),
        _str_to_enum(VLMUL, args.vlmul),
    )

    with open(args.out_filename, 'w') as f:
        f.write(gen_test_preamble(test_name, test_desc))

        f.write(gen_test_code(
            vcsr,
            enc_width,
            indexing_mode,
            args.base_offset,
            args.stride,
            args.nfields,
        ))

        f.write(gen_test_data())
    
    print(f"Wrote output to {args.out_filename}")

if __name__ == '__main__':
    main()
