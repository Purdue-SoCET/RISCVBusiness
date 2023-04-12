/*
*		Copyright 2016 Purdue University
*		
*		Licensed under the Apache License, Version 2.0 (the "License");
*		you may not use this file except in compliance with the License.
*		You may obtain a copy of the License at
*		
*		    http://www.apache.org/licenses/LICENSE-2.0
*		
*		Unless required by applicable law or agreed to in writing, software
*		distributed under the License is distributed on an "AS IS" BASIS,
*		WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*		See the License for the specific language governing permissions and
*		limitations under the License.
*
*
*		Filename:     coherence_ctrl_if.vh
*
*		Created by:   Jiahao Xu
*		Email:        xu1392@purdue.edu
*		Date Created: 02/01/2022
*		Description:  interface of cohenrece bus connections with L1/L2 Caches.	
*/

`ifndef COHERENCE_CTRL_IF_VH
`define COHERENCE_CTRL_IF_VH
//`include "rv32i_types_pkg.sv" // testbench purpose. 

typedef enum logic[4:0] {  
    IDLE, EIDLE, WB, INV, 
    SNP1, SNP2, 
    LOAD1, LOAD2,  
    LOADEX1, LOADEX2, LOADEX3,  
    FWDWB1, FWDWB2, FWDWB3,
    FWDEX1, FWDEX2, FWDEX3, 
    WB1, WB2
} cc_state_t;

typedef enum logic[1:0] {
    L2_FREE, L2_BUSY, L2_ACCESS, L2_ERROR
} l2_state_t;

typedef logic [31:0] word_t;

parameter CPUS = 2;  // current only 2 supported. 

interface coherence_ctrl_if;

    logic   [CPUS-1 : 0] dREN, dWEN, dwait; 
    word_t  [CPUS-1 : 0] daddr, dload, dstore; 

    // coherence control input from L1 Cache side. 
    logic   [CPUS-1 : 0] cctrans, ccwrite, ccdirty, cchit;  
    // cohrence control output to L1 Cache side. 
    logic   [CPUS-1 : 0] ccwait, ccinv, ccexclusive; 
    word_t  [CPUS-1 : 0] ccsnpaddr; 

    // input from L2 Cache side. 
    // TODO: handshake protocols of load/store with L2 Cache? 
    l2_state_t l2state; 
    word_t l2load; 
    // output to L2 Cache side. 
    logic l2WEN, l2REN; 
    word_t l2addr, l2store; 

    modport cc(
        input   dREN, dWEN, daddr, dstore, 
                cctrans, ccwrite, ccdirty, cchit, 
                l2load, l2state, 
        output  dwait, dload, 
                ccwait, ccinv, ccsnpaddr, ccexclusive, 
                l2addr, l2store, l2REN, l2WEN

    ); 

    modport tb(
        output  dREN, dWEN, daddr, dstore, 
                cctrans, ccwrite, ccdirty, cchit,
                l2load, l2state, 
        input   dwait, dload, 
                ccwait, ccinv, ccsnpaddr, ccexclusive, 
                l2addr, l2store, l2REN, l2WEN

    ); 

endinterface
`endif // COHERENCE_CTRL_IF_VH