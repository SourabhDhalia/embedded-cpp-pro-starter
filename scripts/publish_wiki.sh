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

git init -q "${TMP_DIR}"
pushd "${TMP_DIR}" >/dev/null
git config user.email "ci@example.com"
git config user.name "wiki-publisher"
git remote add origin "${WIKI_URL}"
git fetch origin -q || true

# Detect remote default branch (master/main) and base local branch on it
BRANCH="master"
if git ls-remote --exit-code --heads origin main >/dev/null 2>&1; then
  BRANCH="main"
elif git ls-remote --exit-code --heads origin master >/dev/null 2>&1; then
  BRANCH="master"
fi

if git rev-parse --verify "origin/${BRANCH}" >/dev/null 2>&1; then
  git checkout -B "${BRANCH}" "origin/${BRANCH}"
else
  git checkout -B "${BRANCH}"
fi

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
  # Rebase in case remote changed since fetch
  git pull --rebase origin "${BRANCH}" || true
  git push -u origin HEAD
fi
popd >/dev/null

echo "Wiki published"
