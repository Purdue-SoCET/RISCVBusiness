// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop_core.h for the primary calling header

#include "verilated.h"
#include "verilated_dpi.h"

#include "Vtop_core_stage3_hazard_unit_if.h"

VL_ATTR_COLD void Vtop_core_stage3_hazard_unit_if___ctor_var_reset(Vtop_core_stage3_hazard_unit_if* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vtop_core_stage3_hazard_unit_if___ctor_var_reset\n"); );
    // Body
    vlSelf->__PVT__fence_stall = VL_RAND_RESET_I(1);
    vlSelf->__PVT__ex_mem_flush = VL_RAND_RESET_I(1);
    vlSelf->__PVT__if_ex_stall = VL_RAND_RESET_I(1);
    vlSelf->__PVT__ex_mem_stall = VL_RAND_RESET_I(1);
    vlSelf->__PVT__suppress_iren = VL_RAND_RESET_I(1);
    vlSelf->__PVT__illegal_insn = VL_RAND_RESET_I(1);
    vlSelf->__PVT__mal_l = VL_RAND_RESET_I(1);
    vlSelf->__PVT__mal_s = VL_RAND_RESET_I(1);
    vlSelf->__PVT__token_ex = VL_RAND_RESET_I(1);
}
