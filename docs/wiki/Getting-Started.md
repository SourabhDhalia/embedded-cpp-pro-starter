## Getting Started

Two ways to work: native host tools, or the dev container for a consistent toolchain on any OS.

Host (macOS/Linux)
- Configure: `cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Debug -DBUILD_TESTS=ON`
- Build: `cmake --build build -j`
- Test: `ctest --test-dir build --output-on-failure`
- Run: `./build/host_app`

Dev Container (recommended)
- Build image: `docker build -f Dockerfile.dev -t embedded-dev .`
- Run shell: `docker run --rm -it -v "$PWD:/workspace" -w /workspace embedded-dev bash`
- Inside container: `scripts/build.sh && scripts/test.sh`

Cross‑compile (ARM GCC)
- Configure: `cmake -S . -B build-arm -G Ninja -DCMAKE_TOOLCHAIN_FILE=cmake/toolchains/arm-gcc.cmake -DBUILD_TESTS=OFF -DCMAKE_BUILD_TYPE=Release`
- Build: `cmake --build build-arm -j`

Quality helpers
- Format: `scripts/format.sh`
- Analyze: `scripts/analyze.sh`
- Coverage (GCC): `scripts/coverage.sh` then open `build-cov/coverage.html`

