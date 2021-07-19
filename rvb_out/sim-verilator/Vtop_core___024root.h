// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vtop_core.h for the primary calling header

#ifndef VERILATED_VTOP_CORE___024ROOT_H_
#define VERILATED_VTOP_CORE___024ROOT_H_  // guard

#include "verilated.h"

class Vtop_core__Syms;
class Vtop_core_top_core;


class Vtop_core___024root final : public VerilatedModule {
  public:
    // CELLS
    Vtop_core_top_core* top_core;

    // DESIGN SPECIFIC STATE
    VL_IN8(CLK,0,0);
    VL_IN8(nRST,0,0);
    VL_OUT8(wfi,0,0);
    VL_OUT8(halt,0,0);
    VL_IN8(busy,0,0);
    VL_OUT8(ren,0,0);
    VL_OUT8(wen,0,0);
    VL_OUT8(byte_en,3,0);
    VL_IN8(ext_int,0,0);
    VL_IN8(ext_int_clear,0,0);
    VL_IN8(soft_int,0,0);
    VL_IN8(soft_int_clear,0,0);
    VL_IN8(timer_int,0,0);
    VL_IN8(timer_int_clear,0,0);
    CData/*0:0*/ __Vtrigrprev__TOP__CLK;
    CData/*0:0*/ __Vtrigrprev__TOP__nRST;
    CData/*0:0*/ __VactContinue;
    VL_IN(rdata,31,0);
    VL_OUT(addr,31,0);
    VL_OUT(wdata,31,0);
    IData/*31:0*/ __VstlIterCount;
    IData/*31:0*/ __VicoIterCount;
    IData/*31:0*/ __VactIterCount;
    VL_IN64(mtime,63,0);
    VlUnpacked<CData/*0:0*/, 6> __Vm_traceActivity;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<1> __VicoTriggered;
    VlTriggerVec<3> __VactTriggered;
    VlTriggerVec<3> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vtop_core__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vtop_core___024root(Vtop_core__Syms* symsp, const char* name);
    ~Vtop_core___024root();
    VL_UNCOPYABLE(Vtop_core___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);


#endif  // guard
