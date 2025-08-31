#!/usr/bin/env bash
set -euo pipefail
FILES=$(git ls-files '*.c' '*.cpp' '*.h' '*.hpp')
[ -z "$FILES" ] || clang-format -style=file -i $FILES
