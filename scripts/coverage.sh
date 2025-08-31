#!/usr/bin/env bash
set -euo pipefail
BUILD_DIR=${1:-build-cov}
cmake -S . -B "$BUILD_DIR" -G Ninja -DCMAKE_BUILD_TYPE=Debug -DBUILD_TESTS=ON -DENABLE_COVERAGE=ON
cmake --build "$BUILD_DIR" -j
ctest --test-dir "$BUILD_DIR" --output-on-failure
gcovr -r . -e 'tests/.*' --xml-pretty -o "$BUILD_DIR"/coverage.xml --html-details "$BUILD_DIR"/coverage.html --print-summary

