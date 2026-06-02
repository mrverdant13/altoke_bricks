import * as vscode from 'vscode';

import { type AnnotationConfig } from './annotationConfig';
import { interiorsToRanges } from './rangeUtils';
import { isSupportedBrickFile } from './supportedFiles';

type PartialMarkerKind = 'start' | 'end';

interface PartialMarker {
  kind: PartialMarkerKind;
  offset: number;
  length: number;
  name: string;
}

const PARTIAL_MARKER_SETS = [
  { start: /\/\*partial v ([^*]+)\*\//g, end: /\/\*partial \^ ([^*]+)\*\//g },
  { start: /#partial v ([^#]+)#/g, end: /#partial \^ ([^#]+)#/g },
  { start: /<!--partial v (.+?)-->/g, end: /<!--partial \^ (.+?)-->/g },
];

const PARTIAL_BOUNDARY_MARKER_PATTERN =
  /\/\*partial [v^] [^*]+\*\/|#partial [v^] [^#]+#|<!--partial [v^] .+?-->/g;

let markerDecoration = vscode.window.createTextEditorDecorationType({});
let payloadDecoration = vscode.window.createTextEditorDecorationType({});
let appliedConfigKey = '';

function ensureDecorations(config: AnnotationConfig): void {
  const key = JSON.stringify(config.partial);
  if (key === appliedConfigKey) return;

  const prevMarker = markerDecoration;
  const prevPayload = payloadDecoration;

  markerDecoration = vscode.window.createTextEditorDecorationType({
    color: config.partial.markerForeground,
    fontWeight: 'bold',
  });
  payloadDecoration = vscode.window.createTextEditorDecorationType({
    backgroundColor: config.partial.payloadBackground,
    isWholeLine: false,
  });

  prevMarker.dispose();
  prevPayload.dispose();
  appliedConfigKey = key;
}

function collectPartialMarkers(
  text: string,
  pattern: RegExp,
  kind: PartialMarkerKind,
): PartialMarker[] {
  const markers: PartialMarker[] = [];
  const expression = new RegExp(pattern.source, pattern.flags);

  for (const match of text.matchAll(expression)) {
    const offset = match.index;
    if (offset === undefined) continue;
    markers.push({ kind, offset, length: match[0].length, name: match[1] ?? '' });
  }

  return markers;
}

function findPartialPayloadInteriors(text: string): Array<{ start: number; end: number }> {
  const interiors: Array<{ start: number; end: number }> = [];

  for (const markerSet of PARTIAL_MARKER_SETS) {
    const markers = [
      ...collectPartialMarkers(text, markerSet.start, 'start'),
      ...collectPartialMarkers(text, markerSet.end, 'end'),
    ].sort((a, b) => a.offset - b.offset);

    const stack: PartialMarker[] = [];
    for (const marker of markers) {
      if (marker.kind === 'start') { stack.push(marker); continue; }
      if (stack.length === 0) continue;
      const startMarker = stack.pop()!;
      if (startMarker.name !== marker.name) continue;
      const interiorStart = startMarker.offset + startMarker.length;
      const interiorEnd = marker.offset;
      if (interiorEnd > interiorStart) {
        interiors.push({ start: interiorStart, end: interiorEnd });
      }
    }
  }

  return interiors;
}

export function refreshPartialHighlights(
  editor: vscode.TextEditor | undefined,
  config: AnnotationConfig,
): void {
  ensureDecorations(config);

  if (editor === undefined || !isSupportedBrickFile(editor.document)) return;

  const text = editor.document.getText();

  editor.setDecorations(
    markerDecoration,
    [...text.matchAll(PARTIAL_BOUNDARY_MARKER_PATTERN)]
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
    payloadDecoration,
    interiorsToRanges(editor.document, findPartialPayloadInteriors(text)),
  );
}

export function registerPartialHighlighting(context: vscode.ExtensionContext): void {
  context.subscriptions.push(
    new vscode.Disposable(() => {
      markerDecoration.dispose();
      payloadDecoration.dispose();
    }),
  );
}
