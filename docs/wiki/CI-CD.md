## CI/CD Pipeline

Workflows
- CI (`.github/workflows/ci.yml`)
  - Matrix: gcc/clang × Debug/Release
  - Steps: checkout → configure → build → tests → clang‑format → cppcheck → clang‑tidy → upload artifacts
  - Coverage job (GCC): produces `coverage.xml` and `coverage.html`
  - Dev‑container job: builds/tests using `Dockerfile.dev` for environment parity
  - Cross‑compile job: builds `core` with ARM GCC using the toolchain file
- Release (`.github/workflows/release.yml`)
  - Trigger: push tag `v*.*.*`
  - Builds Release and uploads `host_app` and `firmware` to a GitHub Release.

Quality gates
- Formatting: clang‑format enforces `.clang-format` (Google style)
- Static analysis: clang‑tidy + cppcheck per `.clang-tidy`
- Tests: GoogleTest discovered and run by CTest

Why install deps each run?
- GitHub‑hosted runners are ephemeral; every job starts from a clean VM for isolation and reproducibility.
- Installing tools guarantees consistent versions regardless of the runner image drift.

Improving speed & reproducibility (recommended)
- Prebuilt dev image: build/push `Dockerfile.dev` to GHCR, then run matrix jobs in that container to avoid apt installs.
  - Pros: faster jobs, identical versions across local/CI, fewer flakes.
  - Cons: you own image updates; add a scheduled rebuild or rebuild on Dockerfile changes.
- Caching: enable ccache and cache build/FetchContent artifacts to speed rebuilds.

How to adopt GHCR image for CI (outline)
1) Build/push image on Dockerfile changes (see Dev‑Container page).
2) In CI jobs, set:
   - `container: ghcr.io/<owner>/embedded-dev:latest`
   - Drop apt‑get step; keep the rest.

