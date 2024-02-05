#!/bin/bash

mkdir build
cd build

cmake -G "NMake Makefiles" ^
    -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_PREFIX_PATH:PATH="%LIBRARY_PREFIX%" ^
    -DBOOST_ROOT:PATH="%PREFIX%" ^
    -DSNAPPY_ROOT_DIR:PATH="%PREFIX%" ^
    -DCMAKE_BUILD_TYPE:STRING=Release ^
    -DBUILD_SHARED_LIBS=ON ^
    -DCMAKE_CXX_FLAGS="-Wno-error=c++20-compat" ^
    -DCMAKE_CXX_STANDARD=14 ^
    -DCMAKE_CXX_STANDARD_REQUIRED=ON ^
    -DCMAKE_CXX_EXTENSIONS=OFF ^
    ..
if errorlevel 1 exit 1

nmake
if errorlevel 1 exit 1

nmake install
if errorlevel 1 exit 1
