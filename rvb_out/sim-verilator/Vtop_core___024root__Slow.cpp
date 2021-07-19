// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop_core.h for the primary calling header

#include "verilated.h"
#include "verilated_dpi.h"

#include "Vtop_core__Syms.h"
#include "Vtop_core___024root.h"

void Vtop_core___024root___ctor_var_reset(Vtop_core___024root* vlSelf);

Vtop_core___024root::Vtop_core___024root(Vtop_core__Syms* symsp, const char* name)
    : VerilatedModule{name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vtop_core___024root___ctor_var_reset(this);
}

void Vtop_core___024root::__Vconfigure(bool first) {
    if (false && first) {}  // Prevent unused
}

Vtop_core___024root::~Vtop_core___024root() {
}
