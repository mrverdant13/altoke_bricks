import * as vscode from 'vscode';

import { findBrickScopeForFile } from './brickScope';
import { PREVIEW_COMMAND_ID } from './previewCommand';
import { collectRegexMatches } from './markerScanning';
import { isSupportedBrickFile } from './supportedFiles';

const FIRST_ANNOTATION_PATTERN =
  /\/\*(?:x-)?(?:remove-start|replace-start|insert-start|partial v|drop)\*\/|#(?:x-)?(?:remove-start|replace-start|insert-start|partial v|drop)#|<!--(?:x-)?(?:remove-start|replace-start|insert-start|partial v|drop)-->|\/\*(?:x)?\{\{|#(?:x)?\{\{|<!--(?:x)?\{\{/g;

class PreviewCodeLensProvider implements vscode.CodeLensProvider {
  provideCodeLenses(document: vscode.TextDocument): vscode.CodeLens[] {
    if (!isSupportedBrickFile(document)) {
      return [];
    }
    if (!findBrickScopeForFile(document.fileName)) {
      return [];
    }

    const matches = collectRegexMatches(document.getText(), FIRST_ANNOTATION_PATTERN);
    const firstMatch = matches[0];
    if (!firstMatch) {
      return [];
    }

    const position = document.positionAt(firstMatch.offset);
    const range = new vscode.Range(position, position);

    return [
      new vscode.CodeLens(range, {
        title: 'Preview generated output',
        command: PREVIEW_COMMAND_ID,
        arguments: [document.uri],
      }),
    ];
  }
}

export function registerPreviewCodeLens(context: vscode.ExtensionContext): void {
  context.subscriptions.push(
    vscode.languages.registerCodeLensProvider(
      [
        { language: 'dart' },
        { language: 'shellscript' },
        { language: 'yaml' },
        { language: 'html' },
        { language: 'xml' },
        { language: 'markdown' },
        { language: 'ignore' },
      ],
      new PreviewCodeLensProvider(),
    ),
  );
}
