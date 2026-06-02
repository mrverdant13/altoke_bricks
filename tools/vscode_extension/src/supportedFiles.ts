import * as path from 'path';
import * as vscode from 'vscode';

/** Extensions used by brick reference projects (see TIMELINE PR 3). */
const SUPPORTED_EXTENSIONS = new Set([
  '.dart',
  '.sh',
  '.yaml',
  '.yml',
  '.html',
  '.htm',
  '.xml',
  '.md',
  '.markdown',
]);

/** Ignore-style files that use `#` annotation comments without an extension. */
const SUPPORTED_BASENAMES = new Set(['.gitignore', '.dockerignore']);

export function isSupportedBrickFile(document: vscode.TextDocument): boolean {
  const basename = path.basename(document.fileName).toLowerCase();
  if (SUPPORTED_BASENAMES.has(basename)) {
    return true;
  }

  return SUPPORTED_EXTENSIONS.has(
    path.extname(document.fileName).toLowerCase(),
  );
}
