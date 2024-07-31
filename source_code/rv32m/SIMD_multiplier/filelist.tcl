set listofdirs {}
set_db init_hdl_search_path $listofdirs
read_hdl -sv -define {NOIP SYNTHESIS} /home/asicfab/a/socet53/2024summer/RISCVBusiness/source_code/rv32m/SIMD_multiplier/vedic_mul32.sv
read_hdl -sv -define {NOIP SYNTHESIS} /home/asicfab/a/socet53/2024summer/RISCVBusiness/source_code/rv32m/SIMD_multiplier/vedic_mul16.sv
read_hdl -sv -define {NOIP SYNTHESIS} /home/asicfab/a/socet53/2024summer/RISCVBusiness/source_code/rv32m/SIMD_multiplier/mul8.sv
read_hdl -sv -define {NOIP SYNTHESIS} /home/asicfab/a/socet53/2024summer/RISCVBusiness/source_code/rv32m/SIMD_multiplier/carry_save_adder.sv
read_hdl -sv -define {NOIP SYNTHESIS} /home/asicfab/a/socet53/2024summer/RISCVBusiness/source_code/rv32m/SIMD_multiplier/full_adder.sv
