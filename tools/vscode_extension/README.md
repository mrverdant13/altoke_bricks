# Brick Generator (VS Code extension)

Editor support for [brick generator](https://github.com/mrverdant13/altoke_bricks/tree/main/tools/brick_generator) annotation syntax in reference projects.

This package is a scaffold: syntax highlighting, folding, diagnostics, and inline preview land in follow-up changes.

## Prerequisites

- [Node.js](https://nodejs.org/) 20+
- [pnpm](https://pnpm.io/) 10+ ([install](https://pnpm.io/installation))
- [VS Code](https://code.visualstudio.com/) 1.85+

## Development

From this directory:

```bash
pnpm install
pnpm run compile   # one-off build → out/extension.js
pnpm run watch     # rebuild on file changes
```

Open the repository root in VS Code and use **Run Extension** from `tools/vscode_extension` (F5 with a launch config), or load the folder as a workspace folder.

## Package a `.vsix`

```bash
pnpm install
pnpm run package
```

Produces `brick-generator-0.0.1.vsix` in this directory.

From the monorepo root you can also run:

```bash
melos run vscode.package
```

(after `melos bootstrap` and `pnpm install` in `tools/vscode_extension`).

## Install locally

1. Build a VSIX: `pnpm run package`
2. In VS Code: **Extensions** → `…` menu → **Install from VSIX…** → select the `.vsix` file.

Or from the CLI:

```bash
code --install-extension brick-generator-0.0.1.vsix
```

The extension activates after startup (`onStartupFinished`). When debugging from source, reload the window if you do not see expected behavior after installing or rebuilding.
