// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vtop_core.h for the primary calling header

#ifndef VERILATED_VTOP_CORE_PRV_PIPELINE_IF_H_
#define VERILATED_VTOP_CORE_PRV_PIPELINE_IF_H_  // guard

#include "verilated.h"

class Vtop_core__Syms;

class Vtop_core_prv_pipeline_if final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    CData/*0:0*/ __PVT__fault_insn;
    CData/*0:0*/ __PVT__timer_int;
    CData/*0:0*/ __PVT__soft_int;
    CData/*0:0*/ __PVT__ext_int;
    CData/*0:0*/ __PVT__valid_write;
    CData/*0:0*/ __PVT__prot_fault_s;
    CData/*0:0*/ __PVT__prot_fault_l;
    CData/*0:0*/ __PVT__prot_fault_i;
    VlWide<4>/*127:0*/ __PVT__xtvec;
    VlWide<4>/*127:0*/ __PVT__xepc_r;

    // INTERNAL VARIABLES
    Vtop_core__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vtop_core_prv_pipeline_if(Vtop_core__Syms* symsp, const char* name);
    ~Vtop_core_prv_pipeline_if();
    VL_UNCOPYABLE(Vtop_core_prv_pipeline_if);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);


#endif  // guard
