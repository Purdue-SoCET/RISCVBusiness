// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop_core.h for the primary calling header

#include "verilated.h"
#include "verilated_dpi.h"

#include "Vtop_core__Syms.h"
#include "Vtop_core_prv_pipeline_if.h"

void Vtop_core_prv_pipeline_if___ctor_var_reset(Vtop_core_prv_pipeline_if* vlSelf);

Vtop_core_prv_pipeline_if::Vtop_core_prv_pipeline_if(Vtop_core__Syms* symsp, const char* name)
    : VerilatedModule{name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vtop_core_prv_pipeline_if___ctor_var_reset(this);
}

void Vtop_core_prv_pipeline_if::__Vconfigure(bool first) {
    if (false && first) {}  // Prevent unused
}

Vtop_core_prv_pipeline_if::~Vtop_core_prv_pipeline_if() {
}
