// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop_core.h for the primary calling header

#include "verilated.h"
#include "verilated_dpi.h"

#include "Vtop_core__Syms.h"
#include "Vtop_core_stage3_hazard_unit_if.h"

void Vtop_core_stage3_hazard_unit_if___ctor_var_reset(Vtop_core_stage3_hazard_unit_if* vlSelf);

Vtop_core_stage3_hazard_unit_if::Vtop_core_stage3_hazard_unit_if(Vtop_core__Syms* symsp, const char* name)
    : VerilatedModule{name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vtop_core_stage3_hazard_unit_if___ctor_var_reset(this);
}

void Vtop_core_stage3_hazard_unit_if::__Vconfigure(bool first) {
    if (false && first) {}  // Prevent unused
}

Vtop_core_stage3_hazard_unit_if::~Vtop_core_stage3_hazard_unit_if() {
}
