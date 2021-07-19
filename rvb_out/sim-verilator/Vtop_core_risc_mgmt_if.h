// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vtop_core.h for the primary calling header

#ifndef VERILATED_VTOP_CORE_RISC_MGMT_IF_H_
#define VERILATED_VTOP_CORE_RISC_MGMT_IF_H_  // guard

#include "verilated.h"

class Vtop_core__Syms;

class Vtop_core_risc_mgmt_if final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    CData/*0:0*/ __PVT__req_reg_r;
    CData/*0:0*/ __PVT__req_reg_w;
    CData/*4:0*/ __PVT__rsel_s_0;
    CData/*4:0*/ __PVT__rsel_s_1;
    CData/*4:0*/ __PVT__rsel_d;
    CData/*0:0*/ __PVT__reg_w;
    CData/*0:0*/ __PVT__req_br_j;
    CData/*0:0*/ __PVT__branch_jump;
    CData/*0:0*/ __PVT__req_mem;
    CData/*0:0*/ __PVT__mem_ren;
    CData/*0:0*/ __PVT__mem_wen;
    CData/*0:0*/ __PVT__mem_busy;
    CData/*3:0*/ __PVT__mem_byte_en;
    CData/*0:0*/ __PVT__execute_stall;
    CData/*0:0*/ __PVT__memory_stall;
    CData/*0:0*/ __PVT__active_insn;
    CData/*0:0*/ __PVT__ex_token;
    CData/*0:0*/ __PVT__if_ex_enable;
    CData/*0:0*/ __PVT__exception;
    CData/*0:0*/ __PVT__ex_cause;
    CData/*0:0*/ __PVT__risc_mgmt_start;
    IData/*31:0*/ __PVT__insn;
    IData/*31:0*/ __PVT__rdata_s_0;
    IData/*31:0*/ __PVT__rdata_s_1;
    IData/*31:0*/ __PVT__reg_wdata;
    IData/*31:0*/ __PVT__br_j_addr;
    IData/*31:0*/ __PVT__pc;
    IData/*31:0*/ __PVT__mem_addr;
    IData/*31:0*/ __PVT__mem_store;
    IData/*31:0*/ __PVT__mem_load;

    // INTERNAL VARIABLES
    Vtop_core__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vtop_core_risc_mgmt_if(Vtop_core__Syms* symsp, const char* name);
    ~Vtop_core_risc_mgmt_if();
    VL_UNCOPYABLE(Vtop_core_risc_mgmt_if);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);


#endif  // guard
