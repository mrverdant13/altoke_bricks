import * as vscode from 'vscode';

import { type AnnotationConfig } from './annotationConfig';
import { matchToRange } from './rangeUtils';
import { isSupportedBrickFile } from './supportedFiles';

const SPACING_MARKER_PATTERNS = [
  /\/\*w ?(?:\d+[v>] ?)* ?w\*\//g,
  /#w ?(?:\d+[v>] ?)* ?w#/g,
  /<!--w ?(?:\d+[v>] ?)* ?w-->/g,
];

let spacingDecoration = vscode.window.createTextEditorDecorationType({});
let appliedConfigKey = '';

function ensureDecorations(config: AnnotationConfig): void {
  const key = JSON.stringify(config.spacing);
  if (key === appliedConfigKey) return;

  const prev = spacingDecoration;
  spacingDecoration = vscode.window.createTextEditorDecorationType({
    color: config.spacing.markerForeground,
    backgroundColor: config.spacing.markerBackground,
    fontWeight: 'bold',
  });
  prev.dispose();
  appliedConfigKey = key;
}

function findSpacingMarkerRanges(document: vscode.TextDocument): vscode.Range[] {
  const text = document.getText();
  const ranges: vscode.Range[] = [];

  for (const pattern of SPACING_MARKER_PATTERNS) {
    const expression = new RegExp(pattern.source, pattern.flags);
    for (const match of text.matchAll(expression)) {
      ranges.push(matchToRange(document, match));
    }
  }

  return ranges;
}

export function refreshSpacingHighlights(
  editor: vscode.TextEditor | undefined,
  config: AnnotationConfig,
): void {
  ensureDecorations(config);

  if (editor === undefined || !isSupportedBrickFile(editor.document)) return;

  editor.setDecorations(spacingDecoration, findSpacingMarkerRanges(editor.document));
}

export function registerSpacingHighlighting(context: vscode.ExtensionContext): void {
  context.subscriptions.push(
    new vscode.Disposable(() => { spacingDecoration.dispose(); }),
  );
}
