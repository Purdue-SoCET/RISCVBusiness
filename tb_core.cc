#include <iostream>
#include <iomanip>
#include <chrono>
#include <cstdio>
#include <fstream>
#include <sstream>
#include <map>
#include <csignal>

#include "verilated.h"
#include "verilated_fst_c.h"
#include "Vtop_core.h"
#include "Vtop_core_top_core.h"

#define BASE_SIM_TIME    500000

#define MTIME_ADDR      0xFFFFFFE0
#define MTIMEH_ADDR     0xFFFFFFE4
#define MTIMECMP_ADDR   0xFFFFFFE8
#define MTIMECMPH_ADDR  0xFFFFFFEC
#define MSIP_ADDR       0xFFFFFFF0
#define EXT_ADDR_SET    0xFFFFFFF4
#define EXT_ADDR_CLEAR  0xFFFFFFF8
#define MAGIC_ADDR      0xFFFFFFFC
#define FROMHOST_ADDR   0x80001040 // TODO(anyone): determine if this needs to be a parameter?
#define BUS_ERROR_TOP   0x20000000

// Inclusive range of memory-mapped peripherals
#define MMIO_RANGE_BEGIN (MTIME_ADDR)
#define MMIO_RANGE_END   (MAGIC_ADDR)

#define FROMHOST_OFFSET 0x40

// doubles as mtime counter
vluint64_t sim_time = 0;
Vtop_core *dut_ptr;
VerilatedFstC *trace_ptr;
bool use_tohost = false;
uint32_t tohost_address = 0;
uint64_t max_sim_time = BASE_SIM_TIME;
bool tohost_break = false;
bool debug_test = false;
bool require_trace = true;

uint32_t num_harts = 1;
bool use_tohost_multi = false;
uint32_t tohost_written_mask = 0;
uint32_t tohost_stride = 8;
std::vector<uint32_t> tohost_values;
char extension;

/*
 *  Emulate memory-mapped CSRs
 */
uint64_t mtimecmp = 0;
uint32_t msip = 0;

// Interrupt signals
bool ext_int = false;

void signal_handler(int signum) {
    std::cout << "Got signal " << signum << std::endl;
    dut_ptr->final();
    trace_ptr->close();
    exit(1);
}

class MemoryMap {
private:

    // NOTE: Assuming 0 for uninitialized memory
    // This is because bare-metal tests may not set up bss,
    // but the program will nonetheless have a bss section.
    const uint32_t c_default_value = 0x00000000;
    const char *dumpfile = "memsim.dump";
    std::map<uint32_t, uint32_t> mmap;

protected:
    inline uint32_t expand_mask(uint8_t mask) {
        uint32_t acc = 0;
        for(int i = 0; i < 4; i++) {
            auto bit = ((mask & (1 << i)) != 0);
            if(bit) {
                acc |= (0xFF << (i * 8));
            }
        }

        return acc;
    }

public:

    MemoryMap(const char *fname) {
        uint32_t address = 0x80000000;
        std::ifstream myFile(fname, std::ios::in | std::ios::binary);
        if(!myFile) {
            std::ostringstream ss;
            ss << "Couldn't open " << fname << std::endl;
            throw ss.str();
        }

        while(!myFile.eof()) {
            uint32_t data;
            myFile.read((char *)&data, sizeof(data));

            mmap.insert(std::make_pair(address, data));

            address += 4;
        }
    }

    uint32_t mmio_read(uint32_t addr) {
        uint32_t value = 0xBAD1BAD1;
        switch(addr) {
            case MTIME_ADDR:        value = (uint32_t)(sim_time & 0xFFFFFFFF);
                                    break;
            case MTIMEH_ADDR:       value = (uint32_t)(sim_time >> 32);
                                    break;
            case MTIMECMP_ADDR:     value = (uint32_t)(mtimecmp & 0xFFFFFFFF);
                                    break;
            case MTIMECMPH_ADDR:    value = (uint32_t)(mtimecmp >> 32);
                                    break;
            case MSIP_ADDR:         value = msip;
                                    break;
            case EXT_ADDR_SET:      value = ext_int; // Marker value for peripheral memory
                                    break;
            case EXT_ADDR_CLEAR:    value = 0; // Clear 'register' doesn't return a value
                                    break;
            case MAGIC_ADDR:        value = 0; // TODO: Should this be able to take stdin inputs? Any use?
                                    break;
            default: std::cout << "Warning: read of empty MMIO region @ " << std::hex << addr << std::dec << std::endl;
        };


        return value;
    }

