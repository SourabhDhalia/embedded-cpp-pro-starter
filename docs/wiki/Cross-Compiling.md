## Cross‑Compiling (ARM)

Toolchain file
- `cmake/toolchains/arm-gcc.cmake` sets compilers, MCU tuning flags, and link flags.
- Default: Cortex‑M4, thumb, hard‑float. Adjust for your target.

Build
- Configure: `cmake -S . -B build-arm -G Ninja -DCMAKE_TOOLCHAIN_FILE=cmake/toolchains/arm-gcc.cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=OFF`
- Build: `cmake --build build-arm -j`

Next steps for real firmware
- Provide a linker script, startup code, and syscalls (`_sbrk`, `_write`, etc.) or use `--specs=nosys.specs` for minimal setups.
- Link BSP/drivers; replace `src/hal` host stubs with real HAL.

