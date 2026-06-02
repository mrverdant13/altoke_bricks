import * as vscode from 'vscode';

import { readAnnotationConfig } from './annotationConfig';
import { refreshInsertHighlights } from './insertHighlighting';
import { refreshMustacheHighlights } from './mustacheHighlighting';
import { refreshPartialHighlights } from './partialHighlighting';
import { refreshRemoveHighlights } from './removeHighlighting';
import { refreshReplaceHighlights } from './replaceHighlighting';
import { refreshSpacingHighlights } from './spacingHighlighting';

function refreshBrickHighlights(editor: vscode.TextEditor | undefined): void {
  const config = readAnnotationConfig();
  refreshRemoveHighlights(editor, config);
  refreshReplaceHighlights(editor, config);
  refreshInsertHighlights(editor, config);
  refreshPartialHighlights(editor, config);
  refreshMustacheHighlights(editor, config);
  refreshSpacingHighlights(editor, config);
}

function refreshAllVisibleEditors(): void {
  for (const editor of vscode.window.visibleTextEditors) {
    refreshBrickHighlights(editor);
  }
}

function refreshEditorsForDocument(document: vscode.TextDocument): void {
  for (const editor of vscode.window.visibleTextEditors) {
    if (editor.document === document) {
      refreshBrickHighlights(editor);
    }
  }
}

export function registerBrickHighlighting(context: vscode.ExtensionContext): void {
  refreshAllVisibleEditors();

  context.subscriptions.push(
    vscode.window.onDidChangeActiveTextEditor(refreshBrickHighlights),
    vscode.workspace.onDidChangeTextDocument((event) => {
      refreshEditorsForDocument(event.document);
    }),
    vscode.workspace.onDidOpenTextDocument((document) => {
      refreshEditorsForDocument(document);
    }),
    vscode.workspace.onDidChangeConfiguration((event) => {
      if (!event.affectsConfiguration('brickGenerator.colors')) return;
      refreshAllVisibleEditors();
    }),
  );
}
