## Static Analysis & Formatting

Formatting
- Tool: clang‑format with `.clang-format` (Google style).
- CI: runs `--Werror --dry-run` to fail on diffs.
- Local: `scripts/format.sh` to apply changes.

Clang‑tidy
- Config: `.clang-tidy` focuses on bugprone/modernize/readability/cppcoreguidelines.
- Scope: headers under `include/` and sources under `src/`.
- CI treats warnings as errors to keep code healthy.

Cppcheck
- Runs with `--enable=all` and inline suppressions for known non‑issues in minimal containers.

Tuning
- Prefer fixing code to meet checks; if a rule doesn’t fit your team, document and disable it consciously in `.clang-tidy`.

