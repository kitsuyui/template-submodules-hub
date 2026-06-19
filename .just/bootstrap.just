# Show bootstrap phase and available recipes.
status:
  #!/bin/sh
  if [ -f "repo/github.com/kitsuyui/just-submodules-hub/just/index.just" ]; then
    echo "phase: post-bootstrap"
    echo "just-submodules-hub is available. All hub recipes are active."
  else
    echo "phase: pre-bootstrap"
    echo "just-submodules-hub is not yet initialized."
    echo "Run 'just setup' to enable hub recipes."
  fi

# Set up the shared just module and initialize registered submodules.
setup:
  #!/bin/sh
  set -eu
  just bootstrap-shared-commands
  just repo::submodule::init-all

# Bootstrap the shared just module repository.
bootstrap-shared-commands:
  #!/bin/sh
  set -eu
  target="repo/github.com/kitsuyui/just-submodules-hub"
  url="https://github.com/kitsuyui/just-submodules-hub.git"
  lock_dir=$(git rev-parse --git-path bootstrap-shared-commands.lock)
  lock_acquired=0
  cleanup_target=0

  __bootstrap_cleanup() {
    if [ "$cleanup_target" -eq 1 ]; then
      rm -rf ".git/modules/$target" "$target"
    fi
    if [ "$lock_acquired" -eq 1 ]; then
      rmdir "$lock_dir" 2>/dev/null || true
      lock_acquired=0
    fi
  }

  __bootstrap_abort_int() {
    __bootstrap_cleanup
    exit 130
  }

  __bootstrap_abort_term() {
    __bootstrap_cleanup
    exit 143
  }

  trap __bootstrap_cleanup EXIT
  trap __bootstrap_abort_int INT
  trap __bootstrap_abort_term TERM

  lock_wait_seconds=120
  until mkdir "$lock_dir" 2>/dev/null; do
    if [ "$lock_wait_seconds" -le 0 ]; then
      echo "error: timed out waiting for bootstrap lock: $lock_dir" >&2
      exit 1
    fi
    sleep 1
    lock_wait_seconds=$((lock_wait_seconds - 1))
  done
  lock_acquired=1

  if git config -f .gitmodules --get "submodule.${target}.path" >/dev/null 2>&1; then
    actual_url=$(git config -f .gitmodules --get "submodule.${target}.url" 2>/dev/null || echo "")
    if [ "$actual_url" != "$url" ]; then
      echo "error: submodule '${target}' is registered with URL '${actual_url}', expected '${url}'" >&2
      exit 1
    fi
    git config -f .gitmodules "submodule.${target}.shallow" true
    if [ -z "$(git ls-tree HEAD "$target" 2>/dev/null)" ]; then
      git add .gitmodules "$target"
      git commit -m "bootstrap: register just-submodules-hub submodule"
    fi
    timeout 120 git submodule update --init --recommend-shallow -- "$target"
    git config --local "submodule.${target}.ignore" all
    exit 0
  fi

  if [ -d "$target" ] && [ -z "$(find "$target" -mindepth 1 -maxdepth 1 -print -quit)" ]; then
    rmdir "$target"
  fi

  if [ -d "$target" ]; then
    echo "$target already exists but is not registered in .gitmodules" >&2
    exit 1
  fi

  if [ -d ".git/modules/$target" ]; then
    rm -rf ".git/modules/$target"
  fi

  cleanup_target=1
  timeout 120 git submodule add -- "$url" "$target"
  cleanup_target=0
  git config -f .gitmodules "submodule.${target}.shallow" true
  git config --local "submodule.${target}.ignore" all
  git add .gitmodules "$target"
  git commit -m "bootstrap: register just-submodules-hub submodule"
