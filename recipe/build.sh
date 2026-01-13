#!/bin/bash

set -euxo pipefail

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-0}" == "1" ]]; then
  (
    mkdir -p build-native
    cd build-native
    export CC=$CC_FOR_BUILD
    export CXX=$CXX_FOR_BUILD
    unset CFLAGS
    unset CXXFLAGS
    unset CPPFLAGS
    export LDFLAGS=${LDFLAGS//$PREFIX/$BUILD_PREFIX}
    cmake \
       -S ../lang/c++ \
       -G Ninja \
       -DBOOST_ROOT=${BUILD_PREFIX} \
       -DCMAKE_INSTALL_PREFIX=${BUILD_PREFIX} \
       -DCMAKE_PREFIX_PATH=${BUILD_PREFIX} \
       -DCMAKE_BUILD_TYPE=RelWithDebInfo \
       -DBUILD_SHARED_LIBS=ON \
       -DCMAKE_CXX_STANDARD=17 \
       -DCMAKE_CXX_STANDARD_REQUIRED=ON \
       -DCMAKE_CXX_EXTENSIONS=OFF \
       -DCMAKE_VERBOSE_MAKEFILE=ON
    cmake --build . --config RelWithDebInfo --target avrogencpp
    mkdir -p ${BUILD_PREFIX}/bin
    cp avrogencpp ${BUILD_PREFIX}/bin/
  )
fi


if [[ "${target_platform}" == osx-* ]]; then
    # See https://conda-forge.org/docs/maintainer/knowledge_base.html#newer-c-features-with-old-sdk
    CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi

cmake \
  ${CMAKE_ARGS} \
  -S lang/c++ \
  -B build \
  -G Ninja \
  -DBOOST_ROOT=$PREFIX \
  -DSNAPPY_ROOT_DIR=$PREFIX \
  -DCMAKE_BUILD_TYPE=RelWithDebInfo \
  -DBUILD_SHARED_LIBS=ON \
  -DCMAKE_CXX_STANDARD=17 \
  -DCMAKE_CXX_STANDARD_REQUIRED=ON \
  -DCMAKE_CXX_EXTENSIONS=OFF \
  -DCMAKE_VERBOSE_MAKEFILE=ON

cmake --build build --config RelWithDebInfo
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-0}" != "1" || "${CROSSCOMPILING_EMULATOR:-0}" != "" ]]; then
  cmake --build build --config RelWithDebInfo --target test
fi
cmake --build build --config RelWithDebInfo --target install
