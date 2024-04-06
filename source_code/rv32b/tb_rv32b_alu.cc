#include <iostream>
#include <iomanip>
#include <random>
#include <functional>
#include <bit>
#include <bitset>

#include "verilated.h"
#include "verilated_fst_c.h"
#include "Vrv32b_alu.h"
#include "Vrv32b_alu_rv32b_pkg.h"

#define DEFAULT_CASES 10000


uint64_t sim_time = 0;

uint64_t test_count = 0;
uint64_t pass_count = 0;

static inline void check(uint32_t expected, uint32_t actual, uint32_t a, uint32_t b) {
    test_count++;
    if(expected == actual) {
        pass_count++;
    } else {
        std::cout << std::dec << "FAIL " << test_count << " @ T=" << sim_time << std::hex 
            << " EXP: " << expected << " ACT: " << actual
            << "; A = " << a << " B = " << b << std::endl;
        
    }
}

void tick(Vrv32b_alu& dut, VerilatedFstC& trace) {
    dut.eval(); 
    trace.dump(sim_time++);
    dut.eval();
    trace.dump(sim_time++);
}


int main(int argc, char **argv) {

    long num_cases = DEFAULT_CASES;
    if(argc == 2) {
        num_cases = atol(argv[1]);
    }
    std::cout << "Running " << num_cases << "cases." << std::endl;

    // RNG
    std::random_device dev;
    std::mt19937 rng(dev());
    std::uniform_int_distribution<std::mt19937::result_type> dist(0, UINT32_MAX);

    Vrv32b_alu dut;
    VerilatedFstC m_trace;
    Verilated::traceEverOn(true);
    dut.trace(&m_trace, 5);

    // Test cases
    typedef uint32_t u32;

    struct test_vector_t {
        Vrv32b_alu_rv32b_pkg::rv32b_op_t aluop;
        std::function<uint32_t(u32, u32)> eval;
    };

    static const test_vector_t ops[] = {
        {Vrv32b_alu_rv32b_pkg::SH1ADD, [](u32 a, u32 b) { return (a << 1) + b; }},
        {Vrv32b_alu_rv32b_pkg::SH2ADD, [](u32 a, u32 b) { return (a << 2) + b; }},
        {Vrv32b_alu_rv32b_pkg::SH3ADD, [](u32 a, u32 b) { return (a << 3) + b; }},
        {Vrv32b_alu_rv32b_pkg::ANDN,   [](u32 a, u32 b) { return a & (~b); }},
        {Vrv32b_alu_rv32b_pkg::ORN,    [](u32 a, u32 b) { return a | (~b); }},
        {Vrv32b_alu_rv32b_pkg::XNOR,   [](u32 a, u32 b) { return ~(a ^ b); }},
        {Vrv32b_alu_rv32b_pkg::CLZ,    [](u32 a, u32 b) { return std::countl_zero(a); }},
        {Vrv32b_alu_rv32b_pkg::CTZ,    [](u32 a, u32 b) { return std::countr_zero(a); }},
        {Vrv32b_alu_rv32b_pkg::CPOP,   [](u32 a, u32 b) { return std::popcount(a); }},
        {Vrv32b_alu_rv32b_pkg::MAX,    [](u32 a, u32 b) { return std::max(std::bit_cast<int32_t>(a), std::bit_cast<int32_t>(b)); }},
        {Vrv32b_alu_rv32b_pkg::MAXU,   [](u32 a, u32 b) { return std::max(a, b); }},
        {Vrv32b_alu_rv32b_pkg::MIN,    [](u32 a, u32 b) { return std::min(std::bit_cast<int32_t>(a), std::bit_cast<int32_t>(b)); }},
        {Vrv32b_alu_rv32b_pkg::MINU,   [](u32 a, u32 b) { return std::min(a, b); }},
        {Vrv32b_alu_rv32b_pkg::SEXTB,  [](u32 a, u32 b) { return std::bit_cast<u32>(((std::bit_cast<int32_t>(a) << 24) >> 24)); }},
        {Vrv32b_alu_rv32b_pkg::SEXTH,  [](u32 a, u32 b) { return std::bit_cast<u32>(((std::bit_cast<int32_t>(a) << 16) >> 16)); }},
        {Vrv32b_alu_rv32b_pkg::ZEXTH,  [](u32 a, u32 b) { return ((a << 16) >> 16); }},
        {Vrv32b_alu_rv32b_pkg::ROL,    [](u32 a, u32 b) { return std::rotl(a, (b & 0x1F)); }},
        {Vrv32b_alu_rv32b_pkg::ROR,    [](u32 a, u32 b) { return std::rotr(a, (b & 0x1F)); }},
        {Vrv32b_alu_rv32b_pkg::ORC,    [](u32 a, u32 b) {
            u32 out = 0;
            for(auto i = 0; i < 4; i++) {
                u32 temp = a & (0xFF << (i*8));
                if(temp != 0) {
                    temp = (0xFF << (i*8));
                }
                out |= temp;
            }

            return out;
        }},
        {Vrv32b_alu_rv32b_pkg::REV8,   [](u32 a, u32 b) { return __builtin_bswap32(a); }},
        {Vrv32b_alu_rv32b_pkg::BCLR,   [](u32 a, u32 b) { 
            std::bitset<32> bs = a;
            bs[b & 0x1F] = 0;
            return bs.to_ulong();
        }},
        {Vrv32b_alu_rv32b_pkg::BSET,   [](u32 a, u32 b) { 
            std::bitset<32> bs = a;
            bs[b & 0x1F] = 1;
            return bs.to_ulong();
        }},
        {Vrv32b_alu_rv32b_pkg::BINV,   [](u32 a, u32 b) { 
            std::bitset<32> bs = a;
            bs[b & 0x1F] = ~bs[b & 0x1F];
            return bs.to_ulong();
        }},
        {Vrv32b_alu_rv32b_pkg::BEXT,   [](u32 a, u32 b) { 
            // std::bitset<32> bs = a;
            // return bs[b & 0x1F]; This doesn't work?
            return (a >> (b & 0x1F)) & 0x1;
        }}
    };

    constexpr auto array_size = sizeof(ops) / sizeof(*ops);
    for(int i = 0; i < array_size; i++) { // SH{N}
        dut.aluop = ops[i].aluop;
        for(int j = 0; j < num_cases; j++) {
            uint32_t a = dist(rng);
            uint32_t b = dist(rng);
            uint32_t expected = ops[i].eval(a, b);
            dut.a = a;
            dut.b = b;
            tick(dut, m_trace);
            check(expected, dut.y, a, b);
        }
    }

    // 

    std::cout << std::dec << "Passed " << pass_count << " / " << test_count << " tests." << std::endl;

    return 0;
}