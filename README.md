# template-submodules-hub

This repository is a template for building a **submodule hub**.
It helps you manage many GitHub repositories as Git submodules from one place.

## What This Template Provides

- A bootstrap `just` command to install the shared module (`just-submodules-hub`)
- A `just`-based interface for common submodule operations after bootstrap
- A simple starting structure for a private or public submodule-management repository

## Quick Start

1. Create a repository from this template.
2. Run the bootstrap command:

```sh
just install-just-submodules-hub
```

After this, shared commands (such as `add-repo`, `remove-repo`, and `update-all-repo`) become available via `just`.

## Add a Repository

Use one of the following:

```sh
just add-repo https://github.com/<owner>/<repo>
```

or

```sh
just add-repo <owner>/<repo>
```

## Typical Workflow

- Add a repository: `just add-repo <owner>/<repo>`
- Update one repository: `just update-repo repo/github.com/<owner>/<repo>`
- Update all repositories: `just update-all-repo`
- Run a command in every repository: `just every-repo '<command>'`

## Notes

- The shared module is referenced at `repo/github.com/kitsuyui/just-submodules-hub`.
- If you need custom behavior, you can add your own local recipes and hooks in this repository.
