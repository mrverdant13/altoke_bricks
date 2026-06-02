import * as vscode from 'vscode';

/**
 * Activates the Brick Generator extension.
 *
 * Annotation syntax highlighting is contributed declaratively via TextMate
 * grammar injection. Folding, diagnostics, and preview register here later.
 */
export function activate(_context: vscode.ExtensionContext): void {
  // No programmatic providers yet — grammar injection handles highlighting.
}

export function deactivate(): void {
  // Nothing to dispose yet.
}
