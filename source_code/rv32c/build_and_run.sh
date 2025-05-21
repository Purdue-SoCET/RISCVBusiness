#! /bin/sh
verilator --assert --cc ../packages/rv32i_types_pkg.sv rv32c_pkg.sv decompressor.sv --top-module decompressor --exe tb_decompressor.cc gen_tests.c -CFLAGS -std=c++20
pushd obj_dir
make -f Vdecompressor.mk
cp Vdecompressor ..
popd
./Vdecompressor
