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
  # Trim any trailing CR/LF to make case matching reliable
  REPO_URL=$(printf "%s" "${REPO_URL}" | tr -d '\r\n')
  if [[ -z "${REPO_URL}" ]]; then
    echo "Origin remote not configured" >&2
    exit 1
  fi
  # Normalize by stripping protocol/user and trailing .git
  case "${REPO_URL}" in
    git@github.com:*)
      REPO_SLUG="${REPO_URL#git@github.com:}"
      ;;
    https://github.com/*)
      REPO_SLUG="${REPO_URL#https://github.com/}"
      ;;
    http://github.com/*)
      REPO_SLUG="${REPO_URL#http://github.com/}"
      ;;
    *)
      echo "Unsupported remote URL: ${REPO_URL}" >&2
      exit 1
      ;;
  esac
  REPO_SLUG="${REPO_SLUG%.git}"
fi

WIKI_URL="https://github.com/${REPO_SLUG}.wiki.git"
if [[ -n "${GITHUB_TOKEN:-}" ]]; then
  WIKI_URL="https://x-access-token:${GITHUB_TOKEN}@github.com/${REPO_SLUG}.wiki.git"
fi

TMP_DIR=$(mktemp -d)
trap 'rm -rf "${TMP_DIR}"' EXIT

# Prefer cloning the existing wiki repository (avoids unrelated histories).
if git clone --depth=1 "${WIKI_URL}" "${TMP_DIR}" >/dev/null 2>&1; then
  pushd "${TMP_DIR}" >/dev/null
  CURRENT_BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || echo master)
else
  # Fallback for brand-new wikis: initialize an empty repo
  git init -q "${TMP_DIR}"
  pushd "${TMP_DIR}" >/dev/null
  git remote add origin "${WIKI_URL}"
  CURRENT_BRANCH=master
  git checkout -B "${CURRENT_BRANCH}"
fi

# Identity
git config user.email "ci@example.com"
git config user.name "wiki-publisher"

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
  # Ensure we're up to date and push to the current branch
  git pull --rebase origin "${CURRENT_BRANCH}" || true
  git push -u origin "HEAD:${CURRENT_BRANCH}"
fi
popd >/dev/null

echo "Wiki published"
