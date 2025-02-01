#include <iostream>
#include <iomanip>
#include <random>
#include <functional>
#include <bit>
#include <bitset>

#include "verilated.h"
#include "verilated_fst_c.h"
#include "Vrv32zc_handler.h"
#include "Vrv32zc_handler_rv32zc_pkg.h"

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

void tick(Vrv32zc_handler& dut, VerilatedFstC& trace) {
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
    std::cout << "Running " << num_cases << " cases." << std::endl;

    // RNG
    std::random_device dev;
    std::mt19937 rng(dev());
    std::uniform_int_distribution<std::mt19937::result_type> dist(0, UINT32_MAX);

    Vrv32zc_handler dut;
    VerilatedFstC m_trace;
    Verilated::traceEverOn(true);
    dut.trace(&m_trace, 5);

    // Test cases
    typedef uint32_t u32;

    struct test_vector_t {
        Vrv32zc_handler_rv32zc_pkg::rv32zc_op_t aluop;
        std::function<uint32_t(u32, u32)> eval;
    };

    static const test_vector_t ops[] = {
        {Vrv32zc_handler_rv32zc_pkg::EQZ, [](u32 a, u32 b) -> uint32_t { 
            return (b == 0) ? 0 : a; 
        }},
        {Vrv32zc_handler_rv32zc_pkg::NEZ, [](u32 a, u32 b) -> uint32_t { 
            return (b != 0) ? 0 : a; 
        }}
    };

    constexpr auto array_size = sizeof(ops) / sizeof(*ops);
    for (int i = 0; i < array_size; i++) { // SH{N}
        dut.aluop = ops[i].aluop;
        for (int j = 0; j < num_cases; j++) {
            uint32_t a = dist(rng);
            uint32_t b = dist(rng);
            uint32_t expected = ops[i].eval(a, b);
            dut.a = a;
            dut.b = b;
            tick(dut, m_trace);
            check(expected, dut.y, a, b);
        }
    }

    std::cout << std::dec << "Passed " << pass_count << " / " << test_count << " tests." << std::endl;

    return 0;
}
