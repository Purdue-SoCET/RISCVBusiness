// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop_core.h for the primary calling header

#include "verilated.h"
#include "verilated_dpi.h"

#include "Vtop_core_priv_1_12_internal_if.h"

VL_ATTR_COLD void Vtop_core_priv_1_12_internal_if___ctor_var_reset(Vtop_core_priv_1_12_internal_if* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+                Vtop_core_priv_1_12_internal_if___ctor_var_reset\n"); );
    // Body
    vlSelf->__PVT__old_csr_val = VL_RAND_RESET_I(32);
    vlSelf->__PVT__env_u = VL_RAND_RESET_I(1);
    vlSelf->__PVT__env_m = VL_RAND_RESET_I(1);
    vlSelf->__PVT__next_mip = VL_RAND_RESET_I(32);
    vlSelf->__PVT__next_mie = VL_RAND_RESET_I(32);
    vlSelf->__PVT__next_mcause = VL_RAND_RESET_I(32);
    vlSelf->__PVT__next_mstatus = VL_RAND_RESET_I(32);
    vlSelf->__PVT__priv_pc = VL_RAND_RESET_I(32);
    vlSelf->__PVT__insert_pc = VL_RAND_RESET_I(1);
    vlSelf->__PVT__mret = VL_RAND_RESET_I(1);
    vlSelf->__PVT__intr = VL_RAND_RESET_I(1);
    vlSelf->__PVT__pma_s_fault = VL_RAND_RESET_I(1);
    vlSelf->__PVT__pma_l_fault = VL_RAND_RESET_I(1);
    vlSelf->__PVT__pma_i_fault = VL_RAND_RESET_I(1);
    vlSelf->__PVT__pmp_s_fault = VL_RAND_RESET_I(1);
    vlSelf->__PVT__pmp_l_fault = VL_RAND_RESET_I(1);
    vlSelf->__PVT__pmp_i_fault = VL_RAND_RESET_I(1);
}
