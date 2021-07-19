// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vtop_core.h for the primary calling header

#ifndef VERILATED_VTOP_CORE___024UNIT_H_
#define VERILATED_VTOP_CORE___024UNIT_H_  // guard

#include "verilated.h"

class Vtop_core__Syms;

class Vtop_core___024unit final : public VerilatedModule {
  public:

    // INTERNAL VARIABLES
    Vtop_core__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vtop_core___024unit(Vtop_core__Syms* symsp, const char* name);
    ~Vtop_core___024unit();
    VL_UNCOPYABLE(Vtop_core___024unit);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);


#endif  // guard
