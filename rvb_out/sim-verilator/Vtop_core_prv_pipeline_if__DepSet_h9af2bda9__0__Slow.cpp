// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop_core.h for the primary calling header

#include "verilated.h"
#include "verilated_dpi.h"

#include "Vtop_core_prv_pipeline_if.h"

VL_ATTR_COLD void Vtop_core_prv_pipeline_if___ctor_var_reset(Vtop_core_prv_pipeline_if* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vtop_core_prv_pipeline_if___ctor_var_reset\n"); );
    // Body
    vlSelf->__PVT__fault_insn = VL_RAND_RESET_I(1);
    vlSelf->__PVT__timer_int = VL_RAND_RESET_I(1);
    vlSelf->__PVT__soft_int = VL_RAND_RESET_I(1);
    vlSelf->__PVT__ext_int = VL_RAND_RESET_I(1);
    VL_RAND_RESET_W(128, vlSelf->__PVT__xtvec);
    VL_RAND_RESET_W(128, vlSelf->__PVT__xepc_r);
    vlSelf->__PVT__valid_write = VL_RAND_RESET_I(1);
    vlSelf->__PVT__prot_fault_s = VL_RAND_RESET_I(1);
    vlSelf->__PVT__prot_fault_l = VL_RAND_RESET_I(1);
    vlSelf->__PVT__prot_fault_i = VL_RAND_RESET_I(1);
}
