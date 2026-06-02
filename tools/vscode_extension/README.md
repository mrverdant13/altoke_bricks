# Brick Generator (VS Code extension)

Editor support for [brick generator](https://github.com/mrverdant13/altoke_bricks/tree/main/tools/brick_generator) annotation syntax in reference projects.

The extension now provides annotation-aware highlighting for all currently supported marker types, including range shading for block annotations.

## Current capabilities

- Marker highlighting for: `remove-start/end`, `drop`, `replace-start/with/end`, `insert-start/end`, `partial v/^`, Mustache tags (`{{...}}`) inside comment annotations, and spacing directives (`w ... w`)
- Block/range shading for: remove blocks, drop tails, replace original/replacement segments, insert blocks, and partial payload blocks
- Code folding for: `remove-start/end`, `replace-start/end`, and matching `partial v/^` blocks (all three comment flavors)
- Coverage across reference file types used in this monorepo, including `.dart`, `.sh`, `.yaml`, `.yml`, `.html`, `.xml`, `.md`, and ignore-style files such as `.gitignore`
- Theme-friendly TextMate scopes with extension-provided defaults for both dark and light themes

Diagnostics and inline preview land in follow-up changes.

## Customizing annotation colors

All annotation colors are configurable in VS Code settings under `brickGenerator.colors.*`.

Example:

```json
{
  "brickGenerator.colors.remove.markerForeground": "#ff6b6b",
  "brickGenerator.colors.remove.contentBackground": "rgba(255, 107, 107, 0.18)",
  "brickGenerator.colors.replace.withMarkerForeground": "#43c6ac",
  "brickGenerator.colors.mustache.tagForeground": "#c77dff"
}
```

Available keys:

- `brickGenerator.colors.remove.markerForeground`
- `brickGenerator.colors.remove.contentBackground`
- `brickGenerator.colors.replace.boundaryMarkerForeground`
- `brickGenerator.colors.replace.withMarkerForeground`
- `brickGenerator.colors.replace.originalBackground`
- `brickGenerator.colors.replace.replacementBackground`
- `brickGenerator.colors.insert.markerForeground`
- `brickGenerator.colors.insert.contentBackground`
- `brickGenerator.colors.partial.markerForeground`
- `brickGenerator.colors.partial.payloadBackground`
- `brickGenerator.colors.mustache.tagForeground`
- `brickGenerator.colors.mustache.commentBackground`
- `brickGenerator.colors.mustache.dropFlagForeground`
- `brickGenerator.colors.spacing.markerForeground`
- `brickGenerator.colors.spacing.markerBackground`

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
