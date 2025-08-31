## Dev Container

Purpose
- Standardize toolchain (compilers, analysis, docs, ARM GCC) across all machines and CI.

Build locally
- `docker build -f Dockerfile.dev -t embedded-dev .`

Use locally
- `docker run --rm -it -v "$PWD:/workspace" -w /workspace embedded-dev bash`
- Inside: `scripts/build.sh && scripts/test.sh`

Publish to GHCR (for CI reuse)
- Use a workflow to build/push `ghcr.io/<owner>/embedded-dev:latest` on changes to `Dockerfile.dev`.
- Then set `container: ghcr.io/<owner>/embedded-dev:latest` in CI jobs to skip apt installs.

VS Code (optional)
- You can add a `.devcontainer/` to auto‑open this image in VS Code; this starter keeps it simple with just the `Dockerfile.dev`.

