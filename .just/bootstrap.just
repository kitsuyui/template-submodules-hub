# Bootstrap: install the shared just module repository
install-just-submodules-hub:
  #!/bin/sh
  set -eu
  target="repo/github.com/kitsuyui/just-submodules-hub"
  if [ -d "$target" ]; then
    echo "$target already exists"
    exit 0
  fi
  if [ -d ".git/modules/$target" ]; then
    rm -rf ".git/modules/$target"
  fi
  git submodule add -- git@github.com:kitsuyui/just-submodules-hub.git "$target"
