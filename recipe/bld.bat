#!/bin/bash

cmake %CMAKE_ARGS% -G "NMake Makefiles" ^
    -S lang/c++ ^
    -B build ^
    -DBOOST_ROOT:PATH="%PREFIX%" ^
    -DSNAPPY_ROOT_DIR:PATH="%PREFIX%" ^
    -DCMAKE_BUILD_TYPE:STRING=Release ^
    -DBUILD_SHARED_LIBS=ON ^
    -DCMAKE_CXX_STANDARD=14 ^
    -DCMAKE_CXX_STANDARD_REQUIRED=ON ^
    -DCMAKE_CXX_EXTENSIONS=ON ^

if errorlevel 1 exit 1

cd build
nmake
if errorlevel 1 exit 1

nmake install
if errorlevel 1 exit 1
