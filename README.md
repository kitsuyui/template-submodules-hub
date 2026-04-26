# template-submodules-hub

`template-submodules-hub` is a template for creating a Git submodule hub with a shared `just` command surface.

Use this template when one parent repository should coordinate many independent repositories under `repo/github.com/<owner>/<repo>`.

## Quick Start

Create a repository from this template, then run:

```sh
just setup
```

`setup` performs two steps:

1. `bootstrap-shared-commands`: add or initialize `repo/github.com/kitsuyui/just-submodules-hub`
2. `repo::submodule::init-all`: initialize registered submodules through the shared command module

This keeps first-run setup working even though the shared recipes are not available until after bootstrap.
Bootstrap and shared submodule setup default managed submodules to `ignore=all` in the local `.git/config`, so parent repository status stays focused on intentional hub-level changes.

## Requirements

This template expects [`just`](https://github.com/casey/just) to be installed before setup.

On macOS:

```sh
brew install just
```

After bootstrap, the shared command module may also require `git`, `uv`, and `gh` depending on which recipes you run.

## Repository Layout

```text
.
├── .just/
│   └── bootstrap.just
├── justfile
└── repo/
    └── github.com/
        └── kitsuyui/
            └── just-submodules-hub/   # added by bootstrap-shared-commands
```

Managed repositories are placed under `repo/github.com/<owner>/<repo>`.

## Command Model

The root `justfile` imports:

```just
import ".just/bootstrap.just"
import? "repo/github.com/kitsuyui/just-submodules-hub/just/index.just"
```

Before bootstrap, only local setup commands are available:

- `just setup`
- `just bootstrap-shared-commands`

After bootstrap, operational commands come from `just-submodules-hub`.
Canonical command names follow a namespace/resource/verb tree, for example:

```sh
just repo::submodule::add <owner>/<repo>
just repo::submodule::default-branch::sync-all
just repo::submodule::managed::list
just github::repos::list
just github::prs::summary
```

Detailed references:

- [`just-submodules-hub` README](https://github.com/kitsuyui/just-submodules-hub)
- [`just-submodules-hub` docs](https://github.com/kitsuyui/just-submodules-hub/tree/main/docs)
- [`just-submodules-hub` command naming](https://github.com/kitsuyui/just-submodules-hub/blob/main/docs/command-naming.md)
- [`just-submodules-hub` repo docs](https://github.com/kitsuyui/just-submodules-hub/tree/main/docs/repo)
- [`just-submodules-hub` GitHub docs](https://github.com/kitsuyui/just-submodules-hub/tree/main/docs/github)

## Shallow Bootstrap

`bootstrap-shared-commands` records `just-submodules-hub` with `shallow = true` in `.gitmodules` and sets its local parent-status visibility to hidden.
Later clones can then use Git's recommended shallow behavior during setup.

## Customization Policy

- Keep `.just/bootstrap.just` focused on first-run bootstrap only.
- Put reusable or complex bootstrap/workflow logic into `just-submodules-hub`.
- Keep repository-specific behavior in local recipes/hooks only when necessary.
- Prefer importing `repo/github.com/kitsuyui/just-submodules-hub/just/index.just` as the single shared entrypoint.
- Keep this README focused on template setup. Ongoing operational command reference belongs in `just-submodules-hub`.

## License Scope

This template repository is dedicated to the public domain under CC0-1.0.

Important scope notes:

- Managed submodules are independent projects. Each submodule is governed by its own license.
- External tools used with this repository (for example, `just`, `git`, and `gh`) are governed by their respective licenses.
