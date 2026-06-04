import * as vscode from 'vscode';

import { findPairedBlockInteriors } from './annotationBlockPairing';
import {
  DROP_MARKER_PATTERN,
  DROP_MARKER_SETS,
  REMOVE_BOUNDARY_MARKER_PATTERN,
  REMOVE_MARKER_SETS,
} from './annotationMarkerSets';
import { type AnnotationConfig } from './annotationConfig';
import { collectRegexMatches } from './markerScanning';
import { interiorsToRanges } from './rangeUtils';
import { isSupportedBrickFile } from './supportedFiles';

let markerDecoration = vscode.window.createTextEditorDecorationType({});
let contentDecoration = vscode.window.createTextEditorDecorationType({});
let appliedConfigKey = '';

function ensureDecorations(config: AnnotationConfig): void {
  const key = JSON.stringify(config.remove);
  if (key === appliedConfigKey) return;

  const prevMarker = markerDecoration;
  const prevContent = contentDecoration;

  markerDecoration = vscode.window.createTextEditorDecorationType({
    color: config.remove.markerForeground,
    fontWeight: 'bold',
  });
  contentDecoration = vscode.window.createTextEditorDecorationType({
    backgroundColor: config.remove.contentBackground,
    isWholeLine: false,
  });

  prevMarker.dispose();
  prevContent.dispose();
  appliedConfigKey = key;
}

function findDropBlockInteriors(text: string): Array<{ start: number; end: number }> {
  const documentEnd = text.length;
  let earliestInteriorStart: number | undefined;

  for (const pattern of DROP_MARKER_SETS) {
    for (const match of collectRegexMatches(text, pattern)) {
      const interiorStart = match.offset + match.length;
      if (interiorStart >= documentEnd) continue;
      if (
        earliestInteriorStart === undefined ||
        interiorStart < earliestInteriorStart
      ) {
        earliestInteriorStart = interiorStart;
      }
    }
  }

  if (earliestInteriorStart === undefined) return [];

  return [{ start: earliestInteriorStart, end: documentEnd }];
}

function findRemovedBoundaryMarkerRanges(document: vscode.TextDocument): vscode.Range[] {
  const text = document.getText();
  const ranges: vscode.Range[] = [];

  for (const pattern of [REMOVE_BOUNDARY_MARKER_PATTERN, DROP_MARKER_PATTERN]) {
    for (const match of text.matchAll(pattern)) {
      const index = match.index;
      if (index === undefined) continue;
      ranges.push(
        new vscode.Range(
          document.positionAt(index),
          document.positionAt(index + match[0].length),
        ),
      );
    }
  }

  return ranges;
}

export function refreshRemoveHighlights(
  editor: vscode.TextEditor | undefined,
  config: AnnotationConfig,
): void {
  ensureDecorations(config);

  if (editor === undefined || !isSupportedBrickFile(editor.document)) return;

  const text = editor.document.getText();
  editor.setDecorations(markerDecoration, findRemovedBoundaryMarkerRanges(editor.document));
  editor.setDecorations(
    contentDecoration,
    interiorsToRanges(editor.document, [
      ...findPairedBlockInteriors(text, REMOVE_MARKER_SETS),
      ...findDropBlockInteriors(text),
    ]),
  );
}

export function registerRemoveHighlighting(context: vscode.ExtensionContext): void {
  context.subscriptions.push(
    new vscode.Disposable(() => {
      markerDecoration.dispose();
      contentDecoration.dispose();
    }),
  );
}
