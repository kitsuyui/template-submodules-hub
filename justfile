set dotenv-load

default_owners := "kitsuyui"
default_visibility := "all"

default:
  @just --choose

import ".just/bootstrap.just"
import? "repo/github.com/kitsuyui/just-submodules-hub/just/index.just"
