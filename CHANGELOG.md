# Changelog

This file tracks user-visible changes to the template so adopters can decide
whether to copy updates into repositories created from it.

The repository does not currently publish tagged releases. Until tags are
introduced, entries are grouped under `Unreleased`.

## Unreleased

### Added

- Add this changelog for future template updates.

## Initial template snapshot

The changelog was introduced after the initial template had already evolved.
At that point, the template included:

- a root `justfile` that imports bootstrap recipes and the shared
  `just-submodules-hub` command surface;
- `just setup` for first-run bootstrap and submodule initialization;
- shallow bootstrap of `just-submodules-hub`;
- local parent-status hiding for the managed shared submodule;
- README guidance for setup, requirements, repository layout, command model,
  shallow bootstrap behavior, customization policy, and license scope.
