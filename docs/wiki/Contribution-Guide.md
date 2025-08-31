## Contribution Guide

Development flow
- Branch from `main`: `feature/<topic>`
- Format and analyze locally: `scripts/format.sh`, `scripts/analyze.sh`
- Build and test: `scripts/build.sh && scripts/test.sh`
- Open PR → CI must pass → 1 review → merge.

Style & quality
- Formatting is enforced by CI.
- Static analysis warnings fail CI; prefer fixing or justify disabling.

Where to change what
- Core logic: `src/core`, headers in `include/core`.
- HAL APIs: `include/hal`; host stubs in `src/hal`; replace for MCU.
- Tests: `tests/*` (GoogleTest).

