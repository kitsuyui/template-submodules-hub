# template-submodules-hub

`template-submodules-hub` is a **template repository** for creating a Git submodule hub.
Use it when you want to manage multiple repositories from one parent repository with a shared `just` entrypoint.

## Purpose

This template gives you a minimal, practical starting point for submodule-hub repositories:

- bootstrap once
- use shared submodule operations
- keep local customization small and explicit

## Requirements

This template expects [`just`](https://github.com/casey/just) to be installed before bootstrap.

On macOS, install it with Homebrew:

```sh
brew install just
```

## Concept

This template intentionally separates concerns:

- **`template-submodules-hub`** defines the starting layout and bootstrap entrypoint.
- **`just-submodules-hub`** provides reusable, shared `just` modules and scripts.

`template-submodules-hub` keeps bootstrap logic minimal. If bootstrap becomes complex, move that complexity into `just-submodules-hub` instead of growing `.just/bootstrap.just`.

## Directory Structure

```text
.
├── .just/
│   └── bootstrap.just
├── justfile
└── repo/
    └── github.com/
        └── kitsuyui/
            └── just-submodules-hub/   # added by bootstrap command
```

Managed repositories are placed under `repo/github.com/<owner>/<repo>`.

## Quick Start

1. Create a new repository from this template.
2. Run:

```sh
just install-just-submodules-hub
```

After bootstrap, the template imports `just-submodules-hub/just/index.just`.

From that point on, operational command reference lives in `just-submodules-hub`, not in this template repository.

## What You Get After Bootstrap

```sh
import? "repo/github.com/kitsuyui/just-submodules-hub/just/index.just"
```

Typical usage then looks like:

```sh
just repo submodule add <owner>/<repo>
just github repos list
just github prs summary
```

Detailed command guides:

- [`just-submodules-hub` README](https://github.com/kitsuyui/just-submodules-hub)
- [`just-submodules-hub` docs](https://github.com/kitsuyui/just-submodules-hub/tree/main/docs)
- [`just-submodules-hub` repo docs](https://github.com/kitsuyui/just-submodules-hub/tree/main/docs/repo)
- [`just-submodules-hub` GitHub docs](https://github.com/kitsuyui/just-submodules-hub/tree/main/docs/github)

## Customization Policy

- Keep `.just/bootstrap.just` minimal.
- Put reusable or complex bootstrap/workflow logic into `just-submodules-hub`.
- Keep repository-specific behavior in local recipes/hooks only when necessary.
- Prefer importing `repo/github.com/kitsuyui/just-submodules-hub/just/index.just` as the single shared entrypoint.
- Keep this README focused on template setup, not ongoing operational command reference.

## License Scope

This template repository is dedicated to the public domain under CC0-1.0.

Important scope notes:

- Managed submodules are independent projects. Each submodule is governed by its own license.
- External tools used with this repository (for example, `just`, `git`, and `gh`) are governed by their respective licenses.
