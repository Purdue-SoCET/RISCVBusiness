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
*   Filename:     stage5_fetch_decode_if.vh
*   
*   Created by:   William Cunningham	
*   Email:        wrcunnin@purdue.edu
*   Date Created: 01/26/2026
*   Description:  Interface between the fetch and decode pipeline stages
*/

`ifndef STAGE5_FETCH_DECODE_IF_VH
`define STAGE5_FETCH_DECODE_IF_VH

interface stage5_fetch_decode_if;
  import rv32i_types_pkg::*;
  import stage5_types_pkg::*;

  fetch_decode_t fetch_decode_reg;

  modport fetch(
    output fetch_decode_reg
  );

  modport decode(
    input fetch_decode_reg
  );

endinterface
`endif
