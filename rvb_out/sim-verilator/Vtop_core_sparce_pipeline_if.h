// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vtop_core.h for the primary calling header

#ifndef VERILATED_VTOP_CORE_SPARCE_PIPELINE_IF_H_
#define VERILATED_VTOP_CORE_SPARCE_PIPELINE_IF_H_  // guard

#include "verilated.h"

class Vtop_core__Syms;

class Vtop_core_sparce_pipeline_if final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    CData/*0:0*/ __PVT__wb_en;
    CData/*0:0*/ __PVT__sasa_wen;
    CData/*4:0*/ __PVT__rd;
    CData/*0:0*/ __PVT__if_ex_enable;
    IData/*31:0*/ __PVT__wb_data;
    IData/*31:0*/ __PVT__sasa_data;
    IData/*31:0*/ __PVT__sasa_addr;

    // INTERNAL VARIABLES
    Vtop_core__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vtop_core_sparce_pipeline_if(Vtop_core__Syms* symsp, const char* name);
    ~Vtop_core_sparce_pipeline_if();
    VL_UNCOPYABLE(Vtop_core_sparce_pipeline_if);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);


#endif  // guard
