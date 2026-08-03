# Contributing

Thank you for your interest in contributing to template-submodules-hub.

## Reporting Issues

Please use [GitHub Issues](https://github.com/kitsuyui/template-submodules-hub/issues) to report bugs or suggest improvements to this template.

When reporting a bug, include:

- What you expected to happen
- What actually happened
- Steps to reproduce, starting from `just setup`
- Your operating system and `just --version` output

## Submitting Changes

1. Fork the repository and create a topic branch from `main`.
2. Make a focused change — one logical change per pull request.
3. Run `just test-bootstrap-smoke` to verify the first-run bootstrap path and its idempotent rerun behavior in a fresh fixture repository.
4. Open a pull request against `main` with a clear description of the change and why it is needed.

## Commit Messages

Follow the format `prefix: short description` using one of:

- `fix:` — bug fix
- `feat:` — new capability
- `docs:` — documentation only
- `chore:` — maintenance (dependency bumps, CI tweaks)

## License

By contributing, you agree that your changes will be released under the same [CC0-1.0](LICENSE) license as this repository.
