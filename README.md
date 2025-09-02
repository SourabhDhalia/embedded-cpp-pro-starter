# embedded-cpp-pro-starter

SPDX-License-Identifier: Apache-2.0

**Highlights**
- CMake (host + ARM cross).
- CI: build, tests (GoogleTest), static analysis (clang-tidy/cppcheck), coverage (gcovr), release on tags.
- Dev container via Docker (`Dockerfile.dev`).
- Doxygen docs + (optional) Pages.

## Quick Start (Host)
```bash
cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Debug -DBUILD_TESTS=ON
cmake --build build -j
ctest --test-dir build --output-on-failure
```

## Cross-Compile (ARM GCC)
```bash
cmake -S . -B build-arm -G Ninja \
  -DCMAKE_TOOLCHAIN_FILE=cmake/toolchains/arm-gcc.cmake \
  -DBUILD_TESTS=OFF -DCMAKE_BUILD_TYPE=Release
cmake --build build-arm -j
```

## Scripts
- `scripts/build.sh` / `scripts/test.sh`
- `scripts/format.sh` / `scripts/analyze.sh`
- `scripts/coverage.sh` / `scripts/docs.sh`

## Wiki
Full documentation, architecture notes, CI/CD details, and troubleshooting live in the project Wiki.

- Project Wiki: https://github.com/SourabhDhalia/embedded-cpp-pro-starter/wiki

## CI/CD
See `.github/workflows/ci.yml` and `release.yml`.
