#! /bin/sh

git submodule update --init --recursive
pushd riscv-tests
pushd isa
make clean
popd
pushd benchmarks
make clean
popd
autoconf
./configure
make $1
popd
