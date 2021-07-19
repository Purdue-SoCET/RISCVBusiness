// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop_core.h for the primary calling header

#include "verilated.h"
#include "verilated_dpi.h"

#include "Vtop_core_control_unit_if.h"

VL_ATTR_COLD void Vtop_core_control_unit_if___ctor_var_reset(Vtop_core_control_unit_if* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+                Vtop_core_control_unit_if___ctor_var_reset\n"); );
    // Body
    vlSelf->__PVT__wen = VL_RAND_RESET_I(1);
    vlSelf->__PVT__wfi = VL_RAND_RESET_I(1);
    vlSelf->__PVT__alu_a_sel = VL_RAND_RESET_I(2);
    vlSelf->__PVT__alu_b_sel = VL_RAND_RESET_I(2);
    vlSelf->__PVT__w_sel = VL_RAND_RESET_I(3);
    vlSelf->__PVT__imm_S = VL_RAND_RESET_I(12);
    vlSelf->__PVT__imm_UJ = VL_RAND_RESET_I(21);
    vlSelf->__PVT__imm_SB = VL_RAND_RESET_I(13);
    vlSelf->__PVT__ret_insn = VL_RAND_RESET_I(1);
    vlSelf->__PVT__breakpoint = VL_RAND_RESET_I(1);
    vlSelf->__PVT__ecall_insn = VL_RAND_RESET_I(1);
    vlSelf->__PVT__csr_swap = VL_RAND_RESET_I(1);
    vlSelf->__PVT__csr_set = VL_RAND_RESET_I(1);
    vlSelf->__PVT__csr_clr = VL_RAND_RESET_I(1);
    vlSelf->__PVT__csr_imm = VL_RAND_RESET_I(1);
}
