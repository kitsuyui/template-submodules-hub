set dotenv-load

# GitHub owner(s) for hub-wide commands. Use alphanumeric characters, hyphens,
# and commas only — shell metacharacters (; | $ ` & < >) are not safe here.
default_owners := "kitsuyui"
# Repository visibility filter. Safe values: all, public, private.
default_visibility := "all"

default:
  #!/bin/sh
  if [ -f "repo/github.com/kitsuyui/just-submodules-hub/just/index.just" ]; then
    just --choose
  else
    printf 'Bootstrap not complete.\n\nRun: just setup\n\nAvailable recipes before bootstrap:\n'
    just --list
    exit 1
  fi

import ".just/bootstrap.just"
import? "repo/github.com/kitsuyui/just-submodules-hub/just/index.just"
