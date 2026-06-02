import * as vscode from 'vscode';

import { type AnnotationConfig } from './annotationConfig';
import { collectRegexMatches } from './markerScanning';
import { interiorsToRanges } from './rangeUtils';
import { isSupportedBrickFile } from './supportedFiles';

type MarkerKind = 'start' | 'end';

interface MarkerMatch {
  kind: MarkerKind;
  offset: number;
  length: number;
}

const INSERT_MARKER_SETS = [
  { start: /\/\*insert-start\*\//g, end: /\/\*insert-end\*\//g },
  { start: /#insert-start#/g, end: /#insert-end#/g },
  { start: /<!--insert-start-->/g, end: /<!--insert-end-->/g },
];

const INSERT_BOUNDARY_MARKER_PATTERN =
  /\/\*insert-start\*\/|\/\*insert-end\*\/|#insert-start#|#insert-end#|<!--insert-start-->|<!--insert-end-->/g;

let markerDecoration = vscode.window.createTextEditorDecorationType({});
let contentDecoration = vscode.window.createTextEditorDecorationType({});
let appliedConfigKey = '';

function ensureDecorations(config: AnnotationConfig): void {
  const key = JSON.stringify(config.insert);
  if (key === appliedConfigKey) return;

  const prevMarker = markerDecoration;
  const prevContent = contentDecoration;

  markerDecoration = vscode.window.createTextEditorDecorationType({
    color: config.insert.markerForeground,
    fontWeight: 'bold',
  });
  contentDecoration = vscode.window.createTextEditorDecorationType({
    backgroundColor: config.insert.contentBackground,
    isWholeLine: false,
  });

  prevMarker.dispose();
  prevContent.dispose();
  appliedConfigKey = key;
}

function collectMarkers(text: string, pattern: RegExp, kind: MarkerKind): MarkerMatch[] {
  return collectRegexMatches(text, pattern).map((m) => ({ ...m, kind }));
}

function findInsertBlockInteriors(text: string): Array<{ start: number; end: number }> {
  const interiors: Array<{ start: number; end: number }> = [];

  for (const markerSet of INSERT_MARKER_SETS) {
    const markers = [
      ...collectMarkers(text, markerSet.start, 'start'),
      ...collectMarkers(text, markerSet.end, 'end'),
    ].sort((a, b) => a.offset - b.offset);

    const stack: MarkerMatch[] = [];
    for (const marker of markers) {
      if (marker.kind === 'start') { stack.push(marker); continue; }
      if (stack.length === 0) continue;
      const startMarker = stack.pop()!;
      const interiorStart = startMarker.offset + startMarker.length;
      const interiorEnd = marker.offset;
      if (interiorEnd > interiorStart) {
        interiors.push({ start: interiorStart, end: interiorEnd });
      }
    }
  }

  return interiors;
}

export function refreshInsertHighlights(
  editor: vscode.TextEditor | undefined,
  config: AnnotationConfig,
): void {
  ensureDecorations(config);

  if (editor === undefined || !isSupportedBrickFile(editor.document)) return;

  const text = editor.document.getText();

  editor.setDecorations(
    markerDecoration,
    [...text.matchAll(INSERT_BOUNDARY_MARKER_PATTERN)]
      .filter((m) => m.index !== undefined)
      .map((m) => {
        const index = m.index!;
        return new vscode.Range(
          editor.document.positionAt(index),
          editor.document.positionAt(index + m[0].length),
        );
      }),
  );
  editor.setDecorations(
    contentDecoration,
    interiorsToRanges(editor.document, findInsertBlockInteriors(text)),
  );
}

export function registerInsertHighlighting(context: vscode.ExtensionContext): void {
  context.subscriptions.push(
    new vscode.Disposable(() => {
      markerDecoration.dispose();
      contentDecoration.dispose();
    }),
  );
}
