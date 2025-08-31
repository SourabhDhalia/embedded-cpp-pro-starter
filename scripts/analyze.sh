#!/usr/bin/env bash
set -euo pipefail
# cppcheck (exclude firmware sources; analyzed by cross-compile job)
cppcheck --enable=all --inline-suppr --error-exitcode=1 --std=c++17 -I include \
  -isrc/firmware src 2> cppcheck-report.txt || (cat cppcheck-report.txt; exit 1)
# clang-tidy (compile_commands.json required)
if [ -f build/compile_commands.json ]; then
  # Exclude firmware-specific sources from host clang-tidy
  mapfile -t FILES < <(git ls-files '*.cpp' ':(exclude)src/firmware/**')
  [ ${#FILES[@]} -eq 0 ] || clang-tidy -p build "${FILES[@]}"
fi
