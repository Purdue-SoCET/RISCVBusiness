// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop_core.h for the primary calling header

#include "verilated.h"
#include "verilated_dpi.h"

#include "Vtop_core__Syms.h"
#include "Vtop_core___024unit.h"

void Vtop_core___024unit___ctor_var_reset(Vtop_core___024unit* vlSelf);

Vtop_core___024unit::Vtop_core___024unit(Vtop_core__Syms* symsp, const char* name)
    : VerilatedModule{name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vtop_core___024unit___ctor_var_reset(this);
}

void Vtop_core___024unit::__Vconfigure(bool first) {
    if (false && first) {}  // Prevent unused
}

Vtop_core___024unit::~Vtop_core___024unit() {
}
