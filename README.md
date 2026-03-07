# template-submodules-hub

`template-submodules-hub` is a **template repository** for creating a Git submodule hub.
Use it when you want to manage multiple repositories from one parent repository with consistent `just` commands.

## Purpose

This template gives you a minimal, practical starting point for submodule-hub repositories:

- bootstrap once
- use shared submodule operations
- keep local customization small and explicit

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

After bootstrap, shared commands like `add-repo`, `remove-repo`, and `update-all-repo` become available.

## Add Repositories

```sh
just add-repo <owner>/<repo>
```

or

```sh
just add-repo https://github.com/<owner>/<repo>
```

## Customization Policy

- Keep `.just/bootstrap.just` minimal.
- Put reusable or complex bootstrap/workflow logic into `just-submodules-hub`.
- Keep repository-specific behavior in local recipes/hooks only when necessary.

## License Scope

This template repository is dedicated to the public domain under CC0-1.0.

Important scope notes:

- Managed submodules are independent projects. Each submodule is governed by its own license.
- External tools used with this repository (for example, `just`, `git`, and `gh`) are governed by their respective licenses.
