import * as vscode from 'vscode';

import { registerBlockFolding } from './blockFolding';
import { registerBrickHighlighting } from './brickHighlighting';
import { registerInsertHighlighting } from './insertHighlighting';
import { registerMustacheHighlighting } from './mustacheHighlighting';
import { registerPartialHighlighting } from './partialHighlighting';
import { registerRemoveHighlighting } from './removeHighlighting';
import { registerReplaceHighlighting } from './replaceHighlighting';
import { registerSpacingHighlighting } from './spacingHighlighting';

/**
 * Activates the Brick Generator extension.
 *
 * Annotation syntax highlighting is contributed via TextMate grammar injection;
 * annotation regions are tinted programmatically so colors apply reliably inside
 * comment regions. Diagnostics and preview register here later.
 */
export function activate(context: vscode.ExtensionContext): void {
  registerBlockFolding(context);
  registerRemoveHighlighting(context);
  registerReplaceHighlighting(context);
  registerInsertHighlighting(context);
  registerPartialHighlighting(context);
  registerMustacheHighlighting(context);
  registerSpacingHighlighting(context);
  registerBrickHighlighting(context);
}

export function deactivate(): void {
  // Subscriptions dispose via context.subscriptions.
}