    inline static bool is_mmio_region(uint32_t addr) {
        return (addr >= MMIO_RANGE_BEGIN && addr <= MMIO_RANGE_END);
    }

    void mmio_write(uint32_t addr, uint32_t value, uint8_t mask) {
        auto mask_exp = expand_mask(mask);

        if(addr == MTIMECMP_ADDR) {
            uint32_t mtimecmp_l = (uint32_t)(mtimecmp & 0xFFFFFFFF);
            mtimecmp_l = (value & mask_exp) | (mtimecmp_l & ~mask_exp);
            mtimecmp = (mtimecmp & 0xFFFFFFFF00000000) | ((uint64_t)mtimecmp_l);
        } else if(addr == MTIMECMPH_ADDR) {
            uint32_t mtimecmp_h = (uint32_t)(mtimecmp >> 32);
            mtimecmp_h = (value & mask_exp) | (mtimecmp_h & ~mask_exp);
            mtimecmp = (mtimecmp & 0xFFFFFFFF) | (((uint64_t)mtimecmp_h) << 32);
        } else if(addr == MSIP_ADDR) {
            msip = value;
        } else if(addr == EXT_ADDR_SET) {
            ext_int = true;
        } else if(addr == EXT_ADDR_CLEAR) {
            ext_int = false;
        } else if(addr == MAGIC_ADDR) {
            std::cout << (char)(value & 0xFF);
        } else {
            std::cout << "Warning: write to read-only MMIO region @ " << std::hex << addr << std::dec << std::endl;
        }
    }

    // TODO: Add simulation for SWI/mtime?
    uint32_t read(uint32_t addr) {
        // Used by riscv-tests benchmarks in system calls.
        // Only found call to FROMHOST_ADDR checks to see if
        // the host writes a non-zero value.
        // If different functionality is needed, this is
        // the place to do it.
        // if (addr == FROMHOST_ADDR) {
        //     return 1;
        // }

        auto it = mmap.find(addr);
        if(it != mmap.end()) {
            return it->second;
        } else {
            return c_default_value;
        }
    }

    void write(uint32_t addr, uint32_t value, uint8_t mask) {

        // NOTE: For now, assuming that all memory is legally acessible.
        auto it = mmap.find(addr);
        if(it != mmap.end()) {
            auto mask_exp = expand_mask(mask);
            it->second = (value & mask_exp) | (it->second & ~mask_exp);
        } else {
            mmap.insert(std::make_pair(addr, value));
        }

        if(use_tohost && addr == tohost_address) {
            if (debug_test)
                std::cout << static_cast<char>(value);
            else
                tohost_break = true;
        }

        if(use_tohost_multi) {
            if(tohost_address <= addr <= tohost_address + FROMHOST_OFFSET && (addr - tohost_address) % tohost_stride == 0) {
                uint32_t idx = (addr - tohost_address) / tohost_stride;
                if(idx < num_harts) {
                    tohost_values[idx] = value;
                    tohost_written_mask |= (1 << idx);

                    if(debug_test) {
                        std::cout << "[tohost index " << idx << "] value:" << value << "\n"; 
                    }

                    if(tohost_written_mask == (1 << num_harts) - 1) {
                        tohost_break = true;
                    }
                }
            }
        }
    }

    void dump() {
        std::ofstream outfile;
        outfile.open(dumpfile);
        if(!outfile) {
            std::ostringstream ss;
            ss << "Couldn't open " << dumpfile << std::endl;
            throw ss.str();
        }

        // Account for endianness
        for(auto p : mmap) {
            if(p.second != 0) {
                char buf[80];
                snprintf(buf, 80, "%08x : %02x%02x%02x%02x", p.first,
                        (p.second & 0xFF000000) >> 24,
                        (p.second & 0x00FF0000) >> 16,
                        (p.second & 0x0000FF00) >> 8,
                        p.second & 0x000000FF);
                outfile << buf << std::endl;
            }
        }
    }
};

void update_interrupt_signals(Vtop_core& dut) {
    if(msip) {
        dut.soft_int = msip;
    } else if(dut.soft_int) {
        dut.soft_int = 0;
        dut.soft_int_clear = 1;
    } else if(dut.soft_int_clear) {
        dut.soft_int_clear = 0;
    }

    if(mtimecmp <= sim_time) {
        dut.timer_int = 1;
    } else if(dut.timer_int) {
        dut.timer_int = 0;
        dut.timer_int_clear = 1;
    } else if(dut.timer_int_clear) {
        dut.timer_int_clear = 0;
    }

    if(ext_int) {
        dut.ext_int = 1;
    } else if(dut.ext_int) {
        dut.ext_int = 0;
        dut.ext_int_clear = 1;
    } else if(dut.ext_int_clear) {
        dut.ext_int_clear = 0;
    }
}

