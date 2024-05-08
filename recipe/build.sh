#!/bin/bash

set -euxo pipefail

cmake \
  ${CMAKE_ARGS} \
  -S lang/c++ \
  -B build \
  -G Ninja \
  -DBOOST_ROOT=$PREFIX \
  -DSNAPPY_ROOT_DIR=$PREFIX \
  -DCMAKE_BUILD_TYPE=RelWithDebInfo \
  -DBUILD_SHARED_LIBS=ON \
  -DCMAKE_CXX_STANDARD=14 \
  -DCMAKE_CXX_STANDARD_REQUIRED=ON \
  -DCMAKE_CXX_EXTENSIONS=OFF \
  -DCMAKE_VERBOSE_MAKEFILE=ON

cmake --build build --config RelWithDebInfo --target test
cmake --build build --config RelWithDebInfo --target install
