#!/bin/sh
set -eu

repo_root=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
fixture_root=$(mktemp -d)
fixture_repo="$fixture_root/repo"
target="repo/github.com/kitsuyui/just-submodules-hub"

cleanup() {
  rm -rf "$fixture_root"
}

trap cleanup EXIT INT TERM

mkdir -p "$fixture_repo"

(
  cd "$repo_root"
  tar \
    --exclude='./.git' \
    --exclude='./repo/github.com/kitsuyui/just-submodules-hub' \
    -cf - .
) | (
  cd "$fixture_repo"
  tar -xf -
)

cd "$fixture_repo"
git init -q
git config user.name "Bootstrap Smoke"
git config user.email "bootstrap-smoke@example.com"
git add .
git commit -q -m "chore: seed bootstrap smoke fixture"

just --unstable status | grep -F "phase: pre-bootstrap" >/dev/null
just --unstable setup

first_head=$(git rev-parse HEAD)
registered_path=$(git config -f .gitmodules --get "submodule.${target}.path")
ignore_mode=$(git config --local --get "submodule.${target}.ignore")

[ "$registered_path" = "$target" ]
[ "$ignore_mode" = "all" ]
[ -f "$target/just/index.just" ]
just status | grep -F "phase: post-bootstrap" >/dev/null
[ -z "$(git status --short)" ]

just --unstable setup
second_head=$(git rev-parse HEAD)

[ "$first_head" = "$second_head" ]
[ -z "$(git status --short)" ]
