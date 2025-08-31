#!/usr/bin/env bash
set -euo pipefail
BUILD_DIR=${1:-build}
cmake -S . -B "$BUILD_DIR" -G Ninja -DCMAKE_BUILD_TYPE=Debug -DBUILD_TESTS=ON
cmake --build "$BUILD_DIR" -j

