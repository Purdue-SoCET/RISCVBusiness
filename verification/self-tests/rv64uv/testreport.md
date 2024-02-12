# RVV Test Report
## Information
- Version: rvv1.0
- Test Scope:
    - CH7. Vector Loads and Stores
    - CH11. Vector Integer Arithmetic Instructions
    - CH12. Vector Fixed-Point Arithmetic Instructions
    - CH13. Vector Floating-Point Instructions
    - CH14. Vector Reduction Operations
    - CH15. Vector Mask Instructions
    - CH16. Vector Permutation Instructions
- Reference Model: Spike 1.0.1-dev
- Configuration:
    - VLEN: 128
    - VSEW: 32
    - VMUL: 1
    - VLMAX: 1 (When the number of test elements is greater than 1 (load, store, mask operation, etc.), VLMAX is set to (128/32)*1=4)

## Test Method
### In Test File
Each `.S` file contains several test cases. Each test case needs three values: operand 1, operand 2, and the result. Example in  `vadd.S` :
```
TEST_VV_OP( 3,  vadd.vv, 0x00000002, 0x00000001, 0x00000001 );
TEST_VV_OP( 4,  vadd.vv, 0x0000000a, 0x00000003, 0x00000007 );
```
### Base Test Case
In `TEST_VV_OP` :  
1. Use `vmv.v.x` instruction to load the two operands into the 0th. element of two vreg(v1, v2) respectively.  
2. Execute the instruction and use v14 as the destination vreg.  
```
#define TEST_VV_OP( testnum, inst, result, val1, val2 ) \
  TEST_CASE( testnum, v14, result, \
    li x7, MASK_VSEW(val1); \
    vmv.v.x v1, x7; \
    li x7, MASK_VSEW(val2); \
    vmv.v.x v2, x7; \
    inst v14, v1, v2; \
  )
```

In `TEST_CASE` :  
1. After excuting, use `vmv.x.s` instruction to take out the 0th. element of v14, transfer it to x14.
2. Mask the value in x14, i.e. the low-VSEW bits are retained and the high VLEN-VSEW bits are set to 0. (We only compare low-VSEW bits of Execution results and correctval.)
3. Compare it with the result. Branch to `fail` if not equal.

```
#define TEST_CASE( testnum, testreg, correctval, code... ) \
test_ ## testnum: \
    code; \
    li x7, MASK_VSEW(correctval); \
    li TESTNUM, testnum; \
    vmv.x.s x14, v14; \
    li x2, VSEW_MASK_BITS; \
    and x14, x14, x2; \
    bne x14, x7, fail;
```

## Test Case Table

### Chap7: Load and Store

|       |       |   |   |   |   |   |   |
| ----- | ----- | - | - | - | - | - | - |
| vlse | vsse | vle  | vse  | vlxei  | vsxei  | vlseg   | vsseg  |
|vlsseg|vssseg|vlxseg|vsxseg| vlre     |       |          |        | 

- Note1: Unfinish: 7.4(vlm.v vsm.v), 7.9(vsre (illegal_inst.))
- Note2: 'Seg' load& store can't pass when EEW=64

### Chap11: Integer Arithmetic

|                               |            |           |            |          |        |         |          |
| ----------------------------- | ---------- | --------- | ---------- | -------- | ------ | ------- | -------- |
| <font color="green"> vadd | <font color="green"> vsub | <font color="green"> vrsub     | <font color="green"> vmul       | <font color="green"> vwmul    | <font color="green"> vdiv   | <font color="green"> vrem    | <font color="green"> vremu    |
| <font color="green"> vmacc                         | <font color="green"> vmadd      | <font color="green"> vnmsac    | <font color="green"> vnmsub     | vwmaccu  | vwmacc | vwmaccu | vwmaccus |
| <font color="green"> vmseq                         | <font color="green"> vmsgt      | <font color="green"> vmsle     | <font color="green"> vmsleu     | <font color="green"> vmslt    | <font color="green"> vmsltu | <font color="green"> vmsne   | <font color="green"> vmax     |
| <font color="green"> vmaxu                         | <font color="green"> vmin       | <font color="green"> vminu     | <font color="green"> vand       | <font color="green"> vor      | <font color="green"> vxor   | <font color="green"> vsll    | <font color="green"> vext     |
| <font color="green"> vmsgtu                        | vmulh_32   | vmulhu_32 | vmulhsu_32 | vdivu_32 |  vwadd*      |  vadc    |   vmadc_32     |

- Note1: Currently VSEW=32, if need to test VSEW=64, you should change Makefrag to compile `vmulh_64.S` (vmulh, vmulhsu, vdivu are the same)
- Note2: Unfinish: 11.2(wv inllegal), 11.7(narrow illegal)
- Note3: `vwadd` ONLY support vfwadd.vv/vf, wv/wf not support yet.


### Chap12: Vector Fixed-Point Arithmetic Instructions

|       |       |   |   |   |   |   |   |
| ----- | ----- | - | - | - | - | - | - |
| vsadd_32 | vsaddu_32 | vssub_32  | vssubu_32  | vaadd_32  | vaaddu_32  | vasub_32   | vasubu_32  |
| vsmul_32 | vssra     | vssrl_32  |   |   |   |   |   |
- Note1: Unfinish: 12.5(vnclipu (illegal_inst.))

### Chap13: Floating-Point
**`Floating-point tests *ONLY* support *VSEW=32* so far.`**
|         |          |          |        |         |         |         |   |
| -----   | -        | -        | -      | -       | -       | -       | - |
| vfadd   |  vfsub   | vfmul    | <font color="green"> vfdiv | vfwadd* | vfwmul | vfwsub* | vfmax  |
| vfmacc  | vfnmacc  | vfmsac   | vfnmsac| vfmadd  | vfnmadd | vfmsub  | vfmin  |
| vfnmsub | vfwmacc  | vfwmsac  |vfwnmacc|vfwnmsac | vfsqrt  | vfsgnj  | vmfeq  |
| vmflt   | vmfgt    | vfclass  | vfmerge| vfcvt   | vfwcvt   | vfrec     |        |
- Note1: `vfw*` (13.3/5) *ONLY* support `vfw*.vv/vf`, `wv/wf` not support yet.
- Note2: Unfinish 13.3(wv inllegal), 13.16, 13.19(vfncvt illegal)

### Chap14: Vector Reduction Operations

|         |          |          |         |         |   |   |   |
| ------- | -------- | -------- | ------- | ------- | - | - | - |
| vredand | vredmaxu | vredminu | vredsum | vredxor | vredmax | vredmin | vredor |
| vfredmax | vfredmin | vfredosum | vfredusum |         |   |   |   |

### Chap15: Vector Mask Instructions

|       |       |   |   |   |   |   |   |
| ----- | ----- | - | - | - | - | - | - |
| vmrl | vsfmb | viota| vpopc |   |   |   |   |
|      |       |      |   |   |   |   |   |
- Note1: Unfinish: 15.9(vid (illegal_inst.))

### Chap16: Vector Permutation Instructions

|       |       |   |   |   |   |   |   |
| ----- | ----- | - | - | - | - | - | - |
| vrgather | vcompress | viota| vpopc | vslide | vmvre|vmv|   |
|          |           |      |       |        |      |   |   |