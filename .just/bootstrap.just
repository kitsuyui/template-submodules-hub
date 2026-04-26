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
  url="git@github.com:kitsuyui/just-submodules-hub.git"

  if git config -f .gitmodules --get "submodule.${target}.path" >/dev/null 2>&1; then
    git config -f .gitmodules "submodule.${target}.shallow" true
    git submodule update --init --recommend-shallow -- "$target"
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

  git submodule add -- "$url" "$target"
  git config -f .gitmodules "submodule.${target}.shallow" true

# Deprecated alias for bootstrap-shared-commands.
install-just-submodules-hub:
  #!/bin/sh
  set -eu
  just bootstrap-shared-commands
