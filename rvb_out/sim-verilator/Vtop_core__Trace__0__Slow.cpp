// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_fst_c.h"
#include "Vtop_core__Syms.h"


VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nRST",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declQuad(c+2206,"mtime",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 63,0);
    tracep->declBit(c+2208,"wfi",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2209,"halt",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2210,"busy",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+2211,"rdata",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+2212,"ren",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2213,"wen",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+2214,"byte_en",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 3,0);
    tracep->declBus(c+2215,"addr",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+2216,"wdata",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+2217,"ext_int",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2218,"ext_int_clear",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2219,"soft_int",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2220,"soft_int_clear",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2221,"timer_int",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2222,"timer_int_clear",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__top_core__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__top_core__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+2228,"RESET_PC",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nRST",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declQuad(c+2206,"mtime",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 63,0);
    tracep->declBit(c+2229,"wfi",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1762,"halt",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2210,"busy",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+2211,"rdata",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+995,"ren",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+996,"wen",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+997,"byte_en",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 3,0);
    tracep->declBus(c+998,"addr",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+999,"wdata",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+2217,"ext_int",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2218,"ext_int_clear",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2219,"soft_int",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2220,"soft_int_clear",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2221,"timer_int",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2222,"timer_int_clear",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->pushNamePrefix("CORE ");
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nRST",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declQuad(c+2206,"mtime",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 63,0);
    tracep->declBit(c+2229,"wfi",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1762,"halt",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+2228,"RESET_PC",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->pushNamePrefix("branch_predictor_i ");
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nRST",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->pushNamePrefix("genblk1 ");
    tracep->pushNamePrefix("predictor ");
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nRST",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(3);
    tracep->pushNamePrefix("g_generic_bus_if ");
    tracep->pushNamePrefix("bt ");
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nRST",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+79,"next_wdata",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+2230,"next_busy",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("mc ");
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nRST",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    {
        const char* __VenumItemNames[]
        = {"IDLE", "INSTR_REQ", "INSTR_DATA_REQ", "INSTR_WAIT", 
                                "DATA_REQ", "DATA_INSTR_REQ", 
                                "DATA_WAIT"};
        const char* __VenumItemValues[]
        = {"0", "1", "10", "11", "100", "101", "110"};
        tracep->declDTypeEnum(1, "memory_controller.state_t", 7, 32, __VenumItemNames, __VenumItemValues);
    }
    tracep->declBus(c+1000,"current_state",1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2223,"next_state",1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+79,"wdata",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2211,"rdata",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pipeline ");
    tracep->declBus(c+2228,"RESET_PC",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nRST",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1762,"halt",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2229,"wfi",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->pushNamePrefix("execute_stage_i ");
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nRST",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1763,"wfi",-1, FST_VD_IMPLICIT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2231,"rv32m_busy",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2232,"rv32m_out",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+23,"ex_out",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+24,"rs1_post_fwd",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+25,"rs2_post_fwd",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1764,"imm_I_ext",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1765,"imm_S_ext",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1766,"imm_UJ_ext",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+26,"jump_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1767,"imm_or_shamt",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+2233,"mal_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+27,"resolved_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+28,"branch_taken",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1768,"branch_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+29,"brj_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->pushNamePrefix("RV32M_FU ");
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nRST",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2231,"rv32m_start",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    {
        const char* __VenumItemNames[]
        = {"MUL", "MULH", "MULHSU", "MULHU", "DIV", 
                                "DIVU", "REM", "REMU"};
        const char* __VenumItemValues[]
        = {"0", "1", "10", "11", "100", "101", "110", 
                                "111"};
        tracep->declDTypeEnum(2, "rv32m_pkg::rv32m_op_t", 8, 3, __VenumItemNames, __VenumItemValues);
    }
    tracep->declBus(c+2234,"operation",2,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 2,0);
    tracep->declBus(c+24,"rv32m_a",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+25,"rv32m_b",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+2231,"rv32m_busy",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+2232,"rv32m_out",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("RV32M ");
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nRST",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2231,"rv32m_start",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+2234,"operation",2,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 2,0);
    tracep->declBus(c+24,"rv32m_a",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+25,"rv32m_b",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+2231,"rv32m_busy",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+2232,"rv32m_out",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("alu ");
    tracep->declBus(c+30,"adder_result",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+31,"op_a",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+32,"op_b",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+33,"twos_comp_b",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+34,"carry_out",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+35,"sign_r",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+36,"sign_a",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+37,"sign_b",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declQuad(c+38,"adder_out",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 32,0);
    tracep->declQuad(c+40,"op_a_ext",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 32,0);
    tracep->declQuad(c+42,"op_b_ext",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 32,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("branch_res ");
    tracep->declBus(c+1769,"offset",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+44,"lt",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+45,"eq",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+46,"ltu",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+47,"sign_1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+48,"sign_2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+49,"sign_r",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+50,"carry_out",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declQuad(c+51,"adder_out",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 32,0);
    tracep->declQuad(c+53,"op_1_ext",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 32,0);
    tracep->declQuad(c+55,"op_2_ext",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 32,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("cu ");
    tracep->declBus(c+2235,"rmgmt_rsel_s_0",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 4,0);
    tracep->declBus(c+2235,"rmgmt_rsel_s_1",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 4,0);
    tracep->declBus(c+2235,"rmgmt_rsel_d",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 4,0);
    tracep->declBit(c+2231,"rmgmt_req_reg_r",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2231,"rmgmt_req_reg_w",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->pushNamePrefix("instr_s\206 ");
    tracep->declBus(c+1770,"imm11_05",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 6,0);
    tracep->declBus(c+1771,"rs2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->declBus(c+1772,"rs1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->declBus(c+1773,"funct3",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBus(c+1774,"imm04_00",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    {
        const char* __VenumItemNames[]
        = {"LUI", "AUIPC", "JAL", "JALR", "BRANCH", 
                                "LOAD", "STORE", "IMMED", 
                                "REGREG", "SYSTEM", 
                                "MISCMEM"};
        const char* __VenumItemValues[]
        = {"110111", "10111", "1101111", "1100111", 
                                "1100011", "11", "100011", 
                                "10011", "110011", 
                                "1110011", "1111"};
        tracep->declDTypeEnum(3, "rv32i_types_pkg::opcode_t", 11, 7, __VenumItemNames, __VenumItemValues);
    }
    tracep->declBus(c+1775,"opcode",3, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 6,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("instr_i\206 ");
    tracep->declBus(c+1776,"imm11_00",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 11,0);
    tracep->declBus(c+1772,"rs1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->declBus(c+1773,"funct3",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBus(c+1774,"rd",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->declBus(c+1775,"opcode",3, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 6,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("instr_r\206 ");
    tracep->declBus(c+1770,"funct7",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 6,0);
    tracep->declBus(c+1771,"rs2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->declBus(c+1772,"rs1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->declBus(c+1773,"funct3",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBus(c+1774,"rd",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->declBus(c+1775,"opcode",3, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 6,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("instr_sb\206 ");
    tracep->declBit(c+1777,"imm12",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1778,"imm10_05",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 5,0);
    tracep->declBus(c+1771,"rs2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->declBus(c+1772,"rs1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->declBus(c+1773,"funct3",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBus(c+1779,"imm04_01",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 3,0);
    tracep->declBit(c+1780,"imm11",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1775,"opcode",3, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 6,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("instr_u\206 ");
    tracep->declBus(c+1781,"imm31_12",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 19,0);
    tracep->declBus(c+1774,"rd",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->declBus(c+1775,"opcode",3, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 6,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("instr_uj\206 ");
    tracep->declBit(c+1777,"imm20",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1782,"imm10_01",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 9,0);
    tracep->declBit(c+1783,"imm11",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1784,"imm19_12",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 7,0);
    tracep->declBus(c+1774,"rd",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->declBus(c+1775,"opcode",3, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 6,0);
    tracep->popNamePrefix(1);
    tracep->declBit(c+1785,"maybe_illegal",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"claimed",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"rv32m_claim",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1786,"sr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1787,"aluop_srl",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1788,"aluop_sra",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1789,"aluop_add",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1790,"aluop_sub",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1791,"aluop_and",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1792,"aluop_or",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1793,"aluop_sll",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1794,"aluop_xor",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1795,"aluop_slt",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1796,"aluop_sltu",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1797,"add_sub",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("g_rfile_select ");
    tracep->pushNamePrefix("rf ");
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nRST",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+2236,"NUM_REGS",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->pushNamePrefix("registers");
    tracep->declBus(c+1001,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1002,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1003,"[2]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1004,"[3]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1005,"[4]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1006,"[5]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1007,"[6]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1008,"[7]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1009,"[8]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1010,"[9]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1011,"[10]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1012,"[11]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1013,"[12]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1014,"[13]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1015,"[14]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1016,"[15]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1017,"[16]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1018,"[17]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1019,"[18]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1020,"[19]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1021,"[20]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1022,"[21]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1023,"[22]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1024,"[23]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1025,"[24]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1026,"[25]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1027,"[26]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1028,"[27]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1029,"[28]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1030,"[29]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1031,"[30]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1032,"[31]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("jump_calc ");
    tracep->declBus(c+57,"jump_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("fetch_stage_i ");
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nRST",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+2228,"RESET_PC",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+1798,"pc",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1799,"pc4or2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+58,"npc",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+80,"instr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+1800,"mal_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"fault_insn",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1800,"mal_insn",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1801,"badaddr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+81,"instr_to_ex",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("forward_unit_i ");
    tracep->declBit(c+1802,"rs1_match",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1803,"rs2_match",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("hazard_unit_i ");
    tracep->declBit(c+1804,"dmem_access",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1805,"branch_jump",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+82,"wait_for_imem",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+83,"wait_for_dmem",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1806,"rs1_match",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1807,"rs2_match",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+68,"mem_use_stall",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+69,"cannot_forward",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2237,"fetch_busy",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2238,"execute_busy",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2239,"mem_busy",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+84,"ex_flush_hazard",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1808,"exception",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1809,"intr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1810,"epc",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("mem_stage_i ");
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nRST",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1762,"halt",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2229,"wfi",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1811,"store_swapped",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+85,"dload_ext",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+1812,"mal_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1813,"byte_offset",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1814,"byte_en",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 3,0);
    tracep->declBus(c+1814,"byte_en_temp",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 3,0);
    tracep->declBus(c+1814,"byte_en_standard",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 3,0);
    tracep->declBit(c+1033,"ifence_reg",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1815,"ifence_pulse",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1034,"iflushed",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1660,"iflushed_next",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1035,"dflushed",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1661,"dflushed_next",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2240,"iflush_done_reg",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2241,"dflush_done_reg",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+70,"wb_stall",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1816,"funct3",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBus(c+1817,"funct12",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 11,0);
    tracep->declBit(c+1818,"instr_30",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->pushNamePrefix("cpu_track1 ");
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+70,"wb_stall",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1818,"instr_30",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1819,"instr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1820,"pc",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1821,"opcode",3,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 6,0);
    tracep->declBus(c+1816,"funct3",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 2,0);
    tracep->declBus(c+1817,"funct12",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 11,0);
    tracep->declBus(c+1822,"rs1",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 4,0);
    tracep->declBus(c+1823,"rs2",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 4,0);
    tracep->declBus(c+1824,"rd",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 4,0);
    tracep->declBus(c+1825,"imm_SB",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 12,0);
    tracep->declBus(c+1826,"imm_S",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 11,0);
    tracep->declBus(c+1827,"imm_I",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 11,0);
    tracep->declBus(c+1828,"imm_UJ",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 20,0);
    tracep->declBus(c+1829,"imm_U",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+2242,"CPUID",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+1,"fptr",-1, FST_VD_IMPLICIT,FST_VT_VCD_INTEGER, false,-1, 31,0);
    tracep->declQuad(c+1830,"pc64",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 63,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("dmem_ext ");
    tracep->declBus(c+86,"dmem_in",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    {
        const char* __VenumItemNames[]
        = {"LB", "LH", "LW", "LBU", "LHU"};
        const char* __VenumItemValues[]
        = {"0", "1", "10", "100", "101"};
        tracep->declDTypeEnum(4, "rv32i_types_pkg::load_t", 5, 3, __VenumItemNames, __VenumItemValues);
    }
    tracep->declBus(c+1832,"load_type",4,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 2,0);
    tracep->declBus(c+1814,"byte_en",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 3,0);
    tracep->declBus(c+85,"ext_out",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("store_swap ");
    tracep->declBus(c+2243,"N_BYTES",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2236,"N_BITS",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+1833,"word_in",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1811,"word_out",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->popNamePrefix(3);
    tracep->pushNamePrefix("priv_wrapper_i ");
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nRST",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declQuad(c+2206,"mtime",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 63,0);
    tracep->pushNamePrefix("priv_block_i ");
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nRST",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declQuad(c+2206,"mtime",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 63,0);
    tracep->pushNamePrefix("csr ");
    tracep->declBus(c+2242,"HARTID",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nRST",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declQuad(c+2206,"mtime",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 63,0);
    tracep->declBus(c+2232,"mvendorid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2232,"marchid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2232,"mimpid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2242,"mhartid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2232,"mconfigptr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->pushNamePrefix("mstatus\206 ");
    tracep->declBit(c+1036,"sd",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1037,"reserved_3",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 7,0);
    tracep->declBit(c+1038,"tsr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1039,"tw",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1040,"tvm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1041,"mxr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1042,"sum",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1043,"mprv",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    {
        const char* __VenumItemNames[]
        = {"XS_ALL_OFF", "XS_NONE_DC", "XS_NONE_D", 
                                "XS_SOME_D"};
        const char* __VenumItemValues[]
        = {"0", "1", "10", "11"};
        tracep->declDTypeEnum(5, "machine_mode_types_1_12_pkg::xs_t", 4, 2, __VenumItemNames, __VenumItemValues);
    }
    tracep->declBus(c+1044,"xs",5, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    {
        const char* __VenumItemNames[]
        = {"FS_OFF", "FS_INITIAL", "FS_CLEAN", "FS_DIRTY"};
        const char* __VenumItemValues[]
        = {"0", "1", "10", "11"};
        tracep->declDTypeEnum(6, "machine_mode_types_1_12_pkg::fs_t", 4, 2, __VenumItemNames, __VenumItemValues);
    }
    tracep->declBus(c+1045,"fs",6, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    {
        const char* __VenumItemNames[]
        = {"U_MODE", "S_MODE", "RESERVED_MODE", "M_MODE"};
        const char* __VenumItemValues[]
        = {"0", "1", "10", "11"};
        tracep->declDTypeEnum(7, "machine_mode_types_1_12_pkg::priv_level_t", 4, 2, __VenumItemNames, __VenumItemValues);
    }
    tracep->declBus(c+1046,"mpp",7, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    {
        const char* __VenumItemNames[]
        = {"VS_OFF", "VS_INITIAL", "VS_CLEAN", "VS_DIRTY"};
        const char* __VenumItemValues[]
        = {"0", "1", "10", "11"};
        tracep->declDTypeEnum(8, "machine_mode_types_1_12_pkg::vs_t", 4, 2, __VenumItemNames, __VenumItemValues);
    }
    tracep->declBus(c+1047,"vs",8, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1048,"spp",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1049,"mpie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1050,"ube",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1051,"spie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1052,"reserved_2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1053,"mie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1054,"reserved_1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1055,"sie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1056,"reserved_0",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("mstatus_next\206 ");
    tracep->declBit(c+87,"sd",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+88,"reserved_3",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 7,0);
    tracep->declBit(c+89,"tsr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+90,"tw",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+91,"tvm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+92,"mxr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+93,"sum",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+94,"mprv",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+95,"xs",5, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+96,"fs",6, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+97,"mpp",7, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+98,"vs",8, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+99,"spp",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+100,"mpie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+101,"ube",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+102,"spie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+103,"reserved_2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+104,"mie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+105,"reserved_1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+106,"sie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+107,"reserved_0",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("misa\206 ");
    {
        const char* __VenumItemNames[]
        = {"BASE_RV32", "BASE_RV64", "BASE_RV128"};
        const char* __VenumItemValues[]
        = {"1", "10", "11"};
        tracep->declDTypeEnum(9, "machine_mode_types_1_12_pkg::misa_base_t", 3, 2, __VenumItemNames, __VenumItemValues);
    }
    tracep->declBus(c+2244,"base",9, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+2245,"zero",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 3,0);
    tracep->declBus(c+2246,"extensions",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 25,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("mie\206 ");
    tracep->declBus(c+1057,"impl_defined",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 15,0);
    tracep->declBus(c+1058,"zero_6",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 3,0);
    tracep->declBit(c+1059,"meie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1060,"zero_5",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1061,"seie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1062,"zero_4",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1063,"mtie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1064,"zero_3",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1065,"stie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1066,"zero_2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1067,"msie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1068,"zero_1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1069,"ssie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1070,"zero_0",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("mie_next\206 ");
    tracep->declBus(c+108,"impl_defined",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 15,0);
    tracep->declBus(c+109,"zero_6",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 3,0);
    tracep->declBit(c+110,"meie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+111,"zero_5",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+112,"seie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+113,"zero_4",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+114,"mtie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+115,"zero_3",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+116,"stie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+117,"zero_2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+118,"msie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+119,"zero_1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+120,"ssie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+121,"zero_0",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("mtvec\206 ");
    tracep->declBus(c+1071,"base",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 29,0);
    {
        const char* __VenumItemNames[]
        = {"DIRECT", "VECTORED", "RES_0", "RES_1"};
        const char* __VenumItemValues[]
        = {"0", "1", "10", "11"};
        tracep->declDTypeEnum(10, "machine_mode_types_1_12_pkg::vector_modes_t", 4, 2, __VenumItemNames, __VenumItemValues);
    }
    tracep->declBus(c+1072,"mode",10, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("mtvec_next\206 ");
    tracep->declBus(c+122,"base",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 29,0);
    tracep->declBus(c+123,"mode",10, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("mstatush\206 ");
    tracep->declBus(c+2247,"reserved_1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 25,0);
    tracep->declBit(c+2248,"mbe",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2249,"sbe",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2250,"reserved_0",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 3,0);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1073,"mscratch",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+124,"mscratch_next",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1074,"mepc",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+125,"mepc_next",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->pushNamePrefix("mcause\206 ");
    tracep->declBit(c+1075,"__SYM__interrupt",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1076,"cause",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 30,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("mcause_next\206 ");
    tracep->declBit(c+126,"__SYM__interrupt",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+127,"cause",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 30,0);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1077,"mtval",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+128,"mtval_next",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->pushNamePrefix("mip\206 ");
    tracep->declBus(c+1078,"impl_defined",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 15,0);
    tracep->declBus(c+1079,"zero_6",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 3,0);
    tracep->declBit(c+1080,"meip",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1081,"zero_5",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1082,"seip",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1083,"zero_4",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1084,"mtip",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1085,"zero_3",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1086,"stip",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1087,"zero_2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1088,"msip",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1089,"zero_1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1090,"ssip",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1091,"zero_0",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("mip_next\206 ");
    tracep->declBus(c+129,"impl_defined",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 15,0);
    tracep->declBus(c+130,"zero_6",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 3,0);
    tracep->declBit(c+131,"meip",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+132,"zero_5",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+133,"seip",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+134,"zero_4",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+135,"mtip",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+136,"zero_3",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+137,"stip",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+138,"zero_2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+139,"msip",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+140,"zero_1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+141,"ssip",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+142,"zero_0",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("mcounteren\206 ");
    tracep->declBit(c+1092,"hpm31",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1093,"hpm30",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1094,"hpm29",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1095,"hpm28",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1096,"hpm27",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1097,"hpm26",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1098,"hpm25",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1099,"hpm24",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1100,"hpm23",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1101,"hpm22",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1102,"hpm21",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1103,"hpm20",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1104,"hpm19",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1105,"hpm18",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1106,"hpm17",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1107,"hpm16",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1108,"hpm15",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1109,"hpm14",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1110,"hpm13",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1111,"hpm12",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1112,"hpm11",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1113,"hpm10",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1114,"hpm9",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1115,"hpm8",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1116,"hpm7",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1117,"hpm6",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1118,"hpm5",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1119,"hpm4",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1120,"hpm3",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1121,"ir",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1122,"tm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1123,"cy",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("mcounteren_next\206 ");
    tracep->declBit(c+143,"hpm31",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+144,"hpm30",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+145,"hpm29",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+146,"hpm28",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+147,"hpm27",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+148,"hpm26",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+149,"hpm25",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+150,"hpm24",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+151,"hpm23",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+152,"hpm22",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+153,"hpm21",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+154,"hpm20",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+155,"hpm19",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+156,"hpm18",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+157,"hpm17",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+158,"hpm16",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+159,"hpm15",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+160,"hpm14",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+161,"hpm13",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+162,"hpm12",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+163,"hpm11",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+164,"hpm10",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+165,"hpm9",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+166,"hpm8",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+167,"hpm7",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+168,"hpm6",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+169,"hpm5",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+170,"hpm4",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+171,"hpm3",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+172,"ir",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+173,"tm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+174,"cy",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("mcounterinhibit\206 ");
    tracep->declBit(c+1124,"hpm31",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1125,"hpm30",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1126,"hpm29",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1127,"hpm28",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1128,"hpm27",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1129,"hpm26",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1130,"hpm25",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1131,"hpm24",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1132,"hpm23",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1133,"hpm22",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1134,"hpm21",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1135,"hpm20",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1136,"hpm19",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1137,"hpm18",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1138,"hpm17",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1139,"hpm16",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1140,"hpm15",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1141,"hpm14",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1142,"hpm13",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1143,"hpm12",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1144,"hpm11",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1145,"hpm10",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1146,"hpm9",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1147,"hpm8",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1148,"hpm7",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1149,"hpm6",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1150,"hpm5",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1151,"hpm4",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1152,"hpm3",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1153,"ir",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1154,"reserved_0",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1155,"cy",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("mcounterinhibit_next\206 ");
    tracep->declBit(c+175,"hpm31",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+176,"hpm30",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+177,"hpm29",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+178,"hpm28",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+179,"hpm27",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+180,"hpm26",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+181,"hpm25",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+182,"hpm24",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+183,"hpm23",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+184,"hpm22",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+185,"hpm21",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+186,"hpm20",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+187,"hpm19",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+188,"hpm18",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+189,"hpm17",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+190,"hpm16",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+191,"hpm15",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+192,"hpm14",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+193,"hpm13",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+194,"hpm12",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+195,"hpm11",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+196,"hpm10",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+197,"hpm9",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+198,"hpm8",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+199,"hpm7",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+200,"hpm6",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+201,"hpm5",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+202,"hpm4",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+203,"hpm3",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+204,"ir",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+205,"reserved_0",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+206,"cy",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1156,"mcycle",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1157,"minstret",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1158,"mcycleh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1159,"minstreth",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declQuad(c+1160,"cycles_full",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 63,0);
    tracep->declQuad(c+207,"cf_next",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 63,0);
    tracep->declQuad(c+1162,"instret_full",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 63,0);
    tracep->declQuad(c+209,"if_next",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 63,0);
    tracep->declBus(c+211,"nxt_csr_val",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+1834,"invalid_csr_priv",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1835,"invalid_csr_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1836,"csr_operation",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+212,"inject_mcycle",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+213,"inject_minstret",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+214,"inject_mcycleh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+215,"inject_minstreth",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("int_ex_handler ");
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nRST",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    {
        const char* __VenumItemNames[]
        = {"INSN_MAL", "INSN_ACCESS", "ILLEGAL_INSN", 
                                "BREAKPOINT", "L_ADDR_MAL", 
                                "L_FAULT", "S_ADDR_MAL", 
                                "S_FAULT", "ENV_CALL_U", 
                                "ENV_CALL_S", "ENV_CALL_M", 
                                "INSN_PAGE", "LOAD_PAGE", 
                                "STORE_PAGE"};
        const char* __VenumItemValues[]
        = {"0", "1", "10", "11", "100", "101", "110", 
                                "111", "1000", "1001", 
                                "1011", "1100", "1101", 
                                "1111"};
        tracep->declDTypeEnum(11, "machine_mode_types_1_12_pkg::ex_code_t", 14, 31, __VenumItemNames, __VenumItemValues);
    }
    tracep->declBus(c+1837,"ex_src",11, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 30,0);
    tracep->declBit(c+1838,"exception",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    {
        const char* __VenumItemNames[]
        = {"SOFT_INT_S", "SOFT_INT_M", "TIMER_INT_S", 
                                "TIMER_INT_M", "EXT_INT_S", 
                                "EXT_INT_M"};
        const char* __VenumItemValues[]
        = {"1", "11", "101", "111", "1001", "1011"};
        tracep->declDTypeEnum(12, "machine_mode_types_1_12_pkg::int_code_t", 6, 31, __VenumItemNames, __VenumItemValues);
    }
    tracep->declBus(c+2224,"int_src",12, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 30,0);
    tracep->declBit(c+2225,"interrupt",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2226,"clear_interrupt",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1164,"interrupt_fired",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("mode ");
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nRST",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1165,"curr_priv_level",7, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1839,"next_priv_level",7, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pipe_ctrl ");
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma ");
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nRST",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->pushNamePrefix("pma_regs");
    tracep->pushNamePrefix("[0]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+1166,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1167,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1168,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1169,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    {
        const char* __VenumItemNames[]
        = {"ByteAcc", "HWLower", "HWUpper", "WordAcc", 
                                "Burst2W", "Burst4W", 
                                "Burst8W", "AccWidthReserved"};
        const char* __VenumItemValues[]
        = {"0", "1", "10", "11", "100", "101", "110", 
                                "111"};
        tracep->declDTypeEnum(13, "pma_types_1_12_pkg::pma_accwidth_t", 8, 3, __VenumItemNames, __VenumItemValues);
    }
    tracep->declBus(c+1170,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1171,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1172,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1173,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    {
        const char* __VenumItemNames[]
        = {"RsrvNone", "RsrvNonEventual", "RsrvEventual", 
                                "RsrvReserved"};
        const char* __VenumItemValues[]
        = {"0", "1", "10", "11"};
        tracep->declDTypeEnum(14, "pma_types_1_12_pkg::pma_rsrv_t", 4, 2, __VenumItemNames, __VenumItemValues);
    }
    tracep->declBus(c+1174,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    {
        const char* __VenumItemNames[]
        = {"AMONone", "AMOSwap", "AMOLogical", "AMOArithmetic"};
        const char* __VenumItemValues[]
        = {"0", "1", "10", "11"};
        tracep->declDTypeEnum(15, "pma_types_1_12_pkg::pma_amo_t", 4, 2, __VenumItemNames, __VenumItemValues);
    }
    tracep->declBus(c+1175,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1176,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+1177,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1178,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1179,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1180,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1181,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1182,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1183,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1184,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1185,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1186,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1187,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[1]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+1188,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1189,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1190,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1191,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1192,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1193,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1194,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1195,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1196,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1197,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1198,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+1199,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1200,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1201,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1202,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1203,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1204,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1205,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1206,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1207,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1208,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1209,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[2]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+1210,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1211,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1212,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1213,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1214,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1215,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1216,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1217,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1218,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1219,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1220,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+1221,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1222,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1223,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1224,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1225,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1226,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1227,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1228,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1229,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1230,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1231,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[3]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+1232,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1233,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1234,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1235,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1236,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1237,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1238,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1239,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1240,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1241,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1242,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+1243,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1244,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1245,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1246,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1247,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1248,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1249,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1250,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1251,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1252,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1253,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[4]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+1254,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1255,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1256,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1257,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1258,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1259,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1260,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1261,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1262,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1263,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1264,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+1265,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1266,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1267,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1268,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1269,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1270,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1271,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1272,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1273,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1274,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1275,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[5]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+1276,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1277,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1278,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1279,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1280,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1281,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1282,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1283,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1284,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1285,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1286,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+1287,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1288,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1289,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1290,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1291,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1292,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1293,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1294,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1295,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1296,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1297,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[6]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+1298,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1299,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1300,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1301,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1302,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1303,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1304,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1305,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1306,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1307,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1308,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+1309,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1310,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1311,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1312,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1313,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1314,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1315,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1316,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1317,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1318,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1319,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[7]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+1320,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1321,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1322,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1323,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1324,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1325,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1326,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1327,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1328,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1329,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1330,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+1331,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1332,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1333,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1334,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1335,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1336,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1337,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1338,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1339,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1340,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1341,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[8]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+1342,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1343,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1344,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1345,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1346,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1347,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1348,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1349,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1350,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1351,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1352,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+1353,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1354,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1355,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1356,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1357,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1358,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1359,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1360,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1361,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1362,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1363,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[9]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+1364,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1365,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1366,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1367,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1368,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1369,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1370,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1371,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1372,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1373,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1374,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+1375,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1376,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1377,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1378,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1379,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1380,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1381,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1382,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1383,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1384,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1385,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[10]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+1386,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1387,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1388,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1389,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1390,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1391,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1392,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1393,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1394,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1395,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1396,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+1397,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1398,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1399,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1400,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1401,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1402,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1403,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1404,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1405,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1406,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1407,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[11]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+1408,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1409,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1410,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1411,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1412,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1413,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1414,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1415,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1416,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1417,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1418,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+1419,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1420,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1421,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1422,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1423,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1424,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1425,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1426,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1427,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1428,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1429,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[12]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+1430,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1431,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1432,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1433,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1434,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1435,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1436,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1437,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1438,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1439,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1440,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+1441,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1442,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1443,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1444,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1445,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1446,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1447,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1448,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1449,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1450,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1451,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[13]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+1452,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1453,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1454,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1455,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1456,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1457,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1458,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1459,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1460,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1461,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1462,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+1463,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1464,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1465,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1466,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1467,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1468,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1469,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1470,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1471,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1472,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1473,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[14]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+1474,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1475,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1476,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1477,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1478,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1479,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1480,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1481,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1482,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1483,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1484,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+1485,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1486,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1487,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1488,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1489,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1490,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1491,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1492,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1493,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1494,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1495,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[15]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+1496,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1497,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1498,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1499,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1500,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1501,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1502,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1503,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1504,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1505,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1506,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+1507,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1508,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1509,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1510,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1511,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1512,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1513,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1514,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1515,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1516,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1517,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("nxt_pma_regs");
    tracep->pushNamePrefix("[0]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+216,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+217,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+218,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+219,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+220,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+221,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+222,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+223,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+224,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+225,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+226,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+227,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+228,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+229,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+230,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+231,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+232,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+233,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+234,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+235,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+236,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+237,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[1]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+238,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+239,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+240,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+241,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+242,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+243,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+244,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+245,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+246,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+247,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+248,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+249,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+250,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+251,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+252,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+253,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+254,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+255,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+256,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+257,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+258,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+259,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[2]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+260,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+261,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+262,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+263,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+264,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+265,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+266,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+267,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+268,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+269,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+270,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+271,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+272,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+273,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+274,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+275,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+276,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+277,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+278,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+279,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+280,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+281,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[3]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+282,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+283,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+284,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+285,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+286,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+287,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+288,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+289,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+290,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+291,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+292,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+293,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+294,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+295,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+296,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+297,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+298,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+299,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+300,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+301,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+302,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+303,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[4]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+304,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+305,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+306,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+307,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+308,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+309,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+310,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+311,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+312,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+313,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+314,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+315,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+316,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+317,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+318,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+319,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+320,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+321,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+322,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+323,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+324,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+325,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[5]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+326,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+327,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+328,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+329,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+330,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+331,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+332,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+333,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+334,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+335,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+336,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+337,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+338,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+339,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+340,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+341,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+342,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+343,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+344,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+345,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+346,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+347,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[6]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+348,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+349,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+350,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+351,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+352,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+353,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+354,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+355,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+356,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+357,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+358,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+359,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+360,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+361,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+362,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+363,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+364,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+365,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+366,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+367,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+368,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+369,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[7]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+370,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+371,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+372,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+373,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+374,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+375,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+376,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+377,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+378,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+379,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+380,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+381,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+382,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+383,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+384,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+385,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+386,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+387,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+388,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+389,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+390,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+391,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[8]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+392,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+393,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+394,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+395,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+396,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+397,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+398,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+399,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+400,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+401,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+402,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+403,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+404,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+405,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+406,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+407,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+408,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+409,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+410,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+411,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+412,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+413,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[9]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+414,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+415,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+416,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+417,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+418,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+419,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+420,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+421,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+422,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+423,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+424,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+425,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+426,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+427,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+428,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+429,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+430,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+431,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+432,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+433,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+434,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+435,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[10]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+436,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+437,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+438,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+439,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+440,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+441,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+442,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+443,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+444,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+445,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+446,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+447,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+448,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+449,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+450,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+451,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+452,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+453,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+454,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+455,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+456,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+457,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[11]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+458,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+459,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+460,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+461,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+462,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+463,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+464,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+465,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+466,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+467,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+468,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+469,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+470,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+471,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+472,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+473,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+474,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+475,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+476,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+477,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+478,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+479,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[12]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+480,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+481,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+482,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+483,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+484,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+485,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+486,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+487,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+488,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+489,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+490,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+491,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+492,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+493,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+494,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+495,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+496,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+497,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+498,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+499,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+500,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+501,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[13]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+502,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+503,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+504,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+505,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+506,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+507,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+508,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+509,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+510,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+511,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+512,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+513,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+514,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+515,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+516,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+517,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+518,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+519,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+520,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+521,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+522,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+523,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[14]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+524,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+525,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+526,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+527,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+528,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+529,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+530,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+531,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+532,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+533,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+534,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+535,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+536,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+537,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+538,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+539,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+540,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+541,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+542,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+543,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+544,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+545,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[15]\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+546,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+547,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+548,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+549,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+550,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+551,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+552,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+553,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+554,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+555,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+556,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+557,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+558,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+559,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+560,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+561,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+562,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+563,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+564,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+565,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+566,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+567,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("active_reg_d\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+1840,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1841,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1842,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1843,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1844,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1845,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1846,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1847,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1848,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1849,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1850,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+1851,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1852,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1853,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1854,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1855,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1856,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1857,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1858,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1859,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1860,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1861,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("active_reg_i\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+1862,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1863,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1864,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1865,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1866,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1867,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1868,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1869,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1870,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1871,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1872,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+1873,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1874,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1875,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1876,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1877,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1878,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1879,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1880,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1881,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1882,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1883,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_d\206 ");
    tracep->declBus(c+1884,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1885,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1886,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1887,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1888,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1889,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1890,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1891,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1892,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1893,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1894,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_i\206 ");
    tracep->declBus(c+1895,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1896,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1897,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1898,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1899,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1900,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1901,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1902,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1903,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1904,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1905,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("new_val\206 ");
    tracep->pushNamePrefix("pma_cfg_1\206 ");
    tracep->declBus(c+568,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+569,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+570,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+571,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+572,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+573,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+574,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+575,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+576,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+577,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+578,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pma_cfg_0\206 ");
    tracep->declBus(c+579,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+580,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+581,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+582,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+583,"AccWidth",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+584,"Idm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+585,"Cache",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+586,"Coh",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+587,"Rsrv",14, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+588,"AMO",15, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+589,"MIO",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pmp ");
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nRST",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->pushNamePrefix("pmp_cfg_regs");
    tracep->pushNamePrefix("[0]");
    tracep->pushNamePrefix("[0]\206 ");
    tracep->declBit(c+1518,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1519,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    {
        const char* __VenumItemNames[]
        = {"OFF", "TOR", "NA4", "NAPOT"};
        const char* __VenumItemValues[]
        = {"0", "1", "10", "11"};
        tracep->declDTypeEnum(16, "pmp_types_1_12_pkg::pmp_mode_t", 4, 2, __VenumItemNames, __VenumItemValues);
    }
    tracep->declBus(c+1520,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1521,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1522,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1523,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[1]\206 ");
    tracep->declBit(c+1524,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1525,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1526,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1527,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1528,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1529,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[2]\206 ");
    tracep->declBit(c+1530,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1531,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1532,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1533,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1534,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1535,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[3]\206 ");
    tracep->declBit(c+1536,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1537,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1538,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1539,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1540,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1541,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[1]");
    tracep->pushNamePrefix("[0]\206 ");
    tracep->declBit(c+1542,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1543,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1544,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1545,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1546,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1547,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[1]\206 ");
    tracep->declBit(c+1548,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1549,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1550,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1551,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1552,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1553,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[2]\206 ");
    tracep->declBit(c+1554,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1555,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1556,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1557,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1558,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1559,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[3]\206 ");
    tracep->declBit(c+1560,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1561,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1562,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1563,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1564,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1565,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[2]");
    tracep->pushNamePrefix("[0]\206 ");
    tracep->declBit(c+1566,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1567,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1568,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1569,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1570,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1571,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[1]\206 ");
    tracep->declBit(c+1572,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1573,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1574,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1575,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1576,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1577,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[2]\206 ");
    tracep->declBit(c+1578,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1579,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1580,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1581,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1582,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1583,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[3]\206 ");
    tracep->declBit(c+1584,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1585,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1586,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1587,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1588,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1589,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[3]");
    tracep->pushNamePrefix("[0]\206 ");
    tracep->declBit(c+1590,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1591,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1592,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1593,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1594,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1595,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[1]\206 ");
    tracep->declBit(c+1596,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1597,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1598,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1599,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1600,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1601,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[2]\206 ");
    tracep->declBit(c+1602,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1603,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1604,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1605,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1606,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1607,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[3]\206 ");
    tracep->declBit(c+1608,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1609,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1610,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1611,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1612,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1613,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("nxt_pmp_cfg");
    tracep->pushNamePrefix("[0]");
    tracep->pushNamePrefix("[0]\206 ");
    tracep->declBit(c+590,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+591,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+592,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+593,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+594,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+595,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[1]\206 ");
    tracep->declBit(c+596,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+597,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+598,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+599,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+600,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+601,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[2]\206 ");
    tracep->declBit(c+602,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+603,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+604,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+605,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+606,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+607,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[3]\206 ");
    tracep->declBit(c+608,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+609,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+610,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+611,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+612,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+613,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[1]");
    tracep->pushNamePrefix("[0]\206 ");
    tracep->declBit(c+614,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+615,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+616,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+617,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+618,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+619,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[1]\206 ");
    tracep->declBit(c+620,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+621,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+622,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+623,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+624,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+625,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[2]\206 ");
    tracep->declBit(c+626,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+627,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+628,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+629,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+630,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+631,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[3]\206 ");
    tracep->declBit(c+632,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+633,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+634,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+635,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+636,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+637,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[2]");
    tracep->pushNamePrefix("[0]\206 ");
    tracep->declBit(c+638,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+639,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+640,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+641,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+642,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+643,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[1]\206 ");
    tracep->declBit(c+644,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+645,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+646,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+647,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+648,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+649,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[2]\206 ");
    tracep->declBit(c+650,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+651,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+652,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+653,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+654,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+655,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[3]\206 ");
    tracep->declBit(c+656,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+657,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+658,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+659,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+660,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+661,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[3]");
    tracep->pushNamePrefix("[0]\206 ");
    tracep->declBit(c+662,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+663,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+664,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+665,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+666,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+667,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[1]\206 ");
    tracep->declBit(c+668,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+669,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+670,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+671,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+672,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+673,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[2]\206 ");
    tracep->declBit(c+674,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+675,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+676,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+677,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+678,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+679,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[3]\206 ");
    tracep->declBit(c+680,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+681,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+682,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+683,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+684,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+685,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pmp_addr_regs");
    tracep->declBus(c+1614,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1615,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1616,"[2]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1617,"[3]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1618,"[4]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1619,"[5]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1620,"[6]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1621,"[7]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1622,"[8]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1623,"[9]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1624,"[10]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1625,"[11]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1626,"[12]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1627,"[13]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1628,"[14]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1629,"[15]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("nxt_pmp_addr");
    tracep->declBus(c+686,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+687,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+688,"[2]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+689,"[3]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+690,"[4]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+691,"[5]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+692,"[6]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+693,"[7]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+694,"[8]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+695,"[9]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+696,"[10]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+697,"[11]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+698,"[12]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+699,"[13]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+700,"[14]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+701,"[15]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("new_cfg");
    tracep->pushNamePrefix("[0]\206 ");
    tracep->declBit(c+702,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+703,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+704,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+705,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+706,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+707,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[1]\206 ");
    tracep->declBit(c+708,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+709,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+710,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+711,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+712,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+713,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[2]\206 ");
    tracep->declBit(c+714,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+715,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+716,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+717,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+718,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+719,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[3]\206 ");
    tracep->declBit(c+720,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+721,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+722,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+723,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+724,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+725,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1906,"pmp_cfg_addr_add_one_reg",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1907,"pmp_cfg_addr_add_one_cfg",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1908,"d_cfg_match",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 15,0);
    tracep->pushNamePrefix("d_match\206 ");
    tracep->declBit(c+1909,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1910,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1911,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1912,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1913,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1914,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBit(c+1915,"d_match_found",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1916,"d_prot_fault",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1917,"i_cfg_match",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 15,0);
    tracep->pushNamePrefix("i_match\206 ");
    tracep->declBit(c+1918,"L",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1919,"reserved",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1920,"A",16, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1921,"X",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1922,"W",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1923,"R",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBit(c+1924,"i_match_found",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1925,"i_prot_fault",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->pushNamePrefix("genblk1[0] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1926,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1518,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1519,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1520,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1521,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1522,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1523,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1614,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+2232,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1927,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[10] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1926,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1578,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1579,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1580,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1581,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1582,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1583,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1624,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1623,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1928,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[11] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1926,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1584,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1585,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1586,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1587,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1588,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1589,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1625,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1624,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1929,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[12] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1926,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1590,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1591,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1592,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1593,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1594,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1595,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1626,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1625,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1930,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[13] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1926,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1596,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1597,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1598,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1599,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1600,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1601,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1627,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1626,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1931,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[14] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1926,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1602,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1603,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1604,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1605,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1606,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1607,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1628,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1627,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1932,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[15] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1926,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1608,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1609,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1610,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1611,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1612,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1613,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1629,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1628,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1933,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[1] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1926,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1524,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1525,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1526,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1527,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1528,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1529,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1615,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1614,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1934,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[2] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1926,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1530,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1531,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1532,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1533,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1534,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1535,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1616,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1615,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1935,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[3] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1926,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1536,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1537,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1538,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1539,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1540,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1541,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1617,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1616,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1936,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[4] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1926,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1542,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1543,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1544,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1545,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1546,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1547,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1618,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1617,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1937,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[5] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1926,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1548,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1549,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1550,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1551,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1552,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1553,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1619,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1618,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1938,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[6] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1926,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1554,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1555,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1556,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1557,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1558,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1559,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1620,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1619,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1939,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[7] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1926,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1560,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1561,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1562,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1563,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1564,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1565,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1621,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1620,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1940,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[8] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1926,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1566,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1567,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1568,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1569,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1570,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1571,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1622,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1621,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1941,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk1[9] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1926,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1572,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1573,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1574,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1575,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1576,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1577,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1623,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1622,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1942,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk2[0] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1943,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1518,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1519,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1520,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1521,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1522,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1523,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1614,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+2232,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1944,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk2[10] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1943,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1578,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1579,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1580,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1581,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1582,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1583,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1624,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1623,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1945,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk2[11] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1943,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1584,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1585,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1586,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1587,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1588,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1589,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1625,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1624,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1946,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk2[12] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1943,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1590,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1591,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1592,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1593,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1594,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1595,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1626,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1625,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1947,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk2[13] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1943,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1596,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1597,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1598,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1599,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1600,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1601,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1627,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1626,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1948,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk2[14] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1943,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1602,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1603,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1604,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1605,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1606,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1607,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1628,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1627,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1949,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk2[15] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1943,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1608,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1609,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1610,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1611,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1612,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1613,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1629,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1628,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1950,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk2[1] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1943,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1524,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1525,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1526,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1527,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1528,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1529,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1615,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1614,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1951,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk2[2] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1943,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1530,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1531,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1532,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1533,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1534,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1535,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1616,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1615,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1952,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk2[3] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1943,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1536,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1537,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1538,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1539,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1540,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1541,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1617,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1616,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1953,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk2[4] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1943,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1542,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1543,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1544,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1545,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1546,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1547,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1618,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1617,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1954,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk2[5] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1943,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1548,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1549,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1550,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1551,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1552,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1553,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1619,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1618,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1955,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk2[6] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1943,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1554,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1555,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1556,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1557,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1558,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1559,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1620,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1619,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1956,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk2[7] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1943,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1560,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1561,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1562,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1563,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1564,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1565,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1621,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1620,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1957,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk2[8] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1943,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1566,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1567,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1568,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1569,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1570,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1571,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1622,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1621,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1958,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("genblk2[9] ");
    tracep->pushNamePrefix("matcher ");
    tracep->declBus(c+1943,"phys_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->pushNamePrefix("check_cfg\206 ");
    tracep->declBit(c+1572,"L",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1573,"reserved",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBus(c+1574,"A",16,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declBit(c+1575,"X",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1576,"W",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1577,"R",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1623,"cfg_addr",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBus(c+1622,"cfg_addr_before",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
    tracep->declBit(c+1959,"match",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(5);
    tracep->pushNamePrefix("rv32c ");
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nRST",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->pushNamePrefix("genblk1 ");
    tracep->pushNamePrefix("RV32C ");
    tracep->declBit(c+2204,"clk",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nrst",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(3);
    tracep->pushNamePrefix("sep_caches ");
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nRST",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->pushNamePrefix("genblk1 ");
    tracep->pushNamePrefix("dcache ");
    tracep->declBus(c+2251,"CACHE_SIZE",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2252,"BLOCK_SIZE",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2253,"ASSOC",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2254,"NONCACHE_START_ADDR",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nRST",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2255,"clear",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1815,"flush",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2231,"clear_done",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1630,"flush_done",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+2256,"N_TOTAL_BYTES",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2257,"N_TOTAL_WORDS",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2258,"N_TOTAL_FRAMES",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2253,"N_SETS",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2252,"N_FRAME_BITS",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2252,"N_SET_BITS",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2259,"N_BLOCK_BITS",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2260,"N_TAG_BITS",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2261,"FRAME_SIZE",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2262,"SRAM_W",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->pushNamePrefix("flush_idx\206 ");
    tracep->declBit(c+1631,"finish",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1632,"set_num",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1633,"frame_num",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1634,"word_num",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 0,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("next_flush_idx\206 ");
    tracep->declBit(c+726,"finish",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+727,"set_num",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+728,"frame_num",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+729,"word_num",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 0,0);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1635,"word_num",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+2,"next_word_num",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+3,"enable_word_count",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1636,"clear_word_count",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1637,"clear_flush_count",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+730,"enable_flush_count",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2121,"enable_flush_count_nowb",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    {
        const char* __VenumItemNames[]
        = {"IDLE", "FETCH", "WB", "FLUSH_CACHE"};
        const char* __VenumItemValues[]
        = {"0", "1", "10", "11"};
        tracep->declDTypeEnum(17, "l1_cache.cache_fsm_t", 4, 32, __VenumItemNames, __VenumItemValues);
    }
    tracep->declBus(c+1638,"state",17, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+731,"next_state",17, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+732,"ridx",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1639,"last_used",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+2122,"next_last_used",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1640,"read_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+733,"next_read_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->pushNamePrefix("decoded_req_addr\206 ");
    tracep->declBus(c+1641,"tag_bits",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->declBus(c+1642,"idx_bits",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1643,"block_bits",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 0,0);
    tracep->declBus(c+1644,"byte_bits",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("next_decoded_req_addr\206 ");
    tracep->declBus(c+734,"tag_bits",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->declBus(c+735,"idx_bits",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+736,"block_bits",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 0,0);
    tracep->declBus(c+737,"byte_bits",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("decoded_addr\206 ");
    tracep->declBus(c+1960,"tag_bits",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->declBus(c+1961,"idx_bits",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1962,"block_bits",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 0,0);
    tracep->declBus(c+1813,"byte_bits",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->popNamePrefix(1);
    tracep->declBit(c+2123,"hit",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2124,"pass_through",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->pushNamePrefix("hit_data");
    tracep->declBus(c+2125,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2126,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->declBus(c+2127,"hit_idx",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->pushNamePrefix("sramWrite\206 ");
    tracep->pushNamePrefix("frames");
    tracep->pushNamePrefix("[0]\206 ");
    tracep->declBit(c+738,"valid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+739,"dirty",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+740,"tag",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->pushNamePrefix("data");
    tracep->declBus(c+741,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+742,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[1]\206 ");
    tracep->declBit(c+743,"valid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+744,"dirty",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+745,"tag",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->pushNamePrefix("data");
    tracep->declBus(c+746,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+747,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[2]\206 ");
    tracep->declBit(c+748,"valid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+749,"dirty",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+750,"tag",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->pushNamePrefix("data");
    tracep->declBus(c+751,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+752,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[3]\206 ");
    tracep->declBit(c+753,"valid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+754,"dirty",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+755,"tag",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->pushNamePrefix("data");
    tracep->declBus(c+756,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+757,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("sramRead\206 ");
    tracep->pushNamePrefix("frames");
    tracep->pushNamePrefix("[0]\206 ");
    tracep->declBit(c+2128,"valid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2129,"dirty",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2130,"tag",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->pushNamePrefix("data");
    tracep->declBus(c+2131,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2132,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[1]\206 ");
    tracep->declBit(c+2133,"valid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2134,"dirty",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2135,"tag",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->pushNamePrefix("data");
    tracep->declBus(c+2136,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2137,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[2]\206 ");
    tracep->declBit(c+2138,"valid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2139,"dirty",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2140,"tag",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->pushNamePrefix("data");
    tracep->declBus(c+2141,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2142,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[3]\206 ");
    tracep->declBit(c+2143,"valid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2144,"dirty",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2145,"tag",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->pushNamePrefix("data");
    tracep->declBus(c+2146,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2147,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("sramMask\206 ");
    tracep->pushNamePrefix("frames");
    tracep->pushNamePrefix("[0]\206 ");
    tracep->declBit(c+758,"valid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+759,"dirty",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+760,"tag",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->pushNamePrefix("data");
    tracep->declBus(c+761,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+762,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[1]\206 ");
    tracep->declBit(c+763,"valid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+764,"dirty",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+765,"tag",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->pushNamePrefix("data");
    tracep->declBus(c+766,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+767,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[2]\206 ");
    tracep->declBit(c+768,"valid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+769,"dirty",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+770,"tag",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->pushNamePrefix("data");
    tracep->declBus(c+771,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+772,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[3]\206 ");
    tracep->declBit(c+773,"valid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+774,"dirty",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+775,"tag",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->pushNamePrefix("data");
    tracep->declBus(c+776,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+777,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->declBit(c+778,"sramWEN",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1963,"sramSEL",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->pushNamePrefix("SRAM ");
    tracep->declBus(c+2262,"SRAM_WR_SIZE",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2253,"SRAM_HEIGHT",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nRST",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declArray(c+779,"wVal",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 371,0);
    tracep->declArray(c+2148,"rVal",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 371,0);
    tracep->declBit(c+2263,"REN",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+778,"WEN",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1963,"SEL",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declArray(c+791,"wMask",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 371,0);
    tracep->pushNamePrefix("sramMemory");
    tracep->declArray(c+1666,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 371,0);
    tracep->declArray(c+1678,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 371,0);
    tracep->declArray(c+1690,"[2]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 371,0);
    tracep->declArray(c+1702,"[3]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 371,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("n_sramMemory");
    tracep->declArray(c+803,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 371,0);
    tracep->declArray(c+815,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 371,0);
    tracep->declArray(c+827,"[2]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 371,0);
    tracep->declArray(c+839,"[3]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 371,0);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("unnamedblk1 ");
    tracep->declBus(c+2160,"i",-1, FST_VD_IMPLICIT,FST_VT_SV_INT, false,-1, 31,0);
    tracep->popNamePrefix(3);
    tracep->pushNamePrefix("genblk2 ");
    tracep->pushNamePrefix("icache ");
    tracep->declBus(c+2251,"CACHE_SIZE",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2252,"BLOCK_SIZE",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2253,"ASSOC",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2254,"NONCACHE_START_ADDR",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nRST",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2264,"clear",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1815,"flush",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2231,"clear_done",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+1645,"flush_done",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+2256,"N_TOTAL_BYTES",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2257,"N_TOTAL_WORDS",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2258,"N_TOTAL_FRAMES",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2253,"N_SETS",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2252,"N_FRAME_BITS",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2252,"N_SET_BITS",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2259,"N_BLOCK_BITS",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2260,"N_TAG_BITS",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2261,"FRAME_SIZE",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2262,"SRAM_W",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->pushNamePrefix("flush_idx\206 ");
    tracep->declBit(c+1646,"finish",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1647,"set_num",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1648,"frame_num",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1649,"word_num",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 0,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("next_flush_idx\206 ");
    tracep->declBit(c+851,"finish",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+852,"set_num",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+853,"frame_num",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+854,"word_num",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 0,0);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1650,"word_num",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+4,"next_word_num",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+5,"enable_word_count",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1651,"clear_word_count",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1652,"clear_flush_count",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+855,"enable_flush_count",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2161,"enable_flush_count_nowb",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1653,"state",17, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+856,"next_state",17, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+857,"ridx",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1654,"last_used",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+858,"next_last_used",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1655,"read_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+859,"next_read_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->pushNamePrefix("decoded_req_addr\206 ");
    tracep->declBus(c+1656,"tag_bits",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->declBus(c+1657,"idx_bits",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1658,"block_bits",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 0,0);
    tracep->declBus(c+1659,"byte_bits",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("next_decoded_req_addr\206 ");
    tracep->declBus(c+860,"tag_bits",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->declBus(c+861,"idx_bits",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+862,"block_bits",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 0,0);
    tracep->declBus(c+863,"byte_bits",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("decoded_addr\206 ");
    tracep->declBus(c+1964,"tag_bits",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->declBus(c+1965,"idx_bits",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1966,"block_bits",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 0,0);
    tracep->declBus(c+1967,"byte_bits",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->popNamePrefix(1);
    tracep->declBit(c+2162,"hit",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2163,"pass_through",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->pushNamePrefix("hit_data");
    tracep->declBus(c+2164,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2165,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->declBus(c+2166,"hit_idx",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->pushNamePrefix("sramWrite\206 ");
    tracep->pushNamePrefix("frames");
    tracep->pushNamePrefix("[0]\206 ");
    tracep->declBit(c+864,"valid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+865,"dirty",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+866,"tag",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->pushNamePrefix("data");
    tracep->declBus(c+867,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+868,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[1]\206 ");
    tracep->declBit(c+869,"valid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+870,"dirty",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+871,"tag",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->pushNamePrefix("data");
    tracep->declBus(c+872,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+873,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[2]\206 ");
    tracep->declBit(c+874,"valid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+875,"dirty",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+876,"tag",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->pushNamePrefix("data");
    tracep->declBus(c+877,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+878,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[3]\206 ");
    tracep->declBit(c+879,"valid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+880,"dirty",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+881,"tag",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->pushNamePrefix("data");
    tracep->declBus(c+882,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+883,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("sramRead\206 ");
    tracep->pushNamePrefix("frames");
    tracep->pushNamePrefix("[0]\206 ");
    tracep->declBit(c+2167,"valid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2168,"dirty",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2169,"tag",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->pushNamePrefix("data");
    tracep->declBus(c+2170,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2171,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[1]\206 ");
    tracep->declBit(c+2172,"valid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2173,"dirty",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2174,"tag",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->pushNamePrefix("data");
    tracep->declBus(c+2175,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2176,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[2]\206 ");
    tracep->declBit(c+2177,"valid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2178,"dirty",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2179,"tag",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->pushNamePrefix("data");
    tracep->declBus(c+2180,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2181,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[3]\206 ");
    tracep->declBit(c+2182,"valid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2183,"dirty",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2184,"tag",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->pushNamePrefix("data");
    tracep->declBus(c+2185,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2186,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("sramMask\206 ");
    tracep->pushNamePrefix("frames");
    tracep->pushNamePrefix("[0]\206 ");
    tracep->declBit(c+884,"valid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+885,"dirty",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+886,"tag",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->pushNamePrefix("data");
    tracep->declBus(c+887,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+888,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[1]\206 ");
    tracep->declBit(c+889,"valid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+890,"dirty",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+891,"tag",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->pushNamePrefix("data");
    tracep->declBus(c+892,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+893,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[2]\206 ");
    tracep->declBit(c+894,"valid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+895,"dirty",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+896,"tag",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->pushNamePrefix("data");
    tracep->declBus(c+897,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+898,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("[3]\206 ");
    tracep->declBit(c+899,"valid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+900,"dirty",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+901,"tag",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 26,0);
    tracep->pushNamePrefix("data");
    tracep->declBus(c+902,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+903,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->declBit(c+904,"sramWEN",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1968,"sramSEL",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->pushNamePrefix("SRAM ");
    tracep->declBus(c+2262,"SRAM_WR_SIZE",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2253,"SRAM_HEIGHT",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nRST",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declArray(c+905,"wVal",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 371,0);
    tracep->declArray(c+2187,"rVal",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 371,0);
    tracep->declBit(c+2263,"REN",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+904,"WEN",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBus(c+1968,"SEL",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 1,0);
    tracep->declArray(c+917,"wMask",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 371,0);
    tracep->pushNamePrefix("sramMemory");
    tracep->declArray(c+1714,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 371,0);
    tracep->declArray(c+1726,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 371,0);
    tracep->declArray(c+1738,"[2]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 371,0);
    tracep->declArray(c+1750,"[3]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 371,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("n_sramMemory");
    tracep->declArray(c+929,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 371,0);
    tracep->declArray(c+941,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 371,0);
    tracep->declArray(c+953,"[2]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 371,0);
    tracep->declArray(c+965,"[3]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 371,0);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("unnamedblk1 ");
    tracep->declBus(c+2199,"i",-1, FST_VD_IMPLICIT,FST_VT_SV_INT, false,-1, 31,0);
    tracep->popNamePrefix(4);
    tracep->pushNamePrefix("sparce_disabled_i ");
    tracep->declBit(c+2204,"CLK",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->declBit(c+2205,"nRST",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
    tracep->popNamePrefix(2);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP____024unit__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP____024unit__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+2257,"XLEN",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declArray(c+2265,"BR_PREDICTOR_TYPE",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 71,0);
    tracep->declQuad(c+2268,"CACHE_CONFIG",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 63,0);
    tracep->declBus(c+2270,"DCACHE_TYPE",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 15,0);
    tracep->declBus(c+2270,"ICACHE_TYPE",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 15,0);
    tracep->declBus(c+2271,"BUS_ENDIANNESS",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 23,0);
    tracep->declArray(c+2272,"BUS_INTERFACE_TYPE",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 111,0);
    tracep->declQuad(c+2276,"SPARCE_ENABLED",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 63,0);
    tracep->declQuad(c+2276,"RV32C_ENABLED",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 63,0);
    tracep->declBus(c+2278,"INFINITE_LOOP_HALTS",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declQuad(c+2279,"BASE_ISA",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 39,0);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__rm_if__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__rm_if__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+2281,"insn",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+2282,"req_reg_r",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2283,"req_reg_w",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2284,"rsel_s_0",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->declBus(c+2285,"rsel_s_1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->declBus(c+2286,"rsel_d",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->declBus(c+2287,"rdata_s_0",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2288,"rdata_s_1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+2289,"reg_w",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2290,"reg_wdata",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+2291,"req_br_j",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2292,"branch_jump",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2293,"br_j_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2294,"pc",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+2295,"req_mem",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2296,"mem_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2297,"mem_store",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2298,"mem_load",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+2299,"mem_ren",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2300,"mem_wen",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2301,"mem_busy",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2302,"mem_byte_en",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 3,0);
    tracep->declBit(c+2303,"execute_stall",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2304,"memory_stall",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2305,"active_insn",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2306,"ex_token",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2307,"if_ex_enable",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2308,"exception",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2309,"ex_cause",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 0,0);
    tracep->declBus(c+2310,"risc_mgmt_start",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 0,0);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__fetch_ex_if__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__fetch_ex_if__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->pushNamePrefix("fetch_ex_reg\206 ");
    tracep->declBit(c+2311,"token",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2312,"pc",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2313,"pc4",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2314,"instr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2315,"prediction",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->declBus(c+2316,"brj_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__hazard_if__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__hazard_if__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBit(c+2317,"pc_en",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2318,"npc_sel",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2319,"i_mem_busy",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2320,"d_mem_busy",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2321,"dren",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2322,"dwen",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2323,"iren",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2324,"ret",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2325,"branch_taken",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2326,"prediction",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2327,"jump",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2328,"branch",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2329,"if_ex_stall",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2330,"fence_stall",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2331,"if_ex_flush",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2332,"mispredict",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2333,"halt",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2334,"pc",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+2335,"fault_insn",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2336,"mal_insn",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2337,"illegal_insn",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2338,"fault_l",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2339,"mal_l",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2340,"fault_s",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2341,"mal_s",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2342,"breakpoint",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2343,"env",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2344,"epc_f",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2345,"epc_e",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2346,"badaddr_f",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2347,"badaddr_e",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2348,"priv_pc",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+2349,"insert_priv_pc",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2350,"token_ex",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2351,"rv32c_ready",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__prv_pipe_if__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__prv_pipe_if__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBit(c+1969,"fault_insn",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1970,"mal_insn",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1971,"illegal_insn",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1972,"fault_l",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1973,"mal_l",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1974,"fault_s",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1975,"mal_s",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1976,"breakpoint",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1977,"env",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1978,"ret",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1979,"wfi",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2352,"timer_int",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2353,"soft_int",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2354,"ext_int",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1810,"epc",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+59,"priv_pc",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1980,"badaddr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+1981,"insert_pc",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1982,"intr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2263,"pipe_clear",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->pushNamePrefix("xtvec");
    tracep->declBus(c+2355,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2356,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2357,"[2]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2358,"[3]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("xepc_r");
    tracep->declBus(c+2359,"[0]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2360,"[1]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2361,"[2]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2362,"[3]",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->declBit(c+1983,"swap",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1984,"clr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1985,"set",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1986,"read_only",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1662,"invalid_priv_isn",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+977,"valid_write",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1987,"csr_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 11,0);
    tracep->declBus(c+60,"rdata",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1988,"wdata",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+71,"wb_enable",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1989,"instr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"ex_rmgmt",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2363,"ex_rmgmt_cause",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, -1,0);
    tracep->declBit(c+2263,"iren",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1990,"dwen",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1991,"dren",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1801,"iaddr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1992,"daddr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2364,"d_acc_width",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBus(c+2364,"i_acc_width",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+1974,"prot_fault_s",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1972,"prot_fault_l",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1993,"prot_fault_i",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__top_core__interrupt_if__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__top_core__interrupt_if__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBit(c+2217,"ext_int",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2218,"ext_int_clear",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2219,"soft_int",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2220,"soft_int_clear",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2221,"timer_int",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2222,"timer_int_clear",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__top_core__gen_bus_if__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__top_core__gen_bus_if__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+998,"addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+999,"wdata",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2211,"rdata",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+995,"ren",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+996,"wen",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2210,"busy",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+997,"byte_en",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 3,0);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__tspp_icache_gen_bus_if__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__tspp_icache_gen_bus_if__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+1801,"addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2232,"wdata",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+80,"rdata",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+978,"ren",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"wen",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+979,"busy",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2365,"byte_en",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 3,0);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+1992,"addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1994,"wdata",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+86,"rdata",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+1995,"ren",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1996,"wen",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+980,"busy",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1814,"byte_en",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 3,0);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__icache_mc_if__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__icache_mc_if__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+981,"addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+982,"wdata",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2211,"rdata",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+983,"ren",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+984,"wen",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+6,"busy",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+985,"byte_en",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 3,0);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__dcache_mc_if__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__dcache_mc_if__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+2200,"addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+79,"wdata",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2211,"rdata",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+2201,"ren",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2202,"wen",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+7,"busy",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2203,"byte_en",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 3,0);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline_trans_if__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline_trans_if__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+986,"addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+79,"wdata",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2211,"rdata",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+987,"ren",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+988,"wen",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+8,"busy",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+989,"byte_en",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 3,0);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__cc_if__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__cc_if__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBit(c+2264,"icache_clear",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1815,"icache_flush",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"iclear_done",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1645,"iflush_done",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2255,"dcache_clear",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1815,"dcache_flush",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"dclear_done",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1630,"dflush_done",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__sparce_if__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__sparce_if__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+1798,"pc",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2366,"wb_data",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2367,"sasa_data",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2368,"sasa_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+2369,"wb_en",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2370,"sasa_wen",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2371,"rd",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->declBit(c+2372,"if_ex_enable",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2232,"sparce_target",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+80,"rdata",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+2231,"skipping",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__rv32cif__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__rv32cif__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+80,"inst",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+58,"reset_pc",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2232,"nextpc",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2232,"imem_pc",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2232,"result",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2232,"inst32",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2228,"reset_pc_val",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1997,"inst16",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 15,0);
    tracep->declBit(c+1998,"reset_en",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+72,"inst_arrived",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+73,"pc_update",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"done",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"c_ena",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"rv32c_ena",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"done_earlier",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2373,"done_earlier_send",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"halt",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+990,"ex_busy",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->pushNamePrefix("fetch_ex_reg\206 ");
    tracep->declBit(c+1999,"valid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2000,"token",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2001,"mal_insn",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2002,"fault_insn",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2003,"pc",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2004,"pc4",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2005,"instr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2006,"prediction",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2007,"badaddr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->declBus(c+2374,"brj_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+1772,"rs1_e",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->declBus(c+1771,"rs2_e",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->declBus(c+1824,"rd_m",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->declBit(c+2008,"reg_write",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+977,"csr_read",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+979,"i_mem_busy",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+980,"d_mem_busy",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1991,"dren",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1990,"dwen",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1978,"ret",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1808,"suppress_data",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2009,"jump",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2010,"branch",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2011,"fence_stall",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2012,"mispredict",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1762,"halt",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1798,"pc_f",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2003,"pc_e",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1820,"pc_m",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+2013,"valid_e",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2014,"valid_m",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2015,"ifence",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"ex_busy",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+73,"pc_en",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1805,"npc_sel",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+74,"if_ex_flush",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+991,"ex_mem_flush",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+992,"if_ex_stall",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+990,"ex_mem_stall",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2263,"iren",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+993,"suppress_iren",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2016,"rollback",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+59,"priv_pc",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+1981,"insert_priv_pc",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2017,"fault_insn",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1970,"mal_insn",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1971,"illegal_insn",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"fault_l",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1973,"mal_l",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"fault_s",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1975,"mal_s",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1976,"breakpoint",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1977,"env",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1979,"wfi",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1980,"badaddr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+2375,"token_ex",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"token_mem",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"rv32c_ready",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__predict_if__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__predict_if__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+1798,"current_pc",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1799,"target_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2018,"update_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+2010,"update_predictor",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"predict_taken",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2019,"prediction",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2020,"branch_result",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__fw_if__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__fw_if__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+1824,"rd_m",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->declBus(c+1772,"rs1_e",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->declBus(c+1771,"rs2_e",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->declBit(c+2008,"reg_write",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2021,"load",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2022,"fwd_rs1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2023,"fwd_rs2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+61,"rd_mem_data",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBit(c+2008,"reg_write",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1824,"rd_m",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->pushNamePrefix("ex_mem_reg\206 ");
    tracep->declBit(c+2024,"valid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2025,"branch",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2026,"prediction",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2027,"branch_taken",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2028,"dren",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2029,"dwen",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2030,"reg_write",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2031,"ifence",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2032,"jump",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2033,"halt",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2034,"csr_swap",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2035,"csr_clr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2036,"csr_set",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2037,"csr_imm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2038,"csr_read_only",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2039,"breakpoint",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2040,"ecall_insn",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2041,"ret_insn",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2042,"wfi_insn",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2043,"was_compressed",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2044,"w_sel",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBus(c+2045,"byte_en",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 3,0);
    tracep->declBus(c+2046,"zimm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->declBus(c+2047,"rd_m",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->declBit(c+2048,"mal_insn",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2049,"fault_insn",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2050,"illegal_insn",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1832,"load_type",4, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBus(c+1987,"csr_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 11,0);
    tracep->declBus(c+2018,"brj_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1992,"port_out",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2051,"rs1_data",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1833,"rs2_data",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1819,"instr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1820,"pc",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2052,"pc4",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2053,"imm_U",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2054,"badaddr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->pushNamePrefix("tracker_signals\206 ");
    tracep->declBus(c+2055,"opcode",3, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 6,0);
    tracep->declBus(c+2056,"imm_SB",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 12,0);
    tracep->declBus(c+1826,"imm_S",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 11,0);
    tracep->declBus(c+1827,"imm_I",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 11,0);
    tracep->declBus(c+2057,"imm_UJ",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 20,0);
    tracep->declBus(c+1829,"imm_U",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->popNamePrefix(1);
    tracep->declBus(c+2018,"brj_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+75,"reg_wdata",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2052,"pc4",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBit(c+2231,"ex_rmgmt",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2363,"ex_rmgmt_cause",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, -1,0);
    tracep->declBus(c+1165,"curr_privilege_level",7, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1987,"csr_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 11,0);
    tracep->declBit(c+1983,"csr_write",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1985,"csr_set",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1984,"csr_clear",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1986,"csr_read_only",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2058,"invalid_csr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+76,"inst_ret",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1988,"new_csr_val",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+60,"old_csr_val",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+977,"valid_write",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"timer_int_u",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"timer_int_s",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2221,"timer_int_m",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"soft_int_u",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"soft_int_s",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2219,"soft_int_m",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"ext_int_u",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"ext_int_s",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2217,"ext_int_m",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"clear_timer_int_u",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"clear_timer_int_s",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2222,"clear_timer_int_m",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"clear_soft_int_u",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"clear_soft_int_s",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2220,"clear_soft_int_m",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"clear_ext_int_u",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"clear_ext_int_s",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2218,"clear_ext_int_m",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1970,"mal_insn",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1969,"fault_insn_access",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1971,"illegal_insn",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1976,"breakpoint",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1972,"fault_l",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1973,"mal_l",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1974,"fault_s",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1975,"mal_s",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2059,"env_u",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"env_s",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2060,"env_m",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"fault_insn_page",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"fault_load_page",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"fault_store_page",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->pushNamePrefix("curr_mip\206 ");
    tracep->declBus(c+1078,"impl_defined",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 15,0);
    tracep->declBus(c+1079,"zero_6",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 3,0);
    tracep->declBit(c+1080,"meip",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1081,"zero_5",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1082,"seip",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1083,"zero_4",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1084,"mtip",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1085,"zero_3",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1086,"stip",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1087,"zero_2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1088,"msip",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1089,"zero_1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1090,"ssip",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1091,"zero_0",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("next_mip\206 ");
    tracep->declBus(c+9,"impl_defined",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 15,0);
    tracep->declBus(c+10,"zero_6",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 3,0);
    tracep->declBit(c+11,"meip",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+12,"zero_5",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+13,"seip",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+14,"zero_4",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+15,"mtip",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+16,"zero_3",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+17,"stip",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+18,"zero_2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+19,"msip",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+20,"zero_1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+21,"ssip",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+22,"zero_0",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("curr_mie\206 ");
    tracep->declBus(c+1057,"impl_defined",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 15,0);
    tracep->declBus(c+1058,"zero_6",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 3,0);
    tracep->declBit(c+1059,"meie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1060,"zero_5",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1061,"seie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1062,"zero_4",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1063,"mtie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1064,"zero_3",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1065,"stie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1066,"zero_2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1067,"msie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1068,"zero_1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1069,"ssie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1070,"zero_0",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("next_mie\206 ");
    tracep->declBus(c+2376,"impl_defined",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 15,0);
    tracep->declBus(c+2377,"zero_6",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 3,0);
    tracep->declBit(c+2378,"meie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2379,"zero_5",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2380,"seie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2381,"zero_4",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2382,"mtie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2383,"zero_3",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2384,"stie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2385,"zero_2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2386,"msie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2387,"zero_1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2388,"ssie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2389,"zero_0",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("curr_mcause\206 ");
    tracep->declBit(c+1075,"__SYM__interrupt",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1076,"cause",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 30,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("next_mcause\206 ");
    tracep->declBit(c+62,"__SYM__interrupt",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+63,"cause",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 30,0);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1074,"curr_mepc",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1810,"next_mepc",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->pushNamePrefix("curr_mstatus\206 ");
    tracep->declBit(c+1036,"sd",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1037,"reserved_3",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 7,0);
    tracep->declBit(c+1038,"tsr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1039,"tw",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1040,"tvm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1041,"mxr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1042,"sum",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1043,"mprv",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1044,"xs",5, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1045,"fs",6, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1046,"mpp",7, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+1047,"vs",8, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+1048,"spp",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1049,"mpie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1050,"ube",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1051,"spie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1052,"reserved_2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1053,"mie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1054,"reserved_1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1055,"sie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1056,"reserved_0",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("next_mstatus\206 ");
    tracep->declBit(c+2061,"sd",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2062,"reserved_3",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 7,0);
    tracep->declBit(c+2063,"tsr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2064,"tw",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2065,"tvm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2066,"mxr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2067,"sum",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2068,"mprv",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2069,"xs",5, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+2070,"fs",6, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+2071,"mpp",7, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+2072,"vs",8, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBit(c+2073,"spp",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2074,"mpie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2075,"ube",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2076,"spie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2077,"reserved_2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2078,"mie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2079,"reserved_1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2080,"sie",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2081,"reserved_0",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("curr_mtvec\206 ");
    tracep->declBus(c+1071,"base",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 29,0);
    tracep->declBus(c+1072,"mode",10, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->popNamePrefix(1);
    tracep->declBus(c+1980,"curr_mtval",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1980,"next_mtval",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+2227,"inject_mip",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1663,"inject_mcause",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1663,"inject_mepc",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2082,"inject_mstatus",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2083,"inject_mtval",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1810,"epc",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+59,"priv_pc",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+2263,"pipe_clear",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1981,"insert_pc",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2084,"mret",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"sret",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1982,"intr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1992,"daddr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1801,"iaddr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+1991,"ren",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1990,"wen",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2263,"xen",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2364,"d_acc_width",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBus(c+2364,"i_acc_width",13, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+2085,"pma_s_fault",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2086,"pma_l_fault",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2087,"pma_i_fault",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2088,"pmp_s_fault",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2089,"pmp_l_fault",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2090,"pmp_i_fault",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pma_if__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pma_if__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+1987,"csr_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 11,0);
    tracep->declBus(c+211,"value_in",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+77,"csr_active",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"invalid_csr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2091,"ack",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2092,"value_out",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pmp_if__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pmp_if__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+1987,"csr_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 11,0);
    tracep->declBus(c+211,"value_in",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBit(c+994,"csr_active",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2231,"invalid_csr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2093,"ack",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2094,"value_out",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu_if__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu_if__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    {
        const char* __VenumItemNames[]
        = {"ALU_SLL", "ALU_SRL", "ALU_SRA", "ALU_ADD", 
                                "ALU_SUB", "ALU_AND", 
                                "ALU_OR", "ALU_XOR", 
                                "ALU_SLT", "ALU_SLTU"};
        const char* __VenumItemValues[]
        = {"0", "1", "10", "11", "100", "101", "110", 
                                "111", "1000", "1001"};
        tracep->declDTypeEnum(18, "alu_types_pkg::aluop_t", 10, 4, __VenumItemNames, __VenumItemValues);
    }
    tracep->declBus(c+2095,"aluop",18, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 3,0);
    tracep->declBus(c+31,"port_a",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+64,"port_b",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+65,"port_out",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_if__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_if__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+24,"rs1_data",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+25,"rs2_data",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2003,"pc",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1768,"branch_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2096,"imm_sb",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 12,0);
    {
        const char* __VenumItemNames[]
        = {"BEQ", "BNE", "BLT", "BGE", "BLTU", "BGEU"};
        const char* __VenumItemValues[]
        = {"0", "1", "100", "101", "110", "111"};
        tracep->declDTypeEnum(19, "rv32i_types_pkg::branch_t", 6, 3, __VenumItemNames, __VenumItemValues);
    }
    tracep->declBus(c+1773,"branch_type",19, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBit(c+28,"branch_taken",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBit(c+2097,"dwen",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2098,"dren",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2099,"j_sel",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2100,"branch",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2101,"jump",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2101,"ex_pc_sel",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2102,"imm_shamt_sel",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2103,"halt",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2104,"wen",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2105,"ifence",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1763,"wfi",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2095,"alu_op",18, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 3,0);
    tracep->declBus(c+2106,"alu_a_sel",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+2107,"alu_b_sel",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 1,0);
    tracep->declBus(c+2108,"w_sel",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBus(c+1771,"shamt",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->declBus(c+1774,"rd",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->declBus(c+1776,"imm_I",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 11,0);
    tracep->declBus(c+2109,"imm_S",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 11,0);
    tracep->declBus(c+2110,"imm_UJ",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 20,0);
    tracep->declBus(c+2096,"imm_SB",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 12,0);
    tracep->declBus(c+2005,"instr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2111,"imm_U",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1773,"load_type",4, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBus(c+1773,"branch_type",19, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->declBus(c+1775,"opcode",3, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 6,0);
    tracep->declBit(c+2231,"fault_insn",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+1785,"illegal_insn",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2112,"ret_insn",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2113,"breakpoint",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2114,"ecall_insn",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2115,"csr_swap",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2116,"csr_set",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2117,"csr_clr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2118,"csr_imm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBit(c+2119,"csr_rw_valid",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+1776,"csr_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 11,0);
    tracep->declBus(c+1772,"zimm",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->pushNamePrefix("rv32m_control\206 ");
    tracep->declBit(c+2390,"select",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
    tracep->declBus(c+2234,"op",2, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 2,0);
    tracep->popNamePrefix(1);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__rf_if__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__rf_if__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+75,"w_data",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1664,"rs1_data",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1665,"rs2_data",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+1772,"rs1",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->declBus(c+1771,"rs2",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->declBus(c+1824,"rd",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 4,0);
    tracep->declBit(c+78,"wen",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__jump_if__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__jump_if__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+66,"base",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+2120,"offset",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+57,"jal_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
    tracep->declBus(c+67,"jalr_addr",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, false,-1, 31,0);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__rv32i_types_pkg__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__rv32i_types_pkg__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+2236,"WORD_SIZE",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2236,"RAM_ADDR_SIZE",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2391,"OP_W",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2392,"BR_W",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2392,"LD_W",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2392,"SW_W",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2392,"IMM_W",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
    tracep->declBus(c+2392,"REG_W",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 31,0);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__machine_mode_types_1_12_pkg__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__machine_mode_types_1_12_pkg__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+2393,"MISA_EXT_A",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 25,0);
    tracep->declBus(c+2394,"MISA_EXT_B",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 25,0);
    tracep->declBus(c+2395,"MISA_EXT_C",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 25,0);
    tracep->declBus(c+2396,"MISA_EXT_D",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 25,0);
    tracep->declBus(c+2397,"MISA_EXT_E",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 25,0);
    tracep->declBus(c+2398,"MISA_EXT_F",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 25,0);
    tracep->declBus(c+2399,"MISA_EXT_G",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 25,0);
    tracep->declBus(c+2400,"MISA_EXT_H",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 25,0);
    tracep->declBus(c+2401,"MISA_EXT_I",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 25,0);
    tracep->declBus(c+2402,"MISA_EXT_J",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 25,0);
    tracep->declBus(c+2403,"MISA_EXT_K",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 25,0);
    tracep->declBus(c+2404,"MISA_EXT_L",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 25,0);
    tracep->declBus(c+2405,"MISA_EXT_M",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 25,0);
    tracep->declBus(c+2406,"MISA_EXT_N",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 25,0);
    tracep->declBus(c+2407,"MISA_EXT_O",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 25,0);
    tracep->declBus(c+2408,"MISA_EXT_P",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 25,0);
    tracep->declBus(c+2409,"MISA_EXT_Q",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 25,0);
    tracep->declBus(c+2410,"MISA_EXT_R",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 25,0);
    tracep->declBus(c+2411,"MISA_EXT_S",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 25,0);
    tracep->declBus(c+2412,"MISA_EXT_T",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 25,0);
    tracep->declBus(c+2413,"MISA_EXT_U",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 25,0);
    tracep->declBus(c+2414,"MISA_EXT_V",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 25,0);
    tracep->declBus(c+2415,"MISA_EXT_W",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 25,0);
    tracep->declBus(c+2416,"MISA_EXT_X",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 25,0);
    tracep->declBus(c+2417,"MISA_EXT_Y",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 25,0);
    tracep->declBus(c+2418,"MISA_EXT_Z",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 25,0);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_sub__TOP__rv32m_pkg__0(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_sub__TOP__rv32m_pkg__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+2419,"RV32M_OPCODE",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 6,0);
    tracep->declBus(c+2420,"RV32M_OPCODE_MINOR",-1, FST_VD_IMPLICIT,FST_VT_VCD_PARAMETER, false,-1, 6,0);
}

VL_ATTR_COLD void Vtop_core___024root__trace_init_top(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_init_top\n"); );
    // Body
    Vtop_core___024root__trace_init_sub__TOP__0(vlSelf, tracep);
    tracep->pushNamePrefix("$unit ");
    Vtop_core___024root__trace_init_sub__TOP____024unit__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("machine_mode_types_1_12_pkg ");
    Vtop_core___024root__trace_init_sub__TOP__machine_mode_types_1_12_pkg__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("rv32i_types_pkg ");
    Vtop_core___024root__trace_init_sub__TOP__rv32i_types_pkg__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("rv32m_pkg ");
    Vtop_core___024root__trace_init_sub__TOP__rv32m_pkg__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("top_core ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__0(vlSelf, tracep);
    tracep->pushNamePrefix("CORE ");
    tracep->pushNamePrefix("branch_predictor_i ");
    tracep->pushNamePrefix("genblk1 ");
    tracep->pushNamePrefix("predictor ");
    tracep->pushNamePrefix("predict_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__predict_if__0(vlSelf, tracep);
    tracep->popNamePrefix(3);
    tracep->pushNamePrefix("predict_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__predict_if__0(vlSelf, tracep);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("cc_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__cc_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("dcache_mc_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__dcache_mc_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("fetch_ex_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__fetch_ex_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("g_generic_bus_if ");
    tracep->pushNamePrefix("bt ");
    tracep->pushNamePrefix("out_gen_bus_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__gen_bus_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("pipeline_trans_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline_trans_if__0(vlSelf, tracep);
    tracep->popNamePrefix(3);
    tracep->pushNamePrefix("gen_bus_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__gen_bus_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("hazard_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__hazard_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("icache_mc_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__icache_mc_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("interrupt_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__interrupt_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("mc ");
    tracep->pushNamePrefix("d_gen_bus_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__dcache_mc_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("i_gen_bus_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__icache_mc_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("out_gen_bus_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline_trans_if__0(vlSelf, tracep);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("pipeline ");
    tracep->pushNamePrefix("cc_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__cc_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("dgen_bus_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("execute_stage_i ");
    tracep->pushNamePrefix("alu ");
    tracep->pushNamePrefix("alu_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu_if__0(vlSelf, tracep);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("alu_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("branch_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("branch_res ");
    tracep->pushNamePrefix("br_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_if__0(vlSelf, tracep);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("cu ");
    tracep->pushNamePrefix("cu_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("rf_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__rf_if__0(vlSelf, tracep);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("cu_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("ex_mem_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("fetch_ex_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("fw_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__fw_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("g_rfile_select ");
    tracep->pushNamePrefix("rf ");
    tracep->pushNamePrefix("rf_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__rf_if__0(vlSelf, tracep);
    tracep->popNamePrefix(3);
    tracep->pushNamePrefix("hazard_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("jump_calc ");
    tracep->pushNamePrefix("jump_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__jump_if__0(vlSelf, tracep);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("jump_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__jump_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("rf_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__rf_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("rv32cif\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__rv32cif__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("sparce_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__sparce_if__0(vlSelf, tracep);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("fetch_ex_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("fetch_stage_i ");
    tracep->pushNamePrefix("fetch_ex_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("hazard_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("igen_bus_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__tspp_icache_gen_bus_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("mem_fetch_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("predict_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__predict_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("prv_pipe_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__prv_pipe_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("rv32cif\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__rv32cif__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("sparce_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__sparce_if__0(vlSelf, tracep);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("forward_unit_i ");
    tracep->pushNamePrefix("fw_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__fw_if__0(vlSelf, tracep);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("fw_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__fw_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("hazard_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("hazard_unit_i ");
    tracep->pushNamePrefix("hazard_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("prv_pipe_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__prv_pipe_if__0(vlSelf, tracep);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("igen_bus_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__tspp_icache_gen_bus_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("mem_pipe_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("mem_stage_i ");
    tracep->pushNamePrefix("cc_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__cc_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("dgen_bus_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("ex_mem_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("fw_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__fw_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("hazard_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("predict_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__predict_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("prv_pipe_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__prv_pipe_if__0(vlSelf, tracep);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("predict_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__predict_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("prv_pipe_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__prv_pipe_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("rv32cif\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__rv32cif__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("sparce_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__sparce_if__0(vlSelf, tracep);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("pipeline_trans_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__pipeline_trans_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("predict_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__predict_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("priv_wrapper_i ");
    tracep->pushNamePrefix("interrupt_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__interrupt_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("priv_block_i ");
    tracep->pushNamePrefix("csr ");
    tracep->pushNamePrefix("priv_ext_pma_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pma_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("priv_ext_pmp_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pmp_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("prv_intern_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if__0(vlSelf, tracep);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("int_ex_handler ");
    tracep->pushNamePrefix("prv_intern_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if__0(vlSelf, tracep);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("interrupt_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__interrupt_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("mode ");
    tracep->pushNamePrefix("prv_intern_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if__0(vlSelf, tracep);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("pipe_ctrl ");
    tracep->pushNamePrefix("prv_intern_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if__0(vlSelf, tracep);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("pma ");
    tracep->pushNamePrefix("priv_ext_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pma_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("prv_intern_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if__0(vlSelf, tracep);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("pmp ");
    tracep->pushNamePrefix("priv_ext_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pmp_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("prv_intern_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if__0(vlSelf, tracep);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("priv_ext_pma_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pma_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("priv_ext_pmp_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pmp_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("prv_intern_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("prv_pipe_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__prv_pipe_if__0(vlSelf, tracep);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("prv_pipe_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__prv_pipe_if__0(vlSelf, tracep);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("prv_pipe_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__prv_pipe_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("rm_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__rm_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("rv32c ");
    tracep->pushNamePrefix("genblk1 ");
    tracep->pushNamePrefix("RV32C ");
    tracep->pushNamePrefix("rv32cif\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__rv32cif__0(vlSelf, tracep);
    tracep->popNamePrefix(3);
    tracep->pushNamePrefix("rv32cif\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__rv32cif__0(vlSelf, tracep);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("rv32cif\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__rv32cif__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("sep_caches ");
    tracep->pushNamePrefix("cc_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__cc_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("dcache_mem_gen_bus_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__dcache_mc_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("dcache_proc_gen_bus_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("genblk1 ");
    tracep->pushNamePrefix("dcache ");
    tracep->pushNamePrefix("mem_gen_bus_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__dcache_mc_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("proc_gen_bus_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if__0(vlSelf, tracep);
    tracep->popNamePrefix(3);
    tracep->pushNamePrefix("genblk2 ");
    tracep->pushNamePrefix("icache ");
    tracep->pushNamePrefix("mem_gen_bus_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__icache_mc_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("proc_gen_bus_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__tspp_icache_gen_bus_if__0(vlSelf, tracep);
    tracep->popNamePrefix(3);
    tracep->pushNamePrefix("icache_mem_gen_bus_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__icache_mc_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("icache_proc_gen_bus_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__tspp_icache_gen_bus_if__0(vlSelf, tracep);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("sparce_disabled_i ");
    tracep->pushNamePrefix("sparce_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__sparce_if__0(vlSelf, tracep);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("sparce_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__sparce_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("tspp_dcache_gen_bus_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("tspp_icache_gen_bus_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__CORE__DOT__tspp_icache_gen_bus_if__0(vlSelf, tracep);
    tracep->popNamePrefix(2);
    tracep->pushNamePrefix("gen_bus_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__gen_bus_if__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("interrupt_if\211 ");
    Vtop_core___024root__trace_init_sub__TOP__top_core__interrupt_if__0(vlSelf, tracep);
    tracep->popNamePrefix(2);
}

VL_ATTR_COLD void Vtop_core___024root__trace_full_top_0(void* voidSelf, VerilatedFst::Buffer* bufp);
void Vtop_core___024root__trace_chg_top_0(void* voidSelf, VerilatedFst::Buffer* bufp);
void Vtop_core___024root__trace_cleanup(void* voidSelf, VerilatedFst* /*unused*/);

VL_ATTR_COLD void Vtop_core___024root__trace_register(Vtop_core___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_register\n"); );
    // Body
    tracep->addFullCb(&Vtop_core___024root__trace_full_top_0, vlSelf);
    tracep->addChgCb(&Vtop_core___024root__trace_chg_top_0, vlSelf);
    tracep->addCleanupCb(&Vtop_core___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void Vtop_core___024root__trace_full_sub_0(Vtop_core___024root* vlSelf, VerilatedFst::Buffer* bufp);

VL_ATTR_COLD void Vtop_core___024root__trace_full_top_0(void* voidSelf, VerilatedFst::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_full_top_0\n"); );
    // Init
    Vtop_core___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtop_core___024root*>(voidSelf);
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    Vtop_core___024root__trace_full_sub_0((&vlSymsp->TOP), bufp);
}

extern const VlWide<12>/*383:0*/ Vtop_core__ConstPool__CONST_h1b548564_0;

VL_ATTR_COLD void Vtop_core___024root__trace_full_sub_0(Vtop_core___024root* vlSelf, VerilatedFst::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root__trace_full_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
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
    VlWide<3>/*95:0*/ __Vtemp_h1a982929__0;
    VlWide<4>/*127:0*/ __Vtemp_ha2760738__0;
    // Body
    bufp->fullIData(oldp+1,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__cpu_track1__DOT__fptr),32);
    bufp->fullCData(oldp+2,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_word_num),2);
    bufp->fullBit(oldp+3,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__enable_word_count));
    bufp->fullCData(oldp+4,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_word_num),2);
    bufp->fullBit(oldp+5,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__enable_word_count));
    bufp->fullBit(oldp+6,(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__busy));
    bufp->fullBit(oldp+7,(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__busy));
    bufp->fullBit(oldp+8,(vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__busy));
    bufp->fullSData(oldp+9,((vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip 
                             >> 0x10U)),16);
    bufp->fullCData(oldp+10,((0xfU & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip 
                                      >> 0xcU))),4);
    bufp->fullBit(oldp+11,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip 
                                  >> 0xbU))));
    bufp->fullBit(oldp+12,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip 
                                  >> 0xaU))));
    bufp->fullBit(oldp+13,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip 
                                  >> 9U))));
    bufp->fullBit(oldp+14,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip 
                                  >> 8U))));
    bufp->fullBit(oldp+15,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip 
                                  >> 7U))));
    bufp->fullBit(oldp+16,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip 
                                  >> 6U))));
    bufp->fullBit(oldp+17,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip 
                                  >> 5U))));
    bufp->fullBit(oldp+18,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip 
                                  >> 4U))));
    bufp->fullBit(oldp+19,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip 
                                  >> 3U))));
    bufp->fullBit(oldp+20,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip 
                                  >> 2U))));
    bufp->fullBit(oldp+21,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip 
                                  >> 1U))));
    bufp->fullBit(oldp+22,((1U & vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip)));
    bufp->fullIData(oldp+23,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu_if.__PVT__port_out),32);
    bufp->fullIData(oldp+24,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__rs1_post_fwd),32);
    bufp->fullIData(oldp+25,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__rs2_post_fwd),32);
    bufp->fullIData(oldp+26,(((0x6fU == (0x7fU & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))
                               ? vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__jump_calc__DOT__jump_addr
                               : (0xfffffffeU & vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__jump_calc__DOT__jump_addr))),32);
    bufp->fullIData(oldp+27,(((IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_if.__PVT__branch_taken)
                               ? (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[4U] 
                                  + VL_EXTENDS_II(32,13, (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__imm_SB)))
                               : vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[3U])),32);
    bufp->fullBit(oldp+28,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_if.__PVT__branch_taken));
    bufp->fullIData(oldp+29,((((0x6fU == (0x7fU & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U])) 
                               | (0x67U == (0x7fU & 
                                            vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U])))
                               ? ((0x6fU == (0x7fU 
                                             & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))
                                   ? vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__jump_calc__DOT__jump_addr
                                   : (0xfffffffeU & vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__jump_calc__DOT__jump_addr))
                               : ((IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_if.__PVT__branch_taken)
                                   ? (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[4U] 
                                      + VL_EXTENDS_II(32,13, (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__imm_SB)))
                                   : vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[3U]))),32);
    bufp->fullIData(oldp+30,((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu__DOT__adder_out)),32);
    bufp->fullIData(oldp+31,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu_if.__PVT__port_a),32);
    bufp->fullIData(oldp+32,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu__DOT__op_b),32);
    bufp->fullIData(oldp+33,(((IData)(1U) + (~ vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu_if.__PVT__port_b))),32);
    bufp->fullBit(oldp+34,((1U & (IData)((vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu__DOT__adder_out 
                                          >> 0x20U)))));
    bufp->fullBit(oldp+35,((1U & (IData)((vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu__DOT__adder_out 
                                          >> 0x1fU)))));
    bufp->fullBit(oldp+36,((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu_if.__PVT__port_a 
                            >> 0x1fU)));
    bufp->fullBit(oldp+37,((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu_if.__PVT__port_b 
                            >> 0x1fU)));
    bufp->fullQData(oldp+38,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu__DOT__adder_out),33);
    bufp->fullQData(oldp+40,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu__DOT__op_a_ext),33);
    bufp->fullQData(oldp+42,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu__DOT__op_b_ext),33);
    bufp->fullBit(oldp+44,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_res__DOT__lt));
    bufp->fullBit(oldp+45,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_res__DOT__eq));
    bufp->fullBit(oldp+46,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_res__DOT__ltu));
    bufp->fullBit(oldp+47,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__rs1_post_fwd 
                            >> 0x1fU)));
    bufp->fullBit(oldp+48,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__rs2_post_fwd 
                            >> 0x1fU)));
    bufp->fullBit(oldp+49,((1U & (IData)((vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_res__DOT__adder_out 
                                          >> 0x1fU)))));
    bufp->fullBit(oldp+50,((1U & (IData)((vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_res__DOT__adder_out 
                                          >> 0x20U)))));
    bufp->fullQData(oldp+51,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_res__DOT__adder_out),33);
    bufp->fullQData(oldp+53,((((QData)((IData)(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__rs1_post_fwd 
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
    bufp->fullQData(oldp+55,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_res__DOT__op_2_ext),33);
    bufp->fullIData(oldp+57,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__jump_calc__DOT__jump_addr),32);
    bufp->fullIData(oldp+58,(((IData)(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__insert_pc)
                               ? vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__priv_pc
                               : ((1U & ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                          >> 0x10U) 
                                         & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__fence_stall))))
                                   ? ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[6U] 
                                       << 0x1fU) | 
                                      (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[5U] 
                                       >> 1U)) : ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__branch_jump)
                                                   ? 
                                                  ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                    << 0x1fU) 
                                                   | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xbU] 
                                                      >> 1U))
                                                   : 
                                                  ((IData)(4U) 
                                                   + vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc))))),32);
    bufp->fullIData(oldp+59,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__priv_pc),32);
    bufp->fullIData(oldp+60,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__old_csr_val),32);
    bufp->fullIData(oldp+61,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fw_if.__PVT__rd_mem_data),32);
    bufp->fullBit(oldp+62,((vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mcause 
                            >> 0x1fU)));
    bufp->fullIData(oldp+63,((0x7fffffffU & vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mcause)),31);
    bufp->fullIData(oldp+64,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu_if.__PVT__port_b),32);
    bufp->fullIData(oldp+65,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu_if.__PVT__port_out),32);
    bufp->fullIData(oldp+66,(((0x6fU == (0x7fU & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))
                               ? vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[4U]
                               : vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__rs1_post_fwd)),32);
    bufp->fullIData(oldp+67,((0xfffffffeU & vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__jump_calc__DOT__jump_addr)),32);
    bufp->fullBit(oldp+68,((((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                              >> 0x11U) & ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                            >> 0x13U) 
                                           | (IData)(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__valid_write))) 
                            & ((((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                           >> 0xfU)) 
                                 == (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                              >> 0x13U))) 
                                & (0U != (0x1fU & (
                                                   vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                   >> 0x13U)))) 
                               | (((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                             >> 0x14U)) 
                                   == (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                >> 0x13U))) 
                                  & (0U != (0x1fU & 
                                            (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                             >> 0x13U))))))));
    bufp->fullBit(oldp+69,((1U & ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                   >> 0x13U) | (IData)(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__valid_write)))));
    bufp->fullBit(oldp+70,(((IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__ex_mem_stall) 
                            & (0U == (0x408000U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU])))));
    bufp->fullBit(oldp+71,((1U & ((~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__if_ex_stall)) 
                                  | (0U != (0x408000U 
                                            & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU]))))));
    bufp->fullBit(oldp+72,((1U & ((~ (((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__ex_flush_hazard) 
                                       | (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__branch_jump)) 
                                      | ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__wait_for_imem) 
                                         & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__ex_mem_stall))))) 
                                  & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__if_ex_stall))))));
    bufp->fullBit(oldp+73,((1U & (((((((~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__if_ex_stall)) 
                                       & (~ (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__wait_for_imem))) 
                                      | (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__branch_jump)) 
                                     | (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__ex_flush_hazard)) 
                                    | (IData)(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__insert_pc)) 
                                   | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                      >> 6U)) & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__fence_stall))))));
    bufp->fullBit(oldp+74,((((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__ex_flush_hazard) 
                             | (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__branch_jump)) 
                            | ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__wait_for_imem) 
                               & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__ex_mem_stall))))));
    bufp->fullIData(oldp+75,(((8U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU])
                               ? ((4U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU])
                                   ? 0U : ((2U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU])
                                            ? 0U : vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__old_csr_val))
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
    bufp->fullBit(oldp+76,(((((~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__if_ex_stall)) 
                              | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                 >> 0xfU)) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                              >> 0x16U)) 
                            & (0U != ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[8U] 
                                       << 0x1fU) | 
                                      (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[7U] 
                                       >> 1U))))));
    bufp->fullBit(oldp+77,((((~ (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__invalid_csr_priv)) 
                             & (IData)(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__valid_write)) 
                            & (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__csr_operation))));
    bufp->fullBit(oldp+78,((1U & ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                   >> 0x11U) & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__ex_mem_stall))))));
    bufp->fullIData(oldp+79,(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__wdata),32);
    bufp->fullIData(oldp+80,(vlSymsp->TOP__top_core__CORE__DOT__tspp_icache_gen_bus_if.__PVT__rdata),32);
    bufp->fullIData(oldp+81,(vlSymsp->TOP__top_core__CORE__DOT__tspp_icache_gen_bus_if.__PVT__rdata),32);
    bufp->fullBit(oldp+82,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__wait_for_imem));
    bufp->fullBit(oldp+83,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__wait_for_dmem));
    bufp->fullBit(oldp+84,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__ex_flush_hazard));
    bufp->fullIData(oldp+85,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__dload_ext),32);
    bufp->fullIData(oldp+86,(vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__rdata),32);
    bufp->fullBit(oldp+87,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                            >> 0x1fU)));
    bufp->fullCData(oldp+88,((0xffU & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                       >> 0x17U))),8);
    bufp->fullBit(oldp+89,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                  >> 0x16U))));
    bufp->fullBit(oldp+90,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                  >> 0x15U))));
    bufp->fullBit(oldp+91,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                  >> 0x14U))));
    bufp->fullBit(oldp+92,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                  >> 0x13U))));
    bufp->fullBit(oldp+93,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                  >> 0x12U))));
    bufp->fullBit(oldp+94,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                  >> 0x11U))));
    bufp->fullCData(oldp+95,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                    >> 0xfU))),2);
    bufp->fullCData(oldp+96,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                    >> 0xdU))),2);
    bufp->fullCData(oldp+97,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                    >> 0xbU))),2);
    bufp->fullCData(oldp+98,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                    >> 9U))),2);
    bufp->fullBit(oldp+99,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                  >> 8U))));
    bufp->fullBit(oldp+100,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                   >> 7U))));
    bufp->fullBit(oldp+101,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                   >> 6U))));
    bufp->fullBit(oldp+102,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                   >> 5U))));
    bufp->fullBit(oldp+103,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                   >> 4U))));
    bufp->fullBit(oldp+104,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                   >> 3U))));
    bufp->fullBit(oldp+105,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                   >> 2U))));
    bufp->fullBit(oldp+106,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                   >> 1U))));
    bufp->fullBit(oldp+107,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next)));
    bufp->fullSData(oldp+108,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                               >> 0x10U)),16);
    bufp->fullCData(oldp+109,((0xfU & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                                       >> 0xcU))),4);
    bufp->fullBit(oldp+110,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                                   >> 0xbU))));
    bufp->fullBit(oldp+111,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                                   >> 0xaU))));
    bufp->fullBit(oldp+112,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                                   >> 9U))));
    bufp->fullBit(oldp+113,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                                   >> 8U))));
    bufp->fullBit(oldp+114,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                                   >> 7U))));
    bufp->fullBit(oldp+115,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                                   >> 6U))));
    bufp->fullBit(oldp+116,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                                   >> 5U))));
    bufp->fullBit(oldp+117,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                                   >> 4U))));
    bufp->fullBit(oldp+118,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                                   >> 3U))));
    bufp->fullBit(oldp+119,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                                   >> 2U))));
    bufp->fullBit(oldp+120,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                                   >> 1U))));
    bufp->fullBit(oldp+121,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next)));
    bufp->fullIData(oldp+122,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mtvec_next 
                               >> 2U)),30);
    bufp->fullCData(oldp+123,((3U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mtvec_next)),2);
    bufp->fullIData(oldp+124,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mscratch_next),32);
    bufp->fullIData(oldp+125,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mepc_next),32);
    bufp->fullBit(oldp+126,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcause_next 
                             >> 0x1fU)));
    bufp->fullIData(oldp+127,((0x7fffffffU & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcause_next)),31);
    bufp->fullIData(oldp+128,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mtval_next),32);
    bufp->fullSData(oldp+129,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                               >> 0x10U)),16);
    bufp->fullCData(oldp+130,((0xfU & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                                       >> 0xcU))),4);
    bufp->fullBit(oldp+131,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                                   >> 0xbU))));
    bufp->fullBit(oldp+132,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                                   >> 0xaU))));
    bufp->fullBit(oldp+133,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                                   >> 9U))));
    bufp->fullBit(oldp+134,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                                   >> 8U))));
    bufp->fullBit(oldp+135,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                                   >> 7U))));
    bufp->fullBit(oldp+136,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                                   >> 6U))));
    bufp->fullBit(oldp+137,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                                   >> 5U))));
    bufp->fullBit(oldp+138,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                                   >> 4U))));
    bufp->fullBit(oldp+139,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                                   >> 3U))));
    bufp->fullBit(oldp+140,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                                   >> 2U))));
    bufp->fullBit(oldp+141,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                                   >> 1U))));
    bufp->fullBit(oldp+142,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next)));
    bufp->fullBit(oldp+143,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                             >> 0x1fU)));
    bufp->fullBit(oldp+144,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 0x1eU))));
    bufp->fullBit(oldp+145,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 0x1dU))));
    bufp->fullBit(oldp+146,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 0x1cU))));
    bufp->fullBit(oldp+147,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 0x1bU))));
    bufp->fullBit(oldp+148,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 0x1aU))));
    bufp->fullBit(oldp+149,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 0x19U))));
    bufp->fullBit(oldp+150,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 0x18U))));
    bufp->fullBit(oldp+151,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 0x17U))));
    bufp->fullBit(oldp+152,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 0x16U))));
    bufp->fullBit(oldp+153,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 0x15U))));
    bufp->fullBit(oldp+154,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 0x14U))));
    bufp->fullBit(oldp+155,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 0x13U))));
    bufp->fullBit(oldp+156,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 0x12U))));
    bufp->fullBit(oldp+157,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 0x11U))));
    bufp->fullBit(oldp+158,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 0x10U))));
    bufp->fullBit(oldp+159,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 0xfU))));
    bufp->fullBit(oldp+160,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 0xeU))));
    bufp->fullBit(oldp+161,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 0xdU))));
    bufp->fullBit(oldp+162,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 0xcU))));
    bufp->fullBit(oldp+163,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 0xbU))));
    bufp->fullBit(oldp+164,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 0xaU))));
    bufp->fullBit(oldp+165,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 9U))));
    bufp->fullBit(oldp+166,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 8U))));
    bufp->fullBit(oldp+167,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 7U))));
    bufp->fullBit(oldp+168,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 6U))));
    bufp->fullBit(oldp+169,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 5U))));
    bufp->fullBit(oldp+170,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 4U))));
    bufp->fullBit(oldp+171,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 3U))));
    bufp->fullBit(oldp+172,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 2U))));
    bufp->fullBit(oldp+173,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                                   >> 1U))));
    bufp->fullBit(oldp+174,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next)));
    bufp->fullBit(oldp+175,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                             >> 0x1fU)));
    bufp->fullBit(oldp+176,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 0x1eU))));
    bufp->fullBit(oldp+177,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 0x1dU))));
    bufp->fullBit(oldp+178,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 0x1cU))));
    bufp->fullBit(oldp+179,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 0x1bU))));
    bufp->fullBit(oldp+180,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 0x1aU))));
    bufp->fullBit(oldp+181,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 0x19U))));
    bufp->fullBit(oldp+182,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 0x18U))));
    bufp->fullBit(oldp+183,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 0x17U))));
    bufp->fullBit(oldp+184,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 0x16U))));
    bufp->fullBit(oldp+185,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 0x15U))));
    bufp->fullBit(oldp+186,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 0x14U))));
    bufp->fullBit(oldp+187,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 0x13U))));
    bufp->fullBit(oldp+188,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 0x12U))));
    bufp->fullBit(oldp+189,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 0x11U))));
    bufp->fullBit(oldp+190,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 0x10U))));
    bufp->fullBit(oldp+191,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 0xfU))));
    bufp->fullBit(oldp+192,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 0xeU))));
    bufp->fullBit(oldp+193,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 0xdU))));
    bufp->fullBit(oldp+194,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 0xcU))));
    bufp->fullBit(oldp+195,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 0xbU))));
    bufp->fullBit(oldp+196,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 0xaU))));
    bufp->fullBit(oldp+197,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 9U))));
    bufp->fullBit(oldp+198,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 8U))));
    bufp->fullBit(oldp+199,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 7U))));
    bufp->fullBit(oldp+200,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 6U))));
    bufp->fullBit(oldp+201,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 5U))));
    bufp->fullBit(oldp+202,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 4U))));
    bufp->fullBit(oldp+203,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 3U))));
    bufp->fullBit(oldp+204,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 2U))));
    bufp->fullBit(oldp+205,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                                   >> 1U))));
    bufp->fullBit(oldp+206,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next)));
    bufp->fullQData(oldp+207,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__cf_next),64);
    bufp->fullQData(oldp+209,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__if_next),64);
    bufp->fullIData(oldp+211,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val),32);
    bufp->fullBit(oldp+212,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__inject_mcycle));
    bufp->fullBit(oldp+213,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__inject_minstret));
    bufp->fullBit(oldp+214,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__inject_mcycleh));
    bufp->fullBit(oldp+215,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__inject_minstreth));
    bufp->fullCData(oldp+216,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                               >> 0x1eU)),2);
    bufp->fullBit(oldp+217,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                   >> 0x1dU))));
    bufp->fullBit(oldp+218,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                   >> 0x1cU))));
    bufp->fullBit(oldp+219,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                   >> 0x1bU))));
    bufp->fullCData(oldp+220,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                     >> 0x18U))),3);
    bufp->fullBit(oldp+221,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                   >> 0x17U))));
    bufp->fullBit(oldp+222,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                   >> 0x16U))));
    bufp->fullBit(oldp+223,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                   >> 0x15U))));
    bufp->fullCData(oldp+224,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                     >> 0x13U))),2);
    bufp->fullCData(oldp+225,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                     >> 0x11U))),2);
    bufp->fullBit(oldp+226,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                   >> 0x10U))));
    bufp->fullCData(oldp+227,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                     >> 0xeU))),2);
    bufp->fullBit(oldp+228,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                   >> 0xdU))));
    bufp->fullBit(oldp+229,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                   >> 0xcU))));
    bufp->fullBit(oldp+230,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                   >> 0xbU))));
    bufp->fullCData(oldp+231,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                     >> 8U))),3);
    bufp->fullBit(oldp+232,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                   >> 7U))));
    bufp->fullBit(oldp+233,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                   >> 6U))));
    bufp->fullBit(oldp+234,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                   >> 5U))));
    bufp->fullCData(oldp+235,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                     >> 3U))),2);
    bufp->fullCData(oldp+236,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
                                     >> 1U))),2);
    bufp->fullBit(oldp+237,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U])));
    bufp->fullCData(oldp+238,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                               >> 0x1eU)),2);
    bufp->fullBit(oldp+239,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                   >> 0x1dU))));
    bufp->fullBit(oldp+240,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                   >> 0x1cU))));
    bufp->fullBit(oldp+241,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                   >> 0x1bU))));
    bufp->fullCData(oldp+242,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                     >> 0x18U))),3);
    bufp->fullBit(oldp+243,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                   >> 0x17U))));
    bufp->fullBit(oldp+244,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                   >> 0x16U))));
    bufp->fullBit(oldp+245,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                   >> 0x15U))));
    bufp->fullCData(oldp+246,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                     >> 0x13U))),2);
    bufp->fullCData(oldp+247,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                     >> 0x11U))),2);
    bufp->fullBit(oldp+248,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                   >> 0x10U))));
    bufp->fullCData(oldp+249,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                     >> 0xeU))),2);
    bufp->fullBit(oldp+250,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                   >> 0xdU))));
    bufp->fullBit(oldp+251,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                   >> 0xcU))));
    bufp->fullBit(oldp+252,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                   >> 0xbU))));
    bufp->fullCData(oldp+253,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                     >> 8U))),3);
    bufp->fullBit(oldp+254,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                   >> 7U))));
    bufp->fullBit(oldp+255,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                   >> 6U))));
    bufp->fullBit(oldp+256,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                   >> 5U))));
    bufp->fullCData(oldp+257,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                     >> 3U))),2);
    bufp->fullCData(oldp+258,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
                                     >> 1U))),2);
    bufp->fullBit(oldp+259,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U])));
    bufp->fullCData(oldp+260,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                               >> 0x1eU)),2);
    bufp->fullBit(oldp+261,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                   >> 0x1dU))));
    bufp->fullBit(oldp+262,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                   >> 0x1cU))));
    bufp->fullBit(oldp+263,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                   >> 0x1bU))));
    bufp->fullCData(oldp+264,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                     >> 0x18U))),3);
    bufp->fullBit(oldp+265,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                   >> 0x17U))));
    bufp->fullBit(oldp+266,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                   >> 0x16U))));
    bufp->fullBit(oldp+267,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                   >> 0x15U))));
    bufp->fullCData(oldp+268,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                     >> 0x13U))),2);
    bufp->fullCData(oldp+269,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                     >> 0x11U))),2);
    bufp->fullBit(oldp+270,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                   >> 0x10U))));
    bufp->fullCData(oldp+271,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                     >> 0xeU))),2);
    bufp->fullBit(oldp+272,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                   >> 0xdU))));
    bufp->fullBit(oldp+273,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                   >> 0xcU))));
    bufp->fullBit(oldp+274,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                   >> 0xbU))));
    bufp->fullCData(oldp+275,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                     >> 8U))),3);
    bufp->fullBit(oldp+276,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                   >> 7U))));
    bufp->fullBit(oldp+277,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                   >> 6U))));
    bufp->fullBit(oldp+278,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                   >> 5U))));
    bufp->fullCData(oldp+279,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                     >> 3U))),2);
    bufp->fullCData(oldp+280,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
                                     >> 1U))),2);
    bufp->fullBit(oldp+281,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U])));
    bufp->fullCData(oldp+282,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                               >> 0x1eU)),2);
    bufp->fullBit(oldp+283,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                   >> 0x1dU))));
    bufp->fullBit(oldp+284,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                   >> 0x1cU))));
    bufp->fullBit(oldp+285,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                   >> 0x1bU))));
    bufp->fullCData(oldp+286,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                     >> 0x18U))),3);
    bufp->fullBit(oldp+287,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                   >> 0x17U))));
    bufp->fullBit(oldp+288,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                   >> 0x16U))));
    bufp->fullBit(oldp+289,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                   >> 0x15U))));
    bufp->fullCData(oldp+290,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                     >> 0x13U))),2);
    bufp->fullCData(oldp+291,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                     >> 0x11U))),2);
    bufp->fullBit(oldp+292,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                   >> 0x10U))));
    bufp->fullCData(oldp+293,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                     >> 0xeU))),2);
    bufp->fullBit(oldp+294,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                   >> 0xdU))));
    bufp->fullBit(oldp+295,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                   >> 0xcU))));
    bufp->fullBit(oldp+296,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                   >> 0xbU))));
    bufp->fullCData(oldp+297,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                     >> 8U))),3);
    bufp->fullBit(oldp+298,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                   >> 7U))));
    bufp->fullBit(oldp+299,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                   >> 6U))));
    bufp->fullBit(oldp+300,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                   >> 5U))));
    bufp->fullCData(oldp+301,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                     >> 3U))),2);
    bufp->fullCData(oldp+302,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
                                     >> 1U))),2);
    bufp->fullBit(oldp+303,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U])));
    bufp->fullCData(oldp+304,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                               >> 0x1eU)),2);
    bufp->fullBit(oldp+305,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                   >> 0x1dU))));
    bufp->fullBit(oldp+306,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                   >> 0x1cU))));
    bufp->fullBit(oldp+307,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                   >> 0x1bU))));
    bufp->fullCData(oldp+308,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                     >> 0x18U))),3);
    bufp->fullBit(oldp+309,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                   >> 0x17U))));
    bufp->fullBit(oldp+310,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                   >> 0x16U))));
    bufp->fullBit(oldp+311,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                   >> 0x15U))));
    bufp->fullCData(oldp+312,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                     >> 0x13U))),2);
    bufp->fullCData(oldp+313,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                     >> 0x11U))),2);
    bufp->fullBit(oldp+314,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                   >> 0x10U))));
    bufp->fullCData(oldp+315,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                     >> 0xeU))),2);
    bufp->fullBit(oldp+316,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                   >> 0xdU))));
    bufp->fullBit(oldp+317,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                   >> 0xcU))));
    bufp->fullBit(oldp+318,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                   >> 0xbU))));
    bufp->fullCData(oldp+319,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                     >> 8U))),3);
    bufp->fullBit(oldp+320,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                   >> 7U))));
    bufp->fullBit(oldp+321,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                   >> 6U))));
    bufp->fullBit(oldp+322,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                   >> 5U))));
    bufp->fullCData(oldp+323,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                     >> 3U))),2);
    bufp->fullCData(oldp+324,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
                                     >> 1U))),2);
    bufp->fullBit(oldp+325,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U])));
    bufp->fullCData(oldp+326,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                               >> 0x1eU)),2);
    bufp->fullBit(oldp+327,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                   >> 0x1dU))));
    bufp->fullBit(oldp+328,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                   >> 0x1cU))));
    bufp->fullBit(oldp+329,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                   >> 0x1bU))));
    bufp->fullCData(oldp+330,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                     >> 0x18U))),3);
    bufp->fullBit(oldp+331,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                   >> 0x17U))));
    bufp->fullBit(oldp+332,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                   >> 0x16U))));
    bufp->fullBit(oldp+333,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                   >> 0x15U))));
    bufp->fullCData(oldp+334,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                     >> 0x13U))),2);
    bufp->fullCData(oldp+335,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                     >> 0x11U))),2);
    bufp->fullBit(oldp+336,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                   >> 0x10U))));
    bufp->fullCData(oldp+337,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                     >> 0xeU))),2);
    bufp->fullBit(oldp+338,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                   >> 0xdU))));
    bufp->fullBit(oldp+339,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                   >> 0xcU))));
    bufp->fullBit(oldp+340,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                   >> 0xbU))));
    bufp->fullCData(oldp+341,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                     >> 8U))),3);
    bufp->fullBit(oldp+342,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                   >> 7U))));
    bufp->fullBit(oldp+343,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                   >> 6U))));
    bufp->fullBit(oldp+344,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                   >> 5U))));
    bufp->fullCData(oldp+345,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                     >> 3U))),2);
    bufp->fullCData(oldp+346,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
                                     >> 1U))),2);
    bufp->fullBit(oldp+347,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U])));
    bufp->fullCData(oldp+348,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                               >> 0x1eU)),2);
    bufp->fullBit(oldp+349,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                   >> 0x1dU))));
    bufp->fullBit(oldp+350,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                   >> 0x1cU))));
    bufp->fullBit(oldp+351,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                   >> 0x1bU))));
    bufp->fullCData(oldp+352,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                     >> 0x18U))),3);
    bufp->fullBit(oldp+353,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                   >> 0x17U))));
    bufp->fullBit(oldp+354,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                   >> 0x16U))));
    bufp->fullBit(oldp+355,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                   >> 0x15U))));
    bufp->fullCData(oldp+356,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                     >> 0x13U))),2);
    bufp->fullCData(oldp+357,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                     >> 0x11U))),2);
    bufp->fullBit(oldp+358,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                   >> 0x10U))));
    bufp->fullCData(oldp+359,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                     >> 0xeU))),2);
    bufp->fullBit(oldp+360,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                   >> 0xdU))));
    bufp->fullBit(oldp+361,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                   >> 0xcU))));
    bufp->fullBit(oldp+362,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                   >> 0xbU))));
    bufp->fullCData(oldp+363,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                     >> 8U))),3);
    bufp->fullBit(oldp+364,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                   >> 7U))));
    bufp->fullBit(oldp+365,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                   >> 6U))));
    bufp->fullBit(oldp+366,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                   >> 5U))));
    bufp->fullCData(oldp+367,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                     >> 3U))),2);
    bufp->fullCData(oldp+368,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
                                     >> 1U))),2);
    bufp->fullBit(oldp+369,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U])));
    bufp->fullCData(oldp+370,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                               >> 0x1eU)),2);
    bufp->fullBit(oldp+371,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                   >> 0x1dU))));
    bufp->fullBit(oldp+372,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                   >> 0x1cU))));
    bufp->fullBit(oldp+373,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                   >> 0x1bU))));
    bufp->fullCData(oldp+374,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                     >> 0x18U))),3);
    bufp->fullBit(oldp+375,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                   >> 0x17U))));
    bufp->fullBit(oldp+376,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                   >> 0x16U))));
    bufp->fullBit(oldp+377,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                   >> 0x15U))));
    bufp->fullCData(oldp+378,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                     >> 0x13U))),2);
    bufp->fullCData(oldp+379,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                     >> 0x11U))),2);
    bufp->fullBit(oldp+380,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                   >> 0x10U))));
    bufp->fullCData(oldp+381,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                     >> 0xeU))),2);
    bufp->fullBit(oldp+382,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                   >> 0xdU))));
    bufp->fullBit(oldp+383,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                   >> 0xcU))));
    bufp->fullBit(oldp+384,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                   >> 0xbU))));
    bufp->fullCData(oldp+385,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                     >> 8U))),3);
    bufp->fullBit(oldp+386,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                   >> 7U))));
    bufp->fullBit(oldp+387,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                   >> 6U))));
    bufp->fullBit(oldp+388,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                   >> 5U))));
    bufp->fullCData(oldp+389,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                     >> 3U))),2);
    bufp->fullCData(oldp+390,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
                                     >> 1U))),2);
    bufp->fullBit(oldp+391,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U])));
    bufp->fullCData(oldp+392,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                               >> 0x1eU)),2);
    bufp->fullBit(oldp+393,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                   >> 0x1dU))));
    bufp->fullBit(oldp+394,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                   >> 0x1cU))));
    bufp->fullBit(oldp+395,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                   >> 0x1bU))));
    bufp->fullCData(oldp+396,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                     >> 0x18U))),3);
    bufp->fullBit(oldp+397,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                   >> 0x17U))));
    bufp->fullBit(oldp+398,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                   >> 0x16U))));
    bufp->fullBit(oldp+399,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                   >> 0x15U))));
    bufp->fullCData(oldp+400,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                     >> 0x13U))),2);
    bufp->fullCData(oldp+401,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                     >> 0x11U))),2);
    bufp->fullBit(oldp+402,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                   >> 0x10U))));
    bufp->fullCData(oldp+403,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                     >> 0xeU))),2);
    bufp->fullBit(oldp+404,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                   >> 0xdU))));
    bufp->fullBit(oldp+405,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                   >> 0xcU))));
    bufp->fullBit(oldp+406,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                   >> 0xbU))));
    bufp->fullCData(oldp+407,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                     >> 8U))),3);
    bufp->fullBit(oldp+408,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                   >> 7U))));
    bufp->fullBit(oldp+409,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                   >> 6U))));
    bufp->fullBit(oldp+410,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                   >> 5U))));
    bufp->fullCData(oldp+411,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                     >> 3U))),2);
    bufp->fullCData(oldp+412,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
                                     >> 1U))),2);
    bufp->fullBit(oldp+413,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U])));
    bufp->fullCData(oldp+414,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                               >> 0x1eU)),2);
    bufp->fullBit(oldp+415,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                   >> 0x1dU))));
    bufp->fullBit(oldp+416,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                   >> 0x1cU))));
    bufp->fullBit(oldp+417,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                   >> 0x1bU))));
    bufp->fullCData(oldp+418,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                     >> 0x18U))),3);
    bufp->fullBit(oldp+419,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                   >> 0x17U))));
    bufp->fullBit(oldp+420,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                   >> 0x16U))));
    bufp->fullBit(oldp+421,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                   >> 0x15U))));
    bufp->fullCData(oldp+422,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                     >> 0x13U))),2);
    bufp->fullCData(oldp+423,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                     >> 0x11U))),2);
    bufp->fullBit(oldp+424,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                   >> 0x10U))));
    bufp->fullCData(oldp+425,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                     >> 0xeU))),2);
    bufp->fullBit(oldp+426,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                   >> 0xdU))));
    bufp->fullBit(oldp+427,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                   >> 0xcU))));
    bufp->fullBit(oldp+428,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                   >> 0xbU))));
    bufp->fullCData(oldp+429,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                     >> 8U))),3);
    bufp->fullBit(oldp+430,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                   >> 7U))));
    bufp->fullBit(oldp+431,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                   >> 6U))));
    bufp->fullBit(oldp+432,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                   >> 5U))));
    bufp->fullCData(oldp+433,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                     >> 3U))),2);
    bufp->fullCData(oldp+434,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
                                     >> 1U))),2);
    bufp->fullBit(oldp+435,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U])));
    bufp->fullCData(oldp+436,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                               >> 0x1eU)),2);
    bufp->fullBit(oldp+437,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                   >> 0x1dU))));
    bufp->fullBit(oldp+438,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                   >> 0x1cU))));
    bufp->fullBit(oldp+439,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                   >> 0x1bU))));
    bufp->fullCData(oldp+440,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                     >> 0x18U))),3);
    bufp->fullBit(oldp+441,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                   >> 0x17U))));
    bufp->fullBit(oldp+442,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                   >> 0x16U))));
    bufp->fullBit(oldp+443,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                   >> 0x15U))));
    bufp->fullCData(oldp+444,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                     >> 0x13U))),2);
    bufp->fullCData(oldp+445,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                     >> 0x11U))),2);
    bufp->fullBit(oldp+446,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                   >> 0x10U))));
    bufp->fullCData(oldp+447,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                     >> 0xeU))),2);
    bufp->fullBit(oldp+448,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                   >> 0xdU))));
    bufp->fullBit(oldp+449,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                   >> 0xcU))));
    bufp->fullBit(oldp+450,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                   >> 0xbU))));
    bufp->fullCData(oldp+451,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                     >> 8U))),3);
    bufp->fullBit(oldp+452,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                   >> 7U))));
    bufp->fullBit(oldp+453,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                   >> 6U))));
    bufp->fullBit(oldp+454,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                   >> 5U))));
    bufp->fullCData(oldp+455,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                     >> 3U))),2);
    bufp->fullCData(oldp+456,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
                                     >> 1U))),2);
    bufp->fullBit(oldp+457,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU])));
    bufp->fullCData(oldp+458,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                               >> 0x1eU)),2);
    bufp->fullBit(oldp+459,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                   >> 0x1dU))));
    bufp->fullBit(oldp+460,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                   >> 0x1cU))));
    bufp->fullBit(oldp+461,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                   >> 0x1bU))));
    bufp->fullCData(oldp+462,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                     >> 0x18U))),3);
    bufp->fullBit(oldp+463,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                   >> 0x17U))));
    bufp->fullBit(oldp+464,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                   >> 0x16U))));
    bufp->fullBit(oldp+465,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                   >> 0x15U))));
    bufp->fullCData(oldp+466,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                     >> 0x13U))),2);
    bufp->fullCData(oldp+467,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                     >> 0x11U))),2);
    bufp->fullBit(oldp+468,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                   >> 0x10U))));
    bufp->fullCData(oldp+469,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                     >> 0xeU))),2);
    bufp->fullBit(oldp+470,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                   >> 0xdU))));
    bufp->fullBit(oldp+471,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                   >> 0xcU))));
    bufp->fullBit(oldp+472,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                   >> 0xbU))));
    bufp->fullCData(oldp+473,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                     >> 8U))),3);
    bufp->fullBit(oldp+474,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                   >> 7U))));
    bufp->fullBit(oldp+475,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                   >> 6U))));
    bufp->fullBit(oldp+476,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                   >> 5U))));
    bufp->fullCData(oldp+477,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                     >> 3U))),2);
    bufp->fullCData(oldp+478,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
                                     >> 1U))),2);
    bufp->fullBit(oldp+479,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU])));
    bufp->fullCData(oldp+480,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                               >> 0x1eU)),2);
    bufp->fullBit(oldp+481,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                   >> 0x1dU))));
    bufp->fullBit(oldp+482,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                   >> 0x1cU))));
    bufp->fullBit(oldp+483,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                   >> 0x1bU))));
    bufp->fullCData(oldp+484,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                     >> 0x18U))),3);
    bufp->fullBit(oldp+485,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                   >> 0x17U))));
    bufp->fullBit(oldp+486,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                   >> 0x16U))));
    bufp->fullBit(oldp+487,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                   >> 0x15U))));
    bufp->fullCData(oldp+488,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                     >> 0x13U))),2);
    bufp->fullCData(oldp+489,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                     >> 0x11U))),2);
    bufp->fullBit(oldp+490,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                   >> 0x10U))));
    bufp->fullCData(oldp+491,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                     >> 0xeU))),2);
    bufp->fullBit(oldp+492,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                   >> 0xdU))));
    bufp->fullBit(oldp+493,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                   >> 0xcU))));
    bufp->fullBit(oldp+494,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                   >> 0xbU))));
    bufp->fullCData(oldp+495,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                     >> 8U))),3);
    bufp->fullBit(oldp+496,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                   >> 7U))));
    bufp->fullBit(oldp+497,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                   >> 6U))));
    bufp->fullBit(oldp+498,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                   >> 5U))));
    bufp->fullCData(oldp+499,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                     >> 3U))),2);
    bufp->fullCData(oldp+500,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
                                     >> 1U))),2);
    bufp->fullBit(oldp+501,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU])));
    bufp->fullCData(oldp+502,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                               >> 0x1eU)),2);
    bufp->fullBit(oldp+503,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                   >> 0x1dU))));
    bufp->fullBit(oldp+504,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                   >> 0x1cU))));
    bufp->fullBit(oldp+505,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                   >> 0x1bU))));
    bufp->fullCData(oldp+506,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                     >> 0x18U))),3);
    bufp->fullBit(oldp+507,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                   >> 0x17U))));
    bufp->fullBit(oldp+508,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                   >> 0x16U))));
    bufp->fullBit(oldp+509,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                   >> 0x15U))));
    bufp->fullCData(oldp+510,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                     >> 0x13U))),2);
    bufp->fullCData(oldp+511,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                     >> 0x11U))),2);
    bufp->fullBit(oldp+512,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                   >> 0x10U))));
    bufp->fullCData(oldp+513,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                     >> 0xeU))),2);
    bufp->fullBit(oldp+514,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                   >> 0xdU))));
    bufp->fullBit(oldp+515,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                   >> 0xcU))));
    bufp->fullBit(oldp+516,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                   >> 0xbU))));
    bufp->fullCData(oldp+517,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                     >> 8U))),3);
    bufp->fullBit(oldp+518,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                   >> 7U))));
    bufp->fullBit(oldp+519,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                   >> 6U))));
    bufp->fullBit(oldp+520,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                   >> 5U))));
    bufp->fullCData(oldp+521,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                     >> 3U))),2);
    bufp->fullCData(oldp+522,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
                                     >> 1U))),2);
    bufp->fullBit(oldp+523,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU])));
    bufp->fullCData(oldp+524,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                               >> 0x1eU)),2);
    bufp->fullBit(oldp+525,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                   >> 0x1dU))));
    bufp->fullBit(oldp+526,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                   >> 0x1cU))));
    bufp->fullBit(oldp+527,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                   >> 0x1bU))));
    bufp->fullCData(oldp+528,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                     >> 0x18U))),3);
    bufp->fullBit(oldp+529,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                   >> 0x17U))));
    bufp->fullBit(oldp+530,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                   >> 0x16U))));
    bufp->fullBit(oldp+531,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                   >> 0x15U))));
    bufp->fullCData(oldp+532,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                     >> 0x13U))),2);
    bufp->fullCData(oldp+533,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                     >> 0x11U))),2);
    bufp->fullBit(oldp+534,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                   >> 0x10U))));
    bufp->fullCData(oldp+535,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                     >> 0xeU))),2);
    bufp->fullBit(oldp+536,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                   >> 0xdU))));
    bufp->fullBit(oldp+537,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                   >> 0xcU))));
    bufp->fullBit(oldp+538,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                   >> 0xbU))));
    bufp->fullCData(oldp+539,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                     >> 8U))),3);
    bufp->fullBit(oldp+540,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                   >> 7U))));
    bufp->fullBit(oldp+541,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                   >> 6U))));
    bufp->fullBit(oldp+542,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                   >> 5U))));
    bufp->fullCData(oldp+543,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                     >> 3U))),2);
    bufp->fullCData(oldp+544,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
                                     >> 1U))),2);
    bufp->fullBit(oldp+545,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU])));
    bufp->fullCData(oldp+546,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                               >> 0x1eU)),2);
    bufp->fullBit(oldp+547,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                   >> 0x1dU))));
    bufp->fullBit(oldp+548,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                   >> 0x1cU))));
    bufp->fullBit(oldp+549,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                   >> 0x1bU))));
    bufp->fullCData(oldp+550,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                     >> 0x18U))),3);
    bufp->fullBit(oldp+551,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                   >> 0x17U))));
    bufp->fullBit(oldp+552,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                   >> 0x16U))));
    bufp->fullBit(oldp+553,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                   >> 0x15U))));
    bufp->fullCData(oldp+554,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                     >> 0x13U))),2);
    bufp->fullCData(oldp+555,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                     >> 0x11U))),2);
    bufp->fullBit(oldp+556,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                   >> 0x10U))));
    bufp->fullCData(oldp+557,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                     >> 0xeU))),2);
    bufp->fullBit(oldp+558,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                   >> 0xdU))));
    bufp->fullBit(oldp+559,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                   >> 0xcU))));
    bufp->fullBit(oldp+560,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                   >> 0xbU))));
    bufp->fullCData(oldp+561,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                     >> 8U))),3);
    bufp->fullBit(oldp+562,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                   >> 7U))));
    bufp->fullBit(oldp+563,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                   >> 6U))));
    bufp->fullBit(oldp+564,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                   >> 5U))));
    bufp->fullCData(oldp+565,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                     >> 3U))),2);
    bufp->fullCData(oldp+566,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
                                     >> 1U))),2);
    bufp->fullBit(oldp+567,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU])));
    bufp->fullCData(oldp+568,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                               >> 0x1eU)),2);
    bufp->fullBit(oldp+569,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                   >> 0x1dU))));
    bufp->fullBit(oldp+570,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                   >> 0x1cU))));
    bufp->fullBit(oldp+571,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                   >> 0x1bU))));
    bufp->fullCData(oldp+572,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                     >> 0x18U))),3);
    bufp->fullBit(oldp+573,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                   >> 0x17U))));
    bufp->fullBit(oldp+574,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                   >> 0x16U))));
    bufp->fullBit(oldp+575,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                   >> 0x15U))));
    bufp->fullCData(oldp+576,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                     >> 0x13U))),2);
    bufp->fullCData(oldp+577,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                     >> 0x11U))),2);
    bufp->fullBit(oldp+578,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                   >> 0x10U))));
    bufp->fullCData(oldp+579,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                     >> 0xeU))),2);
    bufp->fullBit(oldp+580,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                   >> 0xdU))));
    bufp->fullBit(oldp+581,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                   >> 0xcU))));
    bufp->fullBit(oldp+582,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                   >> 0xbU))));
    bufp->fullCData(oldp+583,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                     >> 8U))),3);
    bufp->fullBit(oldp+584,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                   >> 7U))));
    bufp->fullBit(oldp+585,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                   >> 6U))));
    bufp->fullBit(oldp+586,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                   >> 5U))));
    bufp->fullCData(oldp+587,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                     >> 3U))),2);
    bufp->fullCData(oldp+588,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                                     >> 1U))),2);
    bufp->fullBit(oldp+589,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val)));
    bufp->fullBit(oldp+590,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                   >> 7U))));
    bufp->fullCData(oldp+591,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                     >> 5U))),2);
    bufp->fullCData(oldp+592,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                     >> 3U))),2);
    bufp->fullBit(oldp+593,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                   >> 2U))));
    bufp->fullBit(oldp+594,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                   >> 1U))));
    bufp->fullBit(oldp+595,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U])));
    bufp->fullBit(oldp+596,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                   >> 0xfU))));
    bufp->fullCData(oldp+597,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                     >> 0xdU))),2);
    bufp->fullCData(oldp+598,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                     >> 0xbU))),2);
    bufp->fullBit(oldp+599,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                   >> 0xaU))));
    bufp->fullBit(oldp+600,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                   >> 9U))));
    bufp->fullBit(oldp+601,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                   >> 8U))));
    bufp->fullBit(oldp+602,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                   >> 0x17U))));
    bufp->fullCData(oldp+603,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                     >> 0x15U))),2);
    bufp->fullCData(oldp+604,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                     >> 0x13U))),2);
    bufp->fullBit(oldp+605,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                   >> 0x12U))));
    bufp->fullBit(oldp+606,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                   >> 0x11U))));
    bufp->fullBit(oldp+607,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                   >> 0x10U))));
    bufp->fullBit(oldp+608,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                             >> 0x1fU)));
    bufp->fullCData(oldp+609,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                     >> 0x1dU))),2);
    bufp->fullCData(oldp+610,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                     >> 0x1bU))),2);
    bufp->fullBit(oldp+611,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                   >> 0x1aU))));
    bufp->fullBit(oldp+612,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                   >> 0x19U))));
    bufp->fullBit(oldp+613,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
                                   >> 0x18U))));
    bufp->fullBit(oldp+614,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                   >> 7U))));
    bufp->fullCData(oldp+615,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                     >> 5U))),2);
    bufp->fullCData(oldp+616,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                     >> 3U))),2);
    bufp->fullBit(oldp+617,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                   >> 2U))));
    bufp->fullBit(oldp+618,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                   >> 1U))));
    bufp->fullBit(oldp+619,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U])));
    bufp->fullBit(oldp+620,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                   >> 0xfU))));
    bufp->fullCData(oldp+621,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                     >> 0xdU))),2);
    bufp->fullCData(oldp+622,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                     >> 0xbU))),2);
    bufp->fullBit(oldp+623,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                   >> 0xaU))));
    bufp->fullBit(oldp+624,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                   >> 9U))));
    bufp->fullBit(oldp+625,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                   >> 8U))));
    bufp->fullBit(oldp+626,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                   >> 0x17U))));
    bufp->fullCData(oldp+627,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                     >> 0x15U))),2);
    bufp->fullCData(oldp+628,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                     >> 0x13U))),2);
    bufp->fullBit(oldp+629,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                   >> 0x12U))));
    bufp->fullBit(oldp+630,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                   >> 0x11U))));
    bufp->fullBit(oldp+631,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                   >> 0x10U))));
    bufp->fullBit(oldp+632,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                             >> 0x1fU)));
    bufp->fullCData(oldp+633,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                     >> 0x1dU))),2);
    bufp->fullCData(oldp+634,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                     >> 0x1bU))),2);
    bufp->fullBit(oldp+635,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                   >> 0x1aU))));
    bufp->fullBit(oldp+636,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                   >> 0x19U))));
    bufp->fullBit(oldp+637,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
                                   >> 0x18U))));
    bufp->fullBit(oldp+638,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                   >> 7U))));
    bufp->fullCData(oldp+639,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                     >> 5U))),2);
    bufp->fullCData(oldp+640,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                     >> 3U))),2);
    bufp->fullBit(oldp+641,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                   >> 2U))));
    bufp->fullBit(oldp+642,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                   >> 1U))));
    bufp->fullBit(oldp+643,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U])));
    bufp->fullBit(oldp+644,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                   >> 0xfU))));
    bufp->fullCData(oldp+645,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                     >> 0xdU))),2);
    bufp->fullCData(oldp+646,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                     >> 0xbU))),2);
    bufp->fullBit(oldp+647,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                   >> 0xaU))));
    bufp->fullBit(oldp+648,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                   >> 9U))));
    bufp->fullBit(oldp+649,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                   >> 8U))));
    bufp->fullBit(oldp+650,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                   >> 0x17U))));
    bufp->fullCData(oldp+651,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                     >> 0x15U))),2);
    bufp->fullCData(oldp+652,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                     >> 0x13U))),2);
    bufp->fullBit(oldp+653,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                   >> 0x12U))));
    bufp->fullBit(oldp+654,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                   >> 0x11U))));
    bufp->fullBit(oldp+655,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                   >> 0x10U))));
    bufp->fullBit(oldp+656,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                             >> 0x1fU)));
    bufp->fullCData(oldp+657,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                     >> 0x1dU))),2);
    bufp->fullCData(oldp+658,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                     >> 0x1bU))),2);
    bufp->fullBit(oldp+659,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                   >> 0x1aU))));
    bufp->fullBit(oldp+660,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                   >> 0x19U))));
    bufp->fullBit(oldp+661,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
                                   >> 0x18U))));
    bufp->fullBit(oldp+662,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                   >> 7U))));
    bufp->fullCData(oldp+663,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                     >> 5U))),2);
    bufp->fullCData(oldp+664,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                     >> 3U))),2);
    bufp->fullBit(oldp+665,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                   >> 2U))));
    bufp->fullBit(oldp+666,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                   >> 1U))));
    bufp->fullBit(oldp+667,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U])));
    bufp->fullBit(oldp+668,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                   >> 0xfU))));
    bufp->fullCData(oldp+669,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                     >> 0xdU))),2);
    bufp->fullCData(oldp+670,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                     >> 0xbU))),2);
    bufp->fullBit(oldp+671,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                   >> 0xaU))));
    bufp->fullBit(oldp+672,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                   >> 9U))));
    bufp->fullBit(oldp+673,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                   >> 8U))));
    bufp->fullBit(oldp+674,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                   >> 0x17U))));
    bufp->fullCData(oldp+675,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                     >> 0x15U))),2);
    bufp->fullCData(oldp+676,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                     >> 0x13U))),2);
    bufp->fullBit(oldp+677,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                   >> 0x12U))));
    bufp->fullBit(oldp+678,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                   >> 0x11U))));
    bufp->fullBit(oldp+679,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                   >> 0x10U))));
    bufp->fullBit(oldp+680,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                             >> 0x1fU)));
    bufp->fullCData(oldp+681,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                     >> 0x1dU))),2);
    bufp->fullCData(oldp+682,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                     >> 0x1bU))),2);
    bufp->fullBit(oldp+683,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                   >> 0x1aU))));
    bufp->fullBit(oldp+684,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                   >> 0x19U))));
    bufp->fullBit(oldp+685,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
                                   >> 0x18U))));
    bufp->fullIData(oldp+686,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[0U]),32);
    bufp->fullIData(oldp+687,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[1U]),32);
    bufp->fullIData(oldp+688,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[2U]),32);
    bufp->fullIData(oldp+689,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[3U]),32);
    bufp->fullIData(oldp+690,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[4U]),32);
    bufp->fullIData(oldp+691,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[5U]),32);
    bufp->fullIData(oldp+692,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[6U]),32);
    bufp->fullIData(oldp+693,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[7U]),32);
    bufp->fullIData(oldp+694,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[8U]),32);
    bufp->fullIData(oldp+695,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[9U]),32);
    bufp->fullIData(oldp+696,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[0xaU]),32);
    bufp->fullIData(oldp+697,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[0xbU]),32);
    bufp->fullIData(oldp+698,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[0xcU]),32);
    bufp->fullIData(oldp+699,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[0xdU]),32);
    bufp->fullIData(oldp+700,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[0xeU]),32);
    bufp->fullIData(oldp+701,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[0xfU]),32);
    bufp->fullBit(oldp+702,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                   >> 7U))));
    bufp->fullCData(oldp+703,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                     >> 5U))),2);
    bufp->fullCData(oldp+704,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                     >> 3U))),2);
    bufp->fullBit(oldp+705,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                   >> 2U))));
    bufp->fullBit(oldp+706,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                   >> 1U))));
    bufp->fullBit(oldp+707,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg)));
    bufp->fullBit(oldp+708,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                   >> 0xfU))));
    bufp->fullCData(oldp+709,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                     >> 0xdU))),2);
    bufp->fullCData(oldp+710,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                     >> 0xbU))),2);
    bufp->fullBit(oldp+711,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                   >> 0xaU))));
    bufp->fullBit(oldp+712,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                   >> 9U))));
    bufp->fullBit(oldp+713,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                   >> 8U))));
    bufp->fullBit(oldp+714,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                   >> 0x17U))));
    bufp->fullCData(oldp+715,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                     >> 0x15U))),2);
    bufp->fullCData(oldp+716,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                     >> 0x13U))),2);
    bufp->fullBit(oldp+717,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                   >> 0x12U))));
    bufp->fullBit(oldp+718,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                   >> 0x11U))));
    bufp->fullBit(oldp+719,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                   >> 0x10U))));
    bufp->fullBit(oldp+720,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                             >> 0x1fU)));
    bufp->fullCData(oldp+721,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                     >> 0x1dU))),2);
    bufp->fullCData(oldp+722,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                     >> 0x1bU))),2);
    bufp->fullBit(oldp+723,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                   >> 0x1aU))));
    bufp->fullBit(oldp+724,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                   >> 0x19U))));
    bufp->fullBit(oldp+725,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                                   >> 0x18U))));
    bufp->fullBit(oldp+726,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_flush_idx) 
                                   >> 5U))));
    bufp->fullCData(oldp+727,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_flush_idx) 
                                     >> 3U))),2);
    bufp->fullCData(oldp+728,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_flush_idx) 
                                     >> 1U))),2);
    bufp->fullBit(oldp+729,((1U & (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_flush_idx))));
    bufp->fullBit(oldp+730,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__enable_flush_count));
    bufp->fullIData(oldp+731,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_state),32);
    bufp->fullCData(oldp+732,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx),2);
    bufp->fullIData(oldp+733,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_read_addr),32);
    bufp->fullIData(oldp+734,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_decoded_req_addr 
                               >> 5U)),27);
    bufp->fullCData(oldp+735,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_decoded_req_addr 
                                     >> 3U))),2);
    bufp->fullBit(oldp+736,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_decoded_req_addr 
                                   >> 2U))));
    bufp->fullCData(oldp+737,((3U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_decoded_req_addr)),2);
    bufp->fullBit(oldp+738,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[2U] 
                                   >> 0x1cU))));
    bufp->fullBit(oldp+739,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[2U] 
                                   >> 0x1bU))));
    bufp->fullIData(oldp+740,((0x7ffffffU & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[2U])),27);
    bufp->fullIData(oldp+741,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[0U]),32);
    bufp->fullIData(oldp+742,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[1U]),32);
    bufp->fullBit(oldp+743,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[5U] 
                                   >> 0x19U))));
    bufp->fullBit(oldp+744,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[5U] 
                                   >> 0x18U))));
    bufp->fullIData(oldp+745,((0x7ffffffU & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[5U] 
                                              << 3U) 
                                             | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[4U] 
                                                >> 0x1dU)))),27);
    bufp->fullIData(oldp+746,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[3U] 
                                << 3U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[2U] 
                                          >> 0x1dU))),32);
    bufp->fullIData(oldp+747,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[4U] 
                                << 3U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[3U] 
                                          >> 0x1dU))),32);
    bufp->fullBit(oldp+748,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[8U] 
                                   >> 0x16U))));
    bufp->fullBit(oldp+749,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[8U] 
                                   >> 0x15U))));
    bufp->fullIData(oldp+750,((0x7ffffffU & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[8U] 
                                              << 6U) 
                                             | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[7U] 
                                                >> 0x1aU)))),27);
    bufp->fullIData(oldp+751,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[6U] 
                                << 6U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[5U] 
                                          >> 0x1aU))),32);
    bufp->fullIData(oldp+752,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[7U] 
                                << 6U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[6U] 
                                          >> 0x1aU))),32);
    bufp->fullBit(oldp+753,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[0xbU] 
                                   >> 0x13U))));
    bufp->fullBit(oldp+754,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[0xbU] 
                                   >> 0x12U))));
    bufp->fullIData(oldp+755,((0x7ffffffU & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[0xbU] 
                                              << 9U) 
                                             | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[0xaU] 
                                                >> 0x17U)))),27);
    bufp->fullIData(oldp+756,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[9U] 
                                << 9U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[8U] 
                                          >> 0x17U))),32);
    bufp->fullIData(oldp+757,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[0xaU] 
                                << 9U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[9U] 
                                          >> 0x17U))),32);
    bufp->fullBit(oldp+758,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[2U] 
                                   >> 0x1cU))));
    bufp->fullBit(oldp+759,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[2U] 
                                   >> 0x1bU))));
    bufp->fullIData(oldp+760,((0x7ffffffU & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[2U])),27);
    bufp->fullIData(oldp+761,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[0U]),32);
    bufp->fullIData(oldp+762,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[1U]),32);
    bufp->fullBit(oldp+763,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[5U] 
                                   >> 0x19U))));
    bufp->fullBit(oldp+764,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[5U] 
                                   >> 0x18U))));
    bufp->fullIData(oldp+765,((0x7ffffffU & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[5U] 
                                              << 3U) 
                                             | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[4U] 
                                                >> 0x1dU)))),27);
    bufp->fullIData(oldp+766,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[3U] 
                                << 3U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[2U] 
                                          >> 0x1dU))),32);
    bufp->fullIData(oldp+767,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[4U] 
                                << 3U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[3U] 
                                          >> 0x1dU))),32);
    bufp->fullBit(oldp+768,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[8U] 
                                   >> 0x16U))));
    bufp->fullBit(oldp+769,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[8U] 
                                   >> 0x15U))));
    bufp->fullIData(oldp+770,((0x7ffffffU & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[8U] 
                                              << 6U) 
                                             | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[7U] 
                                                >> 0x1aU)))),27);
    bufp->fullIData(oldp+771,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[6U] 
                                << 6U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[5U] 
                                          >> 0x1aU))),32);
    bufp->fullIData(oldp+772,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[7U] 
                                << 6U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[6U] 
                                          >> 0x1aU))),32);
    bufp->fullBit(oldp+773,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[0xbU] 
                                   >> 0x13U))));
    bufp->fullBit(oldp+774,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[0xbU] 
                                   >> 0x12U))));
    bufp->fullIData(oldp+775,((0x7ffffffU & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[0xbU] 
                                              << 9U) 
                                             | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[0xaU] 
                                                >> 0x17U)))),27);
    bufp->fullIData(oldp+776,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[9U] 
                                << 9U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[8U] 
                                          >> 0x17U))),32);
    bufp->fullIData(oldp+777,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[0xaU] 
                                << 9U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[9U] 
                                          >> 0x17U))),32);
    bufp->fullBit(oldp+778,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWEN));
    bufp->fullWData(oldp+779,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite),372);
    bufp->fullWData(oldp+791,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask),372);
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
    bufp->fullWData(oldp+803,(__Vtemp_hd57fe25b__0),372);
    __Vtemp_hb8fad44c__0[0U] = (Vtop_core__ConstPool__CONST_h1b548564_0[0U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0xcU] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0xbU] 
                                                >> 0x14U)));
    __Vtemp_hb8fad44c__0[1U] = (Vtop_core__ConstPool__CONST_h1b548564_0[1U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0xdU] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0xcU] 
                                                >> 0x14U)));
    __Vtemp_hb8fad44c__0[2U] = (Vtop_core__ConstPool__CONST_h1b548564_0[2U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0xeU] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0xdU] 
                                                >> 0x14U)));
    __Vtemp_hb8fad44c__0[3U] = (Vtop_core__ConstPool__CONST_h1b548564_0[3U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0xfU] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0xeU] 
                                                >> 0x14U)));
    __Vtemp_hb8fad44c__0[4U] = (Vtop_core__ConstPool__CONST_h1b548564_0[4U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x10U] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0xfU] 
                                                >> 0x14U)));
    __Vtemp_hb8fad44c__0[5U] = (Vtop_core__ConstPool__CONST_h1b548564_0[5U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x11U] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x10U] 
                                                >> 0x14U)));
    __Vtemp_hb8fad44c__0[6U] = (Vtop_core__ConstPool__CONST_h1b548564_0[6U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x12U] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x11U] 
                                                >> 0x14U)));
    __Vtemp_hb8fad44c__0[7U] = (Vtop_core__ConstPool__CONST_h1b548564_0[7U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x13U] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x12U] 
                                                >> 0x14U)));
    __Vtemp_hb8fad44c__0[8U] = (Vtop_core__ConstPool__CONST_h1b548564_0[8U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x14U] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x13U] 
                                                >> 0x14U)));
    __Vtemp_hb8fad44c__0[9U] = (Vtop_core__ConstPool__CONST_h1b548564_0[9U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x15U] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x14U] 
                                                >> 0x14U)));
    __Vtemp_hb8fad44c__0[0xaU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xaU] 
                                  & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x16U] 
                                      << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x15U] 
                                                  >> 0x14U)));
    __Vtemp_hb8fad44c__0[0xbU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xbU] 
                                  & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x17U] 
                                      << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x16U] 
                                                  >> 0x14U)));
    bufp->fullWData(oldp+815,(__Vtemp_hb8fad44c__0),372);
    __Vtemp_h832f242f__0[0U] = (Vtop_core__ConstPool__CONST_h1b548564_0[0U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x18U] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x17U] 
                                                 >> 8U)));
    __Vtemp_h832f242f__0[1U] = (Vtop_core__ConstPool__CONST_h1b548564_0[1U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x19U] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x18U] 
                                                 >> 8U)));
    __Vtemp_h832f242f__0[2U] = (Vtop_core__ConstPool__CONST_h1b548564_0[2U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x1aU] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x19U] 
                                                 >> 8U)));
    __Vtemp_h832f242f__0[3U] = (Vtop_core__ConstPool__CONST_h1b548564_0[3U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x1bU] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x1aU] 
                                                 >> 8U)));
    __Vtemp_h832f242f__0[4U] = (Vtop_core__ConstPool__CONST_h1b548564_0[4U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x1cU] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x1bU] 
                                                 >> 8U)));
    __Vtemp_h832f242f__0[5U] = (Vtop_core__ConstPool__CONST_h1b548564_0[5U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x1dU] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x1cU] 
                                                 >> 8U)));
    __Vtemp_h832f242f__0[6U] = (Vtop_core__ConstPool__CONST_h1b548564_0[6U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x1eU] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x1dU] 
                                                 >> 8U)));
    __Vtemp_h832f242f__0[7U] = (Vtop_core__ConstPool__CONST_h1b548564_0[7U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x1fU] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x1eU] 
                                                 >> 8U)));
    __Vtemp_h832f242f__0[8U] = (Vtop_core__ConstPool__CONST_h1b548564_0[8U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x20U] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x1fU] 
                                                 >> 8U)));
    __Vtemp_h832f242f__0[9U] = (Vtop_core__ConstPool__CONST_h1b548564_0[9U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x21U] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x20U] 
                                                 >> 8U)));
    __Vtemp_h832f242f__0[0xaU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xaU] 
                                  & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x22U] 
                                      << 0x18U) | (
                                                   vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x21U] 
                                                   >> 8U)));
    __Vtemp_h832f242f__0[0xbU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xbU] 
                                  & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x23U] 
                                      << 0x18U) | (
                                                   vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x22U] 
                                                   >> 8U)));
    bufp->fullWData(oldp+827,(__Vtemp_h832f242f__0),372);
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
                                      << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x2cU] 
                                                >> 0x1cU)));
    __Vtemp_h66a8f596__0[0xbU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xbU] 
                                  & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x2eU] 
                                      << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[0x2dU] 
                                                >> 0x1cU)));
    bufp->fullWData(oldp+839,(__Vtemp_h66a8f596__0),372);
    bufp->fullBit(oldp+851,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_flush_idx) 
                                   >> 5U))));
    bufp->fullCData(oldp+852,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_flush_idx) 
                                     >> 3U))),2);
    bufp->fullCData(oldp+853,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_flush_idx) 
                                     >> 1U))),2);
    bufp->fullBit(oldp+854,((1U & (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_flush_idx))));
    bufp->fullBit(oldp+855,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__enable_flush_count));
    bufp->fullIData(oldp+856,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_state),32);
    bufp->fullCData(oldp+857,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx),2);
    bufp->fullCData(oldp+858,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_last_used),2);
    bufp->fullIData(oldp+859,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_read_addr),32);
    bufp->fullIData(oldp+860,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_decoded_req_addr 
                               >> 5U)),27);
    bufp->fullCData(oldp+861,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_decoded_req_addr 
                                     >> 3U))),2);
    bufp->fullBit(oldp+862,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_decoded_req_addr 
                                   >> 2U))));
    bufp->fullCData(oldp+863,((3U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_decoded_req_addr)),2);
    bufp->fullBit(oldp+864,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[2U] 
                                   >> 0x1cU))));
    bufp->fullBit(oldp+865,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[2U] 
                                   >> 0x1bU))));
    bufp->fullIData(oldp+866,((0x7ffffffU & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[2U])),27);
    bufp->fullIData(oldp+867,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[0U]),32);
    bufp->fullIData(oldp+868,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[1U]),32);
    bufp->fullBit(oldp+869,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[5U] 
                                   >> 0x19U))));
    bufp->fullBit(oldp+870,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[5U] 
                                   >> 0x18U))));
    bufp->fullIData(oldp+871,((0x7ffffffU & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[5U] 
                                              << 3U) 
                                             | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[4U] 
                                                >> 0x1dU)))),27);
    bufp->fullIData(oldp+872,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[3U] 
                                << 3U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[2U] 
                                          >> 0x1dU))),32);
    bufp->fullIData(oldp+873,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[4U] 
                                << 3U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[3U] 
                                          >> 0x1dU))),32);
    bufp->fullBit(oldp+874,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[8U] 
                                   >> 0x16U))));
    bufp->fullBit(oldp+875,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[8U] 
                                   >> 0x15U))));
    bufp->fullIData(oldp+876,((0x7ffffffU & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[8U] 
                                              << 6U) 
                                             | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[7U] 
                                                >> 0x1aU)))),27);
    bufp->fullIData(oldp+877,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[6U] 
                                << 6U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[5U] 
                                          >> 0x1aU))),32);
    bufp->fullIData(oldp+878,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[7U] 
                                << 6U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[6U] 
                                          >> 0x1aU))),32);
    bufp->fullBit(oldp+879,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[0xbU] 
                                   >> 0x13U))));
    bufp->fullBit(oldp+880,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[0xbU] 
                                   >> 0x12U))));
    bufp->fullIData(oldp+881,((0x7ffffffU & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[0xbU] 
                                              << 9U) 
                                             | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[0xaU] 
                                                >> 0x17U)))),27);
    bufp->fullIData(oldp+882,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[9U] 
                                << 9U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[8U] 
                                          >> 0x17U))),32);
    bufp->fullIData(oldp+883,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[0xaU] 
                                << 9U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[9U] 
                                          >> 0x17U))),32);
    bufp->fullBit(oldp+884,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[2U] 
                                   >> 0x1cU))));
    bufp->fullBit(oldp+885,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[2U] 
                                   >> 0x1bU))));
    bufp->fullIData(oldp+886,((0x7ffffffU & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[2U])),27);
    bufp->fullIData(oldp+887,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[0U]),32);
    bufp->fullIData(oldp+888,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[1U]),32);
    bufp->fullBit(oldp+889,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[5U] 
                                   >> 0x19U))));
    bufp->fullBit(oldp+890,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[5U] 
                                   >> 0x18U))));
    bufp->fullIData(oldp+891,((0x7ffffffU & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[5U] 
                                              << 3U) 
                                             | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[4U] 
                                                >> 0x1dU)))),27);
    bufp->fullIData(oldp+892,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[3U] 
                                << 3U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[2U] 
                                          >> 0x1dU))),32);
    bufp->fullIData(oldp+893,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[4U] 
                                << 3U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[3U] 
                                          >> 0x1dU))),32);
    bufp->fullBit(oldp+894,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[8U] 
                                   >> 0x16U))));
    bufp->fullBit(oldp+895,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[8U] 
                                   >> 0x15U))));
    bufp->fullIData(oldp+896,((0x7ffffffU & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[8U] 
                                              << 6U) 
                                             | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[7U] 
                                                >> 0x1aU)))),27);
    bufp->fullIData(oldp+897,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[6U] 
                                << 6U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[5U] 
                                          >> 0x1aU))),32);
    bufp->fullIData(oldp+898,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[7U] 
                                << 6U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[6U] 
                                          >> 0x1aU))),32);
    bufp->fullBit(oldp+899,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[0xbU] 
                                   >> 0x13U))));
    bufp->fullBit(oldp+900,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[0xbU] 
                                   >> 0x12U))));
    bufp->fullIData(oldp+901,((0x7ffffffU & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[0xbU] 
                                              << 9U) 
                                             | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[0xaU] 
                                                >> 0x17U)))),27);
    bufp->fullIData(oldp+902,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[9U] 
                                << 9U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[8U] 
                                          >> 0x17U))),32);
    bufp->fullIData(oldp+903,(((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[0xaU] 
                                << 9U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[9U] 
                                          >> 0x17U))),32);
    bufp->fullBit(oldp+904,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWEN));
    bufp->fullWData(oldp+905,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite),372);
    bufp->fullWData(oldp+917,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask),372);
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
    bufp->fullWData(oldp+929,(__Vtemp_h42528074__0),372);
    __Vtemp_hca760406__0[0U] = (Vtop_core__ConstPool__CONST_h1b548564_0[0U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0xcU] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0xbU] 
                                                >> 0x14U)));
    __Vtemp_hca760406__0[1U] = (Vtop_core__ConstPool__CONST_h1b548564_0[1U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0xdU] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0xcU] 
                                                >> 0x14U)));
    __Vtemp_hca760406__0[2U] = (Vtop_core__ConstPool__CONST_h1b548564_0[2U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0xeU] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0xdU] 
                                                >> 0x14U)));
    __Vtemp_hca760406__0[3U] = (Vtop_core__ConstPool__CONST_h1b548564_0[3U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0xfU] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0xeU] 
                                                >> 0x14U)));
    __Vtemp_hca760406__0[4U] = (Vtop_core__ConstPool__CONST_h1b548564_0[4U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x10U] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0xfU] 
                                                >> 0x14U)));
    __Vtemp_hca760406__0[5U] = (Vtop_core__ConstPool__CONST_h1b548564_0[5U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x11U] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x10U] 
                                                >> 0x14U)));
    __Vtemp_hca760406__0[6U] = (Vtop_core__ConstPool__CONST_h1b548564_0[6U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x12U] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x11U] 
                                                >> 0x14U)));
    __Vtemp_hca760406__0[7U] = (Vtop_core__ConstPool__CONST_h1b548564_0[7U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x13U] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x12U] 
                                                >> 0x14U)));
    __Vtemp_hca760406__0[8U] = (Vtop_core__ConstPool__CONST_h1b548564_0[8U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x14U] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x13U] 
                                                >> 0x14U)));
    __Vtemp_hca760406__0[9U] = (Vtop_core__ConstPool__CONST_h1b548564_0[9U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x15U] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x14U] 
                                                >> 0x14U)));
    __Vtemp_hca760406__0[0xaU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xaU] 
                                  & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x16U] 
                                      << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x15U] 
                                                  >> 0x14U)));
    __Vtemp_hca760406__0[0xbU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xbU] 
                                  & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x17U] 
                                      << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x16U] 
                                                  >> 0x14U)));
    bufp->fullWData(oldp+941,(__Vtemp_hca760406__0),372);
    __Vtemp_he20d994c__0[0U] = (Vtop_core__ConstPool__CONST_h1b548564_0[0U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x18U] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x17U] 
                                                 >> 8U)));
    __Vtemp_he20d994c__0[1U] = (Vtop_core__ConstPool__CONST_h1b548564_0[1U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x19U] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x18U] 
                                                 >> 8U)));
    __Vtemp_he20d994c__0[2U] = (Vtop_core__ConstPool__CONST_h1b548564_0[2U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x1aU] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x19U] 
                                                 >> 8U)));
    __Vtemp_he20d994c__0[3U] = (Vtop_core__ConstPool__CONST_h1b548564_0[3U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x1bU] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x1aU] 
                                                 >> 8U)));
    __Vtemp_he20d994c__0[4U] = (Vtop_core__ConstPool__CONST_h1b548564_0[4U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x1cU] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x1bU] 
                                                 >> 8U)));
    __Vtemp_he20d994c__0[5U] = (Vtop_core__ConstPool__CONST_h1b548564_0[5U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x1dU] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x1cU] 
                                                 >> 8U)));
    __Vtemp_he20d994c__0[6U] = (Vtop_core__ConstPool__CONST_h1b548564_0[6U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x1eU] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x1dU] 
                                                 >> 8U)));
    __Vtemp_he20d994c__0[7U] = (Vtop_core__ConstPool__CONST_h1b548564_0[7U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x1fU] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x1eU] 
                                                 >> 8U)));
    __Vtemp_he20d994c__0[8U] = (Vtop_core__ConstPool__CONST_h1b548564_0[8U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x20U] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x1fU] 
                                                 >> 8U)));
    __Vtemp_he20d994c__0[9U] = (Vtop_core__ConstPool__CONST_h1b548564_0[9U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x21U] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x20U] 
                                                 >> 8U)));
    __Vtemp_he20d994c__0[0xaU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xaU] 
                                  & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x22U] 
                                      << 0x18U) | (
                                                   vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x21U] 
                                                   >> 8U)));
    __Vtemp_he20d994c__0[0xbU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xbU] 
                                  & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x23U] 
                                      << 0x18U) | (
                                                   vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x22U] 
                                                   >> 8U)));
    bufp->fullWData(oldp+953,(__Vtemp_he20d994c__0),372);
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
                                      << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x2cU] 
                                                >> 0x1cU)));
    __Vtemp_heba899ea__0[0xbU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xbU] 
                                  & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x2eU] 
                                      << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[0x2dU] 
                                                >> 0x1cU)));
    bufp->fullWData(oldp+965,(__Vtemp_heba899ea__0),372);
    bufp->fullBit(oldp+977,(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__valid_write));
    bufp->fullBit(oldp+978,((1U & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__suppress_iren)))));
    bufp->fullBit(oldp+979,(vlSymsp->TOP__top_core__CORE__DOT__tspp_icache_gen_bus_if.__PVT__busy));
    bufp->fullBit(oldp+980,(vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__busy));
    bufp->fullIData(oldp+981,(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__addr),32);
    bufp->fullIData(oldp+982,(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__wdata),32);
    bufp->fullBit(oldp+983,(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__ren));
    bufp->fullBit(oldp+984,(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__wen));
    bufp->fullCData(oldp+985,(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__byte_en),4);
    bufp->fullIData(oldp+986,(vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__addr),32);
    bufp->fullBit(oldp+987,(vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__ren));
    bufp->fullBit(oldp+988,(vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__wen));
    bufp->fullCData(oldp+989,(vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__byte_en),4);
    bufp->fullBit(oldp+990,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__ex_mem_stall));
    bufp->fullBit(oldp+991,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__ex_mem_flush));
    bufp->fullBit(oldp+992,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__if_ex_stall));
    bufp->fullBit(oldp+993,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__suppress_iren));
    bufp->fullBit(oldp+994,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pmp_if.__PVT__csr_active));
    bufp->fullBit(oldp+995,(vlSymsp->TOP__top_core__gen_bus_if.__PVT__ren));
    bufp->fullBit(oldp+996,(vlSymsp->TOP__top_core__gen_bus_if.__PVT__wen));
    bufp->fullCData(oldp+997,(vlSymsp->TOP__top_core__gen_bus_if.__PVT__byte_en),4);
    bufp->fullIData(oldp+998,(vlSymsp->TOP__top_core__gen_bus_if.__PVT__addr),32);
    bufp->fullIData(oldp+999,(vlSymsp->TOP__top_core__gen_bus_if.__PVT__wdata),32);
    bufp->fullIData(oldp+1000,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__mc__DOT__current_state),32);
    bufp->fullIData(oldp+1001,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0U]),32);
    bufp->fullIData(oldp+1002,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[1U]),32);
    bufp->fullIData(oldp+1003,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[2U]),32);
    bufp->fullIData(oldp+1004,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[3U]),32);
    bufp->fullIData(oldp+1005,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[4U]),32);
    bufp->fullIData(oldp+1006,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[5U]),32);
    bufp->fullIData(oldp+1007,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[6U]),32);
    bufp->fullIData(oldp+1008,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[7U]),32);
    bufp->fullIData(oldp+1009,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[8U]),32);
    bufp->fullIData(oldp+1010,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[9U]),32);
    bufp->fullIData(oldp+1011,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0xaU]),32);
    bufp->fullIData(oldp+1012,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0xbU]),32);
    bufp->fullIData(oldp+1013,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0xcU]),32);
    bufp->fullIData(oldp+1014,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0xdU]),32);
    bufp->fullIData(oldp+1015,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0xeU]),32);
    bufp->fullIData(oldp+1016,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0xfU]),32);
    bufp->fullIData(oldp+1017,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x10U]),32);
    bufp->fullIData(oldp+1018,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x11U]),32);
    bufp->fullIData(oldp+1019,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x12U]),32);
    bufp->fullIData(oldp+1020,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x13U]),32);
    bufp->fullIData(oldp+1021,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x14U]),32);
    bufp->fullIData(oldp+1022,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x15U]),32);
    bufp->fullIData(oldp+1023,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x16U]),32);
    bufp->fullIData(oldp+1024,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x17U]),32);
    bufp->fullIData(oldp+1025,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x18U]),32);
    bufp->fullIData(oldp+1026,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x19U]),32);
    bufp->fullIData(oldp+1027,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x1aU]),32);
    bufp->fullIData(oldp+1028,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x1bU]),32);
    bufp->fullIData(oldp+1029,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x1cU]),32);
    bufp->fullIData(oldp+1030,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x1dU]),32);
    bufp->fullIData(oldp+1031,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x1eU]),32);
    bufp->fullIData(oldp+1032,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[0x1fU]),32);
    bufp->fullBit(oldp+1033,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__ifence_reg));
    bufp->fullBit(oldp+1034,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__iflushed));
    bufp->fullBit(oldp+1035,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__dflushed));
    bufp->fullBit(oldp+1036,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                              >> 0x1fU)));
    bufp->fullCData(oldp+1037,((0xffU & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                         >> 0x17U))),8);
    bufp->fullBit(oldp+1038,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                    >> 0x16U))));
    bufp->fullBit(oldp+1039,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                    >> 0x15U))));
    bufp->fullBit(oldp+1040,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                    >> 0x14U))));
    bufp->fullBit(oldp+1041,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                    >> 0x13U))));
    bufp->fullBit(oldp+1042,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                    >> 0x12U))));
    bufp->fullBit(oldp+1043,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                    >> 0x11U))));
    bufp->fullCData(oldp+1044,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                      >> 0xfU))),2);
    bufp->fullCData(oldp+1045,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                      >> 0xdU))),2);
    bufp->fullCData(oldp+1046,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                      >> 0xbU))),2);
    bufp->fullCData(oldp+1047,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                      >> 9U))),2);
    bufp->fullBit(oldp+1048,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                    >> 8U))));
    bufp->fullBit(oldp+1049,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                    >> 7U))));
    bufp->fullBit(oldp+1050,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                    >> 6U))));
    bufp->fullBit(oldp+1051,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                    >> 5U))));
    bufp->fullBit(oldp+1052,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                    >> 4U))));
    bufp->fullBit(oldp+1053,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                    >> 3U))));
    bufp->fullBit(oldp+1054,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                    >> 2U))));
    bufp->fullBit(oldp+1055,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                    >> 1U))));
    bufp->fullBit(oldp+1056,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus)));
    bufp->fullSData(oldp+1057,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie 
                                >> 0x10U)),16);
    bufp->fullCData(oldp+1058,((0xfU & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie 
                                        >> 0xcU))),4);
    bufp->fullBit(oldp+1059,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie 
                                    >> 0xbU))));
    bufp->fullBit(oldp+1060,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie 
                                    >> 0xaU))));
    bufp->fullBit(oldp+1061,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie 
                                    >> 9U))));
    bufp->fullBit(oldp+1062,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie 
                                    >> 8U))));
    bufp->fullBit(oldp+1063,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie 
                                    >> 7U))));
    bufp->fullBit(oldp+1064,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie 
                                    >> 6U))));
    bufp->fullBit(oldp+1065,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie 
                                    >> 5U))));
    bufp->fullBit(oldp+1066,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie 
                                    >> 4U))));
    bufp->fullBit(oldp+1067,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie 
                                    >> 3U))));
    bufp->fullBit(oldp+1068,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie 
                                    >> 2U))));
    bufp->fullBit(oldp+1069,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie 
                                    >> 1U))));
    bufp->fullBit(oldp+1070,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie)));
    bufp->fullIData(oldp+1071,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mtvec 
                                >> 2U)),30);
    bufp->fullCData(oldp+1072,((3U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mtvec)),2);
    bufp->fullIData(oldp+1073,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mscratch),32);
    bufp->fullIData(oldp+1074,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mepc),32);
    bufp->fullBit(oldp+1075,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcause 
                              >> 0x1fU)));
    bufp->fullIData(oldp+1076,((0x7fffffffU & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcause)),31);
    bufp->fullIData(oldp+1077,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mtval),32);
    bufp->fullSData(oldp+1078,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip 
                                >> 0x10U)),16);
    bufp->fullCData(oldp+1079,((0xfU & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip 
                                        >> 0xcU))),4);
    bufp->fullBit(oldp+1080,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip 
                                    >> 0xbU))));
    bufp->fullBit(oldp+1081,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip 
                                    >> 0xaU))));
    bufp->fullBit(oldp+1082,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip 
                                    >> 9U))));
    bufp->fullBit(oldp+1083,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip 
                                    >> 8U))));
    bufp->fullBit(oldp+1084,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip 
                                    >> 7U))));
    bufp->fullBit(oldp+1085,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip 
                                    >> 6U))));
    bufp->fullBit(oldp+1086,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip 
                                    >> 5U))));
    bufp->fullBit(oldp+1087,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip 
                                    >> 4U))));
    bufp->fullBit(oldp+1088,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip 
                                    >> 3U))));
    bufp->fullBit(oldp+1089,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip 
                                    >> 2U))));
    bufp->fullBit(oldp+1090,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip 
                                    >> 1U))));
    bufp->fullBit(oldp+1091,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip)));
    bufp->fullBit(oldp+1092,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                              >> 0x1fU)));
    bufp->fullBit(oldp+1093,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 0x1eU))));
    bufp->fullBit(oldp+1094,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 0x1dU))));
    bufp->fullBit(oldp+1095,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 0x1cU))));
    bufp->fullBit(oldp+1096,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 0x1bU))));
    bufp->fullBit(oldp+1097,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 0x1aU))));
    bufp->fullBit(oldp+1098,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 0x19U))));
    bufp->fullBit(oldp+1099,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 0x18U))));
    bufp->fullBit(oldp+1100,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 0x17U))));
    bufp->fullBit(oldp+1101,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 0x16U))));
    bufp->fullBit(oldp+1102,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 0x15U))));
    bufp->fullBit(oldp+1103,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 0x14U))));
    bufp->fullBit(oldp+1104,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 0x13U))));
    bufp->fullBit(oldp+1105,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 0x12U))));
    bufp->fullBit(oldp+1106,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 0x11U))));
    bufp->fullBit(oldp+1107,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 0x10U))));
    bufp->fullBit(oldp+1108,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 0xfU))));
    bufp->fullBit(oldp+1109,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 0xeU))));
    bufp->fullBit(oldp+1110,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 0xdU))));
    bufp->fullBit(oldp+1111,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 0xcU))));
    bufp->fullBit(oldp+1112,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 0xbU))));
    bufp->fullBit(oldp+1113,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 0xaU))));
    bufp->fullBit(oldp+1114,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 9U))));
    bufp->fullBit(oldp+1115,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 8U))));
    bufp->fullBit(oldp+1116,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 7U))));
    bufp->fullBit(oldp+1117,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 6U))));
    bufp->fullBit(oldp+1118,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 5U))));
    bufp->fullBit(oldp+1119,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 4U))));
    bufp->fullBit(oldp+1120,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 3U))));
    bufp->fullBit(oldp+1121,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 2U))));
    bufp->fullBit(oldp+1122,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren 
                                    >> 1U))));
    bufp->fullBit(oldp+1123,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren)));
    bufp->fullBit(oldp+1124,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                              >> 0x1fU)));
    bufp->fullBit(oldp+1125,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 0x1eU))));
    bufp->fullBit(oldp+1126,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 0x1dU))));
    bufp->fullBit(oldp+1127,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 0x1cU))));
    bufp->fullBit(oldp+1128,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 0x1bU))));
    bufp->fullBit(oldp+1129,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 0x1aU))));
    bufp->fullBit(oldp+1130,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 0x19U))));
    bufp->fullBit(oldp+1131,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 0x18U))));
    bufp->fullBit(oldp+1132,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 0x17U))));
    bufp->fullBit(oldp+1133,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 0x16U))));
    bufp->fullBit(oldp+1134,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 0x15U))));
    bufp->fullBit(oldp+1135,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 0x14U))));
    bufp->fullBit(oldp+1136,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 0x13U))));
    bufp->fullBit(oldp+1137,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 0x12U))));
    bufp->fullBit(oldp+1138,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 0x11U))));
    bufp->fullBit(oldp+1139,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 0x10U))));
    bufp->fullBit(oldp+1140,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 0xfU))));
    bufp->fullBit(oldp+1141,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 0xeU))));
    bufp->fullBit(oldp+1142,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 0xdU))));
    bufp->fullBit(oldp+1143,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 0xcU))));
    bufp->fullBit(oldp+1144,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 0xbU))));
    bufp->fullBit(oldp+1145,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 0xaU))));
    bufp->fullBit(oldp+1146,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 9U))));
    bufp->fullBit(oldp+1147,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 8U))));
    bufp->fullBit(oldp+1148,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 7U))));
    bufp->fullBit(oldp+1149,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 6U))));
    bufp->fullBit(oldp+1150,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 5U))));
    bufp->fullBit(oldp+1151,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 4U))));
    bufp->fullBit(oldp+1152,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 3U))));
    bufp->fullBit(oldp+1153,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 2U))));
    bufp->fullBit(oldp+1154,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                                    >> 1U))));
    bufp->fullBit(oldp+1155,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit)));
    bufp->fullIData(oldp+1156,((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__cycles_full)),32);
    bufp->fullIData(oldp+1157,((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__instret_full)),32);
    bufp->fullIData(oldp+1158,((IData)((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__cycles_full 
                                        >> 0x20U))),32);
    bufp->fullIData(oldp+1159,((IData)((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__instret_full 
                                        >> 0x20U))),32);
    bufp->fullQData(oldp+1160,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__cycles_full),64);
    bufp->fullQData(oldp+1162,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__instret_full),64);
    bufp->fullBit(oldp+1164,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__int_ex_handler__DOT__interrupt_fired));
    bufp->fullCData(oldp+1165,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__mode__DOT__curr_priv_level),2);
    bufp->fullCData(oldp+1166,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                >> 0x1eU)),2);
    bufp->fullBit(oldp+1167,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                    >> 0x1dU))));
    bufp->fullBit(oldp+1168,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                    >> 0x1cU))));
    bufp->fullBit(oldp+1169,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                    >> 0x1bU))));
    bufp->fullCData(oldp+1170,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                      >> 0x18U))),3);
    bufp->fullBit(oldp+1171,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                    >> 0x17U))));
    bufp->fullBit(oldp+1172,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                    >> 0x16U))));
    bufp->fullBit(oldp+1173,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                    >> 0x15U))));
    bufp->fullCData(oldp+1174,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                      >> 0x13U))),2);
    bufp->fullCData(oldp+1175,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                      >> 0x11U))),2);
    bufp->fullBit(oldp+1176,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                    >> 0x10U))));
    bufp->fullCData(oldp+1177,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                      >> 0xeU))),2);
    bufp->fullBit(oldp+1178,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                    >> 0xdU))));
    bufp->fullBit(oldp+1179,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                    >> 0xcU))));
    bufp->fullBit(oldp+1180,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                    >> 0xbU))));
    bufp->fullCData(oldp+1181,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                      >> 8U))),3);
    bufp->fullBit(oldp+1182,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                    >> 7U))));
    bufp->fullBit(oldp+1183,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                    >> 6U))));
    bufp->fullBit(oldp+1184,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                    >> 5U))));
    bufp->fullCData(oldp+1185,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                      >> 3U))),2);
    bufp->fullCData(oldp+1186,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U] 
                                      >> 1U))),2);
    bufp->fullBit(oldp+1187,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U])));
    bufp->fullCData(oldp+1188,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                >> 0x1eU)),2);
    bufp->fullBit(oldp+1189,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                    >> 0x1dU))));
    bufp->fullBit(oldp+1190,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                    >> 0x1cU))));
    bufp->fullBit(oldp+1191,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                    >> 0x1bU))));
    bufp->fullCData(oldp+1192,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                      >> 0x18U))),3);
    bufp->fullBit(oldp+1193,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                    >> 0x17U))));
    bufp->fullBit(oldp+1194,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                    >> 0x16U))));
    bufp->fullBit(oldp+1195,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                    >> 0x15U))));
    bufp->fullCData(oldp+1196,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                      >> 0x13U))),2);
    bufp->fullCData(oldp+1197,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                      >> 0x11U))),2);
    bufp->fullBit(oldp+1198,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                    >> 0x10U))));
    bufp->fullCData(oldp+1199,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                      >> 0xeU))),2);
    bufp->fullBit(oldp+1200,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                    >> 0xdU))));
    bufp->fullBit(oldp+1201,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                    >> 0xcU))));
    bufp->fullBit(oldp+1202,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                    >> 0xbU))));
    bufp->fullCData(oldp+1203,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                      >> 8U))),3);
    bufp->fullBit(oldp+1204,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                    >> 7U))));
    bufp->fullBit(oldp+1205,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                    >> 6U))));
    bufp->fullBit(oldp+1206,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                    >> 5U))));
    bufp->fullCData(oldp+1207,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                      >> 3U))),2);
    bufp->fullCData(oldp+1208,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U] 
                                      >> 1U))),2);
    bufp->fullBit(oldp+1209,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U])));
    bufp->fullCData(oldp+1210,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                >> 0x1eU)),2);
    bufp->fullBit(oldp+1211,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                    >> 0x1dU))));
    bufp->fullBit(oldp+1212,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                    >> 0x1cU))));
    bufp->fullBit(oldp+1213,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                    >> 0x1bU))));
    bufp->fullCData(oldp+1214,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                      >> 0x18U))),3);
    bufp->fullBit(oldp+1215,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                    >> 0x17U))));
    bufp->fullBit(oldp+1216,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                    >> 0x16U))));
    bufp->fullBit(oldp+1217,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                    >> 0x15U))));
    bufp->fullCData(oldp+1218,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                      >> 0x13U))),2);
    bufp->fullCData(oldp+1219,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                      >> 0x11U))),2);
    bufp->fullBit(oldp+1220,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                    >> 0x10U))));
    bufp->fullCData(oldp+1221,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                      >> 0xeU))),2);
    bufp->fullBit(oldp+1222,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                    >> 0xdU))));
    bufp->fullBit(oldp+1223,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                    >> 0xcU))));
    bufp->fullBit(oldp+1224,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                    >> 0xbU))));
    bufp->fullCData(oldp+1225,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                      >> 8U))),3);
    bufp->fullBit(oldp+1226,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                    >> 7U))));
    bufp->fullBit(oldp+1227,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                    >> 6U))));
    bufp->fullBit(oldp+1228,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                    >> 5U))));
    bufp->fullCData(oldp+1229,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                      >> 3U))),2);
    bufp->fullCData(oldp+1230,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U] 
                                      >> 1U))),2);
    bufp->fullBit(oldp+1231,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U])));
    bufp->fullCData(oldp+1232,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                >> 0x1eU)),2);
    bufp->fullBit(oldp+1233,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                    >> 0x1dU))));
    bufp->fullBit(oldp+1234,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                    >> 0x1cU))));
    bufp->fullBit(oldp+1235,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                    >> 0x1bU))));
    bufp->fullCData(oldp+1236,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                      >> 0x18U))),3);
    bufp->fullBit(oldp+1237,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                    >> 0x17U))));
    bufp->fullBit(oldp+1238,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                    >> 0x16U))));
    bufp->fullBit(oldp+1239,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                    >> 0x15U))));
    bufp->fullCData(oldp+1240,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                      >> 0x13U))),2);
    bufp->fullCData(oldp+1241,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                      >> 0x11U))),2);
    bufp->fullBit(oldp+1242,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                    >> 0x10U))));
    bufp->fullCData(oldp+1243,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                      >> 0xeU))),2);
    bufp->fullBit(oldp+1244,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                    >> 0xdU))));
    bufp->fullBit(oldp+1245,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                    >> 0xcU))));
    bufp->fullBit(oldp+1246,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                    >> 0xbU))));
    bufp->fullCData(oldp+1247,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                      >> 8U))),3);
    bufp->fullBit(oldp+1248,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                    >> 7U))));
    bufp->fullBit(oldp+1249,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                    >> 6U))));
    bufp->fullBit(oldp+1250,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                    >> 5U))));
    bufp->fullCData(oldp+1251,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                      >> 3U))),2);
    bufp->fullCData(oldp+1252,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U] 
                                      >> 1U))),2);
    bufp->fullBit(oldp+1253,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U])));
    bufp->fullCData(oldp+1254,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                >> 0x1eU)),2);
    bufp->fullBit(oldp+1255,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                    >> 0x1dU))));
    bufp->fullBit(oldp+1256,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                    >> 0x1cU))));
    bufp->fullBit(oldp+1257,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                    >> 0x1bU))));
    bufp->fullCData(oldp+1258,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                      >> 0x18U))),3);
    bufp->fullBit(oldp+1259,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                    >> 0x17U))));
    bufp->fullBit(oldp+1260,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                    >> 0x16U))));
    bufp->fullBit(oldp+1261,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                    >> 0x15U))));
    bufp->fullCData(oldp+1262,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                      >> 0x13U))),2);
    bufp->fullCData(oldp+1263,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                      >> 0x11U))),2);
    bufp->fullBit(oldp+1264,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                    >> 0x10U))));
    bufp->fullCData(oldp+1265,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                      >> 0xeU))),2);
    bufp->fullBit(oldp+1266,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                    >> 0xdU))));
    bufp->fullBit(oldp+1267,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                    >> 0xcU))));
    bufp->fullBit(oldp+1268,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                    >> 0xbU))));
    bufp->fullCData(oldp+1269,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                      >> 8U))),3);
    bufp->fullBit(oldp+1270,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                    >> 7U))));
    bufp->fullBit(oldp+1271,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                    >> 6U))));
    bufp->fullBit(oldp+1272,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                    >> 5U))));
    bufp->fullCData(oldp+1273,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                      >> 3U))),2);
    bufp->fullCData(oldp+1274,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U] 
                                      >> 1U))),2);
    bufp->fullBit(oldp+1275,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U])));
    bufp->fullCData(oldp+1276,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                >> 0x1eU)),2);
    bufp->fullBit(oldp+1277,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                    >> 0x1dU))));
    bufp->fullBit(oldp+1278,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                    >> 0x1cU))));
    bufp->fullBit(oldp+1279,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                    >> 0x1bU))));
    bufp->fullCData(oldp+1280,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                      >> 0x18U))),3);
    bufp->fullBit(oldp+1281,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                    >> 0x17U))));
    bufp->fullBit(oldp+1282,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                    >> 0x16U))));
    bufp->fullBit(oldp+1283,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                    >> 0x15U))));
    bufp->fullCData(oldp+1284,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                      >> 0x13U))),2);
    bufp->fullCData(oldp+1285,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                      >> 0x11U))),2);
    bufp->fullBit(oldp+1286,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                    >> 0x10U))));
    bufp->fullCData(oldp+1287,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                      >> 0xeU))),2);
    bufp->fullBit(oldp+1288,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                    >> 0xdU))));
    bufp->fullBit(oldp+1289,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                    >> 0xcU))));
    bufp->fullBit(oldp+1290,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                    >> 0xbU))));
    bufp->fullCData(oldp+1291,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                      >> 8U))),3);
    bufp->fullBit(oldp+1292,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                    >> 7U))));
    bufp->fullBit(oldp+1293,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                    >> 6U))));
    bufp->fullBit(oldp+1294,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                    >> 5U))));
    bufp->fullCData(oldp+1295,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                      >> 3U))),2);
    bufp->fullCData(oldp+1296,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U] 
                                      >> 1U))),2);
    bufp->fullBit(oldp+1297,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U])));
    bufp->fullCData(oldp+1298,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                >> 0x1eU)),2);
    bufp->fullBit(oldp+1299,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                    >> 0x1dU))));
    bufp->fullBit(oldp+1300,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                    >> 0x1cU))));
    bufp->fullBit(oldp+1301,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                    >> 0x1bU))));
    bufp->fullCData(oldp+1302,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                      >> 0x18U))),3);
    bufp->fullBit(oldp+1303,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                    >> 0x17U))));
    bufp->fullBit(oldp+1304,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                    >> 0x16U))));
    bufp->fullBit(oldp+1305,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                    >> 0x15U))));
    bufp->fullCData(oldp+1306,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                      >> 0x13U))),2);
    bufp->fullCData(oldp+1307,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                      >> 0x11U))),2);
    bufp->fullBit(oldp+1308,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                    >> 0x10U))));
    bufp->fullCData(oldp+1309,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                      >> 0xeU))),2);
    bufp->fullBit(oldp+1310,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                    >> 0xdU))));
    bufp->fullBit(oldp+1311,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                    >> 0xcU))));
    bufp->fullBit(oldp+1312,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                    >> 0xbU))));
    bufp->fullCData(oldp+1313,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                      >> 8U))),3);
    bufp->fullBit(oldp+1314,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                    >> 7U))));
    bufp->fullBit(oldp+1315,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                    >> 6U))));
    bufp->fullBit(oldp+1316,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                    >> 5U))));
    bufp->fullCData(oldp+1317,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                      >> 3U))),2);
    bufp->fullCData(oldp+1318,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U] 
                                      >> 1U))),2);
    bufp->fullBit(oldp+1319,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U])));
    bufp->fullCData(oldp+1320,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                >> 0x1eU)),2);
    bufp->fullBit(oldp+1321,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                    >> 0x1dU))));
    bufp->fullBit(oldp+1322,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                    >> 0x1cU))));
    bufp->fullBit(oldp+1323,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                    >> 0x1bU))));
    bufp->fullCData(oldp+1324,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                      >> 0x18U))),3);
    bufp->fullBit(oldp+1325,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                    >> 0x17U))));
    bufp->fullBit(oldp+1326,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                    >> 0x16U))));
    bufp->fullBit(oldp+1327,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                    >> 0x15U))));
    bufp->fullCData(oldp+1328,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                      >> 0x13U))),2);
    bufp->fullCData(oldp+1329,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                      >> 0x11U))),2);
    bufp->fullBit(oldp+1330,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                    >> 0x10U))));
    bufp->fullCData(oldp+1331,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                      >> 0xeU))),2);
    bufp->fullBit(oldp+1332,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                    >> 0xdU))));
    bufp->fullBit(oldp+1333,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                    >> 0xcU))));
    bufp->fullBit(oldp+1334,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                    >> 0xbU))));
    bufp->fullCData(oldp+1335,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                      >> 8U))),3);
    bufp->fullBit(oldp+1336,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                    >> 7U))));
    bufp->fullBit(oldp+1337,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                    >> 6U))));
    bufp->fullBit(oldp+1338,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                    >> 5U))));
    bufp->fullCData(oldp+1339,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                      >> 3U))),2);
    bufp->fullCData(oldp+1340,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U] 
                                      >> 1U))),2);
    bufp->fullBit(oldp+1341,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U])));
    bufp->fullCData(oldp+1342,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                >> 0x1eU)),2);
    bufp->fullBit(oldp+1343,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                    >> 0x1dU))));
    bufp->fullBit(oldp+1344,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                    >> 0x1cU))));
    bufp->fullBit(oldp+1345,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                    >> 0x1bU))));
    bufp->fullCData(oldp+1346,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                      >> 0x18U))),3);
    bufp->fullBit(oldp+1347,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                    >> 0x17U))));
    bufp->fullBit(oldp+1348,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                    >> 0x16U))));
    bufp->fullBit(oldp+1349,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                    >> 0x15U))));
    bufp->fullCData(oldp+1350,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                      >> 0x13U))),2);
    bufp->fullCData(oldp+1351,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                      >> 0x11U))),2);
    bufp->fullBit(oldp+1352,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                    >> 0x10U))));
    bufp->fullCData(oldp+1353,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                      >> 0xeU))),2);
    bufp->fullBit(oldp+1354,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                    >> 0xdU))));
    bufp->fullBit(oldp+1355,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                    >> 0xcU))));
    bufp->fullBit(oldp+1356,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                    >> 0xbU))));
    bufp->fullCData(oldp+1357,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                      >> 8U))),3);
    bufp->fullBit(oldp+1358,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                    >> 7U))));
    bufp->fullBit(oldp+1359,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                    >> 6U))));
    bufp->fullBit(oldp+1360,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                    >> 5U))));
    bufp->fullCData(oldp+1361,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                      >> 3U))),2);
    bufp->fullCData(oldp+1362,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U] 
                                      >> 1U))),2);
    bufp->fullBit(oldp+1363,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U])));
    bufp->fullCData(oldp+1364,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                >> 0x1eU)),2);
    bufp->fullBit(oldp+1365,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                    >> 0x1dU))));
    bufp->fullBit(oldp+1366,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                    >> 0x1cU))));
    bufp->fullBit(oldp+1367,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                    >> 0x1bU))));
    bufp->fullCData(oldp+1368,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                      >> 0x18U))),3);
    bufp->fullBit(oldp+1369,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                    >> 0x17U))));
    bufp->fullBit(oldp+1370,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                    >> 0x16U))));
    bufp->fullBit(oldp+1371,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                    >> 0x15U))));
    bufp->fullCData(oldp+1372,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                      >> 0x13U))),2);
    bufp->fullCData(oldp+1373,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                      >> 0x11U))),2);
    bufp->fullBit(oldp+1374,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                    >> 0x10U))));
    bufp->fullCData(oldp+1375,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                      >> 0xeU))),2);
    bufp->fullBit(oldp+1376,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                    >> 0xdU))));
    bufp->fullBit(oldp+1377,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                    >> 0xcU))));
    bufp->fullBit(oldp+1378,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                    >> 0xbU))));
    bufp->fullCData(oldp+1379,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                      >> 8U))),3);
    bufp->fullBit(oldp+1380,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                    >> 7U))));
    bufp->fullBit(oldp+1381,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                    >> 6U))));
    bufp->fullBit(oldp+1382,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                    >> 5U))));
    bufp->fullCData(oldp+1383,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                      >> 3U))),2);
    bufp->fullCData(oldp+1384,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U] 
                                      >> 1U))),2);
    bufp->fullBit(oldp+1385,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U])));
    bufp->fullCData(oldp+1386,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                >> 0x1eU)),2);
    bufp->fullBit(oldp+1387,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                    >> 0x1dU))));
    bufp->fullBit(oldp+1388,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                    >> 0x1cU))));
    bufp->fullBit(oldp+1389,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                    >> 0x1bU))));
    bufp->fullCData(oldp+1390,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                      >> 0x18U))),3);
    bufp->fullBit(oldp+1391,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                    >> 0x17U))));
    bufp->fullBit(oldp+1392,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                    >> 0x16U))));
    bufp->fullBit(oldp+1393,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                    >> 0x15U))));
    bufp->fullCData(oldp+1394,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                      >> 0x13U))),2);
    bufp->fullCData(oldp+1395,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                      >> 0x11U))),2);
    bufp->fullBit(oldp+1396,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                    >> 0x10U))));
    bufp->fullCData(oldp+1397,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                      >> 0xeU))),2);
    bufp->fullBit(oldp+1398,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                    >> 0xdU))));
    bufp->fullBit(oldp+1399,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                    >> 0xcU))));
    bufp->fullBit(oldp+1400,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                    >> 0xbU))));
    bufp->fullCData(oldp+1401,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                      >> 8U))),3);
    bufp->fullBit(oldp+1402,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                    >> 7U))));
    bufp->fullBit(oldp+1403,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                    >> 6U))));
    bufp->fullBit(oldp+1404,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                    >> 5U))));
    bufp->fullCData(oldp+1405,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                      >> 3U))),2);
    bufp->fullCData(oldp+1406,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU] 
                                      >> 1U))),2);
    bufp->fullBit(oldp+1407,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU])));
    bufp->fullCData(oldp+1408,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                >> 0x1eU)),2);
    bufp->fullBit(oldp+1409,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                    >> 0x1dU))));
    bufp->fullBit(oldp+1410,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                    >> 0x1cU))));
    bufp->fullBit(oldp+1411,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                    >> 0x1bU))));
    bufp->fullCData(oldp+1412,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                      >> 0x18U))),3);
    bufp->fullBit(oldp+1413,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                    >> 0x17U))));
    bufp->fullBit(oldp+1414,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                    >> 0x16U))));
    bufp->fullBit(oldp+1415,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                    >> 0x15U))));
    bufp->fullCData(oldp+1416,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                      >> 0x13U))),2);
    bufp->fullCData(oldp+1417,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                      >> 0x11U))),2);
    bufp->fullBit(oldp+1418,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                    >> 0x10U))));
    bufp->fullCData(oldp+1419,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                      >> 0xeU))),2);
    bufp->fullBit(oldp+1420,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                    >> 0xdU))));
    bufp->fullBit(oldp+1421,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                    >> 0xcU))));
    bufp->fullBit(oldp+1422,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                    >> 0xbU))));
    bufp->fullCData(oldp+1423,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                      >> 8U))),3);
    bufp->fullBit(oldp+1424,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                    >> 7U))));
    bufp->fullBit(oldp+1425,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                    >> 6U))));
    bufp->fullBit(oldp+1426,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                    >> 5U))));
    bufp->fullCData(oldp+1427,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                      >> 3U))),2);
    bufp->fullCData(oldp+1428,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU] 
                                      >> 1U))),2);
    bufp->fullBit(oldp+1429,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU])));
    bufp->fullCData(oldp+1430,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                >> 0x1eU)),2);
    bufp->fullBit(oldp+1431,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                    >> 0x1dU))));
    bufp->fullBit(oldp+1432,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                    >> 0x1cU))));
    bufp->fullBit(oldp+1433,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                    >> 0x1bU))));
    bufp->fullCData(oldp+1434,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                      >> 0x18U))),3);
    bufp->fullBit(oldp+1435,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                    >> 0x17U))));
    bufp->fullBit(oldp+1436,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                    >> 0x16U))));
    bufp->fullBit(oldp+1437,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                    >> 0x15U))));
    bufp->fullCData(oldp+1438,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                      >> 0x13U))),2);
    bufp->fullCData(oldp+1439,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                      >> 0x11U))),2);
    bufp->fullBit(oldp+1440,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                    >> 0x10U))));
    bufp->fullCData(oldp+1441,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                      >> 0xeU))),2);
    bufp->fullBit(oldp+1442,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                    >> 0xdU))));
    bufp->fullBit(oldp+1443,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                    >> 0xcU))));
    bufp->fullBit(oldp+1444,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                    >> 0xbU))));
    bufp->fullCData(oldp+1445,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                      >> 8U))),3);
    bufp->fullBit(oldp+1446,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                    >> 7U))));
    bufp->fullBit(oldp+1447,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                    >> 6U))));
    bufp->fullBit(oldp+1448,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                    >> 5U))));
    bufp->fullCData(oldp+1449,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                      >> 3U))),2);
    bufp->fullCData(oldp+1450,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU] 
                                      >> 1U))),2);
    bufp->fullBit(oldp+1451,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU])));
    bufp->fullCData(oldp+1452,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                >> 0x1eU)),2);
    bufp->fullBit(oldp+1453,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                    >> 0x1dU))));
    bufp->fullBit(oldp+1454,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                    >> 0x1cU))));
    bufp->fullBit(oldp+1455,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                    >> 0x1bU))));
    bufp->fullCData(oldp+1456,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                      >> 0x18U))),3);
    bufp->fullBit(oldp+1457,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                    >> 0x17U))));
    bufp->fullBit(oldp+1458,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                    >> 0x16U))));
    bufp->fullBit(oldp+1459,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                    >> 0x15U))));
    bufp->fullCData(oldp+1460,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                      >> 0x13U))),2);
    bufp->fullCData(oldp+1461,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                      >> 0x11U))),2);
    bufp->fullBit(oldp+1462,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                    >> 0x10U))));
    bufp->fullCData(oldp+1463,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                      >> 0xeU))),2);
    bufp->fullBit(oldp+1464,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                    >> 0xdU))));
    bufp->fullBit(oldp+1465,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                    >> 0xcU))));
    bufp->fullBit(oldp+1466,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                    >> 0xbU))));
    bufp->fullCData(oldp+1467,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                      >> 8U))),3);
    bufp->fullBit(oldp+1468,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                    >> 7U))));
    bufp->fullBit(oldp+1469,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                    >> 6U))));
    bufp->fullBit(oldp+1470,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                    >> 5U))));
    bufp->fullCData(oldp+1471,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                      >> 3U))),2);
    bufp->fullCData(oldp+1472,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU] 
                                      >> 1U))),2);
    bufp->fullBit(oldp+1473,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU])));
    bufp->fullCData(oldp+1474,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                >> 0x1eU)),2);
    bufp->fullBit(oldp+1475,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                    >> 0x1dU))));
    bufp->fullBit(oldp+1476,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                    >> 0x1cU))));
    bufp->fullBit(oldp+1477,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                    >> 0x1bU))));
    bufp->fullCData(oldp+1478,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                      >> 0x18U))),3);
    bufp->fullBit(oldp+1479,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                    >> 0x17U))));
    bufp->fullBit(oldp+1480,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                    >> 0x16U))));
    bufp->fullBit(oldp+1481,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                    >> 0x15U))));
    bufp->fullCData(oldp+1482,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                      >> 0x13U))),2);
    bufp->fullCData(oldp+1483,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                      >> 0x11U))),2);
    bufp->fullBit(oldp+1484,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                    >> 0x10U))));
    bufp->fullCData(oldp+1485,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                      >> 0xeU))),2);
    bufp->fullBit(oldp+1486,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                    >> 0xdU))));
    bufp->fullBit(oldp+1487,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                    >> 0xcU))));
    bufp->fullBit(oldp+1488,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                    >> 0xbU))));
    bufp->fullCData(oldp+1489,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                      >> 8U))),3);
    bufp->fullBit(oldp+1490,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                    >> 7U))));
    bufp->fullBit(oldp+1491,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                    >> 6U))));
    bufp->fullBit(oldp+1492,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                    >> 5U))));
    bufp->fullCData(oldp+1493,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                      >> 3U))),2);
    bufp->fullCData(oldp+1494,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU] 
                                      >> 1U))),2);
    bufp->fullBit(oldp+1495,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU])));
    bufp->fullCData(oldp+1496,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                >> 0x1eU)),2);
    bufp->fullBit(oldp+1497,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                    >> 0x1dU))));
    bufp->fullBit(oldp+1498,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                    >> 0x1cU))));
    bufp->fullBit(oldp+1499,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                    >> 0x1bU))));
    bufp->fullCData(oldp+1500,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                      >> 0x18U))),3);
    bufp->fullBit(oldp+1501,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                    >> 0x17U))));
    bufp->fullBit(oldp+1502,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                    >> 0x16U))));
    bufp->fullBit(oldp+1503,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                    >> 0x15U))));
    bufp->fullCData(oldp+1504,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                      >> 0x13U))),2);
    bufp->fullCData(oldp+1505,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                      >> 0x11U))),2);
    bufp->fullBit(oldp+1506,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                    >> 0x10U))));
    bufp->fullCData(oldp+1507,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                      >> 0xeU))),2);
    bufp->fullBit(oldp+1508,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                    >> 0xdU))));
    bufp->fullBit(oldp+1509,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                    >> 0xcU))));
    bufp->fullBit(oldp+1510,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                    >> 0xbU))));
    bufp->fullCData(oldp+1511,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                      >> 8U))),3);
    bufp->fullBit(oldp+1512,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                    >> 7U))));
    bufp->fullBit(oldp+1513,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                    >> 6U))));
    bufp->fullBit(oldp+1514,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                    >> 5U))));
    bufp->fullCData(oldp+1515,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                      >> 3U))),2);
    bufp->fullCData(oldp+1516,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU] 
                                      >> 1U))),2);
    bufp->fullBit(oldp+1517,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU])));
    bufp->fullBit(oldp+1518,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                    >> 7U))));
    bufp->fullCData(oldp+1519,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                      >> 5U))),2);
    bufp->fullCData(oldp+1520,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                      >> 3U))),2);
    bufp->fullBit(oldp+1521,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                    >> 2U))));
    bufp->fullBit(oldp+1522,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                    >> 1U))));
    bufp->fullBit(oldp+1523,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U])));
    bufp->fullBit(oldp+1524,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                    >> 0xfU))));
    bufp->fullCData(oldp+1525,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                      >> 0xdU))),2);
    bufp->fullCData(oldp+1526,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                      >> 0xbU))),2);
    bufp->fullBit(oldp+1527,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                    >> 0xaU))));
    bufp->fullBit(oldp+1528,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                    >> 9U))));
    bufp->fullBit(oldp+1529,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                    >> 8U))));
    bufp->fullBit(oldp+1530,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                    >> 0x17U))));
    bufp->fullCData(oldp+1531,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                      >> 0x15U))),2);
    bufp->fullCData(oldp+1532,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                      >> 0x13U))),2);
    bufp->fullBit(oldp+1533,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                    >> 0x12U))));
    bufp->fullBit(oldp+1534,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                    >> 0x11U))));
    bufp->fullBit(oldp+1535,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                    >> 0x10U))));
    bufp->fullBit(oldp+1536,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                              >> 0x1fU)));
    bufp->fullCData(oldp+1537,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                      >> 0x1dU))),2);
    bufp->fullCData(oldp+1538,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                      >> 0x1bU))),2);
    bufp->fullBit(oldp+1539,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                    >> 0x1aU))));
    bufp->fullBit(oldp+1540,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                    >> 0x19U))));
    bufp->fullBit(oldp+1541,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U] 
                                    >> 0x18U))));
    bufp->fullBit(oldp+1542,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                    >> 7U))));
    bufp->fullCData(oldp+1543,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                      >> 5U))),2);
    bufp->fullCData(oldp+1544,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                      >> 3U))),2);
    bufp->fullBit(oldp+1545,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                    >> 2U))));
    bufp->fullBit(oldp+1546,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                    >> 1U))));
    bufp->fullBit(oldp+1547,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U])));
    bufp->fullBit(oldp+1548,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                    >> 0xfU))));
    bufp->fullCData(oldp+1549,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                      >> 0xdU))),2);
    bufp->fullCData(oldp+1550,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                      >> 0xbU))),2);
    bufp->fullBit(oldp+1551,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                    >> 0xaU))));
    bufp->fullBit(oldp+1552,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                    >> 9U))));
    bufp->fullBit(oldp+1553,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                    >> 8U))));
    bufp->fullBit(oldp+1554,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                    >> 0x17U))));
    bufp->fullCData(oldp+1555,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                      >> 0x15U))),2);
    bufp->fullCData(oldp+1556,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                      >> 0x13U))),2);
    bufp->fullBit(oldp+1557,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                    >> 0x12U))));
    bufp->fullBit(oldp+1558,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                    >> 0x11U))));
    bufp->fullBit(oldp+1559,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                    >> 0x10U))));
    bufp->fullBit(oldp+1560,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                              >> 0x1fU)));
    bufp->fullCData(oldp+1561,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                      >> 0x1dU))),2);
    bufp->fullCData(oldp+1562,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                      >> 0x1bU))),2);
    bufp->fullBit(oldp+1563,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                    >> 0x1aU))));
    bufp->fullBit(oldp+1564,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                    >> 0x19U))));
    bufp->fullBit(oldp+1565,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U] 
                                    >> 0x18U))));
    bufp->fullBit(oldp+1566,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                    >> 7U))));
    bufp->fullCData(oldp+1567,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                      >> 5U))),2);
    bufp->fullCData(oldp+1568,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                      >> 3U))),2);
    bufp->fullBit(oldp+1569,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                    >> 2U))));
    bufp->fullBit(oldp+1570,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                    >> 1U))));
    bufp->fullBit(oldp+1571,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U])));
    bufp->fullBit(oldp+1572,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                    >> 0xfU))));
    bufp->fullCData(oldp+1573,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                      >> 0xdU))),2);
    bufp->fullCData(oldp+1574,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                      >> 0xbU))),2);
    bufp->fullBit(oldp+1575,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                    >> 0xaU))));
    bufp->fullBit(oldp+1576,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                    >> 9U))));
    bufp->fullBit(oldp+1577,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                    >> 8U))));
    bufp->fullBit(oldp+1578,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                    >> 0x17U))));
    bufp->fullCData(oldp+1579,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                      >> 0x15U))),2);
    bufp->fullCData(oldp+1580,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                      >> 0x13U))),2);
    bufp->fullBit(oldp+1581,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                    >> 0x12U))));
    bufp->fullBit(oldp+1582,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                    >> 0x11U))));
    bufp->fullBit(oldp+1583,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                    >> 0x10U))));
    bufp->fullBit(oldp+1584,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                              >> 0x1fU)));
    bufp->fullCData(oldp+1585,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                      >> 0x1dU))),2);
    bufp->fullCData(oldp+1586,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                      >> 0x1bU))),2);
    bufp->fullBit(oldp+1587,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                    >> 0x1aU))));
    bufp->fullBit(oldp+1588,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                    >> 0x19U))));
    bufp->fullBit(oldp+1589,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U] 
                                    >> 0x18U))));
    bufp->fullBit(oldp+1590,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                    >> 7U))));
    bufp->fullCData(oldp+1591,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                      >> 5U))),2);
    bufp->fullCData(oldp+1592,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                      >> 3U))),2);
    bufp->fullBit(oldp+1593,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                    >> 2U))));
    bufp->fullBit(oldp+1594,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                    >> 1U))));
    bufp->fullBit(oldp+1595,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U])));
    bufp->fullBit(oldp+1596,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                    >> 0xfU))));
    bufp->fullCData(oldp+1597,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                      >> 0xdU))),2);
    bufp->fullCData(oldp+1598,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                      >> 0xbU))),2);
    bufp->fullBit(oldp+1599,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                    >> 0xaU))));
    bufp->fullBit(oldp+1600,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                    >> 9U))));
    bufp->fullBit(oldp+1601,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                    >> 8U))));
    bufp->fullBit(oldp+1602,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                    >> 0x17U))));
    bufp->fullCData(oldp+1603,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                      >> 0x15U))),2);
    bufp->fullCData(oldp+1604,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                      >> 0x13U))),2);
    bufp->fullBit(oldp+1605,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                    >> 0x12U))));
    bufp->fullBit(oldp+1606,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                    >> 0x11U))));
    bufp->fullBit(oldp+1607,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                    >> 0x10U))));
    bufp->fullBit(oldp+1608,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                              >> 0x1fU)));
    bufp->fullCData(oldp+1609,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                      >> 0x1dU))),2);
    bufp->fullCData(oldp+1610,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                      >> 0x1bU))),2);
    bufp->fullBit(oldp+1611,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                    >> 0x1aU))));
    bufp->fullBit(oldp+1612,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                    >> 0x19U))));
    bufp->fullBit(oldp+1613,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U] 
                                    >> 0x18U))));
    bufp->fullIData(oldp+1614,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[0U]),32);
    bufp->fullIData(oldp+1615,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[1U]),32);
    bufp->fullIData(oldp+1616,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[2U]),32);
    bufp->fullIData(oldp+1617,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[3U]),32);
    bufp->fullIData(oldp+1618,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[4U]),32);
    bufp->fullIData(oldp+1619,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[5U]),32);
    bufp->fullIData(oldp+1620,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[6U]),32);
    bufp->fullIData(oldp+1621,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[7U]),32);
    bufp->fullIData(oldp+1622,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[8U]),32);
    bufp->fullIData(oldp+1623,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[9U]),32);
    bufp->fullIData(oldp+1624,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[0xaU]),32);
    bufp->fullIData(oldp+1625,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[0xbU]),32);
    bufp->fullIData(oldp+1626,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[0xcU]),32);
    bufp->fullIData(oldp+1627,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[0xdU]),32);
    bufp->fullIData(oldp+1628,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[0xeU]),32);
    bufp->fullIData(oldp+1629,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[0xfU]),32);
    bufp->fullBit(oldp+1630,(vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT____Vcellout__genblk1__DOT__dcache__flush_done));
    bufp->fullBit(oldp+1631,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                    >> 5U))));
    bufp->fullCData(oldp+1632,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                      >> 3U))),2);
    bufp->fullCData(oldp+1633,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                      >> 1U))),2);
    bufp->fullBit(oldp+1634,((1U & (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx))));
    bufp->fullCData(oldp+1635,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__word_num),2);
    bufp->fullBit(oldp+1636,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__clear_word_count));
    bufp->fullBit(oldp+1637,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__clear_flush_count));
    bufp->fullIData(oldp+1638,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__state),32);
    bufp->fullCData(oldp+1639,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__last_used),2);
    bufp->fullIData(oldp+1640,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__read_addr),32);
    bufp->fullIData(oldp+1641,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__decoded_req_addr 
                                >> 5U)),27);
    bufp->fullCData(oldp+1642,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__decoded_req_addr 
                                      >> 3U))),2);
    bufp->fullBit(oldp+1643,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__decoded_req_addr 
                                    >> 2U))));
    bufp->fullCData(oldp+1644,((3U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__decoded_req_addr)),2);
    bufp->fullBit(oldp+1645,(vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT____Vcellout__genblk2__DOT__icache__flush_done));
    bufp->fullBit(oldp+1646,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                    >> 5U))));
    bufp->fullCData(oldp+1647,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                      >> 3U))),2);
    bufp->fullCData(oldp+1648,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                      >> 1U))),2);
    bufp->fullBit(oldp+1649,((1U & (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx))));
    bufp->fullCData(oldp+1650,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__word_num),2);
    bufp->fullBit(oldp+1651,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__clear_word_count));
    bufp->fullBit(oldp+1652,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__clear_flush_count));
    bufp->fullIData(oldp+1653,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__state),32);
    bufp->fullCData(oldp+1654,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__last_used),2);
    bufp->fullIData(oldp+1655,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__read_addr),32);
    bufp->fullIData(oldp+1656,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__decoded_req_addr 
                                >> 5U)),27);
    bufp->fullCData(oldp+1657,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__decoded_req_addr 
                                      >> 3U))),2);
    bufp->fullBit(oldp+1658,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__decoded_req_addr 
                                    >> 2U))));
    bufp->fullCData(oldp+1659,((3U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__decoded_req_addr)),2);
    bufp->fullBit(oldp+1660,((1U & ((~ (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__ifence_pulse)) 
                                    & ((IData)(vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT____Vcellout__genblk2__DOT__icache__flush_done) 
                                       | (~ (IData)(vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT____Vcellout__genblk1__DOT__dcache__flush_done)))))));
    bufp->fullBit(oldp+1661,((1U & ((~ (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__ifence_pulse)) 
                                    & ((IData)(vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT____Vcellout__genblk1__DOT__dcache__flush_done) 
                                       | (~ (IData)(vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT____Vcellout__genblk2__DOT__icache__flush_done)))))));
    bufp->fullBit(oldp+1662,(((((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__invalid_csr_priv) 
                                | (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__invalid_csr_addr)) 
                               | ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                   >> 6U) & (3U != (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__mode__DOT__curr_priv_level)))) 
                              | (((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                   >> 5U) & (0U == (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__mode__DOT__curr_priv_level))) 
                                 & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                                    >> 0x15U)))));
    bufp->fullBit(oldp+1663,(((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__int_ex_handler__DOT__exception) 
                              | (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__int_ex_handler__DOT__interrupt_fired))));
    bufp->fullIData(oldp+1664,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[
                               (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                         >> 0xfU))]),32);
    bufp->fullIData(oldp+1665,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__g_rfile_select__DOT__rf__DOT__registers[
                               (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                         >> 0x14U))]),32);
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
    bufp->fullWData(oldp+1666,(__Vtemp_ha676a1bf__0),372);
    __Vtemp_h5ee43eb0__0[0U] = (Vtop_core__ConstPool__CONST_h1b548564_0[0U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0xcU] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0xbU] 
                                                >> 0x14U)));
    __Vtemp_h5ee43eb0__0[1U] = (Vtop_core__ConstPool__CONST_h1b548564_0[1U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0xdU] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0xcU] 
                                                >> 0x14U)));
    __Vtemp_h5ee43eb0__0[2U] = (Vtop_core__ConstPool__CONST_h1b548564_0[2U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0xeU] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0xdU] 
                                                >> 0x14U)));
    __Vtemp_h5ee43eb0__0[3U] = (Vtop_core__ConstPool__CONST_h1b548564_0[3U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0xfU] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0xeU] 
                                                >> 0x14U)));
    __Vtemp_h5ee43eb0__0[4U] = (Vtop_core__ConstPool__CONST_h1b548564_0[4U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x10U] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0xfU] 
                                                >> 0x14U)));
    __Vtemp_h5ee43eb0__0[5U] = (Vtop_core__ConstPool__CONST_h1b548564_0[5U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x11U] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x10U] 
                                                >> 0x14U)));
    __Vtemp_h5ee43eb0__0[6U] = (Vtop_core__ConstPool__CONST_h1b548564_0[6U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x12U] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x11U] 
                                                >> 0x14U)));
    __Vtemp_h5ee43eb0__0[7U] = (Vtop_core__ConstPool__CONST_h1b548564_0[7U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x13U] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x12U] 
                                                >> 0x14U)));
    __Vtemp_h5ee43eb0__0[8U] = (Vtop_core__ConstPool__CONST_h1b548564_0[8U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x14U] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x13U] 
                                                >> 0x14U)));
    __Vtemp_h5ee43eb0__0[9U] = (Vtop_core__ConstPool__CONST_h1b548564_0[9U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x15U] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x14U] 
                                                >> 0x14U)));
    __Vtemp_h5ee43eb0__0[0xaU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xaU] 
                                  & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x16U] 
                                      << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x15U] 
                                                  >> 0x14U)));
    __Vtemp_h5ee43eb0__0[0xbU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xbU] 
                                  & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x17U] 
                                      << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x16U] 
                                                  >> 0x14U)));
    bufp->fullWData(oldp+1678,(__Vtemp_h5ee43eb0__0),372);
    __Vtemp_h0a51f55d__0[0U] = (Vtop_core__ConstPool__CONST_h1b548564_0[0U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x18U] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x17U] 
                                                 >> 8U)));
    __Vtemp_h0a51f55d__0[1U] = (Vtop_core__ConstPool__CONST_h1b548564_0[1U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x19U] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x18U] 
                                                 >> 8U)));
    __Vtemp_h0a51f55d__0[2U] = (Vtop_core__ConstPool__CONST_h1b548564_0[2U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x1aU] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x19U] 
                                                 >> 8U)));
    __Vtemp_h0a51f55d__0[3U] = (Vtop_core__ConstPool__CONST_h1b548564_0[3U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x1bU] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x1aU] 
                                                 >> 8U)));
    __Vtemp_h0a51f55d__0[4U] = (Vtop_core__ConstPool__CONST_h1b548564_0[4U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x1cU] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x1bU] 
                                                 >> 8U)));
    __Vtemp_h0a51f55d__0[5U] = (Vtop_core__ConstPool__CONST_h1b548564_0[5U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x1dU] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x1cU] 
                                                 >> 8U)));
    __Vtemp_h0a51f55d__0[6U] = (Vtop_core__ConstPool__CONST_h1b548564_0[6U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x1eU] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x1dU] 
                                                 >> 8U)));
    __Vtemp_h0a51f55d__0[7U] = (Vtop_core__ConstPool__CONST_h1b548564_0[7U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x1fU] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x1eU] 
                                                 >> 8U)));
    __Vtemp_h0a51f55d__0[8U] = (Vtop_core__ConstPool__CONST_h1b548564_0[8U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x20U] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x1fU] 
                                                 >> 8U)));
    __Vtemp_h0a51f55d__0[9U] = (Vtop_core__ConstPool__CONST_h1b548564_0[9U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x21U] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x20U] 
                                                 >> 8U)));
    __Vtemp_h0a51f55d__0[0xaU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xaU] 
                                  & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x22U] 
                                      << 0x18U) | (
                                                   vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x21U] 
                                                   >> 8U)));
    __Vtemp_h0a51f55d__0[0xbU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xbU] 
                                  & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x23U] 
                                      << 0x18U) | (
                                                   vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x22U] 
                                                   >> 8U)));
    bufp->fullWData(oldp+1690,(__Vtemp_h0a51f55d__0),372);
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
                                      << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x2cU] 
                                                >> 0x1cU)));
    __Vtemp_he6508a66__0[0xbU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xbU] 
                                  & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x2eU] 
                                      << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[0x2dU] 
                                                >> 0x1cU)));
    bufp->fullWData(oldp+1702,(__Vtemp_he6508a66__0),372);
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
    bufp->fullWData(oldp+1714,(__Vtemp_h202cdc64__0),372);
    __Vtemp_h0f78598d__0[0U] = (Vtop_core__ConstPool__CONST_h1b548564_0[0U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0xcU] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0xbU] 
                                                >> 0x14U)));
    __Vtemp_h0f78598d__0[1U] = (Vtop_core__ConstPool__CONST_h1b548564_0[1U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0xdU] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0xcU] 
                                                >> 0x14U)));
    __Vtemp_h0f78598d__0[2U] = (Vtop_core__ConstPool__CONST_h1b548564_0[2U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0xeU] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0xdU] 
                                                >> 0x14U)));
    __Vtemp_h0f78598d__0[3U] = (Vtop_core__ConstPool__CONST_h1b548564_0[3U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0xfU] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0xeU] 
                                                >> 0x14U)));
    __Vtemp_h0f78598d__0[4U] = (Vtop_core__ConstPool__CONST_h1b548564_0[4U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x10U] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0xfU] 
                                                >> 0x14U)));
    __Vtemp_h0f78598d__0[5U] = (Vtop_core__ConstPool__CONST_h1b548564_0[5U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x11U] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x10U] 
                                                >> 0x14U)));
    __Vtemp_h0f78598d__0[6U] = (Vtop_core__ConstPool__CONST_h1b548564_0[6U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x12U] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x11U] 
                                                >> 0x14U)));
    __Vtemp_h0f78598d__0[7U] = (Vtop_core__ConstPool__CONST_h1b548564_0[7U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x13U] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x12U] 
                                                >> 0x14U)));
    __Vtemp_h0f78598d__0[8U] = (Vtop_core__ConstPool__CONST_h1b548564_0[8U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x14U] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x13U] 
                                                >> 0x14U)));
    __Vtemp_h0f78598d__0[9U] = (Vtop_core__ConstPool__CONST_h1b548564_0[9U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x15U] 
                                    << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x14U] 
                                                >> 0x14U)));
    __Vtemp_h0f78598d__0[0xaU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xaU] 
                                  & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x16U] 
                                      << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x15U] 
                                                  >> 0x14U)));
    __Vtemp_h0f78598d__0[0xbU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xbU] 
                                  & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x17U] 
                                      << 0xcU) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x16U] 
                                                  >> 0x14U)));
    bufp->fullWData(oldp+1726,(__Vtemp_h0f78598d__0),372);
    __Vtemp_h4f074be2__0[0U] = (Vtop_core__ConstPool__CONST_h1b548564_0[0U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x18U] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x17U] 
                                                 >> 8U)));
    __Vtemp_h4f074be2__0[1U] = (Vtop_core__ConstPool__CONST_h1b548564_0[1U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x19U] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x18U] 
                                                 >> 8U)));
    __Vtemp_h4f074be2__0[2U] = (Vtop_core__ConstPool__CONST_h1b548564_0[2U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x1aU] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x19U] 
                                                 >> 8U)));
    __Vtemp_h4f074be2__0[3U] = (Vtop_core__ConstPool__CONST_h1b548564_0[3U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x1bU] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x1aU] 
                                                 >> 8U)));
    __Vtemp_h4f074be2__0[4U] = (Vtop_core__ConstPool__CONST_h1b548564_0[4U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x1cU] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x1bU] 
                                                 >> 8U)));
    __Vtemp_h4f074be2__0[5U] = (Vtop_core__ConstPool__CONST_h1b548564_0[5U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x1dU] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x1cU] 
                                                 >> 8U)));
    __Vtemp_h4f074be2__0[6U] = (Vtop_core__ConstPool__CONST_h1b548564_0[6U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x1eU] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x1dU] 
                                                 >> 8U)));
    __Vtemp_h4f074be2__0[7U] = (Vtop_core__ConstPool__CONST_h1b548564_0[7U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x1fU] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x1eU] 
                                                 >> 8U)));
    __Vtemp_h4f074be2__0[8U] = (Vtop_core__ConstPool__CONST_h1b548564_0[8U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x20U] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x1fU] 
                                                 >> 8U)));
    __Vtemp_h4f074be2__0[9U] = (Vtop_core__ConstPool__CONST_h1b548564_0[9U] 
                                & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x21U] 
                                    << 0x18U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x20U] 
                                                 >> 8U)));
    __Vtemp_h4f074be2__0[0xaU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xaU] 
                                  & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x22U] 
                                      << 0x18U) | (
                                                   vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x21U] 
                                                   >> 8U)));
    __Vtemp_h4f074be2__0[0xbU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xbU] 
                                  & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x23U] 
                                      << 0x18U) | (
                                                   vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x22U] 
                                                   >> 8U)));
    bufp->fullWData(oldp+1738,(__Vtemp_h4f074be2__0),372);
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
                                      << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x2cU] 
                                                >> 0x1cU)));
    __Vtemp_hc53d5f0a__0[0xbU] = (Vtop_core__ConstPool__CONST_h1b548564_0[0xbU] 
                                  & ((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x2eU] 
                                      << 4U) | (vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[0x2dU] 
                                                >> 0x1cU)));
    bufp->fullWData(oldp+1750,(__Vtemp_hc53d5f0a__0),372);
    bufp->fullBit(oldp+1762,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0xeU))));
    bufp->fullBit(oldp+1763,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__wfi));
    bufp->fullIData(oldp+1764,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__imm_I_ext),32);
    bufp->fullIData(oldp+1765,((((- (IData)((1U & ((IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__imm_S) 
                                                   >> 0xbU)))) 
                                 << 0xcU) | (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__imm_S))),32);
    bufp->fullIData(oldp+1766,((((- (IData)((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__imm_UJ 
                                                   >> 0x14U)))) 
                                 << 0x15U) | vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__imm_UJ)),32);
    bufp->fullIData(oldp+1767,((((0x13U == (0x7fU & 
                                            vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U])) 
                                 & ((1U == (7U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                                  >> 0xcU))) 
                                    | (5U == (7U & 
                                              (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                               >> 0xcU)))))
                                 ? (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                             >> 0x14U))
                                 : vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__imm_I_ext)),32);
    bufp->fullIData(oldp+1768,((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[4U] 
                                + VL_EXTENDS_II(32,13, (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__imm_SB)))),32);
    bufp->fullIData(oldp+1769,(VL_EXTENDS_II(32,13, (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__imm_SB))),32);
    bufp->fullCData(oldp+1770,((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                >> 0x19U)),7);
    bufp->fullCData(oldp+1771,((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                         >> 0x14U))),5);
    bufp->fullCData(oldp+1772,((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                         >> 0xfU))),5);
    bufp->fullCData(oldp+1773,((7U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                      >> 0xcU))),3);
    bufp->fullCData(oldp+1774,((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                         >> 7U))),5);
    bufp->fullCData(oldp+1775,((0x7fU & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U])),7);
    bufp->fullSData(oldp+1776,((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                >> 0x14U)),12);
    bufp->fullBit(oldp+1777,((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                              >> 0x1fU)));
    bufp->fullCData(oldp+1778,((0x3fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                         >> 0x19U))),6);
    bufp->fullCData(oldp+1779,((0xfU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                        >> 8U))),4);
    bufp->fullBit(oldp+1780,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                    >> 7U))));
    bufp->fullIData(oldp+1781,((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                >> 0xcU)),20);
    bufp->fullSData(oldp+1782,((0x3ffU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                          >> 0x15U))),10);
    bufp->fullBit(oldp+1783,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                    >> 0x14U))));
    bufp->fullCData(oldp+1784,((0xffU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                         >> 0xcU))),8);
    bufp->fullBit(oldp+1785,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu__DOT__maybe_illegal));
    bufp->fullBit(oldp+1786,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu__DOT__sr));
    bufp->fullBit(oldp+1787,(((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu__DOT__sr) 
                              & (~ (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                    >> 0x1eU)))));
    bufp->fullBit(oldp+1788,(((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu__DOT__sr) 
                              & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                 >> 0x1eU))));
    bufp->fullBit(oldp+1789,((((((IData)((0x13U == 
                                          (0x707fU 
                                           & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))) 
                                 | (0x17U == (0x7fU 
                                              & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))) 
                                | ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu__DOT__add_sub) 
                                   & (~ (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                         >> 0x1eU)))) 
                               | (3U == (0x7fU & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))) 
                              | (0x23U == (0x7fU & 
                                           vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U])))));
    bufp->fullBit(oldp+1790,(((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu__DOT__add_sub) 
                              & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                 >> 0x1eU))));
    bufp->fullBit(oldp+1791,(((IData)((0x7013U == (0x707fU 
                                                   & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))) 
                              | (IData)((0x7033U == 
                                         (0x707fU & 
                                          vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))))));
    bufp->fullBit(oldp+1792,(((IData)((0x6013U == (0x707fU 
                                                   & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))) 
                              | (IData)((0x6033U == 
                                         (0x707fU & 
                                          vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))))));
    bufp->fullBit(oldp+1793,(((IData)((0x1013U == (0x707fU 
                                                   & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))) 
                              | (IData)((0x1033U == 
                                         (0x707fU & 
                                          vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))))));
    bufp->fullBit(oldp+1794,(((IData)((0x4013U == (0x707fU 
                                                   & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))) 
                              | (IData)((0x4033U == 
                                         (0x707fU & 
                                          vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))))));
    bufp->fullBit(oldp+1795,(((IData)((0x2013U == (0x707fU 
                                                   & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))) 
                              | (IData)((0x2033U == 
                                         (0x707fU & 
                                          vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))))));
    bufp->fullBit(oldp+1796,(((IData)((0x3013U == (0x707fU 
                                                   & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))) 
                              | (IData)((0x3033U == 
                                         (0x707fU & 
                                          vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))))));
    bufp->fullBit(oldp+1797,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu__DOT__add_sub));
    bufp->fullIData(oldp+1798,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc),32);
    bufp->fullIData(oldp+1799,(((IData)(4U) + vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc)),32);
    bufp->fullBit(oldp+1800,((0U != (3U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc))));
    bufp->fullIData(oldp+1801,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc),32);
    bufp->fullBit(oldp+1802,(((0U != (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                               >> 0x13U))) 
                              & ((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                           >> 0xfU)) 
                                 == (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                              >> 0x13U))))));
    bufp->fullBit(oldp+1803,(((0U != (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                               >> 0x13U))) 
                              & ((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                           >> 0x14U)) 
                                 == (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                              >> 0x13U))))));
    bufp->fullBit(oldp+1804,((IData)((0U != (0xc0000U 
                                             & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU])))));
    bufp->fullBit(oldp+1805,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__branch_jump));
    bufp->fullBit(oldp+1806,((((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                         >> 0xfU)) 
                               == (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                            >> 0x13U))) 
                              & (0U != (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                 >> 0x13U))))));
    bufp->fullBit(oldp+1807,((((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                         >> 0x14U)) 
                               == (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                            >> 0x13U))) 
                              & (0U != (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                 >> 0x13U))))));
    bufp->fullBit(oldp+1808,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__exception));
    bufp->fullBit(oldp+1809,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__intr));
    bufp->fullIData(oldp+1810,(((IData)(((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                          >> 0x17U) 
                                         & (~ (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__intr))))
                                 ? ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[7U] 
                                     << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[6U] 
                                                  >> 1U))
                                 : ((8U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[5U])
                                     ? vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[4U]
                                     : vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc))),32);
    bufp->fullIData(oldp+1811,(((0xff000000U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[8U] 
                                                << 0x17U)) 
                                | ((0xff0000U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[8U] 
                                                 << 7U)) 
                                   | ((0xff00U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[8U] 
                                                  >> 9U)) 
                                      | (0xffU & ((
                                                   vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[9U] 
                                                   << 7U) 
                                                  | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[8U] 
                                                     >> 0x19U))))))),32);
    bufp->fullBit(oldp+1812,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__mal_addr));
    bufp->fullCData(oldp+1813,((3U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                      >> 1U))),2);
    bufp->fullCData(oldp+1814,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard),4);
    bufp->fullBit(oldp+1815,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__ifence_pulse));
    bufp->fullCData(oldp+1816,((7U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[7U] 
                                      >> 0xdU))),3);
    bufp->fullSData(oldp+1817,((0xfffU & ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[8U] 
                                           << 0xbU) 
                                          | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[7U] 
                                             >> 0x15U)))),12);
    bufp->fullBit(oldp+1818,((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[7U] 
                              >> 0x1fU)));
    bufp->fullIData(oldp+1819,(((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[8U] 
                                 << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[7U] 
                                              >> 1U))),32);
    bufp->fullIData(oldp+1820,(((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[7U] 
                                 << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[6U] 
                                              >> 1U))),32);
    bufp->fullCData(oldp+1821,((0x7fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[7U] 
                                         >> 1U))),7);
    bufp->fullCData(oldp+1822,((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[7U] 
                                         >> 0x10U))),5);
    bufp->fullCData(oldp+1823,((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[7U] 
                                         >> 0x15U))),5);
    bufp->fullCData(oldp+1824,((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                         >> 0x13U))),5);
    bufp->fullSData(oldp+1825,((0x1fffU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[2U] 
                                           >> 0xdU))),13);
    bufp->fullSData(oldp+1826,((0xfffU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[2U] 
                                          >> 1U))),12);
    bufp->fullSData(oldp+1827,((0xfffU & ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[2U] 
                                           << 0xbU) 
                                          | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[1U] 
                                             >> 0x15U)))),12);
    bufp->fullIData(oldp+1828,((0x1fffffU & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[1U])),21);
    bufp->fullIData(oldp+1829,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0U]),32);
    bufp->fullQData(oldp+1830,((QData)((IData)(((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[7U] 
                                                 << 0x1fU) 
                                                | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[6U] 
                                                   >> 1U))))),64);
    bufp->fullCData(oldp+1832,((7U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                      >> 0xdU))),3);
    bufp->fullIData(oldp+1833,(((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[9U] 
                                 << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[8U] 
                                              >> 1U))),32);
    bufp->fullBit(oldp+1834,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__invalid_csr_priv));
    bufp->fullBit(oldp+1835,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__invalid_csr_addr));
    bufp->fullBit(oldp+1836,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__csr_operation));
    bufp->fullIData(oldp+1837,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__int_ex_handler__DOT__ex_src),31);
    bufp->fullBit(oldp+1838,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__int_ex_handler__DOT__exception));
    bufp->fullCData(oldp+1839,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__mode__DOT__next_priv_level),2);
    bufp->fullCData(oldp+1840,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                >> 0x1eU)),2);
    bufp->fullBit(oldp+1841,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                    >> 0x1dU))));
    bufp->fullBit(oldp+1842,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                    >> 0x1cU))));
    bufp->fullBit(oldp+1843,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                    >> 0x1bU))));
    bufp->fullCData(oldp+1844,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                      >> 0x18U))),3);
    bufp->fullBit(oldp+1845,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                    >> 0x17U))));
    bufp->fullBit(oldp+1846,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                    >> 0x16U))));
    bufp->fullBit(oldp+1847,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                    >> 0x15U))));
    bufp->fullCData(oldp+1848,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                      >> 0x13U))),2);
    bufp->fullCData(oldp+1849,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                      >> 0x11U))),2);
    bufp->fullBit(oldp+1850,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                    >> 0x10U))));
    bufp->fullCData(oldp+1851,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                      >> 0xeU))),2);
    bufp->fullBit(oldp+1852,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                    >> 0xdU))));
    bufp->fullBit(oldp+1853,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                    >> 0xcU))));
    bufp->fullBit(oldp+1854,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                    >> 0xbU))));
    bufp->fullCData(oldp+1855,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                      >> 8U))),3);
    bufp->fullBit(oldp+1856,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                    >> 7U))));
    bufp->fullBit(oldp+1857,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                    >> 6U))));
    bufp->fullBit(oldp+1858,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                    >> 5U))));
    bufp->fullCData(oldp+1859,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                      >> 3U))),2);
    bufp->fullCData(oldp+1860,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d 
                                      >> 1U))),2);
    bufp->fullBit(oldp+1861,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_d)));
    bufp->fullCData(oldp+1862,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                >> 0x1eU)),2);
    bufp->fullBit(oldp+1863,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                    >> 0x1dU))));
    bufp->fullBit(oldp+1864,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                    >> 0x1cU))));
    bufp->fullBit(oldp+1865,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                    >> 0x1bU))));
    bufp->fullCData(oldp+1866,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                      >> 0x18U))),3);
    bufp->fullBit(oldp+1867,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                    >> 0x17U))));
    bufp->fullBit(oldp+1868,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                    >> 0x16U))));
    bufp->fullBit(oldp+1869,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                    >> 0x15U))));
    bufp->fullCData(oldp+1870,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                      >> 0x13U))),2);
    bufp->fullCData(oldp+1871,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                      >> 0x11U))),2);
    bufp->fullBit(oldp+1872,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                    >> 0x10U))));
    bufp->fullCData(oldp+1873,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                      >> 0xeU))),2);
    bufp->fullBit(oldp+1874,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                    >> 0xdU))));
    bufp->fullBit(oldp+1875,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                    >> 0xcU))));
    bufp->fullBit(oldp+1876,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                    >> 0xbU))));
    bufp->fullCData(oldp+1877,((7U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                      >> 8U))),3);
    bufp->fullBit(oldp+1878,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                    >> 7U))));
    bufp->fullBit(oldp+1879,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                    >> 6U))));
    bufp->fullBit(oldp+1880,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                    >> 5U))));
    bufp->fullCData(oldp+1881,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                      >> 3U))),2);
    bufp->fullCData(oldp+1882,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i 
                                      >> 1U))),2);
    bufp->fullBit(oldp+1883,((1U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__active_reg_i)));
    bufp->fullCData(oldp+1884,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_d) 
                                      >> 0xeU))),2);
    bufp->fullBit(oldp+1885,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_d) 
                                    >> 0xdU))));
    bufp->fullBit(oldp+1886,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_d) 
                                    >> 0xcU))));
    bufp->fullBit(oldp+1887,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_d) 
                                    >> 0xbU))));
    bufp->fullCData(oldp+1888,((7U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_d) 
                                      >> 8U))),3);
    bufp->fullBit(oldp+1889,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_d) 
                                    >> 7U))));
    bufp->fullBit(oldp+1890,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_d) 
                                    >> 6U))));
    bufp->fullBit(oldp+1891,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_d) 
                                    >> 5U))));
    bufp->fullCData(oldp+1892,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_d) 
                                      >> 3U))),2);
    bufp->fullCData(oldp+1893,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_d) 
                                      >> 1U))),2);
    bufp->fullBit(oldp+1894,((1U & (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_d))));
    bufp->fullCData(oldp+1895,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_i) 
                                      >> 0xeU))),2);
    bufp->fullBit(oldp+1896,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_i) 
                                    >> 0xdU))));
    bufp->fullBit(oldp+1897,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_i) 
                                    >> 0xcU))));
    bufp->fullBit(oldp+1898,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_i) 
                                    >> 0xbU))));
    bufp->fullCData(oldp+1899,((7U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_i) 
                                      >> 8U))),3);
    bufp->fullBit(oldp+1900,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_i) 
                                    >> 7U))));
    bufp->fullBit(oldp+1901,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_i) 
                                    >> 6U))));
    bufp->fullBit(oldp+1902,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_i) 
                                    >> 5U))));
    bufp->fullCData(oldp+1903,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_i) 
                                      >> 3U))),2);
    bufp->fullCData(oldp+1904,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_i) 
                                      >> 1U))),2);
    bufp->fullBit(oldp+1905,((1U & (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_cfg_i))));
    bufp->fullCData(oldp+1906,((3U & (((IData)(1U) 
                                       + (0xfU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                  >> 1U))) 
                                      >> 2U))),2);
    bufp->fullCData(oldp+1907,((3U & ((IData)(1U) + 
                                      (0xfU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                               >> 1U))))),2);
    bufp->fullSData(oldp+1908,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__d_cfg_match),16);
    bufp->fullBit(oldp+1909,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__d_match) 
                                    >> 7U))));
    bufp->fullCData(oldp+1910,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__d_match) 
                                      >> 5U))),2);
    bufp->fullCData(oldp+1911,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__d_match) 
                                      >> 3U))),2);
    bufp->fullBit(oldp+1912,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__d_match) 
                                    >> 2U))));
    bufp->fullBit(oldp+1913,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__d_match) 
                                    >> 1U))));
    bufp->fullBit(oldp+1914,((1U & (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__d_match))));
    bufp->fullBit(oldp+1915,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__d_match_found));
    bufp->fullBit(oldp+1916,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__d_prot_fault));
    bufp->fullSData(oldp+1917,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__i_cfg_match),16);
    bufp->fullBit(oldp+1918,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__i_match) 
                                    >> 7U))));
    bufp->fullCData(oldp+1919,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__i_match) 
                                      >> 5U))),2);
    bufp->fullCData(oldp+1920,((3U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__i_match) 
                                      >> 3U))),2);
    bufp->fullBit(oldp+1921,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__i_match) 
                                    >> 2U))));
    bufp->fullBit(oldp+1922,((1U & ((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__i_match) 
                                    >> 1U))));
    bufp->fullBit(oldp+1923,((1U & (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__i_match))));
    bufp->fullBit(oldp+1924,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__i_match_found));
    bufp->fullBit(oldp+1925,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__i_prot_fault));
    bufp->fullIData(oldp+1926,((0x3fffffffU & ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xbU] 
                                                << 0x1dU) 
                                               | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                  >> 3U)))),32);
    bufp->fullBit(oldp+1927,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__0__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1928,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__10__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1929,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__11__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1930,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__12__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1931,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__13__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1932,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__14__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1933,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__15__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1934,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__1__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1935,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__2__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1936,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__3__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1937,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__4__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1938,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__5__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1939,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__6__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1940,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__7__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1941,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__8__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1942,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk1__BRA__9__KET____DOT__matcher____pinNumber5));
    bufp->fullIData(oldp+1943,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc 
                                >> 2U)),32);
    bufp->fullBit(oldp+1944,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__0__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1945,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__10__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1946,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__11__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1947,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__12__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1948,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__13__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1949,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__14__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1950,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__15__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1951,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__1__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1952,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__2__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1953,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__3__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1954,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__4__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1955,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__5__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1956,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__6__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1957,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__7__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1958,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__8__KET____DOT__matcher____pinNumber5));
    bufp->fullBit(oldp+1959,(vlSymsp->TOP__top_core.CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT____Vcellout__genblk2__BRA__9__KET____DOT__matcher____pinNumber5));
    bufp->fullIData(oldp+1960,((0x7ffffffU & ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xbU] 
                                               << 0x1aU) 
                                              | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                 >> 6U)))),27);
    bufp->fullCData(oldp+1961,((3U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                      >> 4U))),2);
    bufp->fullBit(oldp+1962,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                    >> 3U))));
    bufp->fullCData(oldp+1963,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL),2);
    bufp->fullIData(oldp+1964,((vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc 
                                >> 5U)),27);
    bufp->fullCData(oldp+1965,((3U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc 
                                      >> 3U))),2);
    bufp->fullBit(oldp+1966,((1U & (vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc 
                                    >> 2U))));
    bufp->fullCData(oldp+1967,((3U & vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc)),2);
    bufp->fullCData(oldp+1968,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL),2);
    bufp->fullBit(oldp+1969,(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__fault_insn));
    bufp->fullBit(oldp+1970,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                    >> 0x12U))));
    bufp->fullBit(oldp+1971,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__illegal_insn));
    bufp->fullBit(oldp+1972,(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__prot_fault_l));
    bufp->fullBit(oldp+1973,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__mal_l));
    bufp->fullBit(oldp+1974,(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__prot_fault_s));
    bufp->fullBit(oldp+1975,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__mal_s));
    bufp->fullBit(oldp+1976,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 8U))));
    bufp->fullBit(oldp+1977,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 7U))));
    bufp->fullBit(oldp+1978,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 6U))));
    bufp->fullBit(oldp+1979,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 5U))));
    bufp->fullIData(oldp+1980,(((IData)((0U != (0x60000U 
                                                & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU])))
                                 ? ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[4U] 
                                     << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[3U] 
                                                  >> 1U))
                                 : ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xbU] 
                                     << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                  >> 1U)))),32);
    bufp->fullBit(oldp+1981,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__insert_pc));
    bufp->fullBit(oldp+1982,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__intr));
    bufp->fullBit(oldp+1983,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0xdU))));
    bufp->fullBit(oldp+1984,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0xcU))));
    bufp->fullBit(oldp+1985,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0xbU))));
    bufp->fullBit(oldp+1986,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 9U))));
    bufp->fullSData(oldp+1987,((0xfffU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                          >> 1U))),12);
    bufp->fullIData(oldp+1988,(((0x400U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU])
                                 ? (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                             >> 0x18U))
                                 : ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                     << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[9U] 
                                                  >> 1U)))),32);
    bufp->fullBit(oldp+1989,((0U != ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[8U] 
                                      << 0x1fU) | (
                                                   vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[7U] 
                                                   >> 1U)))));
    bufp->fullBit(oldp+1990,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0x12U))));
    bufp->fullBit(oldp+1991,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0x13U))));
    bufp->fullIData(oldp+1992,(((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xbU] 
                                 << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                              >> 1U))),32);
    bufp->fullBit(oldp+1993,(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__prot_fault_i));
    bufp->fullIData(oldp+1994,(vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__wdata),32);
    bufp->fullBit(oldp+1995,(vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__ren));
    bufp->fullBit(oldp+1996,(vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__wen));
    bufp->fullSData(oldp+1997,((0xffffU & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U])),16);
    bufp->fullBit(oldp+1998,((1U & (((IData)(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__insert_pc) 
                                     | ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                         >> 0x10U) 
                                        & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__fence_stall)))) 
                                    | (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__branch_jump)))));
    bufp->fullBit(oldp+1999,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[5U] 
                                    >> 3U))));
    bufp->fullBit(oldp+2000,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[5U] 
                                    >> 2U))));
    bufp->fullBit(oldp+2001,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[5U] 
                                    >> 1U))));
    bufp->fullBit(oldp+2002,((1U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[5U])));
    bufp->fullIData(oldp+2003,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[4U]),32);
    bufp->fullIData(oldp+2004,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[3U]),32);
    bufp->fullIData(oldp+2005,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]),32);
    bufp->fullIData(oldp+2006,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[1U]),32);
    bufp->fullIData(oldp+2007,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[0U]),32);
    bufp->fullBit(oldp+2008,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0x11U))));
    bufp->fullBit(oldp+2009,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0xfU))));
    bufp->fullBit(oldp+2010,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0x16U))));
    bufp->fullBit(oldp+2011,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__fence_stall));
    bufp->fullBit(oldp+2012,((1U & VL_REDXOR_32((0x300000U 
                                                 & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU])))));
    bufp->fullBit(oldp+2013,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[5U] 
                                    >> 3U))));
    bufp->fullBit(oldp+2014,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0x17U))));
    bufp->fullBit(oldp+2015,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0x10U))));
    bufp->fullBit(oldp+2016,((1U & ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                     >> 0x10U) & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__fence_stall))))));
    bufp->fullBit(oldp+2017,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                    >> 0x11U))));
    bufp->fullIData(oldp+2018,(((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                 << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xbU] 
                                              >> 1U))),32);
    bufp->fullBit(oldp+2019,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0x15U))));
    bufp->fullBit(oldp+2020,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0x14U))));
    bufp->fullBit(oldp+2021,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fw_if.__PVT__load));
    bufp->fullBit(oldp+2022,(((((0U != (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                 >> 0x13U))) 
                                & ((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                             >> 0xfU)) 
                                   == (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                >> 0x13U)))) 
                               & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                  >> 0x11U)) & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fw_if.__PVT__load)))));
    bufp->fullBit(oldp+2023,(((((0U != (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                 >> 0x13U))) 
                                & ((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                             >> 0x14U)) 
                                   == (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                >> 0x13U)))) 
                               & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                  >> 0x11U)) & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fw_if.__PVT__load)))));
    bufp->fullBit(oldp+2024,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0x17U))));
    bufp->fullBit(oldp+2025,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0x16U))));
    bufp->fullBit(oldp+2026,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0x15U))));
    bufp->fullBit(oldp+2027,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0x14U))));
    bufp->fullBit(oldp+2028,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0x13U))));
    bufp->fullBit(oldp+2029,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0x12U))));
    bufp->fullBit(oldp+2030,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0x11U))));
    bufp->fullBit(oldp+2031,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0x10U))));
    bufp->fullBit(oldp+2032,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0xfU))));
    bufp->fullBit(oldp+2033,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0xeU))));
    bufp->fullBit(oldp+2034,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0xdU))));
    bufp->fullBit(oldp+2035,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0xcU))));
    bufp->fullBit(oldp+2036,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0xbU))));
    bufp->fullBit(oldp+2037,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0xaU))));
    bufp->fullBit(oldp+2038,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 9U))));
    bufp->fullBit(oldp+2039,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 8U))));
    bufp->fullBit(oldp+2040,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 7U))));
    bufp->fullBit(oldp+2041,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 6U))));
    bufp->fullBit(oldp+2042,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 5U))));
    bufp->fullBit(oldp+2043,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 4U))));
    bufp->fullCData(oldp+2044,((7U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                      >> 1U))),3);
    bufp->fullCData(oldp+2045,((0xfU & ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                         << 3U) | (
                                                   vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                   >> 0x1dU)))),4);
    bufp->fullCData(oldp+2046,((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                         >> 0x18U))),5);
    bufp->fullCData(oldp+2047,((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                         >> 0x13U))),5);
    bufp->fullBit(oldp+2048,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                    >> 0x12U))));
    bufp->fullBit(oldp+2049,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                    >> 0x11U))));
    bufp->fullBit(oldp+2050,((1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                    >> 0x10U))));
    bufp->fullIData(oldp+2051,(((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                 << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[9U] 
                                              >> 1U))),32);
    bufp->fullIData(oldp+2052,(((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[6U] 
                                 << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[5U] 
                                              >> 1U))),32);
    bufp->fullIData(oldp+2053,(((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[5U] 
                                 << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[4U] 
                                              >> 1U))),32);
    bufp->fullIData(oldp+2054,(((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[4U] 
                                 << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[3U] 
                                              >> 1U))),32);
    bufp->fullCData(oldp+2055,((0x7fU & ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[3U] 
                                          << 6U) | 
                                         (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[2U] 
                                          >> 0x1aU)))),7);
    bufp->fullSData(oldp+2056,((0x1fffU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[2U] 
                                           >> 0xdU))),13);
    bufp->fullIData(oldp+2057,((0x1fffffU & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[1U])),21);
    bufp->fullBit(oldp+2058,(((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__invalid_csr_priv) 
                              | (IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__invalid_csr_addr))));
    bufp->fullBit(oldp+2059,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__env_u));
    bufp->fullBit(oldp+2060,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__env_m));
    bufp->fullBit(oldp+2061,((vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                              >> 0x1fU)));
    bufp->fullCData(oldp+2062,((0xffU & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                         >> 0x17U))),8);
    bufp->fullBit(oldp+2063,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                    >> 0x16U))));
    bufp->fullBit(oldp+2064,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                    >> 0x15U))));
    bufp->fullBit(oldp+2065,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                    >> 0x14U))));
    bufp->fullBit(oldp+2066,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                    >> 0x13U))));
    bufp->fullBit(oldp+2067,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                    >> 0x12U))));
    bufp->fullBit(oldp+2068,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                    >> 0x11U))));
    bufp->fullCData(oldp+2069,((3U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                      >> 0xfU))),2);
    bufp->fullCData(oldp+2070,((3U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                      >> 0xdU))),2);
    bufp->fullCData(oldp+2071,((3U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                      >> 0xbU))),2);
    bufp->fullCData(oldp+2072,((3U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                      >> 9U))),2);
    bufp->fullBit(oldp+2073,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                    >> 8U))));
    bufp->fullBit(oldp+2074,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                    >> 7U))));
    bufp->fullBit(oldp+2075,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                    >> 6U))));
    bufp->fullBit(oldp+2076,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                    >> 5U))));
    bufp->fullBit(oldp+2077,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                    >> 4U))));
    bufp->fullBit(oldp+2078,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                    >> 3U))));
    bufp->fullBit(oldp+2079,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                    >> 2U))));
    bufp->fullBit(oldp+2080,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                                    >> 1U))));
    bufp->fullBit(oldp+2081,((1U & vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus)));
    bufp->fullBit(oldp+2082,(((IData)(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__intr) 
                              | (IData)(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__mret))));
    bufp->fullBit(oldp+2083,((1U & ((((((((IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__mal_l) 
                                          | (IData)(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__prot_fault_l)) 
                                         | (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__mal_s)) 
                                        | (IData)(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__prot_fault_s)) 
                                       | (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__illegal_insn)) 
                                      | (IData)(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__fault_insn)) 
                                     | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                        >> 0x12U)) 
                                    | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 8U)))));
    bufp->fullBit(oldp+2084,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__mret));
    bufp->fullBit(oldp+2085,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__pma_s_fault));
    bufp->fullBit(oldp+2086,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__pma_l_fault));
    bufp->fullBit(oldp+2087,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__pma_i_fault));
    bufp->fullBit(oldp+2088,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__pmp_s_fault));
    bufp->fullBit(oldp+2089,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__pmp_l_fault));
    bufp->fullBit(oldp+2090,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__pmp_i_fault));
    bufp->fullBit(oldp+2091,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pma_if.__PVT__ack));
    bufp->fullIData(oldp+2092,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pma_if.__PVT__value_out),32);
    bufp->fullBit(oldp+2093,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pmp_if.__PVT__ack));
    bufp->fullIData(oldp+2094,(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pmp_if.__PVT__value_out),32);
    bufp->fullCData(oldp+2095,(vlSymsp->TOP__top_core.CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu__DOT___VdfgExtracted___h7d703271__0),4);
    bufp->fullSData(oldp+2096,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__imm_SB),13);
    bufp->fullBit(oldp+2097,((0x23U == (0x7fU & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))));
    bufp->fullBit(oldp+2098,((3U == (0x7fU & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))));
    bufp->fullBit(oldp+2099,((0x6fU == (0x7fU & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))));
    bufp->fullBit(oldp+2100,((0x63U == (0x7fU & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))));
    bufp->fullBit(oldp+2101,(((0x6fU == (0x7fU & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U])) 
                              | (0x67U == (0x7fU & 
                                           vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U])))));
    bufp->fullBit(oldp+2102,(((0x13U == (0x7fU & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U])) 
                              & ((1U == (7U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                               >> 0xcU))) 
                                 | (5U == (7U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                                 >> 0xcU)))))));
    bufp->fullBit(oldp+2103,((0x6fU == vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U])));
    bufp->fullBit(oldp+2104,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__wen));
    bufp->fullBit(oldp+2105,((IData)((0x100fU == (0x707fU 
                                                  & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U])))));
    bufp->fullCData(oldp+2106,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__alu_a_sel),2);
    bufp->fullCData(oldp+2107,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__alu_b_sel),2);
    bufp->fullCData(oldp+2108,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__w_sel),3);
    bufp->fullSData(oldp+2109,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__imm_S),12);
    bufp->fullIData(oldp+2110,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__imm_UJ),21);
    bufp->fullIData(oldp+2111,((0xfffff000U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U])),32);
    bufp->fullBit(oldp+2112,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__ret_insn));
    bufp->fullBit(oldp+2113,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__breakpoint));
    bufp->fullBit(oldp+2114,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__ecall_insn));
    bufp->fullBit(oldp+2115,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__csr_swap));
    bufp->fullBit(oldp+2116,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__csr_set));
    bufp->fullBit(oldp+2117,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__csr_clr));
    bufp->fullBit(oldp+2118,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__csr_imm));
    bufp->fullBit(oldp+2119,((((IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__csr_swap) 
                               | (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__csr_set)) 
                              | (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__csr_clr))));
    bufp->fullIData(oldp+2120,(((0x6fU == (0x7fU & 
                                           vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]))
                                 ? (((- (IData)((1U 
                                                 & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__imm_UJ 
                                                    >> 0x14U)))) 
                                     << 0x15U) | vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__PVT__imm_UJ)
                                 : vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__imm_I_ext)),32);
    bufp->fullBit(oldp+2121,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__enable_flush_count_nowb));
    bufp->fullCData(oldp+2122,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_last_used),2);
    bufp->fullBit(oldp+2123,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit));
    bufp->fullBit(oldp+2124,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__pass_through));
    bufp->fullIData(oldp+2125,((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_data)),32);
    bufp->fullIData(oldp+2126,((IData)((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_data 
                                        >> 0x20U))),32);
    bufp->fullCData(oldp+2127,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx),2);
    bufp->fullBit(oldp+2128,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[2U] 
                                    >> 0x1cU))));
    bufp->fullBit(oldp+2129,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[2U] 
                                    >> 0x1bU))));
    bufp->fullIData(oldp+2130,((0x7ffffffU & vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[2U])),27);
    bufp->fullIData(oldp+2131,(vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[0U]),32);
    bufp->fullIData(oldp+2132,(vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[1U]),32);
    bufp->fullBit(oldp+2133,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[5U] 
                                    >> 0x19U))));
    bufp->fullBit(oldp+2134,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[5U] 
                                    >> 0x18U))));
    bufp->fullIData(oldp+2135,((0x7ffffffU & ((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[5U] 
                                               << 3U) 
                                              | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[4U] 
                                                 >> 0x1dU)))),27);
    bufp->fullIData(oldp+2136,(((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[3U] 
                                 << 3U) | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[2U] 
                                           >> 0x1dU))),32);
    bufp->fullIData(oldp+2137,(((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[4U] 
                                 << 3U) | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[3U] 
                                           >> 0x1dU))),32);
    bufp->fullBit(oldp+2138,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[8U] 
                                    >> 0x16U))));
    bufp->fullBit(oldp+2139,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[8U] 
                                    >> 0x15U))));
    bufp->fullIData(oldp+2140,((0x7ffffffU & ((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[8U] 
                                               << 6U) 
                                              | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[7U] 
                                                 >> 0x1aU)))),27);
    bufp->fullIData(oldp+2141,(((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[6U] 
                                 << 6U) | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[5U] 
                                           >> 0x1aU))),32);
    bufp->fullIData(oldp+2142,(((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[7U] 
                                 << 6U) | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[6U] 
                                           >> 0x1aU))),32);
    bufp->fullBit(oldp+2143,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[0xbU] 
                                    >> 0x13U))));
    bufp->fullBit(oldp+2144,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[0xbU] 
                                    >> 0x12U))));
    bufp->fullIData(oldp+2145,((0x7ffffffU & ((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[0xbU] 
                                               << 9U) 
                                              | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[0xaU] 
                                                 >> 0x17U)))),27);
    bufp->fullIData(oldp+2146,(((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[9U] 
                                 << 9U) | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[8U] 
                                           >> 0x17U))),32);
    bufp->fullIData(oldp+2147,(((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[0xaU] 
                                 << 9U) | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[9U] 
                                           >> 0x17U))),32);
    bufp->fullWData(oldp+2148,(vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4),372);
    bufp->fullIData(oldp+2160,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__unnamedblk1__DOT__i),32);
    bufp->fullBit(oldp+2161,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__enable_flush_count_nowb));
    bufp->fullBit(oldp+2162,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__hit));
    bufp->fullBit(oldp+2163,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__pass_through));
    bufp->fullIData(oldp+2164,((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__hit_data)),32);
    bufp->fullIData(oldp+2165,((IData)((vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__hit_data 
                                        >> 0x20U))),32);
    bufp->fullCData(oldp+2166,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__hit_idx),2);
    bufp->fullBit(oldp+2167,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[2U] 
                                    >> 0x1cU))));
    bufp->fullBit(oldp+2168,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[2U] 
                                    >> 0x1bU))));
    bufp->fullIData(oldp+2169,((0x7ffffffU & vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[2U])),27);
    bufp->fullIData(oldp+2170,(vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[0U]),32);
    bufp->fullIData(oldp+2171,(vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[1U]),32);
    bufp->fullBit(oldp+2172,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[5U] 
                                    >> 0x19U))));
    bufp->fullBit(oldp+2173,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[5U] 
                                    >> 0x18U))));
    bufp->fullIData(oldp+2174,((0x7ffffffU & ((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[5U] 
                                               << 3U) 
                                              | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[4U] 
                                                 >> 0x1dU)))),27);
    bufp->fullIData(oldp+2175,(((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[3U] 
                                 << 3U) | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[2U] 
                                           >> 0x1dU))),32);
    bufp->fullIData(oldp+2176,(((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[4U] 
                                 << 3U) | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[3U] 
                                           >> 0x1dU))),32);
    bufp->fullBit(oldp+2177,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[8U] 
                                    >> 0x16U))));
    bufp->fullBit(oldp+2178,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[8U] 
                                    >> 0x15U))));
    bufp->fullIData(oldp+2179,((0x7ffffffU & ((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[8U] 
                                               << 6U) 
                                              | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[7U] 
                                                 >> 0x1aU)))),27);
    bufp->fullIData(oldp+2180,(((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[6U] 
                                 << 6U) | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[5U] 
                                           >> 0x1aU))),32);
    bufp->fullIData(oldp+2181,(((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[7U] 
                                 << 6U) | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[6U] 
                                           >> 0x1aU))),32);
    bufp->fullBit(oldp+2182,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[0xbU] 
                                    >> 0x13U))));
    bufp->fullBit(oldp+2183,((1U & (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[0xbU] 
                                    >> 0x12U))));
    bufp->fullIData(oldp+2184,((0x7ffffffU & ((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[0xbU] 
                                               << 9U) 
                                              | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[0xaU] 
                                                 >> 0x17U)))),27);
    bufp->fullIData(oldp+2185,(((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[9U] 
                                 << 9U) | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[8U] 
                                           >> 0x17U))),32);
    bufp->fullIData(oldp+2186,(((vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[0xaU] 
                                 << 9U) | (vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[9U] 
                                           >> 0x17U))),32);
    bufp->fullWData(oldp+2187,(vlSymsp->TOP__top_core.CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4),372);
    bufp->fullIData(oldp+2199,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__unnamedblk1__DOT__i),32);
    bufp->fullIData(oldp+2200,(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__addr),32);
    bufp->fullBit(oldp+2201,(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__ren));
    bufp->fullBit(oldp+2202,(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__wen));
    bufp->fullCData(oldp+2203,(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__byte_en),4);
    bufp->fullBit(oldp+2204,(vlSelf->CLK));
    bufp->fullBit(oldp+2205,(vlSelf->nRST));
    bufp->fullQData(oldp+2206,(vlSelf->mtime),64);
    bufp->fullBit(oldp+2208,(vlSelf->wfi));
    bufp->fullBit(oldp+2209,(vlSelf->halt));
    bufp->fullBit(oldp+2210,(vlSelf->busy));
    bufp->fullIData(oldp+2211,(vlSelf->rdata),32);
    bufp->fullBit(oldp+2212,(vlSelf->ren));
    bufp->fullBit(oldp+2213,(vlSelf->wen));
    bufp->fullCData(oldp+2214,(vlSelf->byte_en),4);
    bufp->fullIData(oldp+2215,(vlSelf->addr),32);
    bufp->fullIData(oldp+2216,(vlSelf->wdata),32);
    bufp->fullBit(oldp+2217,(vlSelf->ext_int));
    bufp->fullBit(oldp+2218,(vlSelf->ext_int_clear));
    bufp->fullBit(oldp+2219,(vlSelf->soft_int));
    bufp->fullBit(oldp+2220,(vlSelf->soft_int_clear));
    bufp->fullBit(oldp+2221,(vlSelf->timer_int));
    bufp->fullBit(oldp+2222,(vlSelf->timer_int_clear));
    bufp->fullIData(oldp+2223,(((0U == vlSymsp->TOP__top_core.__PVT__CORE__DOT__mc__DOT__current_state)
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
    bufp->fullIData(oldp+2224,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__int_ex_handler__DOT__int_src),31);
    bufp->fullBit(oldp+2225,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__int_ex_handler__DOT__interrupt));
    bufp->fullBit(oldp+2226,((((IData)(vlSelf->timer_int_clear) 
                               | (IData)(vlSelf->soft_int_clear)) 
                              | (IData)(vlSelf->ext_int_clear))));
    bufp->fullBit(oldp+2227,(((IData)(vlSymsp->TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__int_ex_handler__DOT__interrupt) 
                              | (((IData)(vlSelf->timer_int_clear) 
                                  | (IData)(vlSelf->soft_int_clear)) 
                                 | (IData)(vlSelf->ext_int_clear)))));
    bufp->fullIData(oldp+2228,(0x80000000U),32);
    bufp->fullBit(oldp+2229,(vlSymsp->TOP__top_core.wfi));
    bufp->fullBit(oldp+2230,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__g_generic_bus_if__DOT__bt__DOT__next_busy));
    bufp->fullBit(oldp+2231,(0U));
    bufp->fullIData(oldp+2232,(0U),32);
    bufp->fullBit(oldp+2233,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__mal_addr));
    bufp->fullCData(oldp+2234,(0U),3);
    bufp->fullCData(oldp+2235,(0U),5);
    bufp->fullIData(oldp+2236,(0x20U),32);
    bufp->fullBit(oldp+2237,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__fetch_busy));
    bufp->fullBit(oldp+2238,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__execute_busy));
    bufp->fullBit(oldp+2239,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__mem_busy));
    bufp->fullBit(oldp+2240,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__iflush_done_reg));
    bufp->fullBit(oldp+2241,(vlSymsp->TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__dflush_done_reg));
    bufp->fullIData(oldp+2242,(0U),32);
    bufp->fullIData(oldp+2243,(4U),32);
    bufp->fullCData(oldp+2244,(1U),2);
    bufp->fullCData(oldp+2245,(0U),4);
    bufp->fullIData(oldp+2246,(0x100100U),26);
    bufp->fullIData(oldp+2247,(0U),26);
    bufp->fullBit(oldp+2248,(0U));
    bufp->fullBit(oldp+2249,(0U));
    bufp->fullCData(oldp+2250,(0U),4);
    bufp->fullIData(oldp+2251,(0x400U),32);
    bufp->fullIData(oldp+2252,(2U),32);
    bufp->fullIData(oldp+2253,(4U),32);
    bufp->fullIData(oldp+2254,(0xf0000000U),32);
    bufp->fullBit(oldp+2255,(vlSymsp->TOP__top_core__CORE__DOT__cc_if.__PVT__dcache_clear));
    bufp->fullIData(oldp+2256,(0x80U),32);
    bufp->fullIData(oldp+2257,(0x20U),32);
    bufp->fullIData(oldp+2258,(0x10U),32);
    bufp->fullIData(oldp+2259,(1U),32);
    bufp->fullIData(oldp+2260,(0x1bU),32);
    bufp->fullIData(oldp+2261,(0x5dU),32);
    bufp->fullIData(oldp+2262,(0x174U),32);
    bufp->fullBit(oldp+2263,(1U));
    bufp->fullBit(oldp+2264,(vlSymsp->TOP__top_core__CORE__DOT__cc_if.__PVT__icache_clear));
    __Vtemp_h1a982929__0[0U] = 0x616b656eU;
    __Vtemp_h1a982929__0[1U] = 0x6f745f74U;
    __Vtemp_h1a982929__0[2U] = 0x6eU;
    bufp->fullWData(oldp+2265,(__Vtemp_h1a982929__0),72);
    bufp->fullQData(oldp+2268,(0x7365706172617465ULL),64);
    bufp->fullSData(oldp+2270,(0x6c31U),16);
    bufp->fullIData(oldp+2271,(0x626967U),24);
    __Vtemp_ha2760738__0[0U] = 0x735f6966U;
    __Vtemp_ha2760738__0[1U] = 0x635f6275U;
    __Vtemp_ha2760738__0[2U] = 0x6e657269U;
    __Vtemp_ha2760738__0[3U] = 0x6765U;
    bufp->fullWData(oldp+2272,(__Vtemp_ha2760738__0),112);
    bufp->fullQData(oldp+2276,(0x64697361626c6564ULL),64);
    bufp->fullIData(oldp+2278,(0x74727565U),32);
    bufp->fullQData(oldp+2279,(0x5256333249ULL),40);
    bufp->fullIData(oldp+2281,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__insn),32);
    bufp->fullBit(oldp+2282,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__req_reg_r));
    bufp->fullBit(oldp+2283,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__req_reg_w));
    bufp->fullCData(oldp+2284,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__rsel_s_0),5);
    bufp->fullCData(oldp+2285,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__rsel_s_1),5);
    bufp->fullCData(oldp+2286,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__rsel_d),5);
    bufp->fullIData(oldp+2287,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__rdata_s_0),32);
    bufp->fullIData(oldp+2288,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__rdata_s_1),32);
    bufp->fullBit(oldp+2289,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__reg_w));
    bufp->fullIData(oldp+2290,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__reg_wdata),32);
    bufp->fullBit(oldp+2291,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__req_br_j));
    bufp->fullBit(oldp+2292,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__branch_jump));
    bufp->fullIData(oldp+2293,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__br_j_addr),32);
    bufp->fullIData(oldp+2294,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__pc),32);
    bufp->fullBit(oldp+2295,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__req_mem));
    bufp->fullIData(oldp+2296,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__mem_addr),32);
    bufp->fullIData(oldp+2297,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__mem_store),32);
    bufp->fullIData(oldp+2298,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__mem_load),32);
    bufp->fullBit(oldp+2299,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__mem_ren));
    bufp->fullBit(oldp+2300,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__mem_wen));
    bufp->fullBit(oldp+2301,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__mem_busy));
    bufp->fullCData(oldp+2302,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__mem_byte_en),4);
    bufp->fullBit(oldp+2303,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__execute_stall));
    bufp->fullBit(oldp+2304,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__memory_stall));
    bufp->fullBit(oldp+2305,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__active_insn));
    bufp->fullBit(oldp+2306,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__ex_token));
    bufp->fullBit(oldp+2307,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__if_ex_enable));
    bufp->fullBit(oldp+2308,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__exception));
    bufp->fullBit(oldp+2309,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__ex_cause));
    bufp->fullBit(oldp+2310,(vlSymsp->TOP__top_core__CORE__DOT__rm_if.__PVT__risc_mgmt_start));
    bufp->fullBit(oldp+2311,((1U & vlSymsp->TOP__top_core__CORE__DOT__fetch_ex_if.__PVT__fetch_ex_reg[4U])));
    bufp->fullIData(oldp+2312,(vlSymsp->TOP__top_core__CORE__DOT__fetch_ex_if.__PVT__fetch_ex_reg[3U]),32);
    bufp->fullIData(oldp+2313,(vlSymsp->TOP__top_core__CORE__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U]),32);
    bufp->fullIData(oldp+2314,(vlSymsp->TOP__top_core__CORE__DOT__fetch_ex_if.__PVT__fetch_ex_reg[1U]),32);
    bufp->fullIData(oldp+2315,(vlSymsp->TOP__top_core__CORE__DOT__fetch_ex_if.__PVT__fetch_ex_reg[0U]),32);
    bufp->fullIData(oldp+2316,(vlSymsp->TOP__top_core__CORE__DOT__fetch_ex_if.__PVT__brj_addr),32);
    bufp->fullBit(oldp+2317,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__pc_en));
    bufp->fullBit(oldp+2318,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__npc_sel));
    bufp->fullBit(oldp+2319,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__i_mem_busy));
    bufp->fullBit(oldp+2320,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__d_mem_busy));
    bufp->fullBit(oldp+2321,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__dren));
    bufp->fullBit(oldp+2322,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__dwen));
    bufp->fullBit(oldp+2323,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__iren));
    bufp->fullBit(oldp+2324,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__ret));
    bufp->fullBit(oldp+2325,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__branch_taken));
    bufp->fullBit(oldp+2326,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__prediction));
    bufp->fullBit(oldp+2327,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__jump));
    bufp->fullBit(oldp+2328,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__branch));
    bufp->fullBit(oldp+2329,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__if_ex_stall));
    bufp->fullBit(oldp+2330,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__fence_stall));
    bufp->fullBit(oldp+2331,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__if_ex_flush));
    bufp->fullBit(oldp+2332,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__mispredict));
    bufp->fullBit(oldp+2333,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__halt));
    bufp->fullIData(oldp+2334,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__pc),32);
    bufp->fullBit(oldp+2335,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__fault_insn));
    bufp->fullBit(oldp+2336,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__mal_insn));
    bufp->fullBit(oldp+2337,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__illegal_insn));
    bufp->fullBit(oldp+2338,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__fault_l));
    bufp->fullBit(oldp+2339,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__mal_l));
    bufp->fullBit(oldp+2340,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__fault_s));
    bufp->fullBit(oldp+2341,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__mal_s));
    bufp->fullBit(oldp+2342,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__breakpoint));
    bufp->fullBit(oldp+2343,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__env));
    bufp->fullIData(oldp+2344,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__epc_f),32);
    bufp->fullIData(oldp+2345,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__epc_e),32);
    bufp->fullIData(oldp+2346,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__badaddr_f),32);
    bufp->fullIData(oldp+2347,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__badaddr_e),32);
    bufp->fullIData(oldp+2348,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__priv_pc),32);
    bufp->fullBit(oldp+2349,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__insert_priv_pc));
    bufp->fullBit(oldp+2350,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__token_ex));
    bufp->fullBit(oldp+2351,(vlSymsp->TOP__top_core__CORE__DOT__hazard_if.__PVT__rv32c_ready));
    bufp->fullBit(oldp+2352,(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__timer_int));
    bufp->fullBit(oldp+2353,(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__soft_int));
    bufp->fullBit(oldp+2354,(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__ext_int));
    bufp->fullIData(oldp+2355,(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__xtvec[0U]),32);
    bufp->fullIData(oldp+2356,(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__xtvec[1U]),32);
    bufp->fullIData(oldp+2357,(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__xtvec[2U]),32);
    bufp->fullIData(oldp+2358,(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__xtvec[3U]),32);
    bufp->fullIData(oldp+2359,(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__xepc_r[0U]),32);
    bufp->fullIData(oldp+2360,(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__xepc_r[1U]),32);
    bufp->fullIData(oldp+2361,(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__xepc_r[2U]),32);
    bufp->fullIData(oldp+2362,(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__xepc_r[3U]),32);
    bufp->fullCData(oldp+2363,(0U),2);
    bufp->fullCData(oldp+2364,(3U),3);
    bufp->fullCData(oldp+2365,(0xfU),4);
    bufp->fullIData(oldp+2366,(vlSymsp->TOP__top_core__CORE__DOT__sparce_if.__PVT__wb_data),32);
    bufp->fullIData(oldp+2367,(vlSymsp->TOP__top_core__CORE__DOT__sparce_if.__PVT__sasa_data),32);
    bufp->fullIData(oldp+2368,(vlSymsp->TOP__top_core__CORE__DOT__sparce_if.__PVT__sasa_addr),32);
    bufp->fullBit(oldp+2369,(vlSymsp->TOP__top_core__CORE__DOT__sparce_if.__PVT__wb_en));
    bufp->fullBit(oldp+2370,(vlSymsp->TOP__top_core__CORE__DOT__sparce_if.__PVT__sasa_wen));
    bufp->fullCData(oldp+2371,(vlSymsp->TOP__top_core__CORE__DOT__sparce_if.__PVT__rd),5);
    bufp->fullBit(oldp+2372,(vlSymsp->TOP__top_core__CORE__DOT__sparce_if.__PVT__if_ex_enable));
    bufp->fullBit(oldp+2373,(vlSymsp->TOP__top_core__CORE__DOT__rv32cif.__PVT__done_earlier_send));
    bufp->fullIData(oldp+2374,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__brj_addr),32);
    bufp->fullBit(oldp+2375,(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__token_ex));
    bufp->fullSData(oldp+2376,((vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mie 
                                >> 0x10U)),16);
    bufp->fullCData(oldp+2377,((0xfU & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mie 
                                        >> 0xcU))),4);
    bufp->fullBit(oldp+2378,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mie 
                                    >> 0xbU))));
    bufp->fullBit(oldp+2379,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mie 
                                    >> 0xaU))));
    bufp->fullBit(oldp+2380,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mie 
                                    >> 9U))));
    bufp->fullBit(oldp+2381,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mie 
                                    >> 8U))));
    bufp->fullBit(oldp+2382,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mie 
                                    >> 7U))));
    bufp->fullBit(oldp+2383,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mie 
                                    >> 6U))));
    bufp->fullBit(oldp+2384,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mie 
                                    >> 5U))));
    bufp->fullBit(oldp+2385,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mie 
                                    >> 4U))));
    bufp->fullBit(oldp+2386,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mie 
                                    >> 3U))));
    bufp->fullBit(oldp+2387,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mie 
                                    >> 2U))));
    bufp->fullBit(oldp+2388,((1U & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mie 
                                    >> 1U))));
    bufp->fullBit(oldp+2389,((1U & vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mie)));
    bufp->fullBit(oldp+2390,(0U));
    bufp->fullIData(oldp+2391,(7U),32);
    bufp->fullIData(oldp+2392,(3U),32);
    bufp->fullIData(oldp+2393,(1U),26);
    bufp->fullIData(oldp+2394,(2U),26);
    bufp->fullIData(oldp+2395,(4U),26);
    bufp->fullIData(oldp+2396,(8U),26);
    bufp->fullIData(oldp+2397,(0x10U),26);
    bufp->fullIData(oldp+2398,(0x20U),26);
    bufp->fullIData(oldp+2399,(0x40U),26);
    bufp->fullIData(oldp+2400,(0x80U),26);
    bufp->fullIData(oldp+2401,(0x100U),26);
    bufp->fullIData(oldp+2402,(0x200U),26);
    bufp->fullIData(oldp+2403,(0x400U),26);
    bufp->fullIData(oldp+2404,(0x800U),26);
    bufp->fullIData(oldp+2405,(0x1000U),26);
    bufp->fullIData(oldp+2406,(0x2000U),26);
    bufp->fullIData(oldp+2407,(0x4000U),26);
    bufp->fullIData(oldp+2408,(0x8000U),26);
    bufp->fullIData(oldp+2409,(0x10000U),26);
    bufp->fullIData(oldp+2410,(0x20000U),26);
    bufp->fullIData(oldp+2411,(0x40000U),26);
    bufp->fullIData(oldp+2412,(0x80000U),26);
    bufp->fullIData(oldp+2413,(0x100000U),26);
    bufp->fullIData(oldp+2414,(0x200000U),26);
    bufp->fullIData(oldp+2415,(0x400000U),26);
    bufp->fullIData(oldp+2416,(0x800000U),26);
    bufp->fullIData(oldp+2417,(0x1000000U),26);
    bufp->fullIData(oldp+2418,(0x2000000U),26);
    bufp->fullCData(oldp+2419,(0x33U),7);
    bufp->fullCData(oldp+2420,(1U),7);
}
