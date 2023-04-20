#include <iostream>
#include <iomanip>
#include <cstdio>
#include <fstream>
#include <sstream>
#include <map>
#include <csignal>
#include <vector>

#include "verilated.h"
#include "verilated_fst_c.h"
#include "Vtop_core.h"
#include "Vtop_core_top_core.h"

#define MTIME_ADDR      0xFFFFFFE0
#define MTIMEH_ADDR     0xFFFFFFE4
#define MTIMECMP_ADDR   0xFFFFFFE8
#define MTIMECMPH_ADDR  0xFFFFFFEC
#define MSIP_ADDR       0xFFFFFFF0
#define EXT_ADDR_SET    0xFFFFFFF4
#define EXT_ADDR_CLEAR  0xFFFFFFF8
#define MAGIC_ADDR      0xFFFFFFFC

// Inclusive range of memory-mapped peripherals
#define MMIO_RANGE_BEGIN (MTIME_ADDR)
#define MMIO_RANGE_END   (MAGIC_ADDR)

// Define a struct to hold instruction data
struct Instruction {
    uint32_t pc;
    uint32_t instruction;
    std::vector<uint32_t> registers;
};

// doubles as mtime counter
vluint64_t sim_time = 0;
Vtop_core *dut_ptr;
VerilatedFstC *trace_ptr;

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
    if(msip & 0x1) {
        dut.soft_int = 1;
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

std::vector<uint32_t> get_all_register_values(Vtop_core& dut, int num_registers) {
    std::vector<uint32_t> registers;
    for (int i = 0; i < num_registers; i++) {
      registers.push_back(dut.top_core->get_register_value(i)); // read the value of the register at address i
    //   std::cout << "Reg  " << i << ":"<< (uint32_t)dut.top_core->get_register_value(i) << std::endl;
    }
    return registers;
}

// Function to convert instruction data to CSV string
std::string instructionToCsv(const Instruction& inst) {
    std::string csv_string = std::to_string(inst.pc) + ",";
    csv_string += "\"" + std::to_string(inst.instruction) + "\",";
    for (int i = 0; i < 32; i++) {
        csv_string += std::to_string(inst.registers[i]) + ",";
    }
    // Remove the trailing comma
    csv_string.pop_back();
    return csv_string;
}

// Function to output instruction data to CSV file
void outputInstructionsToCsv(const std::vector<Instruction>& instructions, const std::string& filename) {
    std::ofstream output_file(filename);
    if (output_file.is_open()) {
        // Output CSV header row
        output_file << "PC,Instruction";
        for (int i = 0; i < 32; i++) {
          output_file << ",Reg" << i;
        }
        output_file << "\n";
        // Output instruction data
        for (const auto& inst : instructions) {
            output_file << instructionToCsv(inst) << "\n";
        }
        output_file.close();
    }
}

int main(int argc, char **argv) {

    std::vector<Instruction> instructions;
    const char *fname; 
    if(argc < 3) {
        std::cout << "Warning: No bin file name provided, assuming './meminit.bin' as file location!" << std::endl;
        fname = "meminit.bin";
    } else {
        fname = argv[1];
    }

    MemoryMap memory(fname);
    uint32_t tohost_addr = strtoul(argv[2], NULL, 16);
    Vtop_core dut;

    Verilated::traceEverOn(true);
    VerilatedFstC m_trace;
    dut.trace(&m_trace, 5);
    m_trace.open("waveform.fst");

    mtimecmp = 0xFFFFFFFFFFFFFFFF; // Default to a massive value


    dut_ptr = &dut;
    trace_ptr = &m_trace;

    signal(SIGINT, signal_handler);


    reset(dut, m_trace);
    while(!dut.halt && sim_time < 1000000000) {
        // TODO: Variable latency
        if(!MemoryMap::is_mmio_region(tohost_addr)) {
                    if(memory.read(tohost_addr)) {
                        break;
                    }
                } else {
                    if(memory.mmio_read(tohost_addr)) {
                        break;
                    }
                }
        if((dut.ren || dut.wen) && dut.busy) {
            dut.busy = 0;
            if(dut.ren) {
                uint32_t addr = dut.addr & 0xFFFFFFFC;
                if(!MemoryMap::is_mmio_region(addr)) {
                    dut.rdata = memory.read(addr);
                } else {
                    dut.rdata = memory.mmio_read(addr);
                }
            } else if(dut.wen) {
                uint32_t addr = dut.addr & 0xFFFFFFFC;
                uint32_t value = dut.wdata;
                uint8_t mask = dut.byte_en;
                if(!MemoryMap::is_mmio_region(addr)) {
                    memory.write(addr, value, mask);
                } else {
                    memory.mmio_write(addr, value, mask);
                }
            }
        } else if(!dut.busy) {
            dut.busy = 1;
        }

        if(!dut.top_core->get_wb_stall() && dut.top_core->get_instr() !=0) {
            // std::cout << "The pc is " << (uint32_t)dut.top_core->get_pc() << std::endl;
            // std::cout << "The instr is " << (uint32_t)dut.top_core->get_instr() << std::endl;
            instructions.push_back({(uint32_t)dut.top_core->get_pc(), (uint32_t)dut.top_core->get_instr(), get_all_register_values(dut, 32)});
        } 
        // else {
        //     std::cout << "not hit" << std::endl;
        //     // std::cout << "The pchit is " << (int)dut.pc_hit << std::endl;
        // }
        dut.mtime = sim_time;

        tick(dut, m_trace);
        update_interrupt_signals(dut);
    }

    int index = 3;
    int registers[32];
    if(sim_time >= 100000000) {
        std::cout << "Test TIMED OUT" << std::endl;
        m_trace.close();
        memory.dump();
        dut.final();
        exit(1);
    } else if(dut.top_core->get_register_value(index) == 1) {
        std::cout << "Test PASSED" << std::endl;
        
        // get_all_register_values(dut, registers, 32);
        // print_registers(registers, 32);
        outputInstructionsToCsv(instructions, "instructions.csv");
        m_trace.close();
        memory.dump();
        dut.final();
        exit(0);
    } else {
        std::cout << "Test FAILED: Test " << dut.top_core->get_x03() << std::endl;
        m_trace.close();
        memory.dump();
        dut.final();
        exit(1);
    }

}
