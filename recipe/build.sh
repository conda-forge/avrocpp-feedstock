#!/bin/bash

mkdir build
cd build

cmake .. \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DBOOST_ROOT=$PREFIX \
  -DCMAKE_MODULE_PATH="$RECIPE_DIR/../src" \
  -DSNAPPY_ROOT_DIR=$PREFIX \
  -DCMAKE_BUILD_TYPE=RelWithDebInfo \
  -DCMAKE_CXX_FLAGS="-Wno-error=c++20-compat" \
  -DCMAKE_CXX_STANDARD=14 \
  -DCMAKE_CXX_STANDARD_REQUIRED=ON \
  -DCMAKE_CXX_EXTENSIONS=OFF

make # VERBOSE=1
make test
make install
