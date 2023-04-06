// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop_core.h for the primary calling header

#include "verilated.h"
#include "verilated_dpi.h"

#include "Vtop_core_top_core.h"

uint32_t Vtop_core_top_core::get_x28() {
    VL_DEBUG_IF(VL_DBG_MSGF("+      Vtop_core_top_core::get_x28\n"); );
    VL_OUT(get_x28__Vfuncrtn,31,0);
    // Body
    get_x28__Vfuncrtn = this->__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x1cU];
    // Final
    return (get_x28__Vfuncrtn);
}
