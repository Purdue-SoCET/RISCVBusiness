/*
*	Copyright 2022 Purdue University
*		
*	Licensed under the Apache License, Version 2.0 (the "License");
*	you may not use this file except in compliance with the License.
*	You may obtain a copy of the License at
*		
*	    http://www.apache.org/licenses/LICENSE-2.0
*		
*	Unless required by applicable law or agreed to in writing, software
*	distributed under the License is distributed on an "AS IS" BASIS,
*	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*	See the License for the specific language governing permissions and
*	limitations under the License.
*
*
*	Filename:     coherence_ctrl.sv
*
*	Created by:   Jiahao Xu
*	Email:        xu1392@purdue.edu
*	Date Created: 02/01/2022
*	Description:  A coherennce controler implentation based on MESI Protocol.
*/

//`include "generic_bus_if.vh"
`include "coherence_ctrl_if.vh"
//`include "rv32i_types_pkg.sv"

module coherence_ctrl #( 
    parameter BLOCK_SIZE = 2    // set how many words are there in a block. 
)(  
    input logic CLK, nRST, 
    coherence_ctrl_if.cc ccif
    // TODO add generic bus to do the testbench. 
);  
    localparam COUNTER_LENGTH = $clog2(BLOCK_SIZE);
    logic [COUNTER_LENGTH : 0] word_counter, next_word_counter; 
    cc_state_t s, ns; 
    logic prid, nprid;  // need change its width if more than dual core. 
    
    assign ccif.ccsnpaddr[0] = ccif.daddr[1]; 
    assign ccif.ccsnpaddr[1] = ccif.daddr[0]; 

    always_ff @(posedge CLK, negedge nRST) begin 
        if (~nRST) begin
            prid <= 0; 
            s <= IDLE; 
            word_counter <= '0; 
        end
        else begin
            prid <= nprid; 
            s <= ns; 
            word_counter <= next_word_counter; 
        end
    end

    always_comb begin
        nprid = prid; 
        ns = s; 
        next_word_counter = word_counter; 
        ccif.dwait = '1; 
        ccif.dload = '0; 
        ccif.ccwait = '0; 
        ccif.ccinv = '0; 
        ccif.l2addr = '0; 
        ccif.l2store = '0; 
        ccif.l2REN = '0; 
        ccif.l2WEN = '0; 
        ccif.ccexclusive = '0; 
        casez (s)
            IDLE, EIDLE: begin
                nprid = ccif.cctrans[~prid] ? ~prid : prid;
                if (ccif.cctrans[nprid]) begin
                    if (ccif.dWEN[nprid]) ns = WB1; 
                    else if (ccif.dREN[nprid]) ns = SNP1; 
                    else ns = INV; 
                end                    
                end
                else ns = IDLE; 
            end
            SNP1: begin
                ccif.ccwait[~prid] = 1'b1; 
                // wait as many cycles as the L1 Cache makes a response.
                // could be more cycles when intergrating. 
                ns = SNP2;  
            end
            SNP2: begin
                ccif.ccwait[~prid] = 1'b1; 
                if (ccif.cctrans[prid] && ccif.ccwrite[prid]) begin
                    // this is a write.
                    ns = ccif.cchit[~prid] && ccif.ccdirty[~prid] ? FWDEX1 : LOADEX1; 
                end
                else if (ccif.cctrans[prid] && ~ccif.ccwrite[prid]) begin
                    // just a read. 
                    ns = ccif.cchit[~prid] && ccif.ccdirty[~prid] ? FWDWB1 : LOAD1; 
                end
                else ns = EIDLE; // should not happen. 
            end
            /***************************************************************************
            * LOAD: load the word from L2 to L1 and set the shared bit (E/S)           *
            ****************************************************************************/
            LOAD1: begin // load  word from L2 Cache. 
                ccif.l2REN = 1'b1; 
                ccif.l2addr = ccif.daddr[prid]; 
                ccif.dload[prid] = ccif.l2load; 
                ccif.dwait[prid] = ~(ccif.l2state == L2_ACCESS); 
                ccif.ccexclusive[prid] = ~ccif.cchit[~prid]; 
                ns = (ccif.l2state == L2_ACCESS) ? LOAD2 : LOAD1; 
            end
            LOAD2: begin // increase the word counter. determine if meets the block size.
                ccif.ccexclusive[prid] = ~ccif.cchit[~prid]; 
                ns = ($unsigned(word_counter + 1) < $unsigned(BLOCK_SIZE)) ? LOAD1 : IDLE; 
                next_word_counter = (ns == LOAD1) ? word_counter+1 : 0; 
            end
            /***************************************************************************
            * FWDWB: cache-to-cache transfer, update the L2 copy, happens only when    *
            *        there is M->S (general bus read from other core).                 *
            ****************************************************************************/
            FWDWB1: begin // supply the word to cache. 
                ccif.dload[prid] = ccif.dstore[~prid]; 
                ccif.dwait[prid] = 1'b0; 
                ns = FWDWB2; 
            end
            FWDWB2: begin // write the word to L2. 
                ccif.l2store = ccif.dstore[~prid]; 
                ccif.l2addr = ccif.daddr[~prid]; 
                ccif.l2WEN = 1'b1; 
                ccif.dwait[~prid] = ~(ccif.l2state == L2_ACCESS); 
                ns = (ccif.l2state == L2_ACCESS) ? FWDWB3 : FWDWB2;   
            end
            FWDWB3: begin // increase the word counter. determine if meets the block size.
                ns = ($unsigned(word_counter + 1) < $unsigned(BLOCK_SIZE)) ? FWDWB1 : IDLE; 
                next_word_counter = (ns == FWDWB1) ? word_counter+1 : 0; 
            end
            /***************************************************************************
            * FWDEX: cache-to-cache transfer, not update the L2 copy, invalidate other 
            *        copies. happens when I->M, M->I
            ****************************************************************************/
            FWDEX1: begin   // supply the word from cache to cache. 
                ccif.ccwait[~prid] = 1'b1; 
                ccif.dload[prid] = ccif.dstore[~prid]; 
                ccif.dwait[prid] = 1'b0; 
                ns = FWDEX2; 
            end
            FWDEX2: begin   // increase the word counter. determine if meets the block size.
                ccif.ccwait[~prid] = 1'b1; 
                ns = ($unsigned(word_counter + 1) < $unsigned(BLOCK_SIZE)) ? FWDEX1 : FWDEX3; 
                next_word_counter = (ns == FWDEX1) ? word_counter+1 : 0; 
            end
            FWDEX3: begin   // invalidate the other copy.
                ccif.ccwait[~prid] = 1'b1; 
                ccif.ccinv[~prid] = 1'b1; 
                ns = IDLE; 
            end
            /***************************************************************************
            * LOADEX: this core has a write request. load from L2, invalidate other copies.
            ****************************************************************************/
            LOADEX1: begin  // load word from L2. 
                ccif.l2REN = 1'b1; 
                ccif.l2addr = ccif.daddr[prid]; 
                ccif.dload[prid] = ccif.l2load; 
                ccif.dwait[prid] = ~(ccif.l2state == L2_ACCESS); 
                ccif.ccexclusive[prid] = 1'b1; 
                ccif.ccwait[~prid] = 1'b1; 
                ns = (ccif.l2state == L2_ACCESS) ? LOADEX2 : LOADEX1; 
            end
            LOADEX2: begin  // increment word counter, determine if it meets the block size.
                ccif.ccexclusive[prid] = 1'b1; 
                ccif.ccwait[~prid] = 1'b1; 
                ns = ($unsigned(word_counter + 1) < $unsigned(BLOCK_SIZE)) ? LOADEX1 : LOADEX3; 
                next_word_counter = (ns == LOADEX1) ? word_counter+1 : 0; 
            end
            LOADEX3: begin  // invalidate other copies.
                ccif.ccinv[~prid] = 1'b1; 
                ccif.ccwait[~prid] = 1'b1; 
                ns = IDLE; 
            end
            WB1: begin
                ccif.l2store = ccif.dstore[prid]; 
                ccif.l2addr = ccif.daddr[prid]; 
                ccif.l2WEN = 1'b1; 
                ccif.dwait[prid] = ~(ccif.l2state == L2_ACCESS); 
                ns = (ccif.l2state == L2_ACCESS) ? WB2 : WB1;   
            end
            WB2: begin
                ns = ($unsigned(word_counter + 1) < $unsigned(BLOCK_SIZE)) ? WB1 : IDLE; 
                next_word_counter = (ns == WB1) ? word_counter+1 : 0; 
            end
            INV: begin
                ccif.ccinv[~prid] = 1'b1; 
                ccif.ccwait= '1; 
                ns = IDLE; 
            end
        endcase
    end
endmodule