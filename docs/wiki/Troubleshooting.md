## Troubleshooting

CMake cache path mismatch in container
- Symptom: cache refers to host path (`/Users/...`) while building at `/workspace`.
- Fix: remove/rebuild or use a separate build dir in container: `scripts/build.sh build-docker`.

Cppcheck missing system headers
- Harmless informational messages in minimal environments. CI suppresses with `--suppress=missingIncludeSystem`.

Clang‑format failures
- Run `scripts/format.sh` locally; CI uses `-style=file` to enforce `.clang-format`.

Clang‑tidy warnings as errors
- Prefer fixing. If a rule is not desired, document and disable it in `.clang-tidy`.

Branch protection
- After first CI run, add required checks (matrix jobs) under Settings → Branches.

