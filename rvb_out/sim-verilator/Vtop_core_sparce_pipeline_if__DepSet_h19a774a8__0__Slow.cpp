// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop_core.h for the primary calling header

#include "verilated.h"
#include "verilated_dpi.h"

#include "Vtop_core_sparce_pipeline_if.h"

VL_ATTR_COLD void Vtop_core_sparce_pipeline_if___ctor_var_reset(Vtop_core_sparce_pipeline_if* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vtop_core_sparce_pipeline_if___ctor_var_reset\n"); );
    // Body
    vlSelf->__PVT__wb_data = VL_RAND_RESET_I(32);
    vlSelf->__PVT__sasa_data = VL_RAND_RESET_I(32);
    vlSelf->__PVT__sasa_addr = VL_RAND_RESET_I(32);
    vlSelf->__PVT__wb_en = VL_RAND_RESET_I(1);
    vlSelf->__PVT__sasa_wen = VL_RAND_RESET_I(1);
    vlSelf->__PVT__rd = VL_RAND_RESET_I(5);
    vlSelf->__PVT__if_ex_enable = VL_RAND_RESET_I(1);
}
