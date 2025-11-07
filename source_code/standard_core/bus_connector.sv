/*
*	Copyright 2025 Purdue University
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
*	Filename:     bus_connector.sv
*
*	Created by:   Cole Nelson 
*	Email:        nelso345@purdue.edu
*	Date Created: 11/07/2025
*	Description:  Connects front side bus interfaces to back side bus interface.
*	              Refactored from logic inside back_side_bus_if interface.
*/

`include "bus_ctrl_if.vh"

module bus_connector #(
    parameter int CPUS = 4
)(
    front_side_bus_if.bsb front_side [CPUS-1:0],
    back_side_bus_if.fsb back_side
);

    genvar i;
    generate
        for (i = 0; i < CPUS; i++) begin : GEN_BUS_MAP
            // Map front side outputs to back side inputs (cache -> bus controller)
            assign back_side.dREN[i]        = front_side[i].dREN;
            assign back_side.dWEN[i]        = front_side[i].dWEN;
            assign back_side.daddr[i]       = front_side[i].daddr;
            assign back_side.dstore[i]      = front_side[i].dstore;
            assign back_side.dbyte_en[i]    = front_side[i].dbyte_en;
            assign back_side.ccwrite[i]     = front_side[i].ccwrite;
            assign back_side.ccsnoophit[i]  = front_side[i].ccsnoophit;
            assign back_side.ccdirty[i]     = front_side[i].ccdirty;
            assign back_side.ccsnoopdone[i] = front_side[i].ccsnoopdone;

            // Map back side outputs to front side inputs (bus controller -> cache)
            assign front_side[i].dwait       = back_side.dwait[i];
            assign front_side[i].dload       = back_side.dload[i];
            assign front_side[i].derror      = back_side.derror[i];
            assign front_side[i].ccwait      = back_side.ccwait[i];
            assign front_side[i].ccinv       = back_side.ccinv[i];
            assign front_side[i].ccsnoopaddr = back_side.ccsnoopaddr[i];
            assign front_side[i].ccexclusive = back_side.ccexclusive[i];
        end
    endgenerate

endmodule
