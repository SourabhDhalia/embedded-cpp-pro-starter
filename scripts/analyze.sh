#!/usr/bin/env bash
set -euo pipefail
# cppcheck
cppcheck --enable=all --inline-suppr --error-exitcode=1 --std=c++17 -I include src 2> cppcheck-report.txt || (cat cppcheck-report.txt; exit 1)
# clang-tidy (compile_commands.json required)
if [ -f build/compile_commands.json ]; then
  mapfile -t FILES < <(git ls-files '*.cpp')
  [ ${#FILES[@]} -eq 0 ] || clang-tidy -p build "${FILES[@]}"
fi

