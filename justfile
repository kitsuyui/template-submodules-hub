set dotenv-load

# GitHub owner(s) for hub-wide commands. Use alphanumeric characters, hyphens,
# and commas only — shell metacharacters (; | $ ` & < >) are not safe here.
default_owners := "kitsuyui"
# Repository visibility filter. Safe values: all, public, private.
default_visibility := "all"

default:
  @just --list

import ".just/bootstrap.just"
import? "repo/github.com/kitsuyui/just-submodules-hub/just/index.just"
