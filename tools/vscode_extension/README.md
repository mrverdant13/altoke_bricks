# Brick Generator (VS Code extension)

Editor support for [brick generator](https://github.com/mrverdant13/altoke_bricks/tree/main/tools/brick_generator) annotation syntax in reference projects.

This package is a scaffold: syntax highlighting, folding, diagnostics, and inline preview land in follow-up changes.

## Prerequisites

- [Node.js](https://nodejs.org/) 20+
- [VS Code](https://code.visualstudio.com/) 1.85+

## Development

From this directory:

```bash
npm install
npm run compile   # one-off build → out/extension.js
npm run watch     # rebuild on file changes
```

Open the repository root in VS Code and use **Run Extension** from `tools/vscode_extension` (F5 with a launch config), or load the folder as a workspace folder.

## Package a `.vsix`

```bash
npm install
npm run package
```

Produces `brick-generator-0.0.1.vsix` in this directory.

From the monorepo root you can also run:

```bash
melos run vscode.package
```

(after `melos bootstrap` and `npm install` in `tools/vscode_extension`).

## Install locally

1. Build a VSIX: `npm run package`
2. In VS Code: **Extensions** → `…` menu → **Install from VSIX…** → select the `.vsix` file.

Or from the CLI:

```bash
code --install-extension brick-generator-0.0.1.vsix
```

Reload the window if the extension does not activate immediately.