void tick(Vtop_core& dut, VerilatedFstC& trace) {
    dut.CLK = 0;
    dut.eval();
    trace.dump(sim_time);
    sim_time++;
    dut.CLK = 1;
    dut.eval();
    trace.dump(sim_time);
    sim_time++;
}

void reset(Vtop_core& dut, VerilatedFstC& trace) {
    // Initialize signals
    dut.CLK = 0;
    dut.nRST = 0;
    dut.ext_int = 0;
    dut.ext_int_clear = 0;
    dut.soft_int = 0;
    dut.soft_int_clear = 0;
    dut.timer_int = 0;
    dut.timer_int_clear = 0;
    dut.busy = 1;
    dut.rdata = 0;
    dut.mtime = 0;

    tick(dut, trace);
    dut.nRST = 0;
    tick(dut, trace);
    dut.nRST = 1;
    tick(dut, trace);
}

void print_help() {
    std::cout << "Usage: ./Vtop_core [--tohost-address <unsigned int> --max-sim-time <unsigned long> --debug --notrace] <filename>" << std::endl;
    std::cout << "\t--help   : Print this" << std::endl;
    std::cout << "\t--tohost-address <address>: address for tohost checking functionality. A write to this address will end the program if --debug is not set." << std::endl;
    std::cout << "\t--max-sim-time <sim-time> : Maximum time to run simulation. Defaults to 100,000." << std::endl;
    std::cout << "\t--debug  : Allows debug strings to print from cores. Changes tohost-address functionality" << std::endl;
    std::cout << "\t--notrace: Indicate to not generate a waveform file. Speeds up simulation incredibly." << std::endl;
    std::cout << "\t--num-harts : Number of cores for multicore test. Defaults to 1." << std::endl;
    std::cout << "\t--extension : RISC-V extension required for the core to run the test. Running pm env tests require this flag to run correctly." << std::endl;
    std::cout << "\tfilename : An executable .bin file to run" << std::endl;
}


