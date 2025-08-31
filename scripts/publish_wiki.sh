#!/usr/bin/env bash
set -euo pipefail

# Publishes docs/wiki/* to the GitHub Wiki.
# Requirements:
# - Repo Wiki enabled (Settings → General → Features → Wikis)
# - Auth via GITHUB_TOKEN env var (with repo scope) or PAT with repo access

if [ ! -d docs/wiki ]; then
  echo "docs/wiki not found" >&2
  exit 1
fi

REPO_SLUG="${GITHUB_REPOSITORY:-}"
if [[ -z "${REPO_SLUG}" ]]; then
  REPO_URL=$(git config --get remote.origin.url || true)
  if [[ -z "${REPO_URL}" ]]; then
    echo "Origin remote not configured" >&2
    exit 1
  fi
  # git@github.com:owner/repo.git
  if [[ "${REPO_URL}" =~ ^git@github.com:(.*)\.git$ ]]; then
    REPO_SLUG="${BASH_REMATCH[1]}"
  # https://github.com/owner/repo or https://github.com/owner/repo.git
  elif [[ "${REPO_URL}" =~ ^https://github.com/([^/]+/[^/]+)(?:\.git)?$ ]]; then
    REPO_SLUG="${BASH_REMATCH[1]}"
  else
    echo "Unsupported remote URL: ${REPO_URL}" >&2
    exit 1
  fi
fi

WIKI_URL="https://github.com/${REPO_SLUG}.wiki.git"
if [[ -n "${GITHUB_TOKEN:-}" ]]; then
  WIKI_URL="https://x-access-token:${GITHUB_TOKEN}@github.com/${REPO_SLUG}.wiki.git"
fi

TMP_DIR=$(mktemp -d)
trap 'rm -rf "${TMP_DIR}"' EXIT

git init -q "${TMP_DIR}"
pushd "${TMP_DIR}" >/dev/null
git config user.email "ci@example.com"
git config user.name "wiki-publisher"
git remote add origin "${WIKI_URL}"
git fetch origin -q || true
git checkout -B master || git checkout -B main || true

# Copy pages
cp -a "${OLDPWD}/docs/wiki/." .

# Ensure Home page exists
if [ -f Home.md ]; then
  :
else
  echo "# Project Wiki" > Home.md
fi

git add .
if git diff --cached --quiet; then
  echo "No wiki changes"
else
  git commit -m "docs(wiki): sync from docs/wiki"
  git push -u origin HEAD
fi
popd >/dev/null

echo "Wiki published"
