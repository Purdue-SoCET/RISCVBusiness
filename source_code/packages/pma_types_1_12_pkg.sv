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
*   Filename:     pma_types_1_12_pkg.sv
*
*   Created by:   Hadi Ahmed
*   Email:        ahmed138@purdue.edu
*   Date Created: 04/04/2022
*   Description:  Types needed to implement physical memory attributes
*/

`ifndef PMA_TYPES_1_12_PKG_SV
`define PMA_TYPES_1_12_PKG_SV

package pma_types_1_12_pkg;

  /* PMA CSR Addresses */
  typedef enum logic [11:0] {

  } pma_addr_t;

  /* pmacfg types */

  typedef enum logic [1:0] {
    AMONone = 2'b00,
    AMOSwap = 2'b01,
    AMOLogical = 2'b10,
    AMOArithmetic = 2'b11
  } pma_amo_t;

  typedef enum logic [1:0] {
    RsrvNone = 2'b00,
    RsrvNonEventual = 2'b01,
    RsrvEventual = 2'b10,
    Reserved = 2'b11
  } pma_rsrv_t;

  typedef enum logic [2:0] {
    ByteAcc = 3'b000,
    HWLower = 3'b001,
    HWUpper = 3'b010,
    WordAcc = 3'b011,
    2WBurst = 3'b100,
    4WBurst = 3'b101,
    8WBurst = 3'b110,
    Reserved = 3'b111
  } pma_accwidth_t;

  typedef struct packed {
    logic [1:0]    reserved;
    logic          W;        // Writes supported
    logic          R;        // Reads supported
    logic          X;        // Execute supported
    pma_accwidth_t AccWidth; // Max supported access width
    logic          Idm;      // Idempotency
    logic          Cache;    // Able to cache
    logic          Coh;      // Coherency
    pma_rsrv_t     Rsrv;     // Reservability
    pma_amo_t      AMO;      // AMO operations
    logic          MIO;      // Memory or I/O
  } pma_cfg_t;

  typedef struct packed {
    pma_cfg_t pma_cfg_1;
    pma_cfg_1 pma_cfg0;
  } pma_reg_t;

endpackage

`endif //PMA_TYPES_1_12_PKG_SV
