// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_fst_c.h"
#include "Vtop_core__Syms.h"


void Vtop_core___024root__trace_chg_sub_0(Vtop_core___024root* vlSelf, VerilatedFst::Buffer* bufp);

void Vtop_core___024root__trace_chg_top_0(void* voidSelf, VerilatedFst::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_chg_top_0\n"); );
    // Init
    Vtop_core___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtop_core___024root*>(voidSelf);
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    Vtop_core___024root__trace_chg_sub_0((&vlSymsp->TOP), bufp);
}

extern const VlWide<12>/*383:0*/ Vtop_core__ConstPool__CONST_h1b548564_0;

void Vtop_core___024root__trace_chg_sub_0(Vtop_core___024root* vlSelf, VerilatedFst::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_chg_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    VlWide<12>/*383:0*/ __Vtemp_hd57fe25b__0;
    VlWide<12>/*383:0*/ __Vtemp_hb8fad44c__0;
    VlWide<12>/*383:0*/ __Vtemp_h832f242f__0;
    VlWide<12>/*383:0*/ __Vtemp_h66a8f596__0;
    VlWide<12>/*383:0*/ __Vtemp_h42528074__0;
    VlWide<12>/*383:0*/ __Vtemp_hca760406__0;
    VlWide<12>/*383:0*/ __Vtemp_he20d994c__0;
    VlWide<12>/*383:0*/ __Vtemp_heba899ea__0;
    VlWide<12>/*383:0*/ __Vtemp_ha676a1bf__0;
    VlWide<12>/*383:0*/ __Vtemp_h5ee43eb0__0;
    VlWide<12>/*383:0*/ __Vtemp_h0a51f55d__0;
    VlWide<12>/*383:0*/ __Vtemp_he6508a66__0;
    VlWide<12>/*383:0*/ __Vtemp_h202cdc64__0;
    VlWide<12>/*383:0*/ __Vtemp_h0f78598d__0;
    VlWide<12>/*383:0*/ __Vtemp_h4f074be2__0;
    VlWide<12>/*383:0*/ __Vtemp_hc53d5f0a__0;
    // Body
    if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[0U])) {
        bufp->chgIData(oldp+0,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__cpu_track1__DOT__fptr),32);
    }
    if (VL_UNLIKELY((vlSelf->__Vm_traceActivity[1U] 
                     | vlSelf->__Vm_traceActivity[2U]))) {
        bufp->chgCData(oldp+1,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_word_num),2);
        bufp->chgBit(oldp+2,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__enable_word_count));
        bufp->chgCData(oldp+3,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_word_num),2);
        bufp->chgBit(oldp+4,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__enable_word_count));
        bufp->chgBit(oldp+5,(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__busy));
        bufp->chgBit(oldp+6,(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__busy));
        bufp->chgBit(oldp+7,(vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__busy));
        bufp->chgSData(oldp+8,((vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip 
                                >> 0x10U)),16);
        bufp->chgCData(oldp+9,((0xfU & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip 
                                        >> 0xcU))),4);
        bufp->chgBit(oldp+10,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip 
                                     >> 0xbU))));
        bufp->chgBit(oldp+11,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip 
                                     >> 0xaU))));
        bufp->chgBit(oldp+12,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip 
                                     >> 9U))));
        bufp->chgBit(oldp+13,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip 
                                     >> 8U))));
        bufp->chgBit(oldp+14,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip 
                                     >> 7U))));
        bufp->chgBit(oldp+15,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip 
                                     >> 6U))));
        bufp->chgBit(oldp+16,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip 
                                     >> 5U))));
        bufp->chgBit(oldp+17,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip 
                                     >> 4U))));
        bufp->chgBit(oldp+18,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip 
                                     >> 3U))));
        bufp->chgBit(oldp+19,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip 
                                     >> 2U))));
        bufp->chgBit(oldp+20,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip 
                                     >> 1U))));
        bufp->chgBit(oldp+21,((1U & vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip)));
    }
    if (VL_UNLIKELY((vlSelf->__Vm_traceActivity[1U] 
                     | vlSelf->__Vm_traceActivity[4U]))) {
        bufp->chgIData(oldp+22,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu_if.__PVT__port_out),32);
        bufp->chgIData(oldp+23,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__rs1_post_fwd),32);
        bufp->chgIData(oldp+24,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__rs2_post_fwd),32);
        bufp->chgIData(oldp+25,(((0x6fU == (0x7fU & 
                                            vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))
                                  ? vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__jump_calc__DOT__jump_addr
                                  : (0xfffffffeU & vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__jump_calc__DOT__jump_addr))),32);
        bufp->chgIData(oldp+26,(((IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_if.__PVT__branch_taken)
                                  ? (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[4U] 
                                     + VL_EXTENDS_II(32,13, (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__imm_SB)))
                                  : vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[3U])),32);
        bufp->chgBit(oldp+27,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_if.__PVT__branch_taken));
        bufp->chgIData(oldp+28,((((0x6fU == (0x7fU 
                                             & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U])) 
                                  | (0x67U == (0x7fU 
                                               & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U])))
                                  ? ((0x6fU == (0x7fU 
                                                & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))
                                      ? vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__jump_calc__DOT__jump_addr
                                      : (0xfffffffeU 
                                         & vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__jump_calc__DOT__jump_addr))
                                  : ((IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_if.__PVT__branch_taken)
                                      ? (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[4U] 
                                         + VL_EXTENDS_II(32,13, (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__imm_SB)))
                                      : vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[3U]))),32);
        bufp->chgIData(oldp+29,((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu__DOT__adder_out)),32);
        bufp->chgIData(oldp+30,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu_if.__PVT__port_a),32);
        bufp->chgIData(oldp+31,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu__DOT__op_b),32);
        bufp->chgIData(oldp+32,(((IData)(1U) + (~ vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu_if.__PVT__port_b))),32);
        bufp->chgBit(oldp+33,((1U & (IData)((vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu__DOT__adder_out 
                                             >> 0x20U)))));
        bufp->chgBit(oldp+34,((1U & (IData)((vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu__DOT__adder_out 
                                             >> 0x1fU)))));
        bufp->chgBit(oldp+35,((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu_if.__PVT__port_a 
                               >> 0x1fU)));
        bufp->chgBit(oldp+36,((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu_if.__PVT__port_b 
                               >> 0x1fU)));
        bufp->chgQData(oldp+37,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu__DOT__adder_out),33);
        bufp->chgQData(oldp+39,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu__DOT__op_a_ext),33);
        bufp->chgQData(oldp+41,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu__DOT__op_b_ext),33);
        bufp->chgBit(oldp+43,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_res__DOT__lt));
        bufp->chgBit(oldp+44,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_res__DOT__eq));
        bufp->chgBit(oldp+45,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_res__DOT__ltu));
        bufp->chgBit(oldp+46,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__rs1_post_fwd 
                               >> 0x1fU)));
        bufp->chgBit(oldp+47,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__rs2_post_fwd 
                               >> 0x1fU)));
        bufp->chgBit(oldp+48,((1U & (IData)((vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_res__DOT__adder_out 
                                             >> 0x1fU)))));
        bufp->chgBit(oldp+49,((1U & (IData)((vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_res__DOT__adder_out 
                                             >> 0x20U)))));
        bufp->chgQData(oldp+50,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_res__DOT__adder_out),33);
        bufp->chgQData(oldp+52,((((QData)((IData)((
                                                   (vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__rs1_post_fwd 
                                                    >> 0x1fU) 
                                                   & (~ 
                                                      ((6U 
                                                        == 
                                                        (7U 
                                                         & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                                            >> 0xcU))) 
                                                       | (7U 
                                                          == 
                                                          (7U 
                                                           & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                                              >> 0xcU)))))))) 
                                  << 0x20U) | (QData)((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__rs1_post_fwd)))),33);
        bufp->chgQData(oldp+54,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_res__DOT__op_2_ext),33);
        bufp->chgIData(oldp+56,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__jump_calc__DOT__jump_addr),32);
        bufp->chgIData(oldp+57,(((IData)(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__insert_pc)
                                  ? vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__priv_pc
                                  : ((1U & ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                             >> 0x10U) 
                                            & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__fence_stall))))
                                      ? ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[6U] 
                                          << 0x1fU) 
                                         | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[5U] 
                                            >> 1U))
                                      : ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__branch_jump)
                                          ? ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                              << 0x1fU) 
                                             | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xbU] 
                                                >> 1U))
                                          : ((IData)(4U) 
                                             + vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc))))),32);
        bufp->chgIData(oldp+58,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__priv_pc),32);
        bufp->chgIData(oldp+59,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__old_csr_val),32);
        bufp->chgIData(oldp+60,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fw_if.__PVT__rd_mem_data),32);
        bufp->chgBit(oldp+61,((vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mcause 
                               >> 0x1fU)));
        bufp->chgIData(oldp+62,((0x7fffffffU & vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mcause)),31);
        bufp->chgIData(oldp+63,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu_if.__PVT__port_b),32);
        bufp->chgIData(oldp+64,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu_if.__PVT__port_out),32);
        bufp->chgIData(oldp+65,(((0x6fU == (0x7fU & 
                                            vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))
                                  ? vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[4U]
                                  : vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__rs1_post_fwd)),32);
        bufp->chgIData(oldp+66,((0xfffffffeU & vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__jump_calc__DOT__jump_addr)),32);
    }
    if (VL_UNLIKELY(((vlSelf->__Vm_traceActivity[1U] 
                      | vlSelf->__Vm_traceActivity[4U]) 
                     | vlSelf->__Vm_traceActivity[5U]))) {
        bufp->chgBit(oldp+67,((((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                 >> 0x11U) & ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                               >> 0x13U) 
                                              | (IData)(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__valid_write))) 
                               & ((((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                              >> 0xfU)) 
                                    == (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                 >> 0x13U))) 
                                   & (0U != (0x1fU 
                                             & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                >> 0x13U)))) 
                                  | (((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                                >> 0x14U)) 
                                      == (0x1fU & (
                                                   vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                   >> 0x13U))) 
                                     & (0U != (0x1fU 
                                               & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                  >> 0x13U))))))));
        bufp->chgBit(oldp+68,((1U & ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                      >> 0x13U) | (IData)(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__valid_write)))));
        bufp->chgBit(oldp+69,(((IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__ex_mem_stall) 
                               & (0U == (0x408000U 
                                         & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU])))));
        bufp->chgBit(oldp+70,((1U & ((~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__if_ex_stall)) 
                                     | (0U != (0x408000U 
                                               & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU]))))));
        bufp->chgBit(oldp+71,((1U & ((~ (((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__ex_flush_hazard) 
                                          | (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__branch_jump)) 
                                         | ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__wait_for_imem) 
                                            & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__ex_mem_stall))))) 
                                     & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__if_ex_stall))))));
        bufp->chgBit(oldp+72,((1U & (((((((~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__if_ex_stall)) 
                                          & (~ (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__wait_for_imem))) 
                                         | (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__branch_jump)) 
                                        | (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__ex_flush_hazard)) 
                                       | (IData)(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__insert_pc)) 
                                      | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                         >> 6U)) & 
                                     (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__fence_stall))))));
        bufp->chgBit(oldp+73,((((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__ex_flush_hazard) 
                                | (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__branch_jump)) 
                               | ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__wait_for_imem) 
                                  & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__ex_mem_stall))))));
        bufp->chgIData(oldp+74,(((8U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU])
                                  ? ((4U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU])
                                      ? 0U : ((2U & 
                                               vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU])
                                               ? 0U
                                               : vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__old_csr_val))
                                  : ((4U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU])
                                      ? ((2U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU])
                                          ? ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xbU] 
                                              << 0x1fU) 
                                             | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                >> 1U))
                                          : ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[5U] 
                                              << 0x1fU) 
                                             | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[4U] 
                                                >> 1U)))
                                      : ((2U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU])
                                          ? ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[6U] 
                                              << 0x1fU) 
                                             | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[5U] 
                                                >> 1U))
                                          : vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__dload_ext)))),32);
        bufp->chgBit(oldp+75,(((((~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__if_ex_stall)) 
                                 | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0xfU)) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                                 >> 0x16U)) 
                               & (0U != ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[8U] 
                                          << 0x1fU) 
                                         | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[7U] 
                                            >> 1U))))));
        bufp->chgBit(oldp+76,((((~ (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__invalid_csr_priv)) 
                                & (IData)(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__valid_write)) 
                               & (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__csr_operation))));
        bufp->chgBit(oldp+77,((1U & ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                      >> 0x11U) & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__ex_mem_stall))))));
    }
    if (VL_UNLIKELY((vlSelf->__Vm_traceActivity[1U] 
                     | vlSelf->__Vm_traceActivity[5U]))) {
        bufp->chgIData(oldp+78,(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__wdata),32);
        bufp->chgIData(oldp+79,(vlSymsp->TOP__top_core__CORE__DOT__tspp_icache_gen_bus_if.__PVT__rdata),32);
        bufp->chgIData(oldp+80,(vlSymsp->TOP__top_core__CORE__DOT__tspp_icache_gen_bus_if.__PVT__rdata),32);
        bufp->chgBit(oldp+81,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__wait_for_imem));
        bufp->chgBit(oldp+82,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__wait_for_dmem));
        bufp->chgBit(oldp+83,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__ex_flush_hazard));
        bufp->chgIData(oldp+84,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__dload_ext),32);
        bufp->chgIData(oldp+85,(vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__rdata),32);
        bufp->chgBit(oldp+86,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                               >> 0x1fU)));
        bufp->chgCData(oldp+87,((0xffU & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                          >> 0x17U))),8);
        bufp->chgBit(oldp+88,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                     >> 0x16U))));
        bufp->chgBit(oldp+89,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                     >> 0x15U))));
        bufp->chgBit(oldp+90,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                     >> 0x14U))));
        bufp->chgBit(oldp+91,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                     >> 0x13U))));
        bufp->chgBit(oldp+92,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                     >> 0x12U))));
        bufp->chgBit(oldp+93,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                     >> 0x11U))));
        bufp->chgCData(oldp+94,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                       >> 0xfU))),2);
        bufp->chgCData(oldp+95,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                       >> 0xdU))),2);
        bufp->chgCData(oldp+96,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                       >> 0xbU))),2);
        bufp->chgCData(oldp+97,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                       >> 9U))),2);
        bufp->chgBit(oldp+98,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                     >> 8U))));
        bufp->chgBit(oldp+99,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                     >> 7U))));
        bufp->chgBit(oldp+100,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                      >> 6U))));
        bufp->chgBit(oldp+101,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                      >> 5U))));
        bufp->chgBit(oldp+102,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                      >> 4U))));
        bufp->chgBit(oldp+103,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                      >> 3U))));
        bufp->chgBit(oldp+104,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                      >> 2U))));
        bufp->chgBit(oldp+105,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                      >> 1U))));
        bufp->chgBit(oldp+106,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next)));
        bufp->chgSData(oldp+107,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                                  >> 0x10U)),16);
        bufp->chgCData(oldp+108,((0xfU & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                                          >> 0xcU))),4);
        bufp->chgBit(oldp+109,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                                      >> 0xbU))));
        bufp->chgBit(oldp+110,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                                      >> 0xaU))));
        bufp->chgBit(oldp+111,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                                      >> 9U))));
        bufp->chgBit(oldp+112,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                                      >> 8U))));
        bufp->chgBit(oldp+113,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                                      >> 7U))));
        bufp->chgBit(oldp+114,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                                      >> 6U))));
        bufp->chgBit(oldp+115,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                                      >> 5U))));
        bufp->chgBit(oldp+116,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                                      >> 4U))));
        bufp->chgBit(oldp+117,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                                      >> 3U))));
        bufp->chgBit(oldp+118,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                                      >> 2U))));
        bufp->chgBit(oldp+119,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                                      >> 1U))));
        bufp->chgBit(oldp+120,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next)));
        bufp->chgIData(oldp+121,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mtvec_next 
                                  >> 2U)),30);
        bufp->chgCData(oldp+122,((3U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mtvec_next)),2);
        bufp->chgIData(oldp+123,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mscratch_next),32);
        bufp->chgIData(oldp+124,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mepc_next),32);
        bufp->chgBit(oldp+125,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcause_next 
                                >> 0x1fU)));
        bufp->chgIData(oldp+126,((0x7fffffffU & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcause_next)),31);
        bufp->chgIData(oldp+127,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mtval_next),32);
        bufp->chgSData(oldp+128,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                                  >> 0x10U)),16);
        bufp->chgCData(oldp+129,((0xfU & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                                          >> 0xcU))),4);
        bufp->chgBit(oldp+130,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                                      >> 0xbU))));
        bufp->chgBit(oldp+131,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                                      >> 0xaU))));
        bufp->chgBit(oldp+132,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                                      >> 9U))));
        bufp->chgBit(oldp+133,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                                      >> 8U))));
        bufp->chgBit(oldp+134,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                                      >> 7U))));
        bufp->chgBit(oldp+135,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                                      >> 6U))));
        bufp->chgBit(oldp+136,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                                      >> 5U))));
        bufp->chgBit(oldp+137,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                                      >> 4U))));
        bufp->chgBit(oldp+138,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                                      >> 3U))));
        bufp->chgBit(oldp+139,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                                      >> 2U))));
        bufp->chgBit(oldp+140,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                                      >> 1U))));
        bufp->chgBit(oldp+141,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next)));
        bufp->chgBit(oldp+142,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                >> 0x1fU)));
        bufp->chgBit(oldp+143,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 0x1eU))));
        bufp->chgBit(oldp+144,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 0x1dU))));
        bufp->chgBit(oldp+145,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 0x1cU))));
        bufp->chgBit(oldp+146,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 0x1bU))));
        bufp->chgBit(oldp+147,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 0x1aU))));
        bufp->chgBit(oldp+148,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 0x19U))));
        bufp->chgBit(oldp+149,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 0x18U))));
        bufp->chgBit(oldp+150,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 0x17U))));
        bufp->chgBit(oldp+151,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 0x16U))));
        bufp->chgBit(oldp+152,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 0x15U))));
        bufp->chgBit(oldp+153,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 0x14U))));
        bufp->chgBit(oldp+154,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 0x13U))));
        bufp->chgBit(oldp+155,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 0x12U))));
        bufp->chgBit(oldp+156,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 0x11U))));
        bufp->chgBit(oldp+157,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 0x10U))));
        bufp->chgBit(oldp+158,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 0xfU))));
        bufp->chgBit(oldp+159,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 0xeU))));
        bufp->chgBit(oldp+160,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 0xdU))));
        bufp->chgBit(oldp+161,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 0xcU))));
        bufp->chgBit(oldp+162,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 0xbU))));
        bufp->chgBit(oldp+163,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 0xaU))));
        bufp->chgBit(oldp+164,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 9U))));
        bufp->chgBit(oldp+165,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 8U))));
        bufp->chgBit(oldp+166,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 7U))));
        bufp->chgBit(oldp+167,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 6U))));
        bufp->chgBit(oldp+168,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 5U))));
        bufp->chgBit(oldp+169,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 4U))));
        bufp->chgBit(oldp+170,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 3U))));
        bufp->chgBit(oldp+171,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 2U))));
        bufp->chgBit(oldp+172,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                      >> 1U))));
        bufp->chgBit(oldp+173,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next)));
        bufp->chgBit(oldp+174,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                >> 0x1fU)));
        bufp->chgBit(oldp+175,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 0x1eU))));
        bufp->chgBit(oldp+176,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 0x1dU))));
        bufp->chgBit(oldp+177,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 0x1cU))));
        bufp->chgBit(oldp+178,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 0x1bU))));
        bufp->chgBit(oldp+179,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 0x1aU))));
        bufp->chgBit(oldp+180,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 0x19U))));
        bufp->chgBit(oldp+181,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 0x18U))));
        bufp->chgBit(oldp+182,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 0x17U))));
        bufp->chgBit(oldp+183,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 0x16U))));
        bufp->chgBit(oldp+184,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 0x15U))));
        bufp->chgBit(oldp+185,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 0x14U))));
        bufp->chgBit(oldp+186,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 0x13U))));
        bufp->chgBit(oldp+187,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 0x12U))));
        bufp->chgBit(oldp+188,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 0x11U))));
        bufp->chgBit(oldp+189,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 0x10U))));
        bufp->chgBit(oldp+190,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 0xfU))));
        bufp->chgBit(oldp+191,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 0xeU))));
        bufp->chgBit(oldp+192,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 0xdU))));
        bufp->chgBit(oldp+193,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 0xcU))));
        bufp->chgBit(oldp+194,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 0xbU))));
        bufp->chgBit(oldp+195,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 0xaU))));
        bufp->chgBit(oldp+196,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 9U))));
        bufp->chgBit(oldp+197,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 8U))));
        bufp->chgBit(oldp+198,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 7U))));
        bufp->chgBit(oldp+199,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 6U))));
        bufp->chgBit(oldp+200,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 5U))));
        bufp->chgBit(oldp+201,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 4U))));
        bufp->chgBit(oldp+202,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 3U))));
        bufp->chgBit(oldp+203,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 2U))));
        bufp->chgBit(oldp+204,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                      >> 1U))));
        bufp->chgBit(oldp+205,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next)));
        bufp->chgQData(oldp+206,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__cf_next),64);
        bufp->chgQData(oldp+208,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__if_next),64);
        bufp->chgIData(oldp+210,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val),32);
        bufp->chgBit(oldp+211,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__inject_mcycle));
        bufp->chgBit(oldp+212,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__inject_minstret));
        bufp->chgBit(oldp+213,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__inject_mcycleh));
        bufp->chgBit(oldp+214,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__inject_minstreth));
        bufp->chgCData(oldp+215,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                  >> 0x1eU)),2);
        bufp->chgBit(oldp+216,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                      >> 0x1dU))));
        bufp->chgBit(oldp+217,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                      >> 0x1cU))));
        bufp->chgBit(oldp+218,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                      >> 0x1bU))));
        bufp->chgCData(oldp+219,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                        >> 0x18U))),3);
        bufp->chgBit(oldp+220,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                      >> 0x17U))));
        bufp->chgBit(oldp+221,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                      >> 0x16U))));
        bufp->chgBit(oldp+222,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                      >> 0x15U))));
        bufp->chgCData(oldp+223,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                        >> 0x13U))),2);
        bufp->chgCData(oldp+224,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                        >> 0x11U))),2);
        bufp->chgBit(oldp+225,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                      >> 0x10U))));
        bufp->chgCData(oldp+226,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                        >> 0xeU))),2);
        bufp->chgBit(oldp+227,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                      >> 0xdU))));
        bufp->chgBit(oldp+228,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                      >> 0xcU))));
        bufp->chgBit(oldp+229,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                      >> 0xbU))));
        bufp->chgCData(oldp+230,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                        >> 8U))),3);
        bufp->chgBit(oldp+231,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                      >> 7U))));
        bufp->chgBit(oldp+232,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                      >> 6U))));
        bufp->chgBit(oldp+233,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                      >> 5U))));
        bufp->chgCData(oldp+234,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                        >> 3U))),2);
        bufp->chgCData(oldp+235,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                        >> 1U))),2);
        bufp->chgBit(oldp+236,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U])));
        bufp->chgCData(oldp+237,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                  >> 0x1eU)),2);
        bufp->chgBit(oldp+238,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                      >> 0x1dU))));
        bufp->chgBit(oldp+239,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                      >> 0x1cU))));
        bufp->chgBit(oldp+240,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                      >> 0x1bU))));
        bufp->chgCData(oldp+241,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                        >> 0x18U))),3);
        bufp->chgBit(oldp+242,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                      >> 0x17U))));
        bufp->chgBit(oldp+243,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                      >> 0x16U))));
        bufp->chgBit(oldp+244,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                      >> 0x15U))));
        bufp->chgCData(oldp+245,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                        >> 0x13U))),2);
        bufp->chgCData(oldp+246,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                        >> 0x11U))),2);
        bufp->chgBit(oldp+247,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                      >> 0x10U))));
        bufp->chgCData(oldp+248,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                        >> 0xeU))),2);
        bufp->chgBit(oldp+249,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                      >> 0xdU))));
        bufp->chgBit(oldp+250,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                      >> 0xcU))));
        bufp->chgBit(oldp+251,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                      >> 0xbU))));
        bufp->chgCData(oldp+252,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                        >> 8U))),3);
        bufp->chgBit(oldp+253,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                      >> 7U))));
        bufp->chgBit(oldp+254,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                      >> 6U))));
        bufp->chgBit(oldp+255,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                      >> 5U))));
        bufp->chgCData(oldp+256,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                        >> 3U))),2);
        bufp->chgCData(oldp+257,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                        >> 1U))),2);
        bufp->chgBit(oldp+258,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U])));
        bufp->chgCData(oldp+259,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                  >> 0x1eU)),2);
        bufp->chgBit(oldp+260,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                      >> 0x1dU))));
        bufp->chgBit(oldp+261,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                      >> 0x1cU))));
        bufp->chgBit(oldp+262,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                      >> 0x1bU))));
        bufp->chgCData(oldp+263,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                        >> 0x18U))),3);
        bufp->chgBit(oldp+264,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                      >> 0x17U))));
        bufp->chgBit(oldp+265,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                      >> 0x16U))));
        bufp->chgBit(oldp+266,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                      >> 0x15U))));
        bufp->chgCData(oldp+267,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                        >> 0x13U))),2);
        bufp->chgCData(oldp+268,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                        >> 0x11U))),2);
        bufp->chgBit(oldp+269,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                      >> 0x10U))));
        bufp->chgCData(oldp+270,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                        >> 0xeU))),2);
        bufp->chgBit(oldp+271,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                      >> 0xdU))));
        bufp->chgBit(oldp+272,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                      >> 0xcU))));
        bufp->chgBit(oldp+273,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                      >> 0xbU))));
        bufp->chgCData(oldp+274,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                        >> 8U))),3);
        bufp->chgBit(oldp+275,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                      >> 7U))));
        bufp->chgBit(oldp+276,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                      >> 6U))));
        bufp->chgBit(oldp+277,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                      >> 5U))));
        bufp->chgCData(oldp+278,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                        >> 3U))),2);
        bufp->chgCData(oldp+279,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                        >> 1U))),2);
        bufp->chgBit(oldp+280,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U])));
        bufp->chgCData(oldp+281,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                  >> 0x1eU)),2);
        bufp->chgBit(oldp+282,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                      >> 0x1dU))));
        bufp->chgBit(oldp+283,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                      >> 0x1cU))));
        bufp->chgBit(oldp+284,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                      >> 0x1bU))));
        bufp->chgCData(oldp+285,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                        >> 0x18U))),3);
        bufp->chgBit(oldp+286,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                      >> 0x17U))));
        bufp->chgBit(oldp+287,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                      >> 0x16U))));
        bufp->chgBit(oldp+288,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                      >> 0x15U))));
        bufp->chgCData(oldp+289,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                        >> 0x13U))),2);
        bufp->chgCData(oldp+290,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                        >> 0x11U))),2);
        bufp->chgBit(oldp+291,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                      >> 0x10U))));
        bufp->chgCData(oldp+292,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                        >> 0xeU))),2);
        bufp->chgBit(oldp+293,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                      >> 0xdU))));
        bufp->chgBit(oldp+294,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                      >> 0xcU))));
        bufp->chgBit(oldp+295,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                      >> 0xbU))));
        bufp->chgCData(oldp+296,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                        >> 8U))),3);
        bufp->chgBit(oldp+297,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                      >> 7U))));
        bufp->chgBit(oldp+298,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                      >> 6U))));
        bufp->chgBit(oldp+299,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                      >> 5U))));
        bufp->chgCData(oldp+300,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                        >> 3U))),2);
        bufp->chgCData(oldp+301,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                        >> 1U))),2);
        bufp->chgBit(oldp+302,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U])));
        bufp->chgCData(oldp+303,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                  >> 0x1eU)),2);
        bufp->chgBit(oldp+304,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                      >> 0x1dU))));
        bufp->chgBit(oldp+305,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                      >> 0x1cU))));
        bufp->chgBit(oldp+306,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                      >> 0x1bU))));
        bufp->chgCData(oldp+307,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                        >> 0x18U))),3);
        bufp->chgBit(oldp+308,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                      >> 0x17U))));
        bufp->chgBit(oldp+309,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                      >> 0x16U))));
        bufp->chgBit(oldp+310,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                      >> 0x15U))));
        bufp->chgCData(oldp+311,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                        >> 0x13U))),2);
        bufp->chgCData(oldp+312,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                        >> 0x11U))),2);
        bufp->chgBit(oldp+313,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                      >> 0x10U))));
        bufp->chgCData(oldp+314,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                        >> 0xeU))),2);
        bufp->chgBit(oldp+315,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                      >> 0xdU))));
        bufp->chgBit(oldp+316,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                      >> 0xcU))));
        bufp->chgBit(oldp+317,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                      >> 0xbU))));
        bufp->chgCData(oldp+318,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                        >> 8U))),3);
        bufp->chgBit(oldp+319,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                      >> 7U))));
        bufp->chgBit(oldp+320,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                      >> 6U))));
        bufp->chgBit(oldp+321,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                      >> 5U))));
        bufp->chgCData(oldp+322,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                        >> 3U))),2);
        bufp->chgCData(oldp+323,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                        >> 1U))),2);
        bufp->chgBit(oldp+324,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U])));
        bufp->chgCData(oldp+325,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                  >> 0x1eU)),2);
        bufp->chgBit(oldp+326,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                      >> 0x1dU))));
        bufp->chgBit(oldp+327,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                      >> 0x1cU))));
        bufp->chgBit(oldp+328,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                      >> 0x1bU))));
        bufp->chgCData(oldp+329,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                        >> 0x18U))),3);
        bufp->chgBit(oldp+330,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                      >> 0x17U))));
        bufp->chgBit(oldp+331,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                      >> 0x16U))));
        bufp->chgBit(oldp+332,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                      >> 0x15U))));
        bufp->chgCData(oldp+333,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                        >> 0x13U))),2);
        bufp->chgCData(oldp+334,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                        >> 0x11U))),2);
        bufp->chgBit(oldp+335,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                      >> 0x10U))));
        bufp->chgCData(oldp+336,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                        >> 0xeU))),2);
        bufp->chgBit(oldp+337,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                      >> 0xdU))));
        bufp->chgBit(oldp+338,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                      >> 0xcU))));
        bufp->chgBit(oldp+339,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                      >> 0xbU))));
        bufp->chgCData(oldp+340,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                        >> 8U))),3);
        bufp->chgBit(oldp+341,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                      >> 7U))));
        bufp->chgBit(oldp+342,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                      >> 6U))));
        bufp->chgBit(oldp+343,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                      >> 5U))));
        bufp->chgCData(oldp+344,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                        >> 3U))),2);
        bufp->chgCData(oldp+345,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                        >> 1U))),2);
        bufp->chgBit(oldp+346,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U])));
        bufp->chgCData(oldp+347,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                  >> 0x1eU)),2);
        bufp->chgBit(oldp+348,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                      >> 0x1dU))));
        bufp->chgBit(oldp+349,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                      >> 0x1cU))));
        bufp->chgBit(oldp+350,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                      >> 0x1bU))));
        bufp->chgCData(oldp+351,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                        >> 0x18U))),3);
        bufp->chgBit(oldp+352,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                      >> 0x17U))));
        bufp->chgBit(oldp+353,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                      >> 0x16U))));
        bufp->chgBit(oldp+354,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                      >> 0x15U))));
        bufp->chgCData(oldp+355,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                        >> 0x13U))),2);
        bufp->chgCData(oldp+356,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                        >> 0x11U))),2);
        bufp->chgBit(oldp+357,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                      >> 0x10U))));
        bufp->chgCData(oldp+358,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                        >> 0xeU))),2);
        bufp->chgBit(oldp+359,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                      >> 0xdU))));
        bufp->chgBit(oldp+360,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                      >> 0xcU))));
        bufp->chgBit(oldp+361,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                      >> 0xbU))));
        bufp->chgCData(oldp+362,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                        >> 8U))),3);
        bufp->chgBit(oldp+363,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                      >> 7U))));
        bufp->chgBit(oldp+364,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                      >> 6U))));
        bufp->chgBit(oldp+365,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                      >> 5U))));
        bufp->chgCData(oldp+366,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                        >> 3U))),2);
        bufp->chgCData(oldp+367,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                        >> 1U))),2);
        bufp->chgBit(oldp+368,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U])));
        bufp->chgCData(oldp+369,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                  >> 0x1eU)),2);
        bufp->chgBit(oldp+370,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                      >> 0x1dU))));
        bufp->chgBit(oldp+371,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                      >> 0x1cU))));
        bufp->chgBit(oldp+372,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                      >> 0x1bU))));
        bufp->chgCData(oldp+373,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                        >> 0x18U))),3);
        bufp->chgBit(oldp+374,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                      >> 0x17U))));
        bufp->chgBit(oldp+375,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                      >> 0x16U))));
        bufp->chgBit(oldp+376,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                      >> 0x15U))));
        bufp->chgCData(oldp+377,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                        >> 0x13U))),2);
        bufp->chgCData(oldp+378,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                        >> 0x11U))),2);
        bufp->chgBit(oldp+379,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                      >> 0x10U))));
        bufp->chgCData(oldp+380,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                        >> 0xeU))),2);
        bufp->chgBit(oldp+381,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                      >> 0xdU))));
        bufp->chgBit(oldp+382,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                      >> 0xcU))));
        bufp->chgBit(oldp+383,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                      >> 0xbU))));
        bufp->chgCData(oldp+384,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                        >> 8U))),3);
        bufp->chgBit(oldp+385,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                      >> 7U))));
        bufp->chgBit(oldp+386,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                      >> 6U))));
        bufp->chgBit(oldp+387,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                      >> 5U))));
        bufp->chgCData(oldp+388,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                        >> 3U))),2);
        bufp->chgCData(oldp+389,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                        >> 1U))),2);
        bufp->chgBit(oldp+390,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U])));
        bufp->chgCData(oldp+391,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                  >> 0x1eU)),2);
        bufp->chgBit(oldp+392,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                      >> 0x1dU))));
        bufp->chgBit(oldp+393,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                      >> 0x1cU))));
        bufp->chgBit(oldp+394,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                      >> 0x1bU))));
        bufp->chgCData(oldp+395,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                        >> 0x18U))),3);
        bufp->chgBit(oldp+396,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                      >> 0x17U))));
        bufp->chgBit(oldp+397,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                      >> 0x16U))));
        bufp->chgBit(oldp+398,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                      >> 0x15U))));
        bufp->chgCData(oldp+399,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                        >> 0x13U))),2);
        bufp->chgCData(oldp+400,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                        >> 0x11U))),2);
        bufp->chgBit(oldp+401,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                      >> 0x10U))));
        bufp->chgCData(oldp+402,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                        >> 0xeU))),2);
        bufp->chgBit(oldp+403,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                      >> 0xdU))));
        bufp->chgBit(oldp+404,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                      >> 0xcU))));
        bufp->chgBit(oldp+405,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                      >> 0xbU))));
        bufp->chgCData(oldp+406,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                        >> 8U))),3);
        bufp->chgBit(oldp+407,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                      >> 7U))));
        bufp->chgBit(oldp+408,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                      >> 6U))));
        bufp->chgBit(oldp+409,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                      >> 5U))));
        bufp->chgCData(oldp+410,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                        >> 3U))),2);
        bufp->chgCData(oldp+411,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                        >> 1U))),2);
        bufp->chgBit(oldp+412,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U])));
        bufp->chgCData(oldp+413,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                  >> 0x1eU)),2);
        bufp->chgBit(oldp+414,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                      >> 0x1dU))));
        bufp->chgBit(oldp+415,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                      >> 0x1cU))));
        bufp->chgBit(oldp+416,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                      >> 0x1bU))));
        bufp->chgCData(oldp+417,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                        >> 0x18U))),3);
        bufp->chgBit(oldp+418,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                      >> 0x17U))));
        bufp->chgBit(oldp+419,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                      >> 0x16U))));
        bufp->chgBit(oldp+420,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                      >> 0x15U))));
        bufp->chgCData(oldp+421,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                        >> 0x13U))),2);
        bufp->chgCData(oldp+422,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                        >> 0x11U))),2);
        bufp->chgBit(oldp+423,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                      >> 0x10U))));
        bufp->chgCData(oldp+424,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                        >> 0xeU))),2);
        bufp->chgBit(oldp+425,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                      >> 0xdU))));
        bufp->chgBit(oldp+426,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                      >> 0xcU))));
        bufp->chgBit(oldp+427,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                      >> 0xbU))));
        bufp->chgCData(oldp+428,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                        >> 8U))),3);
        bufp->chgBit(oldp+429,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                      >> 7U))));
        bufp->chgBit(oldp+430,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                      >> 6U))));
        bufp->chgBit(oldp+431,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                      >> 5U))));
        bufp->chgCData(oldp+432,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                        >> 3U))),2);
        bufp->chgCData(oldp+433,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                        >> 1U))),2);
        bufp->chgBit(oldp+434,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U])));
        bufp->chgCData(oldp+435,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                  >> 0x1eU)),2);
        bufp->chgBit(oldp+436,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                      >> 0x1dU))));
        bufp->chgBit(oldp+437,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                      >> 0x1cU))));
        bufp->chgBit(oldp+438,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                      >> 0x1bU))));
        bufp->chgCData(oldp+439,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                        >> 0x18U))),3);
        bufp->chgBit(oldp+440,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                      >> 0x17U))));
        bufp->chgBit(oldp+441,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                      >> 0x16U))));
        bufp->chgBit(oldp+442,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                      >> 0x15U))));
        bufp->chgCData(oldp+443,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                        >> 0x13U))),2);
        bufp->chgCData(oldp+444,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                        >> 0x11U))),2);
        bufp->chgBit(oldp+445,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                      >> 0x10U))));
        bufp->chgCData(oldp+446,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                        >> 0xeU))),2);
        bufp->chgBit(oldp+447,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                      >> 0xdU))));
        bufp->chgBit(oldp+448,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                      >> 0xcU))));
        bufp->chgBit(oldp+449,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                      >> 0xbU))));
        bufp->chgCData(oldp+450,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                        >> 8U))),3);
        bufp->chgBit(oldp+451,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                      >> 7U))));
        bufp->chgBit(oldp+452,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                      >> 6U))));
        bufp->chgBit(oldp+453,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                      >> 5U))));
        bufp->chgCData(oldp+454,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                        >> 3U))),2);
        bufp->chgCData(oldp+455,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                        >> 1U))),2);
        bufp->chgBit(oldp+456,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU])));
        bufp->chgCData(oldp+457,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                  >> 0x1eU)),2);
        bufp->chgBit(oldp+458,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                      >> 0x1dU))));
        bufp->chgBit(oldp+459,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                      >> 0x1cU))));
        bufp->chgBit(oldp+460,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                      >> 0x1bU))));
        bufp->chgCData(oldp+461,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                        >> 0x18U))),3);
        bufp->chgBit(oldp+462,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                      >> 0x17U))));
        bufp->chgBit(oldp+463,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                      >> 0x16U))));
        bufp->chgBit(oldp+464,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                      >> 0x15U))));
        bufp->chgCData(oldp+465,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                        >> 0x13U))),2);
        bufp->chgCData(oldp+466,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                        >> 0x11U))),2);
        bufp->chgBit(oldp+467,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                      >> 0x10U))));
        bufp->chgCData(oldp+468,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                        >> 0xeU))),2);
        bufp->chgBit(oldp+469,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                      >> 0xdU))));
        bufp->chgBit(oldp+470,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                      >> 0xcU))));
        bufp->chgBit(oldp+471,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                      >> 0xbU))));
        bufp->chgCData(oldp+472,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                        >> 8U))),3);
        bufp->chgBit(oldp+473,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                      >> 7U))));
        bufp->chgBit(oldp+474,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                      >> 6U))));
        bufp->chgBit(oldp+475,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                      >> 5U))));
        bufp->chgCData(oldp+476,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                        >> 3U))),2);
        bufp->chgCData(oldp+477,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                        >> 1U))),2);
        bufp->chgBit(oldp+478,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU])));
        bufp->chgCData(oldp+479,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                  >> 0x1eU)),2);
        bufp->chgBit(oldp+480,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                      >> 0x1dU))));
        bufp->chgBit(oldp+481,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                      >> 0x1cU))));
        bufp->chgBit(oldp+482,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                      >> 0x1bU))));
        bufp->chgCData(oldp+483,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                        >> 0x18U))),3);
        bufp->chgBit(oldp+484,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                      >> 0x17U))));
        bufp->chgBit(oldp+485,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                      >> 0x16U))));
        bufp->chgBit(oldp+486,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                      >> 0x15U))));
        bufp->chgCData(oldp+487,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                        >> 0x13U))),2);
        bufp->chgCData(oldp+488,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                        >> 0x11U))),2);
        bufp->chgBit(oldp+489,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                      >> 0x10U))));
        bufp->chgCData(oldp+490,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                        >> 0xeU))),2);
        bufp->chgBit(oldp+491,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                      >> 0xdU))));
        bufp->chgBit(oldp+492,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                      >> 0xcU))));
        bufp->chgBit(oldp+493,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                      >> 0xbU))));
        bufp->chgCData(oldp+494,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                        >> 8U))),3);
        bufp->chgBit(oldp+495,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                      >> 7U))));
        bufp->chgBit(oldp+496,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                      >> 6U))));
        bufp->chgBit(oldp+497,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                      >> 5U))));
        bufp->chgCData(oldp+498,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                        >> 3U))),2);
        bufp->chgCData(oldp+499,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                        >> 1U))),2);
        bufp->chgBit(oldp+500,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU])));
        bufp->chgCData(oldp+501,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                  >> 0x1eU)),2);
        bufp->chgBit(oldp+502,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                      >> 0x1dU))));
        bufp->chgBit(oldp+503,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                      >> 0x1cU))));
        bufp->chgBit(oldp+504,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                      >> 0x1bU))));
        bufp->chgCData(oldp+505,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                        >> 0x18U))),3);
        bufp->chgBit(oldp+506,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                      >> 0x17U))));
        bufp->chgBit(oldp+507,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                      >> 0x16U))));
        bufp->chgBit(oldp+508,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                      >> 0x15U))));
        bufp->chgCData(oldp+509,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                        >> 0x13U))),2);
        bufp->chgCData(oldp+510,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                        >> 0x11U))),2);
        bufp->chgBit(oldp+511,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                      >> 0x10U))));
        bufp->chgCData(oldp+512,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                        >> 0xeU))),2);
        bufp->chgBit(oldp+513,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                      >> 0xdU))));
        bufp->chgBit(oldp+514,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                      >> 0xcU))));
        bufp->chgBit(oldp+515,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                      >> 0xbU))));
        bufp->chgCData(oldp+516,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                        >> 8U))),3);
        bufp->chgBit(oldp+517,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                      >> 7U))));
        bufp->chgBit(oldp+518,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                      >> 6U))));
        bufp->chgBit(oldp+519,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                      >> 5U))));
        bufp->chgCData(oldp+520,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                        >> 3U))),2);
        bufp->chgCData(oldp+521,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                        >> 1U))),2);
        bufp->chgBit(oldp+522,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU])));
        bufp->chgCData(oldp+523,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                  >> 0x1eU)),2);
        bufp->chgBit(oldp+524,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                      >> 0x1dU))));
        bufp->chgBit(oldp+525,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                      >> 0x1cU))));
        bufp->chgBit(oldp+526,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                      >> 0x1bU))));
        bufp->chgCData(oldp+527,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                        >> 0x18U))),3);
        bufp->chgBit(oldp+528,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                      >> 0x17U))));
        bufp->chgBit(oldp+529,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                      >> 0x16U))));
        bufp->chgBit(oldp+530,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                      >> 0x15U))));
        bufp->chgCData(oldp+531,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                        >> 0x13U))),2);
        bufp->chgCData(oldp+532,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                        >> 0x11U))),2);
        bufp->chgBit(oldp+533,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                      >> 0x10U))));
        bufp->chgCData(oldp+534,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                        >> 0xeU))),2);
        bufp->chgBit(oldp+535,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                      >> 0xdU))));
        bufp->chgBit(oldp+536,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                      >> 0xcU))));
        bufp->chgBit(oldp+537,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                      >> 0xbU))));
        bufp->chgCData(oldp+538,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                        >> 8U))),3);
        bufp->chgBit(oldp+539,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                      >> 7U))));
        bufp->chgBit(oldp+540,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                      >> 6U))));
        bufp->chgBit(oldp+541,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                      >> 5U))));
        bufp->chgCData(oldp+542,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                        >> 3U))),2);
        bufp->chgCData(oldp+543,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                        >> 1U))),2);
        bufp->chgBit(oldp+544,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU])));
        bufp->chgCData(oldp+545,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                  >> 0x1eU)),2);
        bufp->chgBit(oldp+546,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                      >> 0x1dU))));
        bufp->chgBit(oldp+547,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                      >> 0x1cU))));
        bufp->chgBit(oldp+548,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                      >> 0x1bU))));
        bufp->chgCData(oldp+549,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                        >> 0x18U))),3);
        bufp->chgBit(oldp+550,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                      >> 0x17U))));
        bufp->chgBit(oldp+551,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                      >> 0x16U))));
        bufp->chgBit(oldp+552,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                      >> 0x15U))));
        bufp->chgCData(oldp+553,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                        >> 0x13U))),2);
        bufp->chgCData(oldp+554,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                        >> 0x11U))),2);
        bufp->chgBit(oldp+555,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                      >> 0x10U))));
        bufp->chgCData(oldp+556,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                        >> 0xeU))),2);
        bufp->chgBit(oldp+557,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                      >> 0xdU))));
        bufp->chgBit(oldp+558,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                      >> 0xcU))));
        bufp->chgBit(oldp+559,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                      >> 0xbU))));
        bufp->chgCData(oldp+560,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                        >> 8U))),3);
        bufp->chgBit(oldp+561,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                      >> 7U))));
        bufp->chgBit(oldp+562,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                      >> 6U))));
        bufp->chgBit(oldp+563,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                      >> 5U))));
        bufp->chgCData(oldp+564,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                        >> 3U))),2);
        bufp->chgCData(oldp+565,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                        >> 1U))),2);
        bufp->chgBit(oldp+566,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU])));
        bufp->chgCData(oldp+567,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                  >> 0x1eU)),2);
        bufp->chgBit(oldp+568,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                      >> 0x1dU))));
        bufp->chgBit(oldp+569,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                      >> 0x1cU))));
        bufp->chgBit(oldp+570,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                      >> 0x1bU))));
        bufp->chgCData(oldp+571,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                        >> 0x18U))),3);
        bufp->chgBit(oldp+572,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                      >> 0x17U))));
        bufp->chgBit(oldp+573,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                      >> 0x16U))));
        bufp->chgBit(oldp+574,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                      >> 0x15U))));
        bufp->chgCData(oldp+575,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                        >> 0x13U))),2);
        bufp->chgCData(oldp+576,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                        >> 0x11U))),2);
        bufp->chgBit(oldp+577,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                      >> 0x10U))));
        bufp->chgCData(oldp+578,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                        >> 0xeU))),2);
        bufp->chgBit(oldp+579,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                      >> 0xdU))));
        bufp->chgBit(oldp+580,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                      >> 0xcU))));
        bufp->chgBit(oldp+581,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                      >> 0xbU))));
        bufp->chgCData(oldp+582,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                        >> 8U))),3);
        bufp->chgBit(oldp+583,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                      >> 7U))));
        bufp->chgBit(oldp+584,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                      >> 6U))));
        bufp->chgBit(oldp+585,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                      >> 5U))));
        bufp->chgCData(oldp+586,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                        >> 3U))),2);
        bufp->chgCData(oldp+587,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                        >> 1U))),2);
        bufp->chgBit(oldp+588,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val)));
        bufp->chgBit(oldp+589,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                      >> 7U))));
        bufp->chgCData(oldp+590,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                        >> 5U))),2);
        bufp->chgCData(oldp+591,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                        >> 3U))),2);
        bufp->chgBit(oldp+592,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                      >> 2U))));
        bufp->chgBit(oldp+593,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                      >> 1U))));
        bufp->chgBit(oldp+594,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U])));
        bufp->chgBit(oldp+595,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                      >> 0xfU))));
        bufp->chgCData(oldp+596,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                        >> 0xdU))),2);
        bufp->chgCData(oldp+597,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                        >> 0xbU))),2);
        bufp->chgBit(oldp+598,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                      >> 0xaU))));
        bufp->chgBit(oldp+599,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                      >> 9U))));
        bufp->chgBit(oldp+600,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                      >> 8U))));
        bufp->chgBit(oldp+601,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                      >> 0x17U))));
        bufp->chgCData(oldp+602,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                        >> 0x15U))),2);
        bufp->chgCData(oldp+603,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                        >> 0x13U))),2);
        bufp->chgBit(oldp+604,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                      >> 0x12U))));
        bufp->chgBit(oldp+605,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                      >> 0x11U))));
        bufp->chgBit(oldp+606,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                      >> 0x10U))));
        bufp->chgBit(oldp+607,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                >> 0x1fU)));
        bufp->chgCData(oldp+608,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                        >> 0x1dU))),2);
        bufp->chgCData(oldp+609,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                        >> 0x1bU))),2);
        bufp->chgBit(oldp+610,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                      >> 0x1aU))));
        bufp->chgBit(oldp+611,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                      >> 0x19U))));
        bufp->chgBit(oldp+612,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                      >> 0x18U))));
        bufp->chgBit(oldp+613,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                      >> 7U))));
        bufp->chgCData(oldp+614,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                        >> 5U))),2);
        bufp->chgCData(oldp+615,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                        >> 3U))),2);
        bufp->chgBit(oldp+616,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                      >> 2U))));
        bufp->chgBit(oldp+617,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                      >> 1U))));
        bufp->chgBit(oldp+618,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U])));
        bufp->chgBit(oldp+619,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                      >> 0xfU))));
        bufp->chgCData(oldp+620,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                        >> 0xdU))),2);
        bufp->chgCData(oldp+621,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                        >> 0xbU))),2);
        bufp->chgBit(oldp+622,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                      >> 0xaU))));
        bufp->chgBit(oldp+623,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                      >> 9U))));
        bufp->chgBit(oldp+624,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                      >> 8U))));
        bufp->chgBit(oldp+625,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                      >> 0x17U))));
        bufp->chgCData(oldp+626,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                        >> 0x15U))),2);
        bufp->chgCData(oldp+627,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                        >> 0x13U))),2);
        bufp->chgBit(oldp+628,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                      >> 0x12U))));
        bufp->chgBit(oldp+629,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                      >> 0x11U))));
        bufp->chgBit(oldp+630,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                      >> 0x10U))));
        bufp->chgBit(oldp+631,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                >> 0x1fU)));
        bufp->chgCData(oldp+632,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                        >> 0x1dU))),2);
        bufp->chgCData(oldp+633,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                        >> 0x1bU))),2);
        bufp->chgBit(oldp+634,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                      >> 0x1aU))));
        bufp->chgBit(oldp+635,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                      >> 0x19U))));
        bufp->chgBit(oldp+636,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                      >> 0x18U))));
        bufp->chgBit(oldp+637,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                      >> 7U))));
        bufp->chgCData(oldp+638,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                        >> 5U))),2);
        bufp->chgCData(oldp+639,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                        >> 3U))),2);
        bufp->chgBit(oldp+640,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                      >> 2U))));
        bufp->chgBit(oldp+641,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                      >> 1U))));
        bufp->chgBit(oldp+642,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U])));
        bufp->chgBit(oldp+643,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                      >> 0xfU))));
        bufp->chgCData(oldp+644,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                        >> 0xdU))),2);
        bufp->chgCData(oldp+645,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                        >> 0xbU))),2);
        bufp->chgBit(oldp+646,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                      >> 0xaU))));
        bufp->chgBit(oldp+647,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                      >> 9U))));
        bufp->chgBit(oldp+648,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                      >> 8U))));
        bufp->chgBit(oldp+649,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                      >> 0x17U))));
        bufp->chgCData(oldp+650,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                        >> 0x15U))),2);
        bufp->chgCData(oldp+651,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                        >> 0x13U))),2);
        bufp->chgBit(oldp+652,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                      >> 0x12U))));
        bufp->chgBit(oldp+653,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                      >> 0x11U))));
        bufp->chgBit(oldp+654,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                      >> 0x10U))));
        bufp->chgBit(oldp+655,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                >> 0x1fU)));
        bufp->chgCData(oldp+656,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                        >> 0x1dU))),2);
        bufp->chgCData(oldp+657,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                        >> 0x1bU))),2);
        bufp->chgBit(oldp+658,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                      >> 0x1aU))));
        bufp->chgBit(oldp+659,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                      >> 0x19U))));
        bufp->chgBit(oldp+660,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                      >> 0x18U))));
        bufp->chgBit(oldp+661,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                      >> 7U))));
        bufp->chgCData(oldp+662,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                        >> 5U))),2);
        bufp->chgCData(oldp+663,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                        >> 3U))),2);
        bufp->chgBit(oldp+664,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                      >> 2U))));
        bufp->chgBit(oldp+665,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                      >> 1U))));
        bufp->chgBit(oldp+666,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U])));
        bufp->chgBit(oldp+667,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                      >> 0xfU))));
        bufp->chgCData(oldp+668,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                        >> 0xdU))),2);
        bufp->chgCData(oldp+669,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                        >> 0xbU))),2);
        bufp->chgBit(oldp+670,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                      >> 0xaU))));
        bufp->chgBit(oldp+671,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                      >> 9U))));
        bufp->chgBit(oldp+672,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                      >> 8U))));
        bufp->chgBit(oldp+673,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                      >> 0x17U))));
        bufp->chgCData(oldp+674,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                        >> 0x15U))),2);
        bufp->chgCData(oldp+675,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                        >> 0x13U))),2);
        bufp->chgBit(oldp+676,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                      >> 0x12U))));
        bufp->chgBit(oldp+677,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                      >> 0x11U))));
        bufp->chgBit(oldp+678,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                      >> 0x10U))));
        bufp->chgBit(oldp+679,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                >> 0x1fU)));
        bufp->chgCData(oldp+680,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                        >> 0x1dU))),2);
        bufp->chgCData(oldp+681,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                        >> 0x1bU))),2);
        bufp->chgBit(oldp+682,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                      >> 0x1aU))));
        bufp->chgBit(oldp+683,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                      >> 0x19U))));
        bufp->chgBit(oldp+684,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                      >> 0x18U))));
        bufp->chgIData(oldp+685,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[0U]),32);
        bufp->chgIData(oldp+686,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[1U]),32);
        bufp->chgIData(oldp+687,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[2U]),32);
        bufp->chgIData(oldp+688,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[3U]),32);
        bufp->chgIData(oldp+689,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[4U]),32);
        bufp->chgIData(oldp+690,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[5U]),32);
        bufp->chgIData(oldp+691,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[6U]),32);
        bufp->chgIData(oldp+692,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[7U]),32);
        bufp->chgIData(oldp+693,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[8U]),32);
        bufp->chgIData(oldp+694,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[9U]),32);
        bufp->chgIData(oldp+695,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[0xaU]),32);
        bufp->chgIData(oldp+696,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[0xbU]),32);
        bufp->chgIData(oldp+697,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[0xcU]),32);
        bufp->chgIData(oldp+698,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[0xdU]),32);
        bufp->chgIData(oldp+699,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[0xeU]),32);
        bufp->chgIData(oldp+700,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[0xfU]),32);
        bufp->chgBit(oldp+701,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                      >> 7U))));
        bufp->chgCData(oldp+702,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                        >> 5U))),2);
        bufp->chgCData(oldp+703,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                        >> 3U))),2);
        bufp->chgBit(oldp+704,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                      >> 2U))));
        bufp->chgBit(oldp+705,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                      >> 1U))));
        bufp->chgBit(oldp+706,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg)));
        bufp->chgBit(oldp+707,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                      >> 0xfU))));
        bufp->chgCData(oldp+708,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                        >> 0xdU))),2);
        bufp->chgCData(oldp+709,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                        >> 0xbU))),2);
        bufp->chgBit(oldp+710,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                      >> 0xaU))));
        bufp->chgBit(oldp+711,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                      >> 9U))));
        bufp->chgBit(oldp+712,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                      >> 8U))));
        bufp->chgBit(oldp+713,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                      >> 0x17U))));
        bufp->chgCData(oldp+714,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                        >> 0x15U))),2);
        bufp->chgCData(oldp+715,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                        >> 0x13U))),2);
        bufp->chgBit(oldp+716,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                      >> 0x12U))));
        bufp->chgBit(oldp+717,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                      >> 0x11U))));
        bufp->chgBit(oldp+718,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                      >> 0x10U))));
        bufp->chgBit(oldp+719,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                >> 0x1fU)));
        bufp->chgCData(oldp+720,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                        >> 0x1dU))),2);
        bufp->chgCData(oldp+721,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                        >> 0x1bU))),2);
        bufp->chgBit(oldp+722,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                      >> 0x1aU))));
        bufp->chgBit(oldp+723,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                      >> 0x19U))));
        bufp->chgBit(oldp+724,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                      >> 0x18U))));
        bufp->chgBit(oldp+725,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_flush_idx) 
                                      >> 5U))));
        bufp->chgCData(oldp+726,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_flush_idx) 
                                        >> 3U))),2);
        bufp->chgCData(oldp+727,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_flush_idx) 
                                        >> 1U))),2);
        bufp->chgBit(oldp+728,((1U & (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_flush_idx))));
        bufp->chgBit(oldp+729,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__enable_flush_count));
        bufp->chgIData(oldp+730,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_state),32);
        bufp->chgCData(oldp+731,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx),2);
        bufp->chgIData(oldp+732,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_read_addr),32);
        bufp->chgIData(oldp+733,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_decoded_req_addr 
                                  >> 5U)),27);
        bufp->chgCData(oldp+734,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_decoded_req_addr 
                                        >> 3U))),2);
        bufp->chgBit(oldp+735,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_decoded_req_addr 
                                      >> 2U))));
        bufp->chgCData(oldp+736,((3U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_decoded_req_addr)),2);
        bufp->chgBit(oldp+737,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[2U] 
                                      >> 0x1cU))));
        bufp->chgBit(oldp+738,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[2U] 
                                      >> 0x1bU))));
        bufp->chgIData(oldp+739,((0x7ffffffU & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[2U])),27);
        bufp->chgIData(oldp+740,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[0U]),32);
        bufp->chgIData(oldp+741,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[1U]),32);
        bufp->chgBit(oldp+742,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[5U] 
                                      >> 0x19U))));
        bufp->chgBit(oldp+743,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[5U] 
                                      >> 0x18U))));
        bufp->chgIData(oldp+744,((0x7ffffffU & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[5U] 
                                                 << 3U) 
                                                | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[4U] 
                                                   >> 0x1dU)))),27);
        bufp->chgIData(oldp+745,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[3U] 
                                   << 3U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[2U] 
                                             >> 0x1dU))),32);
        bufp->chgIData(oldp+746,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[4U] 
                                   << 3U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[3U] 
                                             >> 0x1dU))),32);
        bufp->chgBit(oldp+747,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[8U] 
                                      >> 0x16U))));
        bufp->chgBit(oldp+748,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[8U] 
                                      >> 0x15U))));
        bufp->chgIData(oldp+749,((0x7ffffffU & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[8U] 
                                                 << 6U) 
                                                | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[7U] 
                                                   >> 0x1aU)))),27);
        bufp->chgIData(oldp+750,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[6U] 
                                   << 6U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[5U] 
                                             >> 0x1aU))),32);
        bufp->chgIData(oldp+751,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[7U] 
                                   << 6U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[6U] 
                                             >> 0x1aU))),32);
        bufp->chgBit(oldp+752,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[0xbU] 
                                      >> 0x13U))));
        bufp->chgBit(oldp+753,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[0xbU] 
                                      >> 0x12U))));
        bufp->chgIData(oldp+754,((0x7ffffffU & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[0xbU] 
                                                 << 9U) 
                                                | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[0xaU] 
                                                   >> 0x17U)))),27);
        bufp->chgIData(oldp+755,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[9U] 
                                   << 9U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[8U] 
                                             >> 0x17U))),32);
        bufp->chgIData(oldp+756,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[0xaU] 
                                   << 9U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[9U] 
                                             >> 0x17U))),32);
        bufp->chgBit(oldp+757,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[2U] 
                                      >> 0x1cU))));
        bufp->chgBit(oldp+758,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[2U] 
                                      >> 0x1bU))));
        bufp->chgIData(oldp+759,((0x7ffffffU & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[2U])),27);
        bufp->chgIData(oldp+760,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[0U]),32);
        bufp->chgIData(oldp+761,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[1U]),32);
        bufp->chgBit(oldp+762,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[5U] 
                                      >> 0x19U))));
        bufp->chgBit(oldp+763,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[5U] 
                                      >> 0x18U))));
        bufp->chgIData(oldp+764,((0x7ffffffU & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[5U] 
                                                 << 3U) 
                                                | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[4U] 
                                                   >> 0x1dU)))),27);
        bufp->chgIData(oldp+765,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[3U] 
                                   << 3U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[2U] 
                                             >> 0x1dU))),32);
        bufp->chgIData(oldp+766,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[4U] 
                                   << 3U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[3U] 
                                             >> 0x1dU))),32);
        bufp->chgBit(oldp+767,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[8U] 
                                      >> 0x16U))));
        bufp->chgBit(oldp+768,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[8U] 
                                      >> 0x15U))));
        bufp->chgIData(oldp+769,((0x7ffffffU & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[8U] 
                                                 << 6U) 
                                                | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[7U] 
                                                   >> 0x1aU)))),27);
        bufp->chgIData(oldp+770,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[6U] 
                                   << 6U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[5U] 
                                             >> 0x1aU))),32);
        bufp->chgIData(oldp+771,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[7U] 
                                   << 6U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[6U] 
                                             >> 0x1aU))),32);
        bufp->chgBit(oldp+772,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[0xbU] 
                                      >> 0x13U))));
        bufp->chgBit(oldp+773,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[0xbU] 
                                      >> 0x12U))));
        bufp->chgIData(oldp+774,((0x7ffffffU & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[0xbU] 
                                                 << 9U) 
                                                | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[0xaU] 
                                                   >> 0x17U)))),27);
        bufp->chgIData(oldp+775,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[9U] 
                                   << 9U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[8U] 
                                             >> 0x17U))),32);
        bufp->chgIData(oldp+776,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[0xaU] 
                                   << 9U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[9U] 
                                             >> 0x17U))),32);
        bufp->chgBit(oldp+777,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWEN));
        bufp->chgWData(oldp+778,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite),372);
        bufp->chgWData(oldp+790,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask),372);
        __Vtemp_hd57fe25b__0[0U] = (Vtop_core__ConstPool__CONST_h1b548564_0[0U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0U]);
        __Vtemp_hd57fe25b__0[1U] = (Vtop_core__ConstPool__CONST_h1b548564_0[1U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[1U]);
        __Vtemp_hd57fe25b__0[2U] = (Vtop_core__ConstPool__CONST_h1b548564_0[2U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[2U]);
        __Vtemp_hd57fe25b__0[3U] = (Vtop_core__ConstPool__CONST_h1b548564_0[3U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[3U]);
        __Vtemp_hd57fe25b__0[4U] = (Vtop_core__ConstPool__CONST_h1b548564_0[4U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[4U]);
        __Vtemp_hd57fe25b__0[5U] = (Vtop_core__ConstPool__CONST_h1b548564_0[5U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[5U]);
        __Vtemp_hd57fe25b__0[6U] = (Vtop_core__ConstPool__CONST_h1b548564_0[6U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[6U]);
        __Vtemp_hd57fe25b__0[7U] = (Vtop_core__ConstPool__CONST_h1b548564_0[7U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[7U]);
        __Vtemp_hd57fe25b__0[8U] = (Vtop_core__ConstPool__CONST_h1b548564_0[8U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[8U]);
        __Vtemp_hd57fe25b__0[9U] = (Vtop_core__ConstPool__CONST_h1b548564_0[9U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[9U]);
        __Vtemp_hd57fe25b__0[0xaU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xaU] 
                                      & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0xaU]);
        __Vtemp_hd57fe25b__0[0xbU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xbU] 
                                      & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0xbU]);
        bufp->chgWData(oldp+802,(__Vtemp_hd57fe25b__0),372);
        __Vtemp_hb8fad44c__0[0U] = (Vtop_core__ConstPool__CONST_h1b548564_0[0U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0xcU] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0xbU] 
                                        >> 0x14U)));
        __Vtemp_hb8fad44c__0[1U] = (Vtop_core__ConstPool__CONST_h1b548564_0[1U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0xdU] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0xcU] 
                                        >> 0x14U)));
        __Vtemp_hb8fad44c__0[2U] = (Vtop_core__ConstPool__CONST_h1b548564_0[2U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0xeU] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0xdU] 
                                        >> 0x14U)));
        __Vtemp_hb8fad44c__0[3U] = (Vtop_core__ConstPool__CONST_h1b548564_0[3U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0xfU] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0xeU] 
                                        >> 0x14U)));
        __Vtemp_hb8fad44c__0[4U] = (Vtop_core__ConstPool__CONST_h1b548564_0[4U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x10U] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0xfU] 
                                        >> 0x14U)));
        __Vtemp_hb8fad44c__0[5U] = (Vtop_core__ConstPool__CONST_h1b548564_0[5U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x11U] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x10U] 
                                        >> 0x14U)));
        __Vtemp_hb8fad44c__0[6U] = (Vtop_core__ConstPool__CONST_h1b548564_0[6U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x12U] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x11U] 
                                        >> 0x14U)));
        __Vtemp_hb8fad44c__0[7U] = (Vtop_core__ConstPool__CONST_h1b548564_0[7U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x13U] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x12U] 
                                        >> 0x14U)));
        __Vtemp_hb8fad44c__0[8U] = (Vtop_core__ConstPool__CONST_h1b548564_0[8U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x14U] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x13U] 
                                        >> 0x14U)));
        __Vtemp_hb8fad44c__0[9U] = (Vtop_core__ConstPool__CONST_h1b548564_0[9U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x15U] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x14U] 
                                        >> 0x14U)));
        __Vtemp_hb8fad44c__0[0xaU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xaU] 
                                      & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x16U] 
                                          << 0xcU) 
                                         | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x15U] 
                                            >> 0x14U)));
        __Vtemp_hb8fad44c__0[0xbU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xbU] 
                                      & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x17U] 
                                          << 0xcU) 
                                         | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x16U] 
                                            >> 0x14U)));
        bufp->chgWData(oldp+814,(__Vtemp_hb8fad44c__0),372);
        __Vtemp_h832f242f__0[0U] = (Vtop_core__ConstPool__CONST_h1b548564_0[0U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x18U] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x17U] 
                                        >> 8U)));
        __Vtemp_h832f242f__0[1U] = (Vtop_core__ConstPool__CONST_h1b548564_0[1U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x19U] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x18U] 
                                        >> 8U)));
        __Vtemp_h832f242f__0[2U] = (Vtop_core__ConstPool__CONST_h1b548564_0[2U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x1aU] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x19U] 
                                        >> 8U)));
        __Vtemp_h832f242f__0[3U] = (Vtop_core__ConstPool__CONST_h1b548564_0[3U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x1bU] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x1aU] 
                                        >> 8U)));
        __Vtemp_h832f242f__0[4U] = (Vtop_core__ConstPool__CONST_h1b548564_0[4U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x1cU] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x1bU] 
                                        >> 8U)));
        __Vtemp_h832f242f__0[5U] = (Vtop_core__ConstPool__CONST_h1b548564_0[5U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x1dU] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x1cU] 
                                        >> 8U)));
        __Vtemp_h832f242f__0[6U] = (Vtop_core__ConstPool__CONST_h1b548564_0[6U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x1eU] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x1dU] 
                                        >> 8U)));
        __Vtemp_h832f242f__0[7U] = (Vtop_core__ConstPool__CONST_h1b548564_0[7U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x1fU] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x1eU] 
                                        >> 8U)));
        __Vtemp_h832f242f__0[8U] = (Vtop_core__ConstPool__CONST_h1b548564_0[8U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x20U] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x1fU] 
                                        >> 8U)));
        __Vtemp_h832f242f__0[9U] = (Vtop_core__ConstPool__CONST_h1b548564_0[9U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x21U] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x20U] 
                                        >> 8U)));
        __Vtemp_h832f242f__0[0xaU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xaU] 
                                      & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x22U] 
                                          << 0x18U) 
                                         | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x21U] 
                                            >> 8U)));
        __Vtemp_h832f242f__0[0xbU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xbU] 
                                      & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x23U] 
                                          << 0x18U) 
                                         | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x22U] 
                                            >> 8U)));
        bufp->chgWData(oldp+826,(__Vtemp_h832f242f__0),372);
        __Vtemp_h66a8f596__0[0U] = (Vtop_core__ConstPool__CONST_h1b548564_0[0U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x23U] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x22U] 
                                                  >> 0x1cU)));
        __Vtemp_h66a8f596__0[1U] = (Vtop_core__ConstPool__CONST_h1b548564_0[1U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x24U] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x23U] 
                                                  >> 0x1cU)));
        __Vtemp_h66a8f596__0[2U] = (Vtop_core__ConstPool__CONST_h1b548564_0[2U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x25U] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x24U] 
                                                  >> 0x1cU)));
        __Vtemp_h66a8f596__0[3U] = (Vtop_core__ConstPool__CONST_h1b548564_0[3U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x26U] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x25U] 
                                                  >> 0x1cU)));
        __Vtemp_h66a8f596__0[4U] = (Vtop_core__ConstPool__CONST_h1b548564_0[4U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x27U] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x26U] 
                                                  >> 0x1cU)));
        __Vtemp_h66a8f596__0[5U] = (Vtop_core__ConstPool__CONST_h1b548564_0[5U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x28U] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x27U] 
                                                  >> 0x1cU)));
        __Vtemp_h66a8f596__0[6U] = (Vtop_core__ConstPool__CONST_h1b548564_0[6U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x29U] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x28U] 
                                                  >> 0x1cU)));
        __Vtemp_h66a8f596__0[7U] = (Vtop_core__ConstPool__CONST_h1b548564_0[7U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x2aU] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x29U] 
                                                  >> 0x1cU)));
        __Vtemp_h66a8f596__0[8U] = (Vtop_core__ConstPool__CONST_h1b548564_0[8U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x2bU] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x2aU] 
                                                  >> 0x1cU)));
        __Vtemp_h66a8f596__0[9U] = (Vtop_core__ConstPool__CONST_h1b548564_0[9U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x2cU] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x2bU] 
                                                  >> 0x1cU)));
        __Vtemp_h66a8f596__0[0xaU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xaU] 
                                      & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x2dU] 
                                          << 4U) | 
                                         (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x2cU] 
                                          >> 0x1cU)));
        __Vtemp_h66a8f596__0[0xbU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xbU] 
                                      & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x2eU] 
                                          << 4U) | 
                                         (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x2dU] 
                                          >> 0x1cU)));
        bufp->chgWData(oldp+838,(__Vtemp_h66a8f596__0),372);
        bufp->chgBit(oldp+850,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_flush_idx) 
                                      >> 5U))));
        bufp->chgCData(oldp+851,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_flush_idx) 
                                        >> 3U))),2);
        bufp->chgCData(oldp+852,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_flush_idx) 
                                        >> 1U))),2);
        bufp->chgBit(oldp+853,((1U & (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_flush_idx))));
        bufp->chgBit(oldp+854,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__enable_flush_count));
        bufp->chgIData(oldp+855,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_state),32);
        bufp->chgCData(oldp+856,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx),2);
        bufp->chgCData(oldp+857,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_last_used),2);
        bufp->chgIData(oldp+858,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_read_addr),32);
        bufp->chgIData(oldp+859,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_decoded_req_addr 
                                  >> 5U)),27);
        bufp->chgCData(oldp+860,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_decoded_req_addr 
                                        >> 3U))),2);
        bufp->chgBit(oldp+861,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_decoded_req_addr 
                                      >> 2U))));
        bufp->chgCData(oldp+862,((3U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_decoded_req_addr)),2);
        bufp->chgBit(oldp+863,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[2U] 
                                      >> 0x1cU))));
        bufp->chgBit(oldp+864,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[2U] 
                                      >> 0x1bU))));
        bufp->chgIData(oldp+865,((0x7ffffffU & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[2U])),27);
        bufp->chgIData(oldp+866,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[0U]),32);
        bufp->chgIData(oldp+867,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[1U]),32);
        bufp->chgBit(oldp+868,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[5U] 
                                      >> 0x19U))));
        bufp->chgBit(oldp+869,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[5U] 
                                      >> 0x18U))));
        bufp->chgIData(oldp+870,((0x7ffffffU & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[5U] 
                                                 << 3U) 
                                                | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[4U] 
                                                   >> 0x1dU)))),27);
        bufp->chgIData(oldp+871,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[3U] 
                                   << 3U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[2U] 
                                             >> 0x1dU))),32);
        bufp->chgIData(oldp+872,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[4U] 
                                   << 3U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[3U] 
                                             >> 0x1dU))),32);
        bufp->chgBit(oldp+873,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[8U] 
                                      >> 0x16U))));
        bufp->chgBit(oldp+874,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[8U] 
                                      >> 0x15U))));
        bufp->chgIData(oldp+875,((0x7ffffffU & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[8U] 
                                                 << 6U) 
                                                | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[7U] 
                                                   >> 0x1aU)))),27);
        bufp->chgIData(oldp+876,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[6U] 
                                   << 6U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[5U] 
                                             >> 0x1aU))),32);
        bufp->chgIData(oldp+877,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[7U] 
                                   << 6U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[6U] 
                                             >> 0x1aU))),32);
        bufp->chgBit(oldp+878,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[0xbU] 
                                      >> 0x13U))));
        bufp->chgBit(oldp+879,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[0xbU] 
                                      >> 0x12U))));
        bufp->chgIData(oldp+880,((0x7ffffffU & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[0xbU] 
                                                 << 9U) 
                                                | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[0xaU] 
                                                   >> 0x17U)))),27);
        bufp->chgIData(oldp+881,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[9U] 
                                   << 9U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[8U] 
                                             >> 0x17U))),32);
        bufp->chgIData(oldp+882,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[0xaU] 
                                   << 9U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[9U] 
                                             >> 0x17U))),32);
        bufp->chgBit(oldp+883,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[2U] 
                                      >> 0x1cU))));
        bufp->chgBit(oldp+884,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[2U] 
                                      >> 0x1bU))));
        bufp->chgIData(oldp+885,((0x7ffffffU & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[2U])),27);
        bufp->chgIData(oldp+886,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[0U]),32);
        bufp->chgIData(oldp+887,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[1U]),32);
        bufp->chgBit(oldp+888,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[5U] 
                                      >> 0x19U))));
        bufp->chgBit(oldp+889,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[5U] 
                                      >> 0x18U))));
        bufp->chgIData(oldp+890,((0x7ffffffU & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[5U] 
                                                 << 3U) 
                                                | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[4U] 
                                                   >> 0x1dU)))),27);
        bufp->chgIData(oldp+891,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[3U] 
                                   << 3U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[2U] 
                                             >> 0x1dU))),32);
        bufp->chgIData(oldp+892,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[4U] 
                                   << 3U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[3U] 
                                             >> 0x1dU))),32);
        bufp->chgBit(oldp+893,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[8U] 
                                      >> 0x16U))));
        bufp->chgBit(oldp+894,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[8U] 
                                      >> 0x15U))));
        bufp->chgIData(oldp+895,((0x7ffffffU & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[8U] 
                                                 << 6U) 
                                                | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[7U] 
                                                   >> 0x1aU)))),27);
        bufp->chgIData(oldp+896,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[6U] 
                                   << 6U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[5U] 
                                             >> 0x1aU))),32);
        bufp->chgIData(oldp+897,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[7U] 
                                   << 6U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[6U] 
                                             >> 0x1aU))),32);
        bufp->chgBit(oldp+898,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[0xbU] 
                                      >> 0x13U))));
        bufp->chgBit(oldp+899,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[0xbU] 
                                      >> 0x12U))));
        bufp->chgIData(oldp+900,((0x7ffffffU & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[0xbU] 
                                                 << 9U) 
                                                | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[0xaU] 
                                                   >> 0x17U)))),27);
        bufp->chgIData(oldp+901,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[9U] 
                                   << 9U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[8U] 
                                             >> 0x17U))),32);
        bufp->chgIData(oldp+902,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[0xaU] 
                                   << 9U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[9U] 
                                             >> 0x17U))),32);
        bufp->chgBit(oldp+903,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWEN));
        bufp->chgWData(oldp+904,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite),372);
        bufp->chgWData(oldp+916,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask),372);
        __Vtemp_h42528074__0[0U] = (Vtop_core__ConstPool__CONST_h1b548564_0[0U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0U]);
        __Vtemp_h42528074__0[1U] = (Vtop_core__ConstPool__CONST_h1b548564_0[1U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[1U]);
        __Vtemp_h42528074__0[2U] = (Vtop_core__ConstPool__CONST_h1b548564_0[2U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[2U]);
        __Vtemp_h42528074__0[3U] = (Vtop_core__ConstPool__CONST_h1b548564_0[3U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[3U]);
        __Vtemp_h42528074__0[4U] = (Vtop_core__ConstPool__CONST_h1b548564_0[4U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[4U]);
        __Vtemp_h42528074__0[5U] = (Vtop_core__ConstPool__CONST_h1b548564_0[5U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[5U]);
        __Vtemp_h42528074__0[6U] = (Vtop_core__ConstPool__CONST_h1b548564_0[6U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[6U]);
        __Vtemp_h42528074__0[7U] = (Vtop_core__ConstPool__CONST_h1b548564_0[7U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[7U]);
        __Vtemp_h42528074__0[8U] = (Vtop_core__ConstPool__CONST_h1b548564_0[8U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[8U]);
        __Vtemp_h42528074__0[9U] = (Vtop_core__ConstPool__CONST_h1b548564_0[9U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[9U]);
        __Vtemp_h42528074__0[0xaU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xaU] 
                                      & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0xaU]);
        __Vtemp_h42528074__0[0xbU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xbU] 
                                      & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0xbU]);
        bufp->chgWData(oldp+928,(__Vtemp_h42528074__0),372);
        __Vtemp_hca760406__0[0U] = (Vtop_core__ConstPool__CONST_h1b548564_0[0U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0xcU] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0xbU] 
                                        >> 0x14U)));
        __Vtemp_hca760406__0[1U] = (Vtop_core__ConstPool__CONST_h1b548564_0[1U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0xdU] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0xcU] 
                                        >> 0x14U)));
        __Vtemp_hca760406__0[2U] = (Vtop_core__ConstPool__CONST_h1b548564_0[2U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0xeU] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0xdU] 
                                        >> 0x14U)));
        __Vtemp_hca760406__0[3U] = (Vtop_core__ConstPool__CONST_h1b548564_0[3U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0xfU] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0xeU] 
                                        >> 0x14U)));
        __Vtemp_hca760406__0[4U] = (Vtop_core__ConstPool__CONST_h1b548564_0[4U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x10U] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0xfU] 
                                        >> 0x14U)));
        __Vtemp_hca760406__0[5U] = (Vtop_core__ConstPool__CONST_h1b548564_0[5U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x11U] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x10U] 
                                        >> 0x14U)));
        __Vtemp_hca760406__0[6U] = (Vtop_core__ConstPool__CONST_h1b548564_0[6U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x12U] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x11U] 
                                        >> 0x14U)));
        __Vtemp_hca760406__0[7U] = (Vtop_core__ConstPool__CONST_h1b548564_0[7U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x13U] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x12U] 
                                        >> 0x14U)));
        __Vtemp_hca760406__0[8U] = (Vtop_core__ConstPool__CONST_h1b548564_0[8U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x14U] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x13U] 
                                        >> 0x14U)));
        __Vtemp_hca760406__0[9U] = (Vtop_core__ConstPool__CONST_h1b548564_0[9U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x15U] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x14U] 
                                        >> 0x14U)));
        __Vtemp_hca760406__0[0xaU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xaU] 
                                      & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x16U] 
                                          << 0xcU) 
                                         | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x15U] 
                                            >> 0x14U)));
        __Vtemp_hca760406__0[0xbU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xbU] 
                                      & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x17U] 
                                          << 0xcU) 
                                         | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x16U] 
                                            >> 0x14U)));
        bufp->chgWData(oldp+940,(__Vtemp_hca760406__0),372);
        __Vtemp_he20d994c__0[0U] = (Vtop_core__ConstPool__CONST_h1b548564_0[0U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x18U] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x17U] 
                                        >> 8U)));
        __Vtemp_he20d994c__0[1U] = (Vtop_core__ConstPool__CONST_h1b548564_0[1U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x19U] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x18U] 
                                        >> 8U)));
        __Vtemp_he20d994c__0[2U] = (Vtop_core__ConstPool__CONST_h1b548564_0[2U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x1aU] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x19U] 
                                        >> 8U)));
        __Vtemp_he20d994c__0[3U] = (Vtop_core__ConstPool__CONST_h1b548564_0[3U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x1bU] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x1aU] 
                                        >> 8U)));
        __Vtemp_he20d994c__0[4U] = (Vtop_core__ConstPool__CONST_h1b548564_0[4U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x1cU] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x1bU] 
                                        >> 8U)));
        __Vtemp_he20d994c__0[5U] = (Vtop_core__ConstPool__CONST_h1b548564_0[5U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x1dU] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x1cU] 
                                        >> 8U)));
        __Vtemp_he20d994c__0[6U] = (Vtop_core__ConstPool__CONST_h1b548564_0[6U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x1eU] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x1dU] 
                                        >> 8U)));
        __Vtemp_he20d994c__0[7U] = (Vtop_core__ConstPool__CONST_h1b548564_0[7U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x1fU] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x1eU] 
                                        >> 8U)));
        __Vtemp_he20d994c__0[8U] = (Vtop_core__ConstPool__CONST_h1b548564_0[8U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x20U] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x1fU] 
                                        >> 8U)));
        __Vtemp_he20d994c__0[9U] = (Vtop_core__ConstPool__CONST_h1b548564_0[9U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x21U] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x20U] 
                                        >> 8U)));
        __Vtemp_he20d994c__0[0xaU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xaU] 
                                      & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x22U] 
                                          << 0x18U) 
                                         | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x21U] 
                                            >> 8U)));
        __Vtemp_he20d994c__0[0xbU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xbU] 
                                      & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x23U] 
                                          << 0x18U) 
                                         | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x22U] 
                                            >> 8U)));
        bufp->chgWData(oldp+952,(__Vtemp_he20d994c__0),372);
        __Vtemp_heba899ea__0[0U] = (Vtop_core__ConstPool__CONST_h1b548564_0[0U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x23U] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x22U] 
                                                  >> 0x1cU)));
        __Vtemp_heba899ea__0[1U] = (Vtop_core__ConstPool__CONST_h1b548564_0[1U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x24U] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x23U] 
                                                  >> 0x1cU)));
        __Vtemp_heba899ea__0[2U] = (Vtop_core__ConstPool__CONST_h1b548564_0[2U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x25U] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x24U] 
                                                  >> 0x1cU)));
        __Vtemp_heba899ea__0[3U] = (Vtop_core__ConstPool__CONST_h1b548564_0[3U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x26U] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x25U] 
                                                  >> 0x1cU)));
        __Vtemp_heba899ea__0[4U] = (Vtop_core__ConstPool__CONST_h1b548564_0[4U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x27U] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x26U] 
                                                  >> 0x1cU)));
        __Vtemp_heba899ea__0[5U] = (Vtop_core__ConstPool__CONST_h1b548564_0[5U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x28U] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x27U] 
                                                  >> 0x1cU)));
        __Vtemp_heba899ea__0[6U] = (Vtop_core__ConstPool__CONST_h1b548564_0[6U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x29U] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x28U] 
                                                  >> 0x1cU)));
        __Vtemp_heba899ea__0[7U] = (Vtop_core__ConstPool__CONST_h1b548564_0[7U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x2aU] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x29U] 
                                                  >> 0x1cU)));
        __Vtemp_heba899ea__0[8U] = (Vtop_core__ConstPool__CONST_h1b548564_0[8U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x2bU] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x2aU] 
                                                  >> 0x1cU)));
        __Vtemp_heba899ea__0[9U] = (Vtop_core__ConstPool__CONST_h1b548564_0[9U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x2cU] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x2bU] 
                                                  >> 0x1cU)));
        __Vtemp_heba899ea__0[0xaU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xaU] 
                                      & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x2dU] 
                                          << 4U) | 
                                         (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x2cU] 
                                          >> 0x1cU)));
        __Vtemp_heba899ea__0[0xbU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xbU] 
                                      & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x2eU] 
                                          << 4U) | 
                                         (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x2dU] 
                                          >> 0x1cU)));
        bufp->chgWData(oldp+964,(__Vtemp_heba899ea__0),372);
        bufp->chgBit(oldp+976,(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__valid_write));
        bufp->chgBit(oldp+977,((1U & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__suppress_iren)))));
        bufp->chgBit(oldp+978,(vlSymsp->TOP__top_core__CORE__DOT__tspp_icache_gen_bus_if.__PVT__busy));
        bufp->chgBit(oldp+979,(vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__busy));
        bufp->chgIData(oldp+980,(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__addr),32);
        bufp->chgIData(oldp+981,(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__wdata),32);
        bufp->chgBit(oldp+982,(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__ren));
        bufp->chgBit(oldp+983,(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__wen));
        bufp->chgCData(oldp+984,(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__byte_en),4);
        bufp->chgIData(oldp+985,(vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__addr),32);
        bufp->chgBit(oldp+986,(vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__ren));
        bufp->chgBit(oldp+987,(vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__wen));
        bufp->chgCData(oldp+988,(vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__byte_en),4);
        bufp->chgBit(oldp+989,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__ex_mem_stall));
        bufp->chgBit(oldp+990,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__ex_mem_flush));
        bufp->chgBit(oldp+991,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__if_ex_stall));
        bufp->chgBit(oldp+992,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__suppress_iren));
        bufp->chgBit(oldp+993,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pmp_if.__PVT__csr_active));
    }
    if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[2U])) {
        bufp->chgBit(oldp+994,(vlSymsp->TOP__top_core__gen_bus_if.__PVT__ren));
        bufp->chgBit(oldp+995,(vlSymsp->TOP__top_core__gen_bus_if.__PVT__wen));
        bufp->chgCData(oldp+996,(vlSymsp->TOP__top_core__gen_bus_if.__PVT__byte_en),4);
        bufp->chgIData(oldp+997,(vlSymsp->TOP__top_core__gen_bus_if.__PVT__addr),32);
        bufp->chgIData(oldp+998,(vlSymsp->TOP__top_core__gen_bus_if.__PVT__wdata),32);
        bufp->chgIData(oldp+999,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__mc__DOT__current_state),32);
        bufp->chgIData(oldp+1000,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0U]),32);
        bufp->chgIData(oldp+1001,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[1U]),32);
        bufp->chgIData(oldp+1002,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[2U]),32);
        bufp->chgIData(oldp+1003,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[3U]),32);
        bufp->chgIData(oldp+1004,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[4U]),32);
        bufp->chgIData(oldp+1005,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[5U]),32);
        bufp->chgIData(oldp+1006,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[6U]),32);
        bufp->chgIData(oldp+1007,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[7U]),32);
        bufp->chgIData(oldp+1008,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[8U]),32);
        bufp->chgIData(oldp+1009,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[9U]),32);
        bufp->chgIData(oldp+1010,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0xaU]),32);
        bufp->chgIData(oldp+1011,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0xbU]),32);
        bufp->chgIData(oldp+1012,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0xcU]),32);
        bufp->chgIData(oldp+1013,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0xdU]),32);
        bufp->chgIData(oldp+1014,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0xeU]),32);
        bufp->chgIData(oldp+1015,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0xfU]),32);
        bufp->chgIData(oldp+1016,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x10U]),32);
        bufp->chgIData(oldp+1017,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x11U]),32);
        bufp->chgIData(oldp+1018,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x12U]),32);
        bufp->chgIData(oldp+1019,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x13U]),32);
        bufp->chgIData(oldp+1020,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x14U]),32);
        bufp->chgIData(oldp+1021,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x15U]),32);
        bufp->chgIData(oldp+1022,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x16U]),32);
        bufp->chgIData(oldp+1023,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x17U]),32);
        bufp->chgIData(oldp+1024,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x18U]),32);
        bufp->chgIData(oldp+1025,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x19U]),32);
        bufp->chgIData(oldp+1026,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x1aU]),32);
        bufp->chgIData(oldp+1027,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x1bU]),32);
        bufp->chgIData(oldp+1028,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x1cU]),32);
        bufp->chgIData(oldp+1029,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x1dU]),32);
        bufp->chgIData(oldp+1030,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x1eU]),32);
        bufp->chgIData(oldp+1031,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x1fU]),32);
        bufp->chgBit(oldp+1032,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__ifence_reg));
        bufp->chgBit(oldp+1033,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__iflushed));
        bufp->chgBit(oldp+1034,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__dflushed));
        bufp->chgBit(oldp+1035,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                 >> 0x1fU)));
        bufp->chgCData(oldp+1036,((0xffU & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                            >> 0x17U))),8);
        bufp->chgBit(oldp+1037,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                       >> 0x16U))));
        bufp->chgBit(oldp+1038,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                       >> 0x15U))));
        bufp->chgBit(oldp+1039,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                       >> 0x14U))));
        bufp->chgBit(oldp+1040,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                       >> 0x13U))));
        bufp->chgBit(oldp+1041,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                       >> 0x12U))));
        bufp->chgBit(oldp+1042,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                       >> 0x11U))));
        bufp->chgCData(oldp+1043,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                         >> 0xfU))),2);
        bufp->chgCData(oldp+1044,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                         >> 0xdU))),2);
        bufp->chgCData(oldp+1045,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                         >> 0xbU))),2);
        bufp->chgCData(oldp+1046,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                         >> 9U))),2);
        bufp->chgBit(oldp+1047,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                       >> 8U))));
        bufp->chgBit(oldp+1048,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                       >> 7U))));
        bufp->chgBit(oldp+1049,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                       >> 6U))));
        bufp->chgBit(oldp+1050,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                       >> 5U))));
        bufp->chgBit(oldp+1051,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                       >> 4U))));
        bufp->chgBit(oldp+1052,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                       >> 3U))));
        bufp->chgBit(oldp+1053,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                       >> 2U))));
        bufp->chgBit(oldp+1054,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                       >> 1U))));
        bufp->chgBit(oldp+1055,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus)));
        bufp->chgSData(oldp+1056,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie 
                                   >> 0x10U)),16);
        bufp->chgCData(oldp+1057,((0xfU & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie 
                                           >> 0xcU))),4);
        bufp->chgBit(oldp+1058,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie 
                                       >> 0xbU))));
        bufp->chgBit(oldp+1059,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie 
                                       >> 0xaU))));
        bufp->chgBit(oldp+1060,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie 
                                       >> 9U))));
        bufp->chgBit(oldp+1061,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie 
                                       >> 8U))));
        bufp->chgBit(oldp+1062,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie 
                                       >> 7U))));
        bufp->chgBit(oldp+1063,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie 
                                       >> 6U))));
        bufp->chgBit(oldp+1064,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie 
                                       >> 5U))));
        bufp->chgBit(oldp+1065,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie 
                                       >> 4U))));
        bufp->chgBit(oldp+1066,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie 
                                       >> 3U))));
        bufp->chgBit(oldp+1067,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie 
                                       >> 2U))));
        bufp->chgBit(oldp+1068,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie 
                                       >> 1U))));
        bufp->chgBit(oldp+1069,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie)));
        bufp->chgIData(oldp+1070,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mtvec 
                                   >> 2U)),30);
        bufp->chgCData(oldp+1071,((3U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mtvec)),2);
        bufp->chgIData(oldp+1072,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mscratch),32);
        bufp->chgIData(oldp+1073,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mepc),32);
        bufp->chgBit(oldp+1074,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcause 
                                 >> 0x1fU)));
        bufp->chgIData(oldp+1075,((0x7fffffffU & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcause)),31);
        bufp->chgIData(oldp+1076,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mtval),32);
        bufp->chgSData(oldp+1077,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip 
                                   >> 0x10U)),16);
        bufp->chgCData(oldp+1078,((0xfU & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip 
                                           >> 0xcU))),4);
        bufp->chgBit(oldp+1079,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip 
                                       >> 0xbU))));
        bufp->chgBit(oldp+1080,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip 
                                       >> 0xaU))));
        bufp->chgBit(oldp+1081,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip 
                                       >> 9U))));
        bufp->chgBit(oldp+1082,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip 
                                       >> 8U))));
        bufp->chgBit(oldp+1083,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip 
                                       >> 7U))));
        bufp->chgBit(oldp+1084,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip 
                                       >> 6U))));
        bufp->chgBit(oldp+1085,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip 
                                       >> 5U))));
        bufp->chgBit(oldp+1086,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip 
                                       >> 4U))));
        bufp->chgBit(oldp+1087,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip 
                                       >> 3U))));
        bufp->chgBit(oldp+1088,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip 
                                       >> 2U))));
        bufp->chgBit(oldp+1089,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip 
                                       >> 1U))));
        bufp->chgBit(oldp+1090,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip)));
        bufp->chgBit(oldp+1091,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                 >> 0x1fU)));
        bufp->chgBit(oldp+1092,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 0x1eU))));
        bufp->chgBit(oldp+1093,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 0x1dU))));
        bufp->chgBit(oldp+1094,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 0x1cU))));
        bufp->chgBit(oldp+1095,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 0x1bU))));
        bufp->chgBit(oldp+1096,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 0x1aU))));
        bufp->chgBit(oldp+1097,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 0x19U))));
        bufp->chgBit(oldp+1098,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 0x18U))));
        bufp->chgBit(oldp+1099,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 0x17U))));
        bufp->chgBit(oldp+1100,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 0x16U))));
        bufp->chgBit(oldp+1101,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 0x15U))));
        bufp->chgBit(oldp+1102,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 0x14U))));
        bufp->chgBit(oldp+1103,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 0x13U))));
        bufp->chgBit(oldp+1104,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 0x12U))));
        bufp->chgBit(oldp+1105,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 0x11U))));
        bufp->chgBit(oldp+1106,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 0x10U))));
        bufp->chgBit(oldp+1107,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 0xfU))));
        bufp->chgBit(oldp+1108,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 0xeU))));
        bufp->chgBit(oldp+1109,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 0xdU))));
        bufp->chgBit(oldp+1110,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 0xcU))));
        bufp->chgBit(oldp+1111,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 0xbU))));
        bufp->chgBit(oldp+1112,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 0xaU))));
        bufp->chgBit(oldp+1113,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 9U))));
        bufp->chgBit(oldp+1114,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 8U))));
        bufp->chgBit(oldp+1115,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 7U))));
        bufp->chgBit(oldp+1116,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 6U))));
        bufp->chgBit(oldp+1117,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 5U))));
        bufp->chgBit(oldp+1118,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 4U))));
        bufp->chgBit(oldp+1119,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 3U))));
        bufp->chgBit(oldp+1120,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 2U))));
        bufp->chgBit(oldp+1121,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                       >> 1U))));
        bufp->chgBit(oldp+1122,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren)));
        bufp->chgBit(oldp+1123,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                 >> 0x1fU)));
        bufp->chgBit(oldp+1124,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 0x1eU))));
        bufp->chgBit(oldp+1125,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 0x1dU))));
        bufp->chgBit(oldp+1126,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 0x1cU))));
        bufp->chgBit(oldp+1127,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 0x1bU))));
        bufp->chgBit(oldp+1128,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 0x1aU))));
        bufp->chgBit(oldp+1129,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 0x19U))));
        bufp->chgBit(oldp+1130,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 0x18U))));
        bufp->chgBit(oldp+1131,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 0x17U))));
        bufp->chgBit(oldp+1132,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 0x16U))));
        bufp->chgBit(oldp+1133,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 0x15U))));
        bufp->chgBit(oldp+1134,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 0x14U))));
        bufp->chgBit(oldp+1135,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 0x13U))));
        bufp->chgBit(oldp+1136,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 0x12U))));
        bufp->chgBit(oldp+1137,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 0x11U))));
        bufp->chgBit(oldp+1138,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 0x10U))));
        bufp->chgBit(oldp+1139,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 0xfU))));
        bufp->chgBit(oldp+1140,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 0xeU))));
        bufp->chgBit(oldp+1141,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 0xdU))));
        bufp->chgBit(oldp+1142,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 0xcU))));
        bufp->chgBit(oldp+1143,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 0xbU))));
        bufp->chgBit(oldp+1144,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 0xaU))));
        bufp->chgBit(oldp+1145,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 9U))));
        bufp->chgBit(oldp+1146,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 8U))));
        bufp->chgBit(oldp+1147,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 7U))));
        bufp->chgBit(oldp+1148,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 6U))));
        bufp->chgBit(oldp+1149,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 5U))));
        bufp->chgBit(oldp+1150,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 4U))));
        bufp->chgBit(oldp+1151,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 3U))));
        bufp->chgBit(oldp+1152,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 2U))));
        bufp->chgBit(oldp+1153,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                       >> 1U))));
        bufp->chgBit(oldp+1154,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit)));
        bufp->chgIData(oldp+1155,((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__cycles_full)),32);
        bufp->chgIData(oldp+1156,((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__instret_full)),32);
        bufp->chgIData(oldp+1157,((IData)((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__cycles_full 
                                           >> 0x20U))),32);
        bufp->chgIData(oldp+1158,((IData)((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__instret_full 
                                           >> 0x20U))),32);
        bufp->chgQData(oldp+1159,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__cycles_full),64);
        bufp->chgQData(oldp+1161,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__instret_full),64);
        bufp->chgBit(oldp+1163,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__int_ex_handler__DOT__interrupt_fired));
        bufp->chgCData(oldp+1164,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__mode__DOT__curr_priv_level),2);
        bufp->chgCData(oldp+1165,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                   >> 0x1eU)),2);
        bufp->chgBit(oldp+1166,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                       >> 0x1dU))));
        bufp->chgBit(oldp+1167,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                       >> 0x1cU))));
        bufp->chgBit(oldp+1168,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                       >> 0x1bU))));
        bufp->chgCData(oldp+1169,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                         >> 0x18U))),3);
        bufp->chgBit(oldp+1170,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                       >> 0x17U))));
        bufp->chgBit(oldp+1171,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                       >> 0x16U))));
        bufp->chgBit(oldp+1172,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                       >> 0x15U))));
        bufp->chgCData(oldp+1173,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                         >> 0x13U))),2);
        bufp->chgCData(oldp+1174,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                         >> 0x11U))),2);
        bufp->chgBit(oldp+1175,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                       >> 0x10U))));
        bufp->chgCData(oldp+1176,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                         >> 0xeU))),2);
        bufp->chgBit(oldp+1177,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                       >> 0xdU))));
        bufp->chgBit(oldp+1178,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                       >> 0xcU))));
        bufp->chgBit(oldp+1179,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                       >> 0xbU))));
        bufp->chgCData(oldp+1180,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                         >> 8U))),3);
        bufp->chgBit(oldp+1181,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                       >> 7U))));
        bufp->chgBit(oldp+1182,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                       >> 6U))));
        bufp->chgBit(oldp+1183,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                       >> 5U))));
        bufp->chgCData(oldp+1184,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                         >> 3U))),2);
        bufp->chgCData(oldp+1185,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                         >> 1U))),2);
        bufp->chgBit(oldp+1186,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U])));
        bufp->chgCData(oldp+1187,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                   >> 0x1eU)),2);
        bufp->chgBit(oldp+1188,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                       >> 0x1dU))));
        bufp->chgBit(oldp+1189,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                       >> 0x1cU))));
        bufp->chgBit(oldp+1190,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                       >> 0x1bU))));
        bufp->chgCData(oldp+1191,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                         >> 0x18U))),3);
        bufp->chgBit(oldp+1192,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                       >> 0x17U))));
        bufp->chgBit(oldp+1193,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                       >> 0x16U))));
        bufp->chgBit(oldp+1194,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                       >> 0x15U))));
        bufp->chgCData(oldp+1195,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                         >> 0x13U))),2);
        bufp->chgCData(oldp+1196,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                         >> 0x11U))),2);
        bufp->chgBit(oldp+1197,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                       >> 0x10U))));
        bufp->chgCData(oldp+1198,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                         >> 0xeU))),2);
        bufp->chgBit(oldp+1199,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                       >> 0xdU))));
        bufp->chgBit(oldp+1200,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                       >> 0xcU))));
        bufp->chgBit(oldp+1201,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                       >> 0xbU))));
        bufp->chgCData(oldp+1202,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                         >> 8U))),3);
        bufp->chgBit(oldp+1203,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                       >> 7U))));
        bufp->chgBit(oldp+1204,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                       >> 6U))));
        bufp->chgBit(oldp+1205,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                       >> 5U))));
        bufp->chgCData(oldp+1206,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                         >> 3U))),2);
        bufp->chgCData(oldp+1207,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                         >> 1U))),2);
        bufp->chgBit(oldp+1208,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U])));
        bufp->chgCData(oldp+1209,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                   >> 0x1eU)),2);
        bufp->chgBit(oldp+1210,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                       >> 0x1dU))));
        bufp->chgBit(oldp+1211,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                       >> 0x1cU))));
        bufp->chgBit(oldp+1212,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                       >> 0x1bU))));
        bufp->chgCData(oldp+1213,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                         >> 0x18U))),3);
        bufp->chgBit(oldp+1214,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                       >> 0x17U))));
        bufp->chgBit(oldp+1215,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                       >> 0x16U))));
        bufp->chgBit(oldp+1216,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                       >> 0x15U))));
        bufp->chgCData(oldp+1217,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                         >> 0x13U))),2);
        bufp->chgCData(oldp+1218,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                         >> 0x11U))),2);
        bufp->chgBit(oldp+1219,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                       >> 0x10U))));
        bufp->chgCData(oldp+1220,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                         >> 0xeU))),2);
        bufp->chgBit(oldp+1221,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                       >> 0xdU))));
        bufp->chgBit(oldp+1222,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                       >> 0xcU))));
        bufp->chgBit(oldp+1223,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                       >> 0xbU))));
        bufp->chgCData(oldp+1224,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                         >> 8U))),3);
        bufp->chgBit(oldp+1225,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                       >> 7U))));
        bufp->chgBit(oldp+1226,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                       >> 6U))));
        bufp->chgBit(oldp+1227,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                       >> 5U))));
        bufp->chgCData(oldp+1228,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                         >> 3U))),2);
        bufp->chgCData(oldp+1229,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                         >> 1U))),2);
        bufp->chgBit(oldp+1230,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U])));
        bufp->chgCData(oldp+1231,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                   >> 0x1eU)),2);
        bufp->chgBit(oldp+1232,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                       >> 0x1dU))));
        bufp->chgBit(oldp+1233,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                       >> 0x1cU))));
        bufp->chgBit(oldp+1234,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                       >> 0x1bU))));
        bufp->chgCData(oldp+1235,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                         >> 0x18U))),3);
        bufp->chgBit(oldp+1236,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                       >> 0x17U))));
        bufp->chgBit(oldp+1237,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                       >> 0x16U))));
        bufp->chgBit(oldp+1238,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                       >> 0x15U))));
        bufp->chgCData(oldp+1239,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                         >> 0x13U))),2);
        bufp->chgCData(oldp+1240,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                         >> 0x11U))),2);
        bufp->chgBit(oldp+1241,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                       >> 0x10U))));
        bufp->chgCData(oldp+1242,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                         >> 0xeU))),2);
        bufp->chgBit(oldp+1243,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                       >> 0xdU))));
        bufp->chgBit(oldp+1244,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                       >> 0xcU))));
        bufp->chgBit(oldp+1245,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                       >> 0xbU))));
        bufp->chgCData(oldp+1246,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                         >> 8U))),3);
        bufp->chgBit(oldp+1247,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                       >> 7U))));
        bufp->chgBit(oldp+1248,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                       >> 6U))));
        bufp->chgBit(oldp+1249,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                       >> 5U))));
        bufp->chgCData(oldp+1250,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                         >> 3U))),2);
        bufp->chgCData(oldp+1251,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                         >> 1U))),2);
        bufp->chgBit(oldp+1252,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U])));
        bufp->chgCData(oldp+1253,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                   >> 0x1eU)),2);
        bufp->chgBit(oldp+1254,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                       >> 0x1dU))));
        bufp->chgBit(oldp+1255,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                       >> 0x1cU))));
        bufp->chgBit(oldp+1256,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                       >> 0x1bU))));
        bufp->chgCData(oldp+1257,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                         >> 0x18U))),3);
        bufp->chgBit(oldp+1258,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                       >> 0x17U))));
        bufp->chgBit(oldp+1259,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                       >> 0x16U))));
        bufp->chgBit(oldp+1260,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                       >> 0x15U))));
        bufp->chgCData(oldp+1261,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                         >> 0x13U))),2);
        bufp->chgCData(oldp+1262,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                         >> 0x11U))),2);
        bufp->chgBit(oldp+1263,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                       >> 0x10U))));
        bufp->chgCData(oldp+1264,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                         >> 0xeU))),2);
        bufp->chgBit(oldp+1265,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                       >> 0xdU))));
        bufp->chgBit(oldp+1266,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                       >> 0xcU))));
        bufp->chgBit(oldp+1267,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                       >> 0xbU))));
        bufp->chgCData(oldp+1268,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                         >> 8U))),3);
        bufp->chgBit(oldp+1269,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                       >> 7U))));
        bufp->chgBit(oldp+1270,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                       >> 6U))));
        bufp->chgBit(oldp+1271,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                       >> 5U))));
        bufp->chgCData(oldp+1272,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                         >> 3U))),2);
        bufp->chgCData(oldp+1273,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                         >> 1U))),2);
        bufp->chgBit(oldp+1274,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U])));
        bufp->chgCData(oldp+1275,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                   >> 0x1eU)),2);
        bufp->chgBit(oldp+1276,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                       >> 0x1dU))));
        bufp->chgBit(oldp+1277,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                       >> 0x1cU))));
        bufp->chgBit(oldp+1278,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                       >> 0x1bU))));
        bufp->chgCData(oldp+1279,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                         >> 0x18U))),3);
        bufp->chgBit(oldp+1280,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                       >> 0x17U))));
        bufp->chgBit(oldp+1281,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                       >> 0x16U))));
        bufp->chgBit(oldp+1282,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                       >> 0x15U))));
        bufp->chgCData(oldp+1283,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                         >> 0x13U))),2);
        bufp->chgCData(oldp+1284,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                         >> 0x11U))),2);
        bufp->chgBit(oldp+1285,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                       >> 0x10U))));
        bufp->chgCData(oldp+1286,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                         >> 0xeU))),2);
        bufp->chgBit(oldp+1287,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                       >> 0xdU))));
        bufp->chgBit(oldp+1288,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                       >> 0xcU))));
        bufp->chgBit(oldp+1289,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                       >> 0xbU))));
        bufp->chgCData(oldp+1290,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                         >> 8U))),3);
        bufp->chgBit(oldp+1291,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                       >> 7U))));
        bufp->chgBit(oldp+1292,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                       >> 6U))));
        bufp->chgBit(oldp+1293,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                       >> 5U))));
        bufp->chgCData(oldp+1294,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                         >> 3U))),2);
        bufp->chgCData(oldp+1295,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                         >> 1U))),2);
        bufp->chgBit(oldp+1296,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U])));
        bufp->chgCData(oldp+1297,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                   >> 0x1eU)),2);
        bufp->chgBit(oldp+1298,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                       >> 0x1dU))));
        bufp->chgBit(oldp+1299,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                       >> 0x1cU))));
        bufp->chgBit(oldp+1300,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                       >> 0x1bU))));
        bufp->chgCData(oldp+1301,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                         >> 0x18U))),3);
        bufp->chgBit(oldp+1302,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                       >> 0x17U))));
        bufp->chgBit(oldp+1303,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                       >> 0x16U))));
        bufp->chgBit(oldp+1304,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                       >> 0x15U))));
        bufp->chgCData(oldp+1305,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                         >> 0x13U))),2);
        bufp->chgCData(oldp+1306,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                         >> 0x11U))),2);
        bufp->chgBit(oldp+1307,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                       >> 0x10U))));
        bufp->chgCData(oldp+1308,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                         >> 0xeU))),2);
        bufp->chgBit(oldp+1309,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                       >> 0xdU))));
        bufp->chgBit(oldp+1310,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                       >> 0xcU))));
        bufp->chgBit(oldp+1311,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                       >> 0xbU))));
        bufp->chgCData(oldp+1312,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                         >> 8U))),3);
        bufp->chgBit(oldp+1313,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                       >> 7U))));
        bufp->chgBit(oldp+1314,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                       >> 6U))));
        bufp->chgBit(oldp+1315,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                       >> 5U))));
        bufp->chgCData(oldp+1316,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                         >> 3U))),2);
        bufp->chgCData(oldp+1317,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                         >> 1U))),2);
        bufp->chgBit(oldp+1318,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U])));
        bufp->chgCData(oldp+1319,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                   >> 0x1eU)),2);
        bufp->chgBit(oldp+1320,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                       >> 0x1dU))));
        bufp->chgBit(oldp+1321,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                       >> 0x1cU))));
        bufp->chgBit(oldp+1322,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                       >> 0x1bU))));
        bufp->chgCData(oldp+1323,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                         >> 0x18U))),3);
        bufp->chgBit(oldp+1324,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                       >> 0x17U))));
        bufp->chgBit(oldp+1325,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                       >> 0x16U))));
        bufp->chgBit(oldp+1326,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                       >> 0x15U))));
        bufp->chgCData(oldp+1327,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                         >> 0x13U))),2);
        bufp->chgCData(oldp+1328,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                         >> 0x11U))),2);
        bufp->chgBit(oldp+1329,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                       >> 0x10U))));
        bufp->chgCData(oldp+1330,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                         >> 0xeU))),2);
        bufp->chgBit(oldp+1331,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                       >> 0xdU))));
        bufp->chgBit(oldp+1332,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                       >> 0xcU))));
        bufp->chgBit(oldp+1333,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                       >> 0xbU))));
        bufp->chgCData(oldp+1334,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                         >> 8U))),3);
        bufp->chgBit(oldp+1335,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                       >> 7U))));
        bufp->chgBit(oldp+1336,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                       >> 6U))));
        bufp->chgBit(oldp+1337,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                       >> 5U))));
        bufp->chgCData(oldp+1338,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                         >> 3U))),2);
        bufp->chgCData(oldp+1339,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                         >> 1U))),2);
        bufp->chgBit(oldp+1340,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U])));
        bufp->chgCData(oldp+1341,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                   >> 0x1eU)),2);
        bufp->chgBit(oldp+1342,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                       >> 0x1dU))));
        bufp->chgBit(oldp+1343,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                       >> 0x1cU))));
        bufp->chgBit(oldp+1344,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                       >> 0x1bU))));
        bufp->chgCData(oldp+1345,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                         >> 0x18U))),3);
        bufp->chgBit(oldp+1346,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                       >> 0x17U))));
        bufp->chgBit(oldp+1347,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                       >> 0x16U))));
        bufp->chgBit(oldp+1348,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                       >> 0x15U))));
        bufp->chgCData(oldp+1349,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                         >> 0x13U))),2);
        bufp->chgCData(oldp+1350,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                         >> 0x11U))),2);
        bufp->chgBit(oldp+1351,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                       >> 0x10U))));
        bufp->chgCData(oldp+1352,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                         >> 0xeU))),2);
        bufp->chgBit(oldp+1353,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                       >> 0xdU))));
        bufp->chgBit(oldp+1354,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                       >> 0xcU))));
        bufp->chgBit(oldp+1355,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                       >> 0xbU))));
        bufp->chgCData(oldp+1356,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                         >> 8U))),3);
        bufp->chgBit(oldp+1357,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                       >> 7U))));
        bufp->chgBit(oldp+1358,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                       >> 6U))));
        bufp->chgBit(oldp+1359,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                       >> 5U))));
        bufp->chgCData(oldp+1360,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                         >> 3U))),2);
        bufp->chgCData(oldp+1361,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                         >> 1U))),2);
        bufp->chgBit(oldp+1362,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U])));
        bufp->chgCData(oldp+1363,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                   >> 0x1eU)),2);
        bufp->chgBit(oldp+1364,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                       >> 0x1dU))));
        bufp->chgBit(oldp+1365,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                       >> 0x1cU))));
        bufp->chgBit(oldp+1366,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                       >> 0x1bU))));
        bufp->chgCData(oldp+1367,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                         >> 0x18U))),3);
        bufp->chgBit(oldp+1368,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                       >> 0x17U))));
        bufp->chgBit(oldp+1369,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                       >> 0x16U))));
        bufp->chgBit(oldp+1370,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                       >> 0x15U))));
        bufp->chgCData(oldp+1371,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                         >> 0x13U))),2);
        bufp->chgCData(oldp+1372,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                         >> 0x11U))),2);
        bufp->chgBit(oldp+1373,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                       >> 0x10U))));
        bufp->chgCData(oldp+1374,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                         >> 0xeU))),2);
        bufp->chgBit(oldp+1375,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                       >> 0xdU))));
        bufp->chgBit(oldp+1376,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                       >> 0xcU))));
        bufp->chgBit(oldp+1377,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                       >> 0xbU))));
        bufp->chgCData(oldp+1378,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                         >> 8U))),3);
        bufp->chgBit(oldp+1379,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                       >> 7U))));
        bufp->chgBit(oldp+1380,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                       >> 6U))));
        bufp->chgBit(oldp+1381,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                       >> 5U))));
        bufp->chgCData(oldp+1382,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                         >> 3U))),2);
        bufp->chgCData(oldp+1383,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                         >> 1U))),2);
        bufp->chgBit(oldp+1384,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U])));
        bufp->chgCData(oldp+1385,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                   >> 0x1eU)),2);
        bufp->chgBit(oldp+1386,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                       >> 0x1dU))));
        bufp->chgBit(oldp+1387,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                       >> 0x1cU))));
        bufp->chgBit(oldp+1388,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                       >> 0x1bU))));
        bufp->chgCData(oldp+1389,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                         >> 0x18U))),3);
        bufp->chgBit(oldp+1390,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                       >> 0x17U))));
        bufp->chgBit(oldp+1391,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                       >> 0x16U))));
        bufp->chgBit(oldp+1392,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                       >> 0x15U))));
        bufp->chgCData(oldp+1393,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                         >> 0x13U))),2);
        bufp->chgCData(oldp+1394,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                         >> 0x11U))),2);
        bufp->chgBit(oldp+1395,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                       >> 0x10U))));
        bufp->chgCData(oldp+1396,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                         >> 0xeU))),2);
        bufp->chgBit(oldp+1397,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                       >> 0xdU))));
        bufp->chgBit(oldp+1398,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                       >> 0xcU))));
        bufp->chgBit(oldp+1399,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                       >> 0xbU))));
        bufp->chgCData(oldp+1400,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                         >> 8U))),3);
        bufp->chgBit(oldp+1401,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                       >> 7U))));
        bufp->chgBit(oldp+1402,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                       >> 6U))));
        bufp->chgBit(oldp+1403,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                       >> 5U))));
        bufp->chgCData(oldp+1404,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                         >> 3U))),2);
        bufp->chgCData(oldp+1405,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                         >> 1U))),2);
        bufp->chgBit(oldp+1406,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU])));
        bufp->chgCData(oldp+1407,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                   >> 0x1eU)),2);
        bufp->chgBit(oldp+1408,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                       >> 0x1dU))));
        bufp->chgBit(oldp+1409,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                       >> 0x1cU))));
        bufp->chgBit(oldp+1410,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                       >> 0x1bU))));
        bufp->chgCData(oldp+1411,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                         >> 0x18U))),3);
        bufp->chgBit(oldp+1412,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                       >> 0x17U))));
        bufp->chgBit(oldp+1413,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                       >> 0x16U))));
        bufp->chgBit(oldp+1414,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                       >> 0x15U))));
        bufp->chgCData(oldp+1415,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                         >> 0x13U))),2);
        bufp->chgCData(oldp+1416,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                         >> 0x11U))),2);
        bufp->chgBit(oldp+1417,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                       >> 0x10U))));
        bufp->chgCData(oldp+1418,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                         >> 0xeU))),2);
        bufp->chgBit(oldp+1419,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                       >> 0xdU))));
        bufp->chgBit(oldp+1420,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                       >> 0xcU))));
        bufp->chgBit(oldp+1421,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                       >> 0xbU))));
        bufp->chgCData(oldp+1422,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                         >> 8U))),3);
        bufp->chgBit(oldp+1423,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                       >> 7U))));
        bufp->chgBit(oldp+1424,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                       >> 6U))));
        bufp->chgBit(oldp+1425,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                       >> 5U))));
        bufp->chgCData(oldp+1426,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                         >> 3U))),2);
        bufp->chgCData(oldp+1427,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                         >> 1U))),2);
        bufp->chgBit(oldp+1428,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU])));
        bufp->chgCData(oldp+1429,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                   >> 0x1eU)),2);
        bufp->chgBit(oldp+1430,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                       >> 0x1dU))));
        bufp->chgBit(oldp+1431,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                       >> 0x1cU))));
        bufp->chgBit(oldp+1432,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                       >> 0x1bU))));
        bufp->chgCData(oldp+1433,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                         >> 0x18U))),3);
        bufp->chgBit(oldp+1434,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                       >> 0x17U))));
        bufp->chgBit(oldp+1435,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                       >> 0x16U))));
        bufp->chgBit(oldp+1436,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                       >> 0x15U))));
        bufp->chgCData(oldp+1437,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                         >> 0x13U))),2);
        bufp->chgCData(oldp+1438,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                         >> 0x11U))),2);
        bufp->chgBit(oldp+1439,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                       >> 0x10U))));
        bufp->chgCData(oldp+1440,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                         >> 0xeU))),2);
        bufp->chgBit(oldp+1441,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                       >> 0xdU))));
        bufp->chgBit(oldp+1442,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                       >> 0xcU))));
        bufp->chgBit(oldp+1443,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                       >> 0xbU))));
        bufp->chgCData(oldp+1444,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                         >> 8U))),3);
        bufp->chgBit(oldp+1445,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                       >> 7U))));
        bufp->chgBit(oldp+1446,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                       >> 6U))));
        bufp->chgBit(oldp+1447,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                       >> 5U))));
        bufp->chgCData(oldp+1448,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                         >> 3U))),2);
        bufp->chgCData(oldp+1449,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                         >> 1U))),2);
        bufp->chgBit(oldp+1450,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU])));
        bufp->chgCData(oldp+1451,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                   >> 0x1eU)),2);
        bufp->chgBit(oldp+1452,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                       >> 0x1dU))));
        bufp->chgBit(oldp+1453,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                       >> 0x1cU))));
        bufp->chgBit(oldp+1454,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                       >> 0x1bU))));
        bufp->chgCData(oldp+1455,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                         >> 0x18U))),3);
        bufp->chgBit(oldp+1456,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                       >> 0x17U))));
        bufp->chgBit(oldp+1457,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                       >> 0x16U))));
        bufp->chgBit(oldp+1458,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                       >> 0x15U))));
        bufp->chgCData(oldp+1459,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                         >> 0x13U))),2);
        bufp->chgCData(oldp+1460,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                         >> 0x11U))),2);
        bufp->chgBit(oldp+1461,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                       >> 0x10U))));
        bufp->chgCData(oldp+1462,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                         >> 0xeU))),2);
        bufp->chgBit(oldp+1463,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                       >> 0xdU))));
        bufp->chgBit(oldp+1464,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                       >> 0xcU))));
        bufp->chgBit(oldp+1465,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                       >> 0xbU))));
        bufp->chgCData(oldp+1466,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                         >> 8U))),3);
        bufp->chgBit(oldp+1467,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                       >> 7U))));
        bufp->chgBit(oldp+1468,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                       >> 6U))));
        bufp->chgBit(oldp+1469,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                       >> 5U))));
        bufp->chgCData(oldp+1470,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                         >> 3U))),2);
        bufp->chgCData(oldp+1471,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                         >> 1U))),2);
        bufp->chgBit(oldp+1472,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU])));
        bufp->chgCData(oldp+1473,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                   >> 0x1eU)),2);
        bufp->chgBit(oldp+1474,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                       >> 0x1dU))));
        bufp->chgBit(oldp+1475,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                       >> 0x1cU))));
        bufp->chgBit(oldp+1476,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                       >> 0x1bU))));
        bufp->chgCData(oldp+1477,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                         >> 0x18U))),3);
        bufp->chgBit(oldp+1478,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                       >> 0x17U))));
        bufp->chgBit(oldp+1479,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                       >> 0x16U))));
        bufp->chgBit(oldp+1480,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                       >> 0x15U))));
        bufp->chgCData(oldp+1481,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                         >> 0x13U))),2);
        bufp->chgCData(oldp+1482,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                         >> 0x11U))),2);
        bufp->chgBit(oldp+1483,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                       >> 0x10U))));
        bufp->chgCData(oldp+1484,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                         >> 0xeU))),2);
        bufp->chgBit(oldp+1485,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                       >> 0xdU))));
        bufp->chgBit(oldp+1486,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                       >> 0xcU))));
        bufp->chgBit(oldp+1487,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                       >> 0xbU))));
        bufp->chgCData(oldp+1488,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                         >> 8U))),3);
        bufp->chgBit(oldp+1489,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                       >> 7U))));
        bufp->chgBit(oldp+1490,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                       >> 6U))));
        bufp->chgBit(oldp+1491,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                       >> 5U))));
        bufp->chgCData(oldp+1492,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                         >> 3U))),2);
        bufp->chgCData(oldp+1493,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                         >> 1U))),2);
        bufp->chgBit(oldp+1494,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU])));
        bufp->chgCData(oldp+1495,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                   >> 0x1eU)),2);
        bufp->chgBit(oldp+1496,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                       >> 0x1dU))));
        bufp->chgBit(oldp+1497,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                       >> 0x1cU))));
        bufp->chgBit(oldp+1498,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                       >> 0x1bU))));
        bufp->chgCData(oldp+1499,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                         >> 0x18U))),3);
        bufp->chgBit(oldp+1500,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                       >> 0x17U))));
        bufp->chgBit(oldp+1501,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                       >> 0x16U))));
        bufp->chgBit(oldp+1502,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                       >> 0x15U))));
        bufp->chgCData(oldp+1503,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                         >> 0x13U))),2);
        bufp->chgCData(oldp+1504,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                         >> 0x11U))),2);
        bufp->chgBit(oldp+1505,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                       >> 0x10U))));
        bufp->chgCData(oldp+1506,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                         >> 0xeU))),2);
        bufp->chgBit(oldp+1507,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                       >> 0xdU))));
        bufp->chgBit(oldp+1508,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                       >> 0xcU))));
        bufp->chgBit(oldp+1509,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                       >> 0xbU))));
        bufp->chgCData(oldp+1510,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                         >> 8U))),3);
        bufp->chgBit(oldp+1511,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                       >> 7U))));
        bufp->chgBit(oldp+1512,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                       >> 6U))));
        bufp->chgBit(oldp+1513,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                       >> 5U))));
        bufp->chgCData(oldp+1514,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                         >> 3U))),2);
        bufp->chgCData(oldp+1515,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                         >> 1U))),2);
        bufp->chgBit(oldp+1516,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU])));
        bufp->chgBit(oldp+1517,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                       >> 7U))));
        bufp->chgCData(oldp+1518,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                         >> 5U))),2);
        bufp->chgCData(oldp+1519,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                         >> 3U))),2);
        bufp->chgBit(oldp+1520,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                       >> 2U))));
        bufp->chgBit(oldp+1521,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                       >> 1U))));
        bufp->chgBit(oldp+1522,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U])));
        bufp->chgBit(oldp+1523,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                       >> 0xfU))));
        bufp->chgCData(oldp+1524,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                         >> 0xdU))),2);
        bufp->chgCData(oldp+1525,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                         >> 0xbU))),2);
        bufp->chgBit(oldp+1526,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                       >> 0xaU))));
        bufp->chgBit(oldp+1527,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                       >> 9U))));
        bufp->chgBit(oldp+1528,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                       >> 8U))));
        bufp->chgBit(oldp+1529,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                       >> 0x17U))));
        bufp->chgCData(oldp+1530,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                         >> 0x15U))),2);
        bufp->chgCData(oldp+1531,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                         >> 0x13U))),2);
        bufp->chgBit(oldp+1532,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                       >> 0x12U))));
        bufp->chgBit(oldp+1533,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                       >> 0x11U))));
        bufp->chgBit(oldp+1534,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                       >> 0x10U))));
        bufp->chgBit(oldp+1535,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                 >> 0x1fU)));
        bufp->chgCData(oldp+1536,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                         >> 0x1dU))),2);
        bufp->chgCData(oldp+1537,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                         >> 0x1bU))),2);
        bufp->chgBit(oldp+1538,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                       >> 0x1aU))));
        bufp->chgBit(oldp+1539,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                       >> 0x19U))));
        bufp->chgBit(oldp+1540,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                       >> 0x18U))));
        bufp->chgBit(oldp+1541,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                       >> 7U))));
        bufp->chgCData(oldp+1542,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                         >> 5U))),2);
        bufp->chgCData(oldp+1543,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                         >> 3U))),2);
        bufp->chgBit(oldp+1544,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                       >> 2U))));
        bufp->chgBit(oldp+1545,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                       >> 1U))));
        bufp->chgBit(oldp+1546,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U])));
        bufp->chgBit(oldp+1547,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                       >> 0xfU))));
        bufp->chgCData(oldp+1548,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                         >> 0xdU))),2);
        bufp->chgCData(oldp+1549,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                         >> 0xbU))),2);
        bufp->chgBit(oldp+1550,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                       >> 0xaU))));
        bufp->chgBit(oldp+1551,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                       >> 9U))));
        bufp->chgBit(oldp+1552,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                       >> 8U))));
        bufp->chgBit(oldp+1553,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                       >> 0x17U))));
        bufp->chgCData(oldp+1554,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                         >> 0x15U))),2);
        bufp->chgCData(oldp+1555,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                         >> 0x13U))),2);
        bufp->chgBit(oldp+1556,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                       >> 0x12U))));
        bufp->chgBit(oldp+1557,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                       >> 0x11U))));
        bufp->chgBit(oldp+1558,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                       >> 0x10U))));
        bufp->chgBit(oldp+1559,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                 >> 0x1fU)));
        bufp->chgCData(oldp+1560,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                         >> 0x1dU))),2);
        bufp->chgCData(oldp+1561,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                         >> 0x1bU))),2);
        bufp->chgBit(oldp+1562,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                       >> 0x1aU))));
        bufp->chgBit(oldp+1563,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                       >> 0x19U))));
        bufp->chgBit(oldp+1564,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                       >> 0x18U))));
        bufp->chgBit(oldp+1565,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                       >> 7U))));
        bufp->chgCData(oldp+1566,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                         >> 5U))),2);
        bufp->chgCData(oldp+1567,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                         >> 3U))),2);
        bufp->chgBit(oldp+1568,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                       >> 2U))));
        bufp->chgBit(oldp+1569,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                       >> 1U))));
        bufp->chgBit(oldp+1570,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U])));
        bufp->chgBit(oldp+1571,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                       >> 0xfU))));
        bufp->chgCData(oldp+1572,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                         >> 0xdU))),2);
        bufp->chgCData(oldp+1573,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                         >> 0xbU))),2);
        bufp->chgBit(oldp+1574,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                       >> 0xaU))));
        bufp->chgBit(oldp+1575,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                       >> 9U))));
        bufp->chgBit(oldp+1576,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                       >> 8U))));
        bufp->chgBit(oldp+1577,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                       >> 0x17U))));
        bufp->chgCData(oldp+1578,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                         >> 0x15U))),2);
        bufp->chgCData(oldp+1579,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                         >> 0x13U))),2);
        bufp->chgBit(oldp+1580,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                       >> 0x12U))));
        bufp->chgBit(oldp+1581,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                       >> 0x11U))));
        bufp->chgBit(oldp+1582,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                       >> 0x10U))));
        bufp->chgBit(oldp+1583,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                 >> 0x1fU)));
        bufp->chgCData(oldp+1584,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                         >> 0x1dU))),2);
        bufp->chgCData(oldp+1585,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                         >> 0x1bU))),2);
        bufp->chgBit(oldp+1586,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                       >> 0x1aU))));
        bufp->chgBit(oldp+1587,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                       >> 0x19U))));
        bufp->chgBit(oldp+1588,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                       >> 0x18U))));
        bufp->chgBit(oldp+1589,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                       >> 7U))));
        bufp->chgCData(oldp+1590,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                         >> 5U))),2);
        bufp->chgCData(oldp+1591,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                         >> 3U))),2);
        bufp->chgBit(oldp+1592,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                       >> 2U))));
        bufp->chgBit(oldp+1593,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                       >> 1U))));
        bufp->chgBit(oldp+1594,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U])));
        bufp->chgBit(oldp+1595,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                       >> 0xfU))));
        bufp->chgCData(oldp+1596,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                         >> 0xdU))),2);
        bufp->chgCData(oldp+1597,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                         >> 0xbU))),2);
        bufp->chgBit(oldp+1598,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                       >> 0xaU))));
        bufp->chgBit(oldp+1599,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                       >> 9U))));
        bufp->chgBit(oldp+1600,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                       >> 8U))));
        bufp->chgBit(oldp+1601,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                       >> 0x17U))));
        bufp->chgCData(oldp+1602,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                         >> 0x15U))),2);
        bufp->chgCData(oldp+1603,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                         >> 0x13U))),2);
        bufp->chgBit(oldp+1604,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                       >> 0x12U))));
        bufp->chgBit(oldp+1605,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                       >> 0x11U))));
        bufp->chgBit(oldp+1606,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                       >> 0x10U))));
        bufp->chgBit(oldp+1607,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                 >> 0x1fU)));
        bufp->chgCData(oldp+1608,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                         >> 0x1dU))),2);
        bufp->chgCData(oldp+1609,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                         >> 0x1bU))),2);
        bufp->chgBit(oldp+1610,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                       >> 0x1aU))));
        bufp->chgBit(oldp+1611,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                       >> 0x19U))));
        bufp->chgBit(oldp+1612,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                       >> 0x18U))));
        bufp->chgIData(oldp+1613,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[0U]),32);
        bufp->chgIData(oldp+1614,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[1U]),32);
        bufp->chgIData(oldp+1615,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[2U]),32);
        bufp->chgIData(oldp+1616,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[3U]),32);
        bufp->chgIData(oldp+1617,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[4U]),32);
        bufp->chgIData(oldp+1618,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[5U]),32);
        bufp->chgIData(oldp+1619,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[6U]),32);
        bufp->chgIData(oldp+1620,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[7U]),32);
        bufp->chgIData(oldp+1621,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[8U]),32);
        bufp->chgIData(oldp+1622,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[9U]),32);
        bufp->chgIData(oldp+1623,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[0xaU]),32);
        bufp->chgIData(oldp+1624,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[0xbU]),32);
        bufp->chgIData(oldp+1625,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[0xcU]),32);
        bufp->chgIData(oldp+1626,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[0xdU]),32);
        bufp->chgIData(oldp+1627,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[0xeU]),32);
        bufp->chgIData(oldp+1628,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[0xfU]),32);
        bufp->chgBit(oldp+1629,(vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT____Vcellout__genblk1__DOT__dcache__flush_done));
        bufp->chgBit(oldp+1630,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                       >> 5U))));
        bufp->chgCData(oldp+1631,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                         >> 3U))),2);
        bufp->chgCData(oldp+1632,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                         >> 1U))),2);
        bufp->chgBit(oldp+1633,((1U & (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx))));
        bufp->chgCData(oldp+1634,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__word_num),2);
        bufp->chgBit(oldp+1635,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__clear_word_count));
        bufp->chgBit(oldp+1636,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__clear_flush_count));
        bufp->chgIData(oldp+1637,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__state),32);
        bufp->chgCData(oldp+1638,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__last_used),2);
        bufp->chgIData(oldp+1639,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__read_addr),32);
        bufp->chgIData(oldp+1640,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__decoded_req_addr 
                                   >> 5U)),27);
        bufp->chgCData(oldp+1641,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__decoded_req_addr 
                                         >> 3U))),2);
        bufp->chgBit(oldp+1642,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__decoded_req_addr 
                                       >> 2U))));
        bufp->chgCData(oldp+1643,((3U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__decoded_req_addr)),2);
        bufp->chgBit(oldp+1644,(vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT____Vcellout__genblk2__DOT__icache__flush_done));
        bufp->chgBit(oldp+1645,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                       >> 5U))));
        bufp->chgCData(oldp+1646,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                         >> 3U))),2);
        bufp->chgCData(oldp+1647,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                         >> 1U))),2);
        bufp->chgBit(oldp+1648,((1U & (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx))));
        bufp->chgCData(oldp+1649,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__word_num),2);
        bufp->chgBit(oldp+1650,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__clear_word_count));
        bufp->chgBit(oldp+1651,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__clear_flush_count));
        bufp->chgIData(oldp+1652,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__state),32);
        bufp->chgCData(oldp+1653,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__last_used),2);
        bufp->chgIData(oldp+1654,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__read_addr),32);
        bufp->chgIData(oldp+1655,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__decoded_req_addr 
                                   >> 5U)),27);
        bufp->chgCData(oldp+1656,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__decoded_req_addr 
                                         >> 3U))),2);
        bufp->chgBit(oldp+1657,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__decoded_req_addr 
                                       >> 2U))));
        bufp->chgCData(oldp+1658,((3U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__decoded_req_addr)),2);
    }
    if (VL_UNLIKELY((vlSelf->__Vm_traceActivity[2U] 
                     | vlSelf->__Vm_traceActivity[4U]))) {
        bufp->chgBit(oldp+1659,((1U & ((~ (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__ifence_pulse)) 
                                       & ((IData)(vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT____Vcellout__genblk2__DOT__icache__flush_done) 
                                          | (~ (IData)(vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT____Vcellout__genblk1__DOT__dcache__flush_done)))))));
        bufp->chgBit(oldp+1660,((1U & ((~ (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__ifence_pulse)) 
                                       & ((IData)(vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT____Vcellout__genblk1__DOT__dcache__flush_done) 
                                          | (~ (IData)(vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT____Vcellout__genblk2__DOT__icache__flush_done)))))));
        bufp->chgBit(oldp+1661,(((((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__invalid_csr_priv) 
                                   | (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__invalid_csr_addr)) 
                                  | ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                      >> 6U) & (3U 
                                                != (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__mode__DOT__curr_priv_level)))) 
                                 | (((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                      >> 5U) & (0U 
                                                == (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__mode__DOT__curr_priv_level))) 
                                    & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                       >> 0x15U)))));
        bufp->chgBit(oldp+1662,(((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__int_ex_handler__DOT__exception) 
                                 | (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__int_ex_handler__DOT__interrupt_fired))));
        bufp->chgIData(oldp+1663,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[
                                  (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                            >> 0xfU))]),32);
        bufp->chgIData(oldp+1664,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[
                                  (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                            >> 0x14U))]),32);
    }
    if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[3U])) {
        __Vtemp_ha676a1bf__0[0U] = (Vtop_core__ConstPool__CONST_h1b548564_0[0U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0U]);
        __Vtemp_ha676a1bf__0[1U] = (Vtop_core__ConstPool__CONST_h1b548564_0[1U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[1U]);
        __Vtemp_ha676a1bf__0[2U] = (Vtop_core__ConstPool__CONST_h1b548564_0[2U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[2U]);
        __Vtemp_ha676a1bf__0[3U] = (Vtop_core__ConstPool__CONST_h1b548564_0[3U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[3U]);
        __Vtemp_ha676a1bf__0[4U] = (Vtop_core__ConstPool__CONST_h1b548564_0[4U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[4U]);
        __Vtemp_ha676a1bf__0[5U] = (Vtop_core__ConstPool__CONST_h1b548564_0[5U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[5U]);
        __Vtemp_ha676a1bf__0[6U] = (Vtop_core__ConstPool__CONST_h1b548564_0[6U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[6U]);
        __Vtemp_ha676a1bf__0[7U] = (Vtop_core__ConstPool__CONST_h1b548564_0[7U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[7U]);
        __Vtemp_ha676a1bf__0[8U] = (Vtop_core__ConstPool__CONST_h1b548564_0[8U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[8U]);
        __Vtemp_ha676a1bf__0[9U] = (Vtop_core__ConstPool__CONST_h1b548564_0[9U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[9U]);
        __Vtemp_ha676a1bf__0[0xaU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xaU] 
                                      & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0xaU]);
        __Vtemp_ha676a1bf__0[0xbU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xbU] 
                                      & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0xbU]);
        bufp->chgWData(oldp+1665,(__Vtemp_ha676a1bf__0),372);
        __Vtemp_h5ee43eb0__0[0U] = (Vtop_core__ConstPool__CONST_h1b548564_0[0U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0xcU] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0xbU] 
                                        >> 0x14U)));
        __Vtemp_h5ee43eb0__0[1U] = (Vtop_core__ConstPool__CONST_h1b548564_0[1U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0xdU] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0xcU] 
                                        >> 0x14U)));
        __Vtemp_h5ee43eb0__0[2U] = (Vtop_core__ConstPool__CONST_h1b548564_0[2U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0xeU] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0xdU] 
                                        >> 0x14U)));
        __Vtemp_h5ee43eb0__0[3U] = (Vtop_core__ConstPool__CONST_h1b548564_0[3U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0xfU] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0xeU] 
                                        >> 0x14U)));
        __Vtemp_h5ee43eb0__0[4U] = (Vtop_core__ConstPool__CONST_h1b548564_0[4U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x10U] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0xfU] 
                                        >> 0x14U)));
        __Vtemp_h5ee43eb0__0[5U] = (Vtop_core__ConstPool__CONST_h1b548564_0[5U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x11U] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x10U] 
                                        >> 0x14U)));
        __Vtemp_h5ee43eb0__0[6U] = (Vtop_core__ConstPool__CONST_h1b548564_0[6U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x12U] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x11U] 
                                        >> 0x14U)));
        __Vtemp_h5ee43eb0__0[7U] = (Vtop_core__ConstPool__CONST_h1b548564_0[7U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x13U] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x12U] 
                                        >> 0x14U)));
        __Vtemp_h5ee43eb0__0[8U] = (Vtop_core__ConstPool__CONST_h1b548564_0[8U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x14U] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x13U] 
                                        >> 0x14U)));
        __Vtemp_h5ee43eb0__0[9U] = (Vtop_core__ConstPool__CONST_h1b548564_0[9U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x15U] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x14U] 
                                        >> 0x14U)));
        __Vtemp_h5ee43eb0__0[0xaU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xaU] 
                                      & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x16U] 
                                          << 0xcU) 
                                         | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x15U] 
                                            >> 0x14U)));
        __Vtemp_h5ee43eb0__0[0xbU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xbU] 
                                      & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x17U] 
                                          << 0xcU) 
                                         | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x16U] 
                                            >> 0x14U)));
        bufp->chgWData(oldp+1677,(__Vtemp_h5ee43eb0__0),372);
        __Vtemp_h0a51f55d__0[0U] = (Vtop_core__ConstPool__CONST_h1b548564_0[0U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x18U] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x17U] 
                                        >> 8U)));
        __Vtemp_h0a51f55d__0[1U] = (Vtop_core__ConstPool__CONST_h1b548564_0[1U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x19U] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x18U] 
                                        >> 8U)));
        __Vtemp_h0a51f55d__0[2U] = (Vtop_core__ConstPool__CONST_h1b548564_0[2U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x1aU] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x19U] 
                                        >> 8U)));
        __Vtemp_h0a51f55d__0[3U] = (Vtop_core__ConstPool__CONST_h1b548564_0[3U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x1bU] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x1aU] 
                                        >> 8U)));
        __Vtemp_h0a51f55d__0[4U] = (Vtop_core__ConstPool__CONST_h1b548564_0[4U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x1cU] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x1bU] 
                                        >> 8U)));
        __Vtemp_h0a51f55d__0[5U] = (Vtop_core__ConstPool__CONST_h1b548564_0[5U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x1dU] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x1cU] 
                                        >> 8U)));
        __Vtemp_h0a51f55d__0[6U] = (Vtop_core__ConstPool__CONST_h1b548564_0[6U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x1eU] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x1dU] 
                                        >> 8U)));
        __Vtemp_h0a51f55d__0[7U] = (Vtop_core__ConstPool__CONST_h1b548564_0[7U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x1fU] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x1eU] 
                                        >> 8U)));
        __Vtemp_h0a51f55d__0[8U] = (Vtop_core__ConstPool__CONST_h1b548564_0[8U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x20U] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x1fU] 
                                        >> 8U)));
        __Vtemp_h0a51f55d__0[9U] = (Vtop_core__ConstPool__CONST_h1b548564_0[9U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x21U] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x20U] 
                                        >> 8U)));
        __Vtemp_h0a51f55d__0[0xaU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xaU] 
                                      & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x22U] 
                                          << 0x18U) 
                                         | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x21U] 
                                            >> 8U)));
        __Vtemp_h0a51f55d__0[0xbU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xbU] 
                                      & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x23U] 
                                          << 0x18U) 
                                         | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x22U] 
                                            >> 8U)));
        bufp->chgWData(oldp+1689,(__Vtemp_h0a51f55d__0),372);
        __Vtemp_he6508a66__0[0U] = (Vtop_core__ConstPool__CONST_h1b548564_0[0U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x23U] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x22U] 
                                                  >> 0x1cU)));
        __Vtemp_he6508a66__0[1U] = (Vtop_core__ConstPool__CONST_h1b548564_0[1U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x24U] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x23U] 
                                                  >> 0x1cU)));
        __Vtemp_he6508a66__0[2U] = (Vtop_core__ConstPool__CONST_h1b548564_0[2U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x25U] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x24U] 
                                                  >> 0x1cU)));
        __Vtemp_he6508a66__0[3U] = (Vtop_core__ConstPool__CONST_h1b548564_0[3U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x26U] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x25U] 
                                                  >> 0x1cU)));
        __Vtemp_he6508a66__0[4U] = (Vtop_core__ConstPool__CONST_h1b548564_0[4U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x27U] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x26U] 
                                                  >> 0x1cU)));
        __Vtemp_he6508a66__0[5U] = (Vtop_core__ConstPool__CONST_h1b548564_0[5U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x28U] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x27U] 
                                                  >> 0x1cU)));
        __Vtemp_he6508a66__0[6U] = (Vtop_core__ConstPool__CONST_h1b548564_0[6U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x29U] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x28U] 
                                                  >> 0x1cU)));
        __Vtemp_he6508a66__0[7U] = (Vtop_core__ConstPool__CONST_h1b548564_0[7U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x2aU] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x29U] 
                                                  >> 0x1cU)));
        __Vtemp_he6508a66__0[8U] = (Vtop_core__ConstPool__CONST_h1b548564_0[8U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x2bU] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x2aU] 
                                                  >> 0x1cU)));
        __Vtemp_he6508a66__0[9U] = (Vtop_core__ConstPool__CONST_h1b548564_0[9U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x2cU] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x2bU] 
                                                  >> 0x1cU)));
        __Vtemp_he6508a66__0[0xaU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xaU] 
                                      & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x2dU] 
                                          << 4U) | 
                                         (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x2cU] 
                                          >> 0x1cU)));
        __Vtemp_he6508a66__0[0xbU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xbU] 
                                      & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x2eU] 
                                          << 4U) | 
                                         (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x2dU] 
                                          >> 0x1cU)));
        bufp->chgWData(oldp+1701,(__Vtemp_he6508a66__0),372);
        __Vtemp_h202cdc64__0[0U] = (Vtop_core__ConstPool__CONST_h1b548564_0[0U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0U]);
        __Vtemp_h202cdc64__0[1U] = (Vtop_core__ConstPool__CONST_h1b548564_0[1U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[1U]);
        __Vtemp_h202cdc64__0[2U] = (Vtop_core__ConstPool__CONST_h1b548564_0[2U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[2U]);
        __Vtemp_h202cdc64__0[3U] = (Vtop_core__ConstPool__CONST_h1b548564_0[3U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[3U]);
        __Vtemp_h202cdc64__0[4U] = (Vtop_core__ConstPool__CONST_h1b548564_0[4U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[4U]);
        __Vtemp_h202cdc64__0[5U] = (Vtop_core__ConstPool__CONST_h1b548564_0[5U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[5U]);
        __Vtemp_h202cdc64__0[6U] = (Vtop_core__ConstPool__CONST_h1b548564_0[6U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[6U]);
        __Vtemp_h202cdc64__0[7U] = (Vtop_core__ConstPool__CONST_h1b548564_0[7U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[7U]);
        __Vtemp_h202cdc64__0[8U] = (Vtop_core__ConstPool__CONST_h1b548564_0[8U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[8U]);
        __Vtemp_h202cdc64__0[9U] = (Vtop_core__ConstPool__CONST_h1b548564_0[9U] 
                                    & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[9U]);
        __Vtemp_h202cdc64__0[0xaU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xaU] 
                                      & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0xaU]);
        __Vtemp_h202cdc64__0[0xbU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xbU] 
                                      & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0xbU]);
        bufp->chgWData(oldp+1713,(__Vtemp_h202cdc64__0),372);
        __Vtemp_h0f78598d__0[0U] = (Vtop_core__ConstPool__CONST_h1b548564_0[0U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0xcU] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0xbU] 
                                        >> 0x14U)));
        __Vtemp_h0f78598d__0[1U] = (Vtop_core__ConstPool__CONST_h1b548564_0[1U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0xdU] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0xcU] 
                                        >> 0x14U)));
        __Vtemp_h0f78598d__0[2U] = (Vtop_core__ConstPool__CONST_h1b548564_0[2U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0xeU] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0xdU] 
                                        >> 0x14U)));
        __Vtemp_h0f78598d__0[3U] = (Vtop_core__ConstPool__CONST_h1b548564_0[3U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0xfU] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0xeU] 
                                        >> 0x14U)));
        __Vtemp_h0f78598d__0[4U] = (Vtop_core__ConstPool__CONST_h1b548564_0[4U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x10U] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0xfU] 
                                        >> 0x14U)));
        __Vtemp_h0f78598d__0[5U] = (Vtop_core__ConstPool__CONST_h1b548564_0[5U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x11U] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x10U] 
                                        >> 0x14U)));
        __Vtemp_h0f78598d__0[6U] = (Vtop_core__ConstPool__CONST_h1b548564_0[6U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x12U] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x11U] 
                                        >> 0x14U)));
        __Vtemp_h0f78598d__0[7U] = (Vtop_core__ConstPool__CONST_h1b548564_0[7U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x13U] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x12U] 
                                        >> 0x14U)));
        __Vtemp_h0f78598d__0[8U] = (Vtop_core__ConstPool__CONST_h1b548564_0[8U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x14U] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x13U] 
                                        >> 0x14U)));
        __Vtemp_h0f78598d__0[9U] = (Vtop_core__ConstPool__CONST_h1b548564_0[9U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x15U] 
                                        << 0xcU) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x14U] 
                                        >> 0x14U)));
        __Vtemp_h0f78598d__0[0xaU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xaU] 
                                      & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x16U] 
                                          << 0xcU) 
                                         | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x15U] 
                                            >> 0x14U)));
        __Vtemp_h0f78598d__0[0xbU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xbU] 
                                      & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x17U] 
                                          << 0xcU) 
                                         | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x16U] 
                                            >> 0x14U)));
        bufp->chgWData(oldp+1725,(__Vtemp_h0f78598d__0),372);
        __Vtemp_h4f074be2__0[0U] = (Vtop_core__ConstPool__CONST_h1b548564_0[0U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x18U] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x17U] 
                                        >> 8U)));
        __Vtemp_h4f074be2__0[1U] = (Vtop_core__ConstPool__CONST_h1b548564_0[1U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x19U] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x18U] 
                                        >> 8U)));
        __Vtemp_h4f074be2__0[2U] = (Vtop_core__ConstPool__CONST_h1b548564_0[2U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x1aU] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x19U] 
                                        >> 8U)));
        __Vtemp_h4f074be2__0[3U] = (Vtop_core__ConstPool__CONST_h1b548564_0[3U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x1bU] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x1aU] 
                                        >> 8U)));
        __Vtemp_h4f074be2__0[4U] = (Vtop_core__ConstPool__CONST_h1b548564_0[4U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x1cU] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x1bU] 
                                        >> 8U)));
        __Vtemp_h4f074be2__0[5U] = (Vtop_core__ConstPool__CONST_h1b548564_0[5U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x1dU] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x1cU] 
                                        >> 8U)));
        __Vtemp_h4f074be2__0[6U] = (Vtop_core__ConstPool__CONST_h1b548564_0[6U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x1eU] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x1dU] 
                                        >> 8U)));
        __Vtemp_h4f074be2__0[7U] = (Vtop_core__ConstPool__CONST_h1b548564_0[7U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x1fU] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x1eU] 
                                        >> 8U)));
        __Vtemp_h4f074be2__0[8U] = (Vtop_core__ConstPool__CONST_h1b548564_0[8U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x20U] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x1fU] 
                                        >> 8U)));
        __Vtemp_h4f074be2__0[9U] = (Vtop_core__ConstPool__CONST_h1b548564_0[9U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x21U] 
                                        << 0x18U) | 
                                       (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x20U] 
                                        >> 8U)));
        __Vtemp_h4f074be2__0[0xaU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xaU] 
                                      & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x22U] 
                                          << 0x18U) 
                                         | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x21U] 
                                            >> 8U)));
        __Vtemp_h4f074be2__0[0xbU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xbU] 
                                      & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x23U] 
                                          << 0x18U) 
                                         | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x22U] 
                                            >> 8U)));
        bufp->chgWData(oldp+1737,(__Vtemp_h4f074be2__0),372);
        __Vtemp_hc53d5f0a__0[0U] = (Vtop_core__ConstPool__CONST_h1b548564_0[0U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x23U] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x22U] 
                                                  >> 0x1cU)));
        __Vtemp_hc53d5f0a__0[1U] = (Vtop_core__ConstPool__CONST_h1b548564_0[1U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x24U] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x23U] 
                                                  >> 0x1cU)));
        __Vtemp_hc53d5f0a__0[2U] = (Vtop_core__ConstPool__CONST_h1b548564_0[2U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x25U] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x24U] 
                                                  >> 0x1cU)));
        __Vtemp_hc53d5f0a__0[3U] = (Vtop_core__ConstPool__CONST_h1b548564_0[3U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x26U] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x25U] 
                                                  >> 0x1cU)));
        __Vtemp_hc53d5f0a__0[4U] = (Vtop_core__ConstPool__CONST_h1b548564_0[4U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x27U] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x26U] 
                                                  >> 0x1cU)));
        __Vtemp_hc53d5f0a__0[5U] = (Vtop_core__ConstPool__CONST_h1b548564_0[5U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x28U] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x27U] 
                                                  >> 0x1cU)));
        __Vtemp_hc53d5f0a__0[6U] = (Vtop_core__ConstPool__CONST_h1b548564_0[6U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x29U] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x28U] 
                                                  >> 0x1cU)));
        __Vtemp_hc53d5f0a__0[7U] = (Vtop_core__ConstPool__CONST_h1b548564_0[7U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x2aU] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x29U] 
                                                  >> 0x1cU)));
        __Vtemp_hc53d5f0a__0[8U] = (Vtop_core__ConstPool__CONST_h1b548564_0[8U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x2bU] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x2aU] 
                                                  >> 0x1cU)));
        __Vtemp_hc53d5f0a__0[9U] = (Vtop_core__ConstPool__CONST_h1b548564_0[9U] 
                                    & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x2cU] 
                                        << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x2bU] 
                                                  >> 0x1cU)));
        __Vtemp_hc53d5f0a__0[0xaU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xaU] 
                                      & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x2dU] 
                                          << 4U) | 
                                         (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x2cU] 
                                          >> 0x1cU)));
        __Vtemp_hc53d5f0a__0[0xbU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xbU] 
                                      & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x2eU] 
                                          << 4U) | 
                                         (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x2dU] 
                                          >> 0x1cU)));
        bufp->chgWData(oldp+1749,(__Vtemp_hc53d5f0a__0),372);
    }
    if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[4U])) {
        bufp->chgBit(oldp+1761,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 0xeU))));
        bufp->chgBit(oldp+1762,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__wfi));
        bufp->chgIData(oldp+1763,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__imm_I_ext),32);
        bufp->chgIData(oldp+1764,((((- (IData)((1U 
                                                & ((IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__imm_S) 
                                                   >> 0xbU)))) 
                                    << 0xcU) | (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__imm_S))),32);
        bufp->chgIData(oldp+1765,((((- (IData)((1U 
                                                & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__imm_UJ 
                                                   >> 0x14U)))) 
                                    << 0x15U) | vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__imm_UJ)),32);
        bufp->chgIData(oldp+1766,((((0x13U == (0x7fU 
                                               & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U])) 
                                    & ((1U == (7U & 
                                               (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                                >> 0xcU))) 
                                       | (5U == (7U 
                                                 & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                                    >> 0xcU)))))
                                    ? (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                                >> 0x14U))
                                    : vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__imm_I_ext)),32);
        bufp->chgIData(oldp+1767,((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[4U] 
                                   + VL_EXTENDS_II(32,13, (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__imm_SB)))),32);
        bufp->chgIData(oldp+1768,(VL_EXTENDS_II(32,13, (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__imm_SB))),32);
        bufp->chgCData(oldp+1769,((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                   >> 0x19U)),7);
        bufp->chgCData(oldp+1770,((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                            >> 0x14U))),5);
        bufp->chgCData(oldp+1771,((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                            >> 0xfU))),5);
        bufp->chgCData(oldp+1772,((7U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                         >> 0xcU))),3);
        bufp->chgCData(oldp+1773,((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                            >> 7U))),5);
        bufp->chgCData(oldp+1774,((0x7fU & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U])),7);
        bufp->chgSData(oldp+1775,((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                   >> 0x14U)),12);
        bufp->chgBit(oldp+1776,((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                 >> 0x1fU)));
        bufp->chgCData(oldp+1777,((0x3fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                            >> 0x19U))),6);
        bufp->chgCData(oldp+1778,((0xfU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                           >> 8U))),4);
        bufp->chgBit(oldp+1779,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                       >> 7U))));
        bufp->chgIData(oldp+1780,((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                   >> 0xcU)),20);
        bufp->chgSData(oldp+1781,((0x3ffU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                             >> 0x15U))),10);
        bufp->chgBit(oldp+1782,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                       >> 0x14U))));
        bufp->chgCData(oldp+1783,((0xffU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                            >> 0xcU))),8);
        bufp->chgBit(oldp+1784,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu__DOT__maybe_illegal));
        bufp->chgBit(oldp+1785,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu__DOT__sr));
        bufp->chgBit(oldp+1786,(((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu__DOT__sr) 
                                 & (~ (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                       >> 0x1eU)))));
        bufp->chgBit(oldp+1787,(((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu__DOT__sr) 
                                 & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                    >> 0x1eU))));
        bufp->chgBit(oldp+1788,((((((IData)((0x13U 
                                             == (0x707fU 
                                                 & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))) 
                                    | (0x17U == (0x7fU 
                                                 & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))) 
                                   | ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu__DOT__add_sub) 
                                      & (~ (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                            >> 0x1eU)))) 
                                  | (3U == (0x7fU & 
                                            vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))) 
                                 | (0x23U == (0x7fU 
                                              & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U])))));
        bufp->chgBit(oldp+1789,(((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu__DOT__add_sub) 
                                 & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                    >> 0x1eU))));
        bufp->chgBit(oldp+1790,(((IData)((0x7013U == 
                                          (0x707fU 
                                           & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))) 
                                 | (IData)((0x7033U 
                                            == (0x707fU 
                                                & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))))));
        bufp->chgBit(oldp+1791,(((IData)((0x6013U == 
                                          (0x707fU 
                                           & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))) 
                                 | (IData)((0x6033U 
                                            == (0x707fU 
                                                & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))))));
        bufp->chgBit(oldp+1792,(((IData)((0x1013U == 
                                          (0x707fU 
                                           & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))) 
                                 | (IData)((0x1033U 
                                            == (0x707fU 
                                                & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))))));
        bufp->chgBit(oldp+1793,(((IData)((0x4013U == 
                                          (0x707fU 
                                           & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))) 
                                 | (IData)((0x4033U 
                                            == (0x707fU 
                                                & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))))));
        bufp->chgBit(oldp+1794,(((IData)((0x2013U == 
                                          (0x707fU 
                                           & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))) 
                                 | (IData)((0x2033U 
                                            == (0x707fU 
                                                & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))))));
        bufp->chgBit(oldp+1795,(((IData)((0x3013U == 
                                          (0x707fU 
                                           & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))) 
                                 | (IData)((0x3033U 
                                            == (0x707fU 
                                                & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))))));
        bufp->chgBit(oldp+1796,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu__DOT__add_sub));
        bufp->chgIData(oldp+1797,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc),32);
        bufp->chgIData(oldp+1798,(((IData)(4U) + vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc)),32);
        bufp->chgBit(oldp+1799,((0U != (3U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc))));
        bufp->chgIData(oldp+1800,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc),32);
        bufp->chgBit(oldp+1801,(((0U != (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                  >> 0x13U))) 
                                 & ((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                              >> 0xfU)) 
                                    == (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                 >> 0x13U))))));
        bufp->chgBit(oldp+1802,(((0U != (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                  >> 0x13U))) 
                                 & ((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                              >> 0x14U)) 
                                    == (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                 >> 0x13U))))));
        bufp->chgBit(oldp+1803,((IData)((0U != (0xc0000U 
                                                & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU])))));
        bufp->chgBit(oldp+1804,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__branch_jump));
        bufp->chgBit(oldp+1805,((((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                            >> 0xfU)) 
                                  == (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                               >> 0x13U))) 
                                 & (0U != (0x1fU & 
                                           (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                            >> 0x13U))))));
        bufp->chgBit(oldp+1806,((((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                            >> 0x14U)) 
                                  == (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                               >> 0x13U))) 
                                 & (0U != (0x1fU & 
                                           (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                            >> 0x13U))))));
        bufp->chgBit(oldp+1807,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__exception));
        bufp->chgBit(oldp+1808,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__intr));
        bufp->chgIData(oldp+1809,(((IData)(((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                             >> 0x17U) 
                                            & (~ (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__intr))))
                                    ? ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[7U] 
                                        << 0x1fU) | 
                                       (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[6U] 
                                        >> 1U)) : (
                                                   (8U 
                                                    & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[5U])
                                                    ? 
                                                   vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[4U]
                                                    : vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc))),32);
        bufp->chgIData(oldp+1810,(((0xff000000U & (
                                                   vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[8U] 
                                                   << 0x17U)) 
                                   | ((0xff0000U & 
                                       (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[8U] 
                                        << 7U)) | (
                                                   (0xff00U 
                                                    & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[8U] 
                                                       >> 9U)) 
                                                   | (0xffU 
                                                      & ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[9U] 
                                                          << 7U) 
                                                         | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[8U] 
                                                            >> 0x19U))))))),32);
        bufp->chgBit(oldp+1811,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__mal_addr));
        bufp->chgCData(oldp+1812,((3U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                         >> 1U))),2);
        bufp->chgCData(oldp+1813,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard),4);
        bufp->chgBit(oldp+1814,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__ifence_pulse));
        bufp->chgCData(oldp+1815,((7U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[7U] 
                                         >> 0xdU))),3);
        bufp->chgSData(oldp+1816,((0xfffU & ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[8U] 
                                              << 0xbU) 
                                             | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[7U] 
                                                >> 0x15U)))),12);
        bufp->chgBit(oldp+1817,((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[7U] 
                                 >> 0x1fU)));
        bufp->chgIData(oldp+1818,(((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[8U] 
                                    << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[7U] 
                                                 >> 1U))),32);
        bufp->chgIData(oldp+1819,(((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[7U] 
                                    << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[6U] 
                                                 >> 1U))),32);
        bufp->chgCData(oldp+1820,((0x7fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[7U] 
                                            >> 1U))),7);
        bufp->chgCData(oldp+1821,((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[7U] 
                                            >> 0x10U))),5);
        bufp->chgCData(oldp+1822,((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[7U] 
                                            >> 0x15U))),5);
        bufp->chgCData(oldp+1823,((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                            >> 0x13U))),5);
        bufp->chgSData(oldp+1824,((0x1fffU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[2U] 
                                              >> 0xdU))),13);
        bufp->chgSData(oldp+1825,((0xfffU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[2U] 
                                             >> 1U))),12);
        bufp->chgSData(oldp+1826,((0xfffU & ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[2U] 
                                              << 0xbU) 
                                             | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[1U] 
                                                >> 0x15U)))),12);
        bufp->chgIData(oldp+1827,((0x1fffffU & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[1U])),21);
        bufp->chgIData(oldp+1828,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0U]),32);
        bufp->chgQData(oldp+1829,((QData)((IData)((
                                                   (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[7U] 
                                                    << 0x1fU) 
                                                   | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[6U] 
                                                      >> 1U))))),64);
        bufp->chgCData(oldp+1831,((7U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                         >> 0xdU))),3);
        bufp->chgIData(oldp+1832,(((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[9U] 
                                    << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[8U] 
                                                 >> 1U))),32);
        bufp->chgBit(oldp+1833,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__invalid_csr_priv));
        bufp->chgBit(oldp+1834,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__invalid_csr_addr));
        bufp->chgBit(oldp+1835,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__csr_operation));
        bufp->chgIData(oldp+1836,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__int_ex_handler__DOT__ex_src),31);
        bufp->chgBit(oldp+1837,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__int_ex_handler__DOT__exception));
        bufp->chgCData(oldp+1838,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__mode__DOT__next_priv_level),2);
        bufp->chgCData(oldp+1839,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                   >> 0x1eU)),2);
        bufp->chgBit(oldp+1840,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                       >> 0x1dU))));
        bufp->chgBit(oldp+1841,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                       >> 0x1cU))));
        bufp->chgBit(oldp+1842,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                       >> 0x1bU))));
        bufp->chgCData(oldp+1843,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                         >> 0x18U))),3);
        bufp->chgBit(oldp+1844,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                       >> 0x17U))));
        bufp->chgBit(oldp+1845,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                       >> 0x16U))));
        bufp->chgBit(oldp+1846,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                       >> 0x15U))));
        bufp->chgCData(oldp+1847,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                         >> 0x13U))),2);
        bufp->chgCData(oldp+1848,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                         >> 0x11U))),2);
        bufp->chgBit(oldp+1849,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                       >> 0x10U))));
        bufp->chgCData(oldp+1850,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                         >> 0xeU))),2);
        bufp->chgBit(oldp+1851,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                       >> 0xdU))));
        bufp->chgBit(oldp+1852,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                       >> 0xcU))));
        bufp->chgBit(oldp+1853,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                       >> 0xbU))));
        bufp->chgCData(oldp+1854,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                         >> 8U))),3);
        bufp->chgBit(oldp+1855,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                       >> 7U))));
        bufp->chgBit(oldp+1856,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                       >> 6U))));
        bufp->chgBit(oldp+1857,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                       >> 5U))));
        bufp->chgCData(oldp+1858,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                         >> 3U))),2);
        bufp->chgCData(oldp+1859,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                         >> 1U))),2);
        bufp->chgBit(oldp+1860,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d)));
        bufp->chgCData(oldp+1861,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                   >> 0x1eU)),2);
        bufp->chgBit(oldp+1862,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                       >> 0x1dU))));
        bufp->chgBit(oldp+1863,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                       >> 0x1cU))));
        bufp->chgBit(oldp+1864,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                       >> 0x1bU))));
        bufp->chgCData(oldp+1865,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                         >> 0x18U))),3);
        bufp->chgBit(oldp+1866,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                       >> 0x17U))));
        bufp->chgBit(oldp+1867,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                       >> 0x16U))));
        bufp->chgBit(oldp+1868,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                       >> 0x15U))));
        bufp->chgCData(oldp+1869,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                         >> 0x13U))),2);
        bufp->chgCData(oldp+1870,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                         >> 0x11U))),2);
        bufp->chgBit(oldp+1871,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                       >> 0x10U))));
        bufp->chgCData(oldp+1872,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                         >> 0xeU))),2);
        bufp->chgBit(oldp+1873,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                       >> 0xdU))));
        bufp->chgBit(oldp+1874,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                       >> 0xcU))));
        bufp->chgBit(oldp+1875,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                       >> 0xbU))));
        bufp->chgCData(oldp+1876,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                         >> 8U))),3);
        bufp->chgBit(oldp+1877,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                       >> 7U))));
        bufp->chgBit(oldp+1878,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                       >> 6U))));
        bufp->chgBit(oldp+1879,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                       >> 5U))));
        bufp->chgCData(oldp+1880,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                         >> 3U))),2);
        bufp->chgCData(oldp+1881,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                         >> 1U))),2);
        bufp->chgBit(oldp+1882,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i)));
        bufp->chgCData(oldp+1883,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_d) 
                                         >> 0xeU))),2);
        bufp->chgBit(oldp+1884,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_d) 
                                       >> 0xdU))));
        bufp->chgBit(oldp+1885,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_d) 
                                       >> 0xcU))));
        bufp->chgBit(oldp+1886,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_d) 
                                       >> 0xbU))));
        bufp->chgCData(oldp+1887,((7U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_d) 
                                         >> 8U))),3);
        bufp->chgBit(oldp+1888,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_d) 
                                       >> 7U))));
        bufp->chgBit(oldp+1889,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_d) 
                                       >> 6U))));
        bufp->chgBit(oldp+1890,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_d) 
                                       >> 5U))));
        bufp->chgCData(oldp+1891,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_d) 
                                         >> 3U))),2);
        bufp->chgCData(oldp+1892,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_d) 
                                         >> 1U))),2);
        bufp->chgBit(oldp+1893,((1U & (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_d))));
        bufp->chgCData(oldp+1894,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_i) 
                                         >> 0xeU))),2);
        bufp->chgBit(oldp+1895,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_i) 
                                       >> 0xdU))));
        bufp->chgBit(oldp+1896,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_i) 
                                       >> 0xcU))));
        bufp->chgBit(oldp+1897,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_i) 
                                       >> 0xbU))));
        bufp->chgCData(oldp+1898,((7U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_i) 
                                         >> 8U))),3);
        bufp->chgBit(oldp+1899,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_i) 
                                       >> 7U))));
        bufp->chgBit(oldp+1900,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_i) 
                                       >> 6U))));
        bufp->chgBit(oldp+1901,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_i) 
                                       >> 5U))));
        bufp->chgCData(oldp+1902,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_i) 
                                         >> 3U))),2);
        bufp->chgCData(oldp+1903,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_i) 
                                         >> 1U))),2);
        bufp->chgBit(oldp+1904,((1U & (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_i))));
        bufp->chgCData(oldp+1905,((3U & (((IData)(1U) 
                                          + (0xfU & 
                                             (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                              >> 1U))) 
                                         >> 2U))),2);
        bufp->chgCData(oldp+1906,((3U & ((IData)(1U) 
                                         + (0xfU & 
                                            (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                             >> 1U))))),2);
        bufp->chgSData(oldp+1907,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__d_cfg_match),16);
        bufp->chgBit(oldp+1908,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__d_match) 
                                       >> 7U))));
        bufp->chgCData(oldp+1909,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__d_match) 
                                         >> 5U))),2);
        bufp->chgCData(oldp+1910,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__d_match) 
                                         >> 3U))),2);
        bufp->chgBit(oldp+1911,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__d_match) 
                                       >> 2U))));
        bufp->chgBit(oldp+1912,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__d_match) 
                                       >> 1U))));
        bufp->chgBit(oldp+1913,((1U & (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__d_match))));
        bufp->chgBit(oldp+1914,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__d_match_found));
        bufp->chgBit(oldp+1915,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__d_prot_fault));
        bufp->chgSData(oldp+1916,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__i_cfg_match),16);
        bufp->chgBit(oldp+1917,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__i_match) 
                                       >> 7U))));
        bufp->chgCData(oldp+1918,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__i_match) 
                                         >> 5U))),2);
        bufp->chgCData(oldp+1919,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__i_match) 
                                         >> 3U))),2);
        bufp->chgBit(oldp+1920,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__i_match) 
                                       >> 2U))));
        bufp->chgBit(oldp+1921,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__i_match) 
                                       >> 1U))));
        bufp->chgBit(oldp+1922,((1U & (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__i_match))));
        bufp->chgBit(oldp+1923,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__i_match_found));
        bufp->chgBit(oldp+1924,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__i_prot_fault));
        bufp->chgIData(oldp+1925,((0x3fffffffU & ((
                                                   vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xbU] 
                                                   << 0x1dU) 
                                                  | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                     >> 3U)))),32);
        bufp->chgBit(oldp+1926,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__0__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1927,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__10__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1928,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__11__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1929,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__12__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1930,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__13__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1931,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__14__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1932,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__15__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1933,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__1__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1934,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__2__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1935,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__3__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1936,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__4__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1937,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__5__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1938,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__6__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1939,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__7__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1940,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__8__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1941,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__9__KET____DOT__matcher____pinNumber5));
        bufp->chgIData(oldp+1942,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc 
                                   >> 2U)),32);
        bufp->chgBit(oldp+1943,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__0__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1944,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__10__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1945,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__11__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1946,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__12__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1947,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__13__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1948,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__14__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1949,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__15__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1950,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__1__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1951,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__2__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1952,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__3__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1953,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__4__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1954,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__5__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1955,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__6__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1956,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__7__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1957,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__8__KET____DOT__matcher____pinNumber5));
        bufp->chgBit(oldp+1958,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__9__KET____DOT__matcher____pinNumber5));
        bufp->chgIData(oldp+1959,((0x7ffffffU & ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xbU] 
                                                  << 0x1aU) 
                                                 | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                    >> 6U)))),27);
        bufp->chgCData(oldp+1960,((3U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                         >> 4U))),2);
        bufp->chgBit(oldp+1961,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                       >> 3U))));
        bufp->chgCData(oldp+1962,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL),2);
        bufp->chgIData(oldp+1963,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc 
                                   >> 5U)),27);
        bufp->chgCData(oldp+1964,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc 
                                         >> 3U))),2);
        bufp->chgBit(oldp+1965,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc 
                                       >> 2U))));
        bufp->chgCData(oldp+1966,((3U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc)),2);
        bufp->chgCData(oldp+1967,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL),2);
        bufp->chgBit(oldp+1968,(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__fault_insn));
        bufp->chgBit(oldp+1969,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                       >> 0x12U))));
        bufp->chgBit(oldp+1970,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__illegal_insn));
        bufp->chgBit(oldp+1971,(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__prot_fault_l));
        bufp->chgBit(oldp+1972,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__mal_l));
        bufp->chgBit(oldp+1973,(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__prot_fault_s));
        bufp->chgBit(oldp+1974,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__mal_s));
        bufp->chgBit(oldp+1975,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 8U))));
        bufp->chgBit(oldp+1976,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 7U))));
        bufp->chgBit(oldp+1977,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 6U))));
        bufp->chgBit(oldp+1978,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 5U))));
        bufp->chgIData(oldp+1979,(((IData)((0U != (0x60000U 
                                                   & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU])))
                                    ? ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[4U] 
                                        << 0x1fU) | 
                                       (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[3U] 
                                        >> 1U)) : (
                                                   (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xbU] 
                                                    << 0x1fU) 
                                                   | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                      >> 1U)))),32);
        bufp->chgBit(oldp+1980,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__insert_pc));
        bufp->chgBit(oldp+1981,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__intr));
        bufp->chgBit(oldp+1982,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 0xdU))));
        bufp->chgBit(oldp+1983,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 0xcU))));
        bufp->chgBit(oldp+1984,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 0xbU))));
        bufp->chgBit(oldp+1985,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 9U))));
        bufp->chgSData(oldp+1986,((0xfffU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                             >> 1U))),12);
        bufp->chgIData(oldp+1987,(((0x400U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU])
                                    ? (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                >> 0x18U))
                                    : ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                        << 0x1fU) | 
                                       (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[9U] 
                                        >> 1U)))),32);
        bufp->chgBit(oldp+1988,((0U != ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[8U] 
                                         << 0x1fU) 
                                        | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[7U] 
                                           >> 1U)))));
        bufp->chgBit(oldp+1989,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 0x12U))));
        bufp->chgBit(oldp+1990,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 0x13U))));
        bufp->chgIData(oldp+1991,(((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xbU] 
                                    << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                 >> 1U))),32);
        bufp->chgBit(oldp+1992,(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__prot_fault_i));
        bufp->chgIData(oldp+1993,(vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__wdata),32);
        bufp->chgBit(oldp+1994,(vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__ren));
        bufp->chgBit(oldp+1995,(vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__wen));
        bufp->chgSData(oldp+1996,((0xffffU & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U])),16);
        bufp->chgBit(oldp+1997,((1U & (((IData)(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__insert_pc) 
                                        | ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                            >> 0x10U) 
                                           & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__fence_stall)))) 
                                       | (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__branch_jump)))));
        bufp->chgBit(oldp+1998,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[5U] 
                                       >> 3U))));
        bufp->chgBit(oldp+1999,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[5U] 
                                       >> 2U))));
        bufp->chgBit(oldp+2000,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[5U] 
                                       >> 1U))));
        bufp->chgBit(oldp+2001,((1U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[5U])));
        bufp->chgIData(oldp+2002,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[4U]),32);
        bufp->chgIData(oldp+2003,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[3U]),32);
        bufp->chgIData(oldp+2004,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]),32);
        bufp->chgIData(oldp+2005,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[1U]),32);
        bufp->chgIData(oldp+2006,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[0U]),32);
        bufp->chgBit(oldp+2007,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 0x11U))));
        bufp->chgBit(oldp+2008,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 0xfU))));
        bufp->chgBit(oldp+2009,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 0x16U))));
        bufp->chgBit(oldp+2010,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__fence_stall));
        bufp->chgBit(oldp+2011,((1U & VL_REDXOR_32(
                                                   (0x300000U 
                                                    & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU])))));
        bufp->chgBit(oldp+2012,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[5U] 
                                       >> 3U))));
        bufp->chgBit(oldp+2013,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 0x17U))));
        bufp->chgBit(oldp+2014,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 0x10U))));
        bufp->chgBit(oldp+2015,((1U & ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                        >> 0x10U) & 
                                       (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__fence_stall))))));
        bufp->chgBit(oldp+2016,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                       >> 0x11U))));
        bufp->chgIData(oldp+2017,(((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                    << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xbU] 
                                                 >> 1U))),32);
        bufp->chgBit(oldp+2018,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 0x15U))));
        bufp->chgBit(oldp+2019,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 0x14U))));
        bufp->chgBit(oldp+2020,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fw_if.__PVT__load));
        bufp->chgBit(oldp+2021,(((((0U != (0x1fU & 
                                           (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                            >> 0x13U))) 
                                   & ((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                                >> 0xfU)) 
                                      == (0x1fU & (
                                                   vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                   >> 0x13U)))) 
                                  & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                     >> 0x11U)) & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fw_if.__PVT__load)))));
        bufp->chgBit(oldp+2022,(((((0U != (0x1fU & 
                                           (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                            >> 0x13U))) 
                                   & ((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                                >> 0x14U)) 
                                      == (0x1fU & (
                                                   vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                   >> 0x13U)))) 
                                  & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                     >> 0x11U)) & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fw_if.__PVT__load)))));
        bufp->chgBit(oldp+2023,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 0x17U))));
        bufp->chgBit(oldp+2024,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 0x16U))));
        bufp->chgBit(oldp+2025,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 0x15U))));
        bufp->chgBit(oldp+2026,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 0x14U))));
        bufp->chgBit(oldp+2027,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 0x13U))));
        bufp->chgBit(oldp+2028,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 0x12U))));
        bufp->chgBit(oldp+2029,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 0x11U))));
        bufp->chgBit(oldp+2030,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 0x10U))));
        bufp->chgBit(oldp+2031,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 0xfU))));
        bufp->chgBit(oldp+2032,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 0xeU))));
        bufp->chgBit(oldp+2033,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 0xdU))));
        bufp->chgBit(oldp+2034,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 0xcU))));
        bufp->chgBit(oldp+2035,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 0xbU))));
        bufp->chgBit(oldp+2036,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 0xaU))));
        bufp->chgBit(oldp+2037,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 9U))));
        bufp->chgBit(oldp+2038,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 8U))));
        bufp->chgBit(oldp+2039,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 7U))));
        bufp->chgBit(oldp+2040,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 6U))));
        bufp->chgBit(oldp+2041,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 5U))));
        bufp->chgBit(oldp+2042,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 4U))));
        bufp->chgCData(oldp+2043,((7U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                         >> 1U))),3);
        bufp->chgCData(oldp+2044,((0xfU & ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                            << 3U) 
                                           | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                              >> 0x1dU)))),4);
        bufp->chgCData(oldp+2045,((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                            >> 0x18U))),5);
        bufp->chgCData(oldp+2046,((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                            >> 0x13U))),5);
        bufp->chgBit(oldp+2047,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                       >> 0x12U))));
        bufp->chgBit(oldp+2048,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                       >> 0x11U))));
        bufp->chgBit(oldp+2049,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                       >> 0x10U))));
        bufp->chgIData(oldp+2050,(((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                    << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[9U] 
                                                 >> 1U))),32);
        bufp->chgIData(oldp+2051,(((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[6U] 
                                    << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[5U] 
                                                 >> 1U))),32);
        bufp->chgIData(oldp+2052,(((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[5U] 
                                    << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[4U] 
                                                 >> 1U))),32);
        bufp->chgIData(oldp+2053,(((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[4U] 
                                    << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[3U] 
                                                 >> 1U))),32);
        bufp->chgCData(oldp+2054,((0x7fU & ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[3U] 
                                             << 6U) 
                                            | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[2U] 
                                               >> 0x1aU)))),7);
        bufp->chgSData(oldp+2055,((0x1fffU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[2U] 
                                              >> 0xdU))),13);
        bufp->chgIData(oldp+2056,((0x1fffffU & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[1U])),21);
        bufp->chgBit(oldp+2057,(((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__invalid_csr_priv) 
                                 | (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__invalid_csr_addr))));
        bufp->chgBit(oldp+2058,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__env_u));
        bufp->chgBit(oldp+2059,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__env_m));
        bufp->chgBit(oldp+2060,((vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                 >> 0x1fU)));
        bufp->chgCData(oldp+2061,((0xffU & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                            >> 0x17U))),8);
        bufp->chgBit(oldp+2062,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                       >> 0x16U))));
        bufp->chgBit(oldp+2063,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                       >> 0x15U))));
        bufp->chgBit(oldp+2064,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                       >> 0x14U))));
        bufp->chgBit(oldp+2065,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                       >> 0x13U))));
        bufp->chgBit(oldp+2066,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                       >> 0x12U))));
        bufp->chgBit(oldp+2067,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                       >> 0x11U))));
        bufp->chgCData(oldp+2068,((3U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                         >> 0xfU))),2);
        bufp->chgCData(oldp+2069,((3U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                         >> 0xdU))),2);
        bufp->chgCData(oldp+2070,((3U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                         >> 0xbU))),2);
        bufp->chgCData(oldp+2071,((3U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                         >> 9U))),2);
        bufp->chgBit(oldp+2072,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                       >> 8U))));
        bufp->chgBit(oldp+2073,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                       >> 7U))));
        bufp->chgBit(oldp+2074,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                       >> 6U))));
        bufp->chgBit(oldp+2075,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                       >> 5U))));
        bufp->chgBit(oldp+2076,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                       >> 4U))));
        bufp->chgBit(oldp+2077,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                       >> 3U))));
        bufp->chgBit(oldp+2078,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                       >> 2U))));
        bufp->chgBit(oldp+2079,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                       >> 1U))));
        bufp->chgBit(oldp+2080,((1U & vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus)));
        bufp->chgBit(oldp+2081,(((IData)(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__intr) 
                                 | (IData)(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__mret))));
        bufp->chgBit(oldp+2082,((1U & ((((((((IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__mal_l) 
                                             | (IData)(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__prot_fault_l)) 
                                            | (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__mal_s)) 
                                           | (IData)(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__prot_fault_s)) 
                                          | (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__illegal_insn)) 
                                         | (IData)(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__fault_insn)) 
                                        | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                           >> 0x12U)) 
                                       | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                          >> 8U)))));
        bufp->chgBit(oldp+2083,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__mret));
        bufp->chgBit(oldp+2084,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__pma_s_fault));
        bufp->chgBit(oldp+2085,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__pma_l_fault));
        bufp->chgBit(oldp+2086,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__pma_i_fault));
        bufp->chgBit(oldp+2087,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__pmp_s_fault));
        bufp->chgBit(oldp+2088,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__pmp_l_fault));
        bufp->chgBit(oldp+2089,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__pmp_i_fault));
        bufp->chgBit(oldp+2090,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pma_if.__PVT__ack));
        bufp->chgIData(oldp+2091,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pma_if.__PVT__value_out),32);
        bufp->chgBit(oldp+2092,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pmp_if.__PVT__ack));
        bufp->chgIData(oldp+2093,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pmp_if.__PVT__value_out),32);
        bufp->chgCData(oldp+2094,(vlSymsp->TOP__top_core.CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu__DOT___VdfgExtracted___h7d703271__0),4);
        bufp->chgSData(oldp+2095,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__imm_SB),13);
        bufp->chgBit(oldp+2096,((0x23U == (0x7fU & 
                                           vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))));
        bufp->chgBit(oldp+2097,((3U == (0x7fU & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))));
        bufp->chgBit(oldp+2098,((0x6fU == (0x7fU & 
                                           vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))));
        bufp->chgBit(oldp+2099,((0x63U == (0x7fU & 
                                           vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))));
        bufp->chgBit(oldp+2100,(((0x6fU == (0x7fU & 
                                            vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U])) 
                                 | (0x67U == (0x7fU 
                                              & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U])))));
        bufp->chgBit(oldp+2101,(((0x13U == (0x7fU & 
                                            vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U])) 
                                 & ((1U == (7U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                                  >> 0xcU))) 
                                    | (5U == (7U & 
                                              (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                               >> 0xcU)))))));
        bufp->chgBit(oldp+2102,((0x6fU == vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U])));
        bufp->chgBit(oldp+2103,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__wen));
        bufp->chgBit(oldp+2104,((IData)((0x100fU == 
                                         (0x707fU & 
                                          vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U])))));
        bufp->chgCData(oldp+2105,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__alu_a_sel),2);
        bufp->chgCData(oldp+2106,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__alu_b_sel),2);
        bufp->chgCData(oldp+2107,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__w_sel),3);
        bufp->chgSData(oldp+2108,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__imm_S),12);
        bufp->chgIData(oldp+2109,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__imm_UJ),21);
        bufp->chgIData(oldp+2110,((0xfffff000U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U])),32);
        bufp->chgBit(oldp+2111,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__ret_insn));
        bufp->chgBit(oldp+2112,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__breakpoint));
        bufp->chgBit(oldp+2113,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__ecall_insn));
        bufp->chgBit(oldp+2114,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__csr_swap));
        bufp->chgBit(oldp+2115,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__csr_set));
        bufp->chgBit(oldp+2116,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__csr_clr));
        bufp->chgBit(oldp+2117,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__csr_imm));
        bufp->chgBit(oldp+2118,((((IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__csr_swap) 
                                  | (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__csr_set)) 
                                 | (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__csr_clr))));
        bufp->chgIData(oldp+2119,(((0x6fU == (0x7fU 
                                              & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))
                                    ? (((- (IData)(
                                                   (1U 
                                                    & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__imm_UJ 
                                                       >> 0x14U)))) 
                                        << 0x15U) | vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__imm_UJ)
                                    : vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__imm_I_ext)),32);
    }
    if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[5U])) {
        bufp->chgBit(oldp+2120,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__enable_flush_count_nowb));
        bufp->chgCData(oldp+2121,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_last_used),2);
        bufp->chgBit(oldp+2122,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit));
        bufp->chgBit(oldp+2123,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__pass_through));
        bufp->chgIData(oldp+2124,((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_data)),32);
        bufp->chgIData(oldp+2125,((IData)((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_data 
                                           >> 0x20U))),32);
        bufp->chgCData(oldp+2126,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx),2);
        bufp->chgBit(oldp+2127,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[2U] 
                                       >> 0x1cU))));
        bufp->chgBit(oldp+2128,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[2U] 
                                       >> 0x1bU))));
        bufp->chgIData(oldp+2129,((0x7ffffffU & vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[2U])),27);
        bufp->chgIData(oldp+2130,(vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[0U]),32);
        bufp->chgIData(oldp+2131,(vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[1U]),32);
        bufp->chgBit(oldp+2132,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[5U] 
                                       >> 0x19U))));
        bufp->chgBit(oldp+2133,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[5U] 
                                       >> 0x18U))));
        bufp->chgIData(oldp+2134,((0x7ffffffU & ((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[5U] 
                                                  << 3U) 
                                                 | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[4U] 
                                                    >> 0x1dU)))),27);
        bufp->chgIData(oldp+2135,(((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[3U] 
                                    << 3U) | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[2U] 
                                              >> 0x1dU))),32);
        bufp->chgIData(oldp+2136,(((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[4U] 
                                    << 3U) | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[3U] 
                                              >> 0x1dU))),32);
        bufp->chgBit(oldp+2137,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[8U] 
                                       >> 0x16U))));
        bufp->chgBit(oldp+2138,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[8U] 
                                       >> 0x15U))));
        bufp->chgIData(oldp+2139,((0x7ffffffU & ((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[8U] 
                                                  << 6U) 
                                                 | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[7U] 
                                                    >> 0x1aU)))),27);
        bufp->chgIData(oldp+2140,(((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[6U] 
                                    << 6U) | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[5U] 
                                              >> 0x1aU))),32);
        bufp->chgIData(oldp+2141,(((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[7U] 
                                    << 6U) | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[6U] 
                                              >> 0x1aU))),32);
        bufp->chgBit(oldp+2142,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[0xbU] 
                                       >> 0x13U))));
        bufp->chgBit(oldp+2143,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[0xbU] 
                                       >> 0x12U))));
        bufp->chgIData(oldp+2144,((0x7ffffffU & ((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[0xbU] 
                                                  << 9U) 
                                                 | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[0xaU] 
                                                    >> 0x17U)))),27);
        bufp->chgIData(oldp+2145,(((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[9U] 
                                    << 9U) | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[8U] 
                                              >> 0x17U))),32);
        bufp->chgIData(oldp+2146,(((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[0xaU] 
                                    << 9U) | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[9U] 
                                              >> 0x17U))),32);
        bufp->chgWData(oldp+2147,(vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4),372);
        bufp->chgIData(oldp+2159,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__unnamedblk1__DOT__i),32);
        bufp->chgBit(oldp+2160,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__enable_flush_count_nowb));
        bufp->chgBit(oldp+2161,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__hit));
        bufp->chgBit(oldp+2162,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__pass_through));
        bufp->chgIData(oldp+2163,((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__hit_data)),32);
        bufp->chgIData(oldp+2164,((IData)((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__hit_data 
                                           >> 0x20U))),32);
        bufp->chgCData(oldp+2165,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__hit_idx),2);
        bufp->chgBit(oldp+2166,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[2U] 
                                       >> 0x1cU))));
        bufp->chgBit(oldp+2167,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[2U] 
                                       >> 0x1bU))));
        bufp->chgIData(oldp+2168,((0x7ffffffU & vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[2U])),27);
        bufp->chgIData(oldp+2169,(vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[0U]),32);
        bufp->chgIData(oldp+2170,(vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[1U]),32);
        bufp->chgBit(oldp+2171,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[5U] 
                                       >> 0x19U))));
        bufp->chgBit(oldp+2172,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[5U] 
                                       >> 0x18U))));
        bufp->chgIData(oldp+2173,((0x7ffffffU & ((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[5U] 
                                                  << 3U) 
                                                 | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[4U] 
                                                    >> 0x1dU)))),27);
        bufp->chgIData(oldp+2174,(((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[3U] 
                                    << 3U) | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[2U] 
                                              >> 0x1dU))),32);
        bufp->chgIData(oldp+2175,(((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[4U] 
                                    << 3U) | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[3U] 
                                              >> 0x1dU))),32);
        bufp->chgBit(oldp+2176,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[8U] 
                                       >> 0x16U))));
        bufp->chgBit(oldp+2177,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[8U] 
                                       >> 0x15U))));
        bufp->chgIData(oldp+2178,((0x7ffffffU & ((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[8U] 
                                                  << 6U) 
                                                 | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[7U] 
                                                    >> 0x1aU)))),27);
        bufp->chgIData(oldp+2179,(((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[6U] 
                                    << 6U) | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[5U] 
                                              >> 0x1aU))),32);
        bufp->chgIData(oldp+2180,(((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[7U] 
                                    << 6U) | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[6U] 
                                              >> 0x1aU))),32);
        bufp->chgBit(oldp+2181,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[0xbU] 
                                       >> 0x13U))));
        bufp->chgBit(oldp+2182,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[0xbU] 
                                       >> 0x12U))));
        bufp->chgIData(oldp+2183,((0x7ffffffU & ((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[0xbU] 
                                                  << 9U) 
                                                 | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[0xaU] 
                                                    >> 0x17U)))),27);
        bufp->chgIData(oldp+2184,(((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[9U] 
                                    << 9U) | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[8U] 
                                              >> 0x17U))),32);
        bufp->chgIData(oldp+2185,(((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[0xaU] 
                                    << 9U) | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[9U] 
                                              >> 0x17U))),32);
        bufp->chgWData(oldp+2186,(vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4),372);
        bufp->chgIData(oldp+2198,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__unnamedblk1__DOT__i),32);
        bufp->chgIData(oldp+2199,(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__addr),32);
        bufp->chgBit(oldp+2200,(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__ren));
        bufp->chgBit(oldp+2201,(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__wen));
        bufp->chgCData(oldp+2202,(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__byte_en),4);
    }
    bufp->chgBit(oldp+2203,(vlSelf->CLK));
    bufp->chgBit(oldp+2204,(vlSelf->nRST));
    bufp->chgQData(oldp+2205,(vlSelf->mtime),64);
    bufp->chgBit(oldp+2207,(vlSelf->wfi));
    bufp->chgBit(oldp+2208,(vlSelf->halt));
    bufp->chgBit(oldp+2209,(vlSelf->busy));
    bufp->chgIData(oldp+2210,(vlSelf->rdata),32);
    bufp->chgBit(oldp+2211,(vlSelf->ren));
    bufp->chgBit(oldp+2212,(vlSelf->wen));
    bufp->chgCData(oldp+2213,(vlSelf->byte_en),4);
    bufp->chgIData(oldp+2214,(vlSelf->addr),32);
    bufp->chgIData(oldp+2215,(vlSelf->wdata),32);
    bufp->chgBit(oldp+2216,(vlSelf->ext_int));
    bufp->chgBit(oldp+2217,(vlSelf->ext_int_clear));
    bufp->chgBit(oldp+2218,(vlSelf->soft_int));
    bufp->chgBit(oldp+2219,(vlSelf->soft_int_clear));
    bufp->chgBit(oldp+2220,(vlSelf->timer_int));
    bufp->chgBit(oldp+2221,(vlSelf->timer_int_clear));
    bufp->chgIData(oldp+2222,(((0U == vlSymsp->TOP__top_core.__PVT__CORE__DOT__mc__DOT__current_state)
                                ? (((IData)(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__ren) 
                                    | (IData)(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__wen))
                                    ? 4U : ((IData)(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__ren)
                                             ? 1U : 0U))
                                : ((1U == vlSymsp->TOP__top_core.__PVT__CORE__DOT__mc__DOT__current_state)
                                    ? ((IData)(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__ren)
                                        ? (((IData)(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__ren) 
                                            | (IData)(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__wen))
                                            ? 2U : 3U)
                                        : 0U) : ((2U 
                                                  == vlSymsp->TOP__top_core.__PVT__CORE__DOT__mc__DOT__current_state)
                                                  ? 
                                                 ((IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__busy)
                                                   ? 2U
                                                   : 6U)
                                                  : 
                                                 ((4U 
                                                   == vlSymsp->TOP__top_core.__PVT__CORE__DOT__mc__DOT__current_state)
                                                   ? 
                                                  ((IData)(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__ren)
                                                    ? 5U
                                                    : 6U)
                                                   : 
                                                  ((5U 
                                                    == vlSymsp->TOP__top_core.__PVT__CORE__DOT__mc__DOT__current_state)
                                                    ? 
                                                   ((1U 
                                                     & ((~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__ren)) 
                                                        & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__busy))))
                                                     ? 0U
                                                     : 
                                                    ((IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__busy)
                                                      ? 5U
                                                      : 3U))
                                                    : 
                                                   ((3U 
                                                     == vlSymsp->TOP__top_core.__PVT__CORE__DOT__mc__DOT__current_state)
                                                     ? 
                                                    ((IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__busy)
                                                      ? 
                                                     (((IData)(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__ren) 
                                                       | (IData)(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__wen))
                                                       ? 2U
                                                       : 
                                                      ((IData)(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__ren)
                                                        ? 3U
                                                        : 0U))
                                                      : 
                                                     (((IData)(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__ren) 
                                                       | (IData)(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__wen))
                                                       ? 4U
                                                       : 0U))
                                                     : 
                                                    ((6U 
                                                      == vlSymsp->TOP__top_core.__PVT__CORE__DOT__mc__DOT__current_state)
                                                      ? 
                                                     ((IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__busy)
                                                       ? 
                                                      ((IData)(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__ren)
                                                        ? 5U
                                                        : 6U)
                                                       : 
                                                      ((IData)(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__ren)
                                                        ? 1U
                                                        : 0U))
                                                      : 0U)))))))),32);
    bufp->chgIData(oldp+2223,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__int_ex_handler__DOT__int_src),31);
    bufp->chgBit(oldp+2224,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__int_ex_handler__DOT__interrupt));
    bufp->chgBit(oldp+2225,((((IData)(vlSelf->timer_int_clear) 
                              | (IData)(vlSelf->soft_int_clear)) 
                             | (IData)(vlSelf->ext_int_clear))));
    bufp->chgBit(oldp+2226,(((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__int_ex_handler__DOT__interrupt) 
                             | (((IData)(vlSelf->timer_int_clear) 
                                 | (IData)(vlSelf->soft_int_clear)) 
                                | (IData)(vlSelf->ext_int_clear)))));
}

void Vtop_core___024root__trace_cleanup(void* voidSelf, VerilatedFst* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_cleanup\n"); );
    // Init
    Vtop_core___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtop_core___024root*>(voidSelf);
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    vlSymsp->__Vm_activity = false;
    vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[2U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[3U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[4U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[5U] = 0U;
}
