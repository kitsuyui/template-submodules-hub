# template-submodules-hub

`template-submodules-hub` is a **template repository** for creating a Git submodule hub.
Use it when you want to manage multiple repositories from one parent repository with consistent `just` commands.

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

Repositories added by `just add-repo` are placed under `repo/github.com/<owner>/<repo>`.

For example:

- `just add-repo kitsuyui/my-service`
- `just add-repo https://github.com/gitignore-in/website`

will create:

- `repo/github.com/kitsuyui/my-service`
- `repo/github.com/gitignore-in/website`

## Quick Start

1. Create a new repository from this template.
2. Run:

```sh
just install-just-submodules-hub
```

After bootstrap, the template imports `just-submodules-hub/just/index.just`, and shared commands like `add-repo`, `remove-repo`, and `sync-all-repo-default-branch` become available.

## Add Repositories

```sh
just add-repo <owner>/<repo>
```

or

```sh
just add-repo https://github.com/<owner>/<repo>
```

## Synchronization and Parent Commit

- Sync one repository to its default branch:

```sh
just sync-repo-default-branch <owner>/<repo>
```

- Sync all repositories to their default branches:

```sh
just sync-all-repo-default-branch
```

- Commit only submodule pointer updates in the parent repository:

```sh
just commit-submodule-pointers
```

## Customization Policy

- Keep `.just/bootstrap.just` minimal.
- Put reusable or complex bootstrap/workflow logic into `just-submodules-hub`.
- Keep repository-specific behavior in local recipes/hooks only when necessary.
- Prefer importing `repo/github.com/kitsuyui/just-submodules-hub/just/index.just` as the single shared entrypoint.

## License Scope

This template repository is dedicated to the public domain under CC0-1.0.

Important scope notes:

- Managed submodules are independent projects. Each submodule is governed by its own license.
- External tools used with this repository (for example, `just`, `git`, and `gh`) are governed by their respective licenses.
