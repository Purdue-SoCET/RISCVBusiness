#! /bin/sh
git submodule sync
git submodule update --init --recursive
pushd riscv-tests
pushd isa
make clean
popd
pushd benchmarks
make clean
popd
autoconf
./configure --with-xlen 32
make $1
popd