int main(int argc, char **argv) {

    const char *fname = "meminit.bin";

    int i = 0;
    while(i < argc) {
        if(strcmp(argv[i], "--tohost-address") == 0) {
            use_tohost = true;
            if(i+1 < argc) {
                try {
                    tohost_address = std::stoul(argv[i+1], nullptr, 0);
                } catch (const std::exception& e) {
                    std::cerr << "Could not convert " << argv[i+1] << " to U32" << std::endl;
                    return 1;
                }

                i += 1;
            } else {
                std::cerr << "Not enough args: " << argv[i] << std::endl;
                print_help();
            }
        } else if(strcmp(argv[i], "--max-sim-time") == 0) {
            if(i+1 < argc) {
                try {
                    max_sim_time = std::stoul(argv[i+1], nullptr, 0);
                } catch (const std::exception& e) {
                    std::cerr << "Could not convert " << argv[i+1] << " to U64" << std::endl;
                    return 1;
                }

                i += 1;
            } else {
                std::cerr << "Not enough args: " << argv[i] << std::endl;
                print_help();
            }
        } else if(strcmp(argv[i], "--help") == 0) {
            print_help();
            return 1;
        } else if(strcmp(argv[i], "--debug") == 0) {
            debug_test = true;
        } else if(strcmp(argv[i], "--notrace") == 0) {
            require_trace = false;
        } else if(strcmp(argv[i], "--num-harts") == 0) {
            if(i+1 < argc) {
                try {
                    num_harts = std::stoul(argv[i+1], nullptr, 0);
                    if(num_harts > 1) {
                        use_tohost_multi = true;
                        use_tohost = false;
                        tohost_values.assign(num_harts, 0);
                    }
                } catch (const std::exception& e) {
                    std::cerr << "Could not convert " << argv[i+1] << " to U32" << std::endl;
                    return 1;
                }
                i += 1;
            } else {
                std::cerr << "Not enough args: " << argv[i] << std::endl;
                print_help();
            }
        } else if(strcmp(argv[i], "--extension") == 0) {
            if(i+1 < argc) {
                std::string ext_str = argv[i + 1];
                if (ext_str.size() != 1) {
                    std::cerr << "Extension must be a single character\n";
                    return 1;
                }
                extension = ext_str[0];
                i+=1;
            } else {
                std::cerr << "Not enough args: " << argv[i] << std::endl;
                print_help();
            }
        } else {
            fname = argv[i];
        }

        i += 1;
    }

    std::cout << "Filename: " << fname << std::endl;
    std::cout << "tohost: " << use_tohost << " addr: " << tohost_address << std::endl;

    MemoryMap memory(fname);

    Vtop_core dut;

    VerilatedFstC m_trace;

    if (require_trace) {
        Verilated::traceEverOn(true);
        dut.trace(&m_trace, 5);
        m_trace.open("waveform.fst");
    }

    mtimecmp = 0xFFFFFFFFFFFFFFFF; // Default to a massive value

    if(num_harts > 1) {
        // write to memory about required extension info
        memory.write(tohost_address + 64, 1 << (extension - 'A'), 0xFF);
    }

    dut_ptr = &dut;
    trace_ptr = &m_trace;

    signal(SIGINT, signal_handler);

    auto tstart = std::chrono::high_resolution_clock::now();

    reset(dut, m_trace);
    while(!dut.halt && !tohost_break && sim_time < max_sim_time) {
        dut.error = 0;
        // TODO: Variable latency
        if((dut.ren || dut.wen) && dut.busy) {
            dut.busy = 0;
            if(dut.ren) {
                uint32_t addr = dut.addr & 0xFFFFFFFC;
                if(addr < BUS_ERROR_TOP) {
                    dut.error = 1;
                }else if(!MemoryMap::is_mmio_region(addr)) {
                    dut.rdata = memory.read(addr);
                } else {
                    dut.rdata = memory.mmio_read(addr);
                }
            } else if(dut.wen) {
                uint32_t addr = dut.addr & 0xFFFFFFFC;
                uint32_t value = dut.wdata;
                uint8_t mask = dut.byte_en;
                if(addr < BUS_ERROR_TOP) {
                    dut.error = 1;
                } else if(!MemoryMap::is_mmio_region(addr)) {
                    memory.write(addr, value, mask);
                } else {
                    memory.mmio_write(addr, value, mask);
                }
            }
        } else if(!dut.busy) {
            dut.busy = 1;
        }

        dut.mtime = sim_time;

        tick(dut, m_trace);
        update_interrupt_signals(dut);
    }

    if(sim_time >= max_sim_time) {
        std::cout << "Test TIMED OUT" << std::endl;
        if(use_tohost_multi) {
            for(uint32_t i = 0; i < num_harts; i++) {
                if(tohost_values[i] == 1) {
                    std::cout << "core " << i << " passed" << std::endl;
                }
                else if (tohost_values[i] == 2) {
                    std::cout << "core " << i << " skipped" << std::endl;
                }
                else {
                    std::cout << "core " << i  << " failed test: " << (tohost_values[i]) << std::endl;
                }
            }
        }
    } else if(use_tohost_multi) {
        bool tests_passed = true;
        bool tests_skipped = true;
        for(uint32_t i = 0; i < num_harts; i++) {
            if((tohost_written_mask  & (1 << i)) == 0) {
                tests_passed = false;
                std::cout << "Hart " << i << " missing result\n";
            }
            if(tohost_values[i] != 2) {
                tests_skipped = false;
                if(tohost_values[i] != 1) {
                    tests_passed = false;
                }
            }
        }
        
        if(tests_skipped) {
            std::cout << "Test SKIPPED" << std::endl;
        }
        else if(tests_passed) {
            std::cout << "Test PASSED" << std::endl;
        }
        else {
            std::cout << "Test FAILED" << std::endl;
        }

        for(uint32_t i = 0; i < num_harts; i++) {
            if(tohost_values[i] == 1) {
                std::cout << "core " << i << " passed" << std::endl;
            }
            else if (tohost_values[i] == 2) {
                std::cout << "core " << i << " skipped" << std::endl;
            }
            else {
                std::cout << "core " << i  << " failed test: " << (tohost_values[i] >> 1) << std::endl;
            }
        }
    } else if(use_tohost && memory.read(tohost_address) == 1 || !use_tohost && dut.top_core->get_x28() == 1) {
        std::cout << "Test PASSED" << std::endl;
    } else if(use_tohost) {
        std::cout << "Test FAILED: Test " << memory.read(tohost_address) << std::endl;
    } else {
        std::cout << "Test FAILED: Test " << dut.top_core->get_x28() << std::endl;
    }

    auto tend = std::chrono::high_resolution_clock::now();

    auto ms = std::chrono::duration_cast<std::chrono::milliseconds>(tend - tstart);

    std::cout << "Simulated " << sim_time << " cycles in " << ms.count() << "ms" << ", rate of " << (float)sim_time / ((float)ms.count() / 1000.0) << " cycles per second." << std::endl;

    if (require_trace)
        m_trace.close();
    memory.dump();
    dut.final();

    return 0;
}
