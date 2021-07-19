// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vtop_core.h for the primary calling header

#ifndef VERILATED_VTOP_CORE_ALU_IF_H_
#define VERILATED_VTOP_CORE_ALU_IF_H_  // guard

#include "verilated.h"

class Vtop_core__Syms;

class Vtop_core_alu_if final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    IData/*31:0*/ __PVT__port_a;
    IData/*31:0*/ __PVT__port_b;
    IData/*31:0*/ __PVT__port_out;

    // INTERNAL VARIABLES
    Vtop_core__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vtop_core_alu_if(Vtop_core__Syms* symsp, const char* name);
    ~Vtop_core_alu_if();
    VL_UNCOPYABLE(Vtop_core_alu_if);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);


#endif  // guard
