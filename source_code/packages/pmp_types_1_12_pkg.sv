/*
*   Copyright 2016 Purdue University
*
*   Licensed under the Apache License, Version 2.0 (the "License");
*   you may not use this file except in compliance with the License.
*   You may obtain a copy of the License at
*
*       http://www.apache.org/licenses/LICENSE-2.0
*
*   Unless required by applicable law or agreed to in writing, software
*   distributed under the License is distributed on an "AS IS" BASIS,
*   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*   See the License for the specific language governing permissions and
*   limitations under the License.
*
*
*   Filename:     pmp_types_1_12_pkg.sv
*
*   Created by:   Hadi Ahmed
*   Email:        ahmed138@purdue.edu
*   Date Created: 03/20/2022
*   Description:  Types needed to implement physical memory protection
*/

`ifndef PMP_TYPES_1_12_PKG_SV
`define PMP_TYPES_1_12_PKG_SV

package pmp_types_1_12_pkg;

  /* PMP CSR Addresses */
  typedef enum logic [11:0] {
    /* Machine Memory Protection */
    PMPCFG0_ADDR   = 12'h3A0,
    PMPCFG1_ADDR   = 12'h3A1,
    PMPCFG2_ADDR   = 12'h3A2,
    PMPCFG3_ADDR   = 12'h3A3,
    PMPCFG4_ADDR   = 12'h3A4,
    PMPCFG5_ADDR   = 12'h3A5,
    PMPCFG6_ADDR   = 12'h3A6,
    PMPCFG7_ADDR   = 12'h3A7,
    PMPCFG8_ADDR   = 12'h3A8,
    PMPCFG9_ADDR   = 12'h3A9,
    PMPCFG10_ADDR  = 12'h3AA,
    PMPCFG11_ADDR  = 12'h3AB,
    PMPCFG12_ADDR  = 12'h3AC,
    PMPCFG13_ADDR  = 12'h3AD,
    PMPCFG14_ADDR  = 12'h3AE,
    PMPCFG15_ADDR  = 12'h3AF,
    PMPADDR0_ADDR  = 12'h3B0,
    PMPADDR1_ADDR  = 12'h3B1,
    PMPADDR2_ADDR  = 12'h3B2,
    PMPADDR3_ADDR  = 12'h3B3,
    PMPADDR4_ADDR  = 12'h3B4,
    PMPADDR5_ADDR  = 12'h3B5,
    PMPADDR6_ADDR  = 12'h3B6,
    PMPADDR7_ADDR  = 12'h3B7,
    PMPADDR8_ADDR  = 12'h3B8,
    PMPADDR9_ADDR  = 12'h3B9,
    PMPADDR10_ADDR = 12'h3BA,
    PMPADDR11_ADDR = 12'h3BB,
    PMPADDR12_ADDR = 12'h3BC,
    PMPADDR13_ADDR = 12'h3BD,
    PMPADDR14_ADDR = 12'h3BE,
    PMPADDR15_ADDR = 12'h3BF,
    PMPADDR16_ADDR = 12'h3C0,
    PMPADDR17_ADDR = 12'h3C1,
    PMPADDR18_ADDR = 12'h3C2,
    PMPADDR19_ADDR = 12'h3C3,
    PMPADDR20_ADDR = 12'h3C4,
    PMPADDR21_ADDR = 12'h3C5,
    PMPADDR22_ADDR = 12'h3C6,
    PMPADDR23_ADDR = 12'h3C7,
    PMPADDR24_ADDR = 12'h3C8,
    PMPADDR25_ADDR = 12'h3C9,
    PMPADDR26_ADDR = 12'h3CA,
    PMPADDR27_ADDR = 12'h3CB,
    PMPADDR28_ADDR = 12'h3CC,
    PMPADDR29_ADDR = 12'h3CD,
    PMPADDR30_ADDR = 12'h3CE
    PMPADDR31_ADDR = 12'h3CF,
    PMPADDR32_ADDR = 12'h3D0,
    PMPADDR33_ADDR = 12'h3D1,
    PMPADDR34_ADDR = 12'h3D2,
    PMPADDR35_ADDR = 12'h3D3,
    PMPADDR36_ADDR = 12'h3D4,
    PMPADDR37_ADDR = 12'h3D5,
    PMPADDR38_ADDR = 12'h3D6,
    PMPADDR39_ADDR = 12'h3D7,
    PMPADDR40_ADDR = 12'h3D8,
    PMPADDR41_ADDR = 12'h3D9,
    PMPADDR42_ADDR = 12'h3DA,
    PMPADDR43_ADDR = 12'h3DB,
    PMPADDR44_ADDR = 12'h3DC,
    PMPADDR45_ADDR = 12'h3DD,
    PMPADDR46_ADDR = 12'h3DE,
    PMPADDR47_ADDR = 12'h3DF,
    PMPADDR48_ADDR = 12'h3E0,
    PMPADDR49_ADDR = 12'h3E1,
    PMPADDR50_ADDR = 12'h3E2,
    PMPADDR51_ADDR = 12'h3E3,
    PMPADDR52_ADDR = 12'h3E4,
    PMPADDR53_ADDR = 12'h3E5,
    PMPADDR54_ADDR = 12'h3E6,
    PMPADDR55_ADDR = 12'h3E7,
    PMPADDR56_ADDR = 12'h3E8,
    PMPADDR57_ADDR = 12'h3E9,
    PMPADDR58_ADDR = 12'h3EA,
    PMPADDR59_ADDR = 12'h3EB,
    PMPADDR60_ADDR = 12'h3EC,
    PMPADDR61_ADDR = 12'h3ED,
    PMPADDR62_ADDR = 12'h3EE,
    PMPADDR63_ADDR = 12'h3EF
  } pmp_addr_t;

  /* pmpcfg types */

  typedef enum logic [1:0] {
    OFF   = 2'b00,
    TOR   = 2'b01,
    NA4   = 2'b10,
    NAPOT = 2'b11
  } pmp_mode_t;

 typedef struct packed {
   logic       L;
   logic [1:0] reserved;
   pmp_mode_t  A;
   logic       X;
   logic       W;
   logic       R;
 } pmpcfg_base_t;

typedef struct packed {
  pmpcfg_base_t cfg3;
  pmpcfg_base_t cfg2;
  pmpcfg_base_t cfg1;
  pmpcfg_base_t cfg0;
} pmpcfg_t;

typedef logic [31:0] pmpaddr_t;

endpackage;

`endif //PMP_TYPES_1_12_PKG_SV
