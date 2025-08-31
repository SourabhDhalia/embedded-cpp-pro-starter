## Build & Run

Host build
- Configure: `cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Debug -DBUILD_TESTS=ON`
- Build: `cmake --build build -j`
- Test: `ctest --test-dir build --output-on-failure`
- Run app: `./build/host_app`

Dev container path
- Build image: `docker build -f Dockerfile.dev -t embedded-dev .`
- Shell: `docker run --rm -it -v "$PWD:/workspace" -w /workspace embedded-dev bash`
- Inside: `scripts/build.sh && scripts/test.sh`

Cross‑compile (ARM)
- Configure: `cmake -S . -B build-arm -G Ninja -DCMAKE_TOOLCHAIN_FILE=cmake/toolchains/arm-gcc.cmake -DBUILD_TESTS=OFF -DCMAKE_BUILD_TYPE=Release`
- Build: `cmake --build build-arm -j`
- Next: add linker script/syscalls for your MCU to produce a .elf/.bin.

Coverage (GCC)
- `scripts/coverage.sh` → artifacts under `build-cov/` including `coverage.html`.

