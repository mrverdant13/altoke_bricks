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

interface MarkerSet {
  start: RegExp;
  end: RegExp;
}

const REMOVE_MARKER_SETS: MarkerSet[] = [
  { start: /\/\*(?:x-)?remove-start\*\//g, end: /\/\*remove-end(?:-x)?\*\//g },
  { start: /#(?:x-)?remove-start#/g, end: /#remove-end(?:-x)?#/g },
  { start: /<!--(?:x-)?remove-start-->/g, end: /<!--remove-end(?:-x)?-->/g },
];

const DROP_MARKER_SETS = [/\/\*drop\*\//g, /#drop#/g, /<!--drop-->/g];

const REMOVE_BOUNDARY_MARKER_PATTERN =
  /\/\*(?:x-)?remove-start\*\/|\/\*remove-end(?:-x)?\*\/|#(?:x-)?remove-start#|#remove-end(?:-x)?#|<!--(?:x-)?remove-start-->|<!--remove-end(?:-x)?-->/g;

const DROP_MARKER_PATTERN = /\/\*drop\*\/|#drop#|<!--drop-->/g;

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

function collectMarkers(text: string, pattern: RegExp, kind: MarkerKind): MarkerMatch[] {
  return collectRegexMatches(text, pattern).map((m) => ({ ...m, kind }));
}

function findRemoveBlockInteriors(text: string): Array<{ start: number; end: number }> {
  const interiors: Array<{ start: number; end: number }> = [];

  for (const markerSet of REMOVE_MARKER_SETS) {
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

function findDropBlockInteriors(text: string): Array<{ start: number; end: number }> {
  const interiors: Array<{ start: number; end: number }> = [];
  const documentEnd = text.length;

  for (const pattern of DROP_MARKER_SETS) {
    for (const match of collectRegexMatches(text, pattern)) {
      const interiorStart = match.offset + match.length;
      if (documentEnd > interiorStart) {
        interiors.push({ start: interiorStart, end: documentEnd });
      }
    }
  }

  return interiors;
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
      ...findRemoveBlockInteriors(text),
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
