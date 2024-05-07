#!/bin/bash

set -euxo pipefail

cmake \
  ${CMAKE_ARGS} \
  -S lang/c++ \
  -B build \
  -DBOOST_ROOT=$PREFIX \
  -DSNAPPY_ROOT_DIR=$PREFIX \
  -DCMAKE_BUILD_TYPE=RelWithDebInfo \
  -DCMAKE_CXX_STANDARD=14 \
  -DCMAKE_CXX_STANDARD_REQUIRED=ON \
  -DCMAKE_CXX_EXTENSIONS=OFF \

cd build
make
make test
make install
