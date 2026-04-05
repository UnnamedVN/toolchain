#!/bin/bash

set -e

clone() {
    git clone https://github.com/llvm/llvm-project --depth=1
}

configure() {
	cmake \
        -G Ninja \
        -S llvm \
        -B build \
        -D CMAKE_INSTALL_PREFIX=llvm-m68k-nightly \
        -D CMAKE_BUILD_TYPE="Release" \
        -D CMAKE_C_COMPILER=clang \
        -D CMAKE_CXX_COMPILER=clang++ \
        -D LLVM_CCACHE_BUILD=ON \
        -D LLVM_ENABLE_PROJECTS="clang" \
        -D LLVM_ENABLE_RUNTIMES="" \
        -D LLVM_ENABLE_LLD=ON \
        -D LLVM_BUILD_LLVM_DYLIB=ON \
        -D LLVM_LINK_LLVM_DYLIB=ON \
        -D CLANG_LINK_CLANG_DYLIB=ON \
        -D LLVM_TARGETS_TO_BUILD="X86" \
        -D LLVM_EXPERIMENTAL_TARGETS_TO_BUILD="M68k" \
        -D LLVM_INSTALL_TOOLCHAIN_ONLY=ON
}

build() {
	ninja -C build install/strip
}

case "$1" in
    clone)
        clone
        ;;
    configure)
        configure
        ;;
    build)
        build
        ;;
    *)
        echo "error: cannot find such verb"
        exit 1
        ;;
esac

