## Architecture

Modules
- `core`: portable logic (logging interface/impl, version). Compiles for host and firmware.
- `hal`: hardware abstraction layer interfaces (e.g., GPIO). Only interfaces in headers; implementations vary per platform.
- `src/hal`: host stub implementation for HAL (simulates hardware in tests/host runs).
- `src/firmware`: firmware entrypoint (infinite loop placeholder). Link with real MCU BSP later.
- `tests`: GoogleTest unit tests that run on host against `core` + host HAL stubs.

Dependency rules
- `core` can depend on `hal` interfaces but not on concrete MCU libs.
- `host_app` and tests link against `core` and the host HAL stub.
- `firmware` links `core` and will later link MCU vendor/BSP libs when you provide a linker script and syscalls.

Why this layout
- Clean separation of portable logic from platform specifics.
- Enables fast, deterministic tests on host while retaining an obvious path to firmware.
- Keeps interfaces stable and encourages testable design.

