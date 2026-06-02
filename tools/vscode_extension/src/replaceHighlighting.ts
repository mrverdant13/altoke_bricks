import * as vscode from 'vscode';

import { type AnnotationConfig } from './annotationConfig';
import { collectRegexMatches, type TextMatch } from './markerScanning';
import { interiorsToRanges } from './rangeUtils';
import { isSupportedBrickFile } from './supportedFiles';

type ReplaceMarkerKind = 'start' | 'with' | 'end';

interface ReplaceMarker extends TextMatch {
  kind: ReplaceMarkerKind;
}

interface ReplaceMarkerSet {
  start: RegExp;
  withMarker: RegExp;
  end: RegExp;
}

const REPLACE_MARKER_SETS: ReplaceMarkerSet[] = [
  {
    start: /\/\*replace-start\*\//g,
    withMarker: /\/\*with(?: +i\d+)?\*\//g,
    end: /\/\*replace-end\*\//g,
  },
  {
    start: /#replace-start#/g,
    withMarker: /#with(?: +i\d+)?#/g,
    end: /#replace-end#/g,
  },
  {
    start: /<!--replace-start-->/g,
    withMarker: /<!--with(?: +i\d+)?-->/g,
    end: /<!--replace-end-->/g,
  },
];

const REPLACE_START_END_MARKER_PATTERN =
  /\/\*replace-start\*\/|\/\*replace-end\*\/|#replace-start#|#replace-end#|<!--replace-start-->|<!--replace-end-->/g;

const WITH_MARKER_PATTERN =
  /\/\*with(?: +i\d+)?\*\/|#with(?: +i\d+)?#|<!--with(?: +i\d+)?-->/g;

let boundaryDecoration = vscode.window.createTextEditorDecorationType({});
let withDecoration = vscode.window.createTextEditorDecorationType({});
let originalDecoration = vscode.window.createTextEditorDecorationType({});
let replacementDecoration = vscode.window.createTextEditorDecorationType({});
let appliedConfigKey = '';

function ensureDecorations(config: AnnotationConfig): void {
  const key = JSON.stringify(config.replace);
  if (key === appliedConfigKey) return;

  const prevBoundary = boundaryDecoration;
  const prevWith = withDecoration;
  const prevOriginal = originalDecoration;
  const prevReplacement = replacementDecoration;

  boundaryDecoration = vscode.window.createTextEditorDecorationType({
    color: config.replace.boundaryMarkerForeground,
    fontWeight: 'bold',
  });
  withDecoration = vscode.window.createTextEditorDecorationType({
    color: config.replace.withMarkerForeground,
    fontWeight: 'bold',
  });
  originalDecoration = vscode.window.createTextEditorDecorationType({
    backgroundColor: config.replace.originalBackground,
    isWholeLine: false,
  });
  replacementDecoration = vscode.window.createTextEditorDecorationType({
    backgroundColor: config.replace.replacementBackground,
    isWholeLine: false,
  });

  prevBoundary.dispose();
  prevWith.dispose();
  prevOriginal.dispose();
  prevReplacement.dispose();
  appliedConfigKey = key;
}

function collectReplaceMarkers(
  text: string,
  pattern: RegExp,
  kind: ReplaceMarkerKind,
): ReplaceMarker[] {
  return collectRegexMatches(text, pattern).map((m) => ({ ...m, kind }));
}

interface ReplaceBlockRegions {
  originalInteriors: Array<{ start: number; end: number }>;
  replacementInteriors: Array<{ start: number; end: number }>;
}

function findReplaceBlockRegions(text: string): ReplaceBlockRegions {
  const originalInteriors: Array<{ start: number; end: number }> = [];
  const replacementInteriors: Array<{ start: number; end: number }> = [];

  for (const markerSet of REPLACE_MARKER_SETS) {
    const markers = [
      ...collectReplaceMarkers(text, markerSet.start, 'start'),
      ...collectReplaceMarkers(text, markerSet.withMarker, 'with'),
      ...collectReplaceMarkers(text, markerSet.end, 'end'),
    ].sort((a, b) => a.offset - b.offset);

    let expecting: ReplaceMarkerKind = 'start';
    let blockStart: ReplaceMarker | undefined;
    let withMarker: ReplaceMarker | undefined;

    for (const marker of markers) {
      switch (expecting) {
        case 'start':
          if (marker.kind === 'start') { blockStart = marker; expecting = 'with'; }
          break;
        case 'with':
          if (marker.kind === 'with') {
            if (blockStart !== undefined) {
              const s = blockStart.offset + blockStart.length;
              const e = marker.offset;
              if (e > s) originalInteriors.push({ start: s, end: e });
            }
            withMarker = marker;
            expecting = 'end';
          } else if (marker.kind === 'start') {
            blockStart = marker; withMarker = undefined;
          } else {
            expecting = 'start'; blockStart = undefined; withMarker = undefined;
          }
          break;
        case 'end':
          if (marker.kind === 'end') {
            if (withMarker !== undefined) {
              const s = withMarker.offset + withMarker.length;
              const e = marker.offset;
              if (e > s) replacementInteriors.push({ start: s, end: e });
            }
            expecting = 'start'; blockStart = undefined; withMarker = undefined;
          } else if (marker.kind === 'start') {
            blockStart = marker; withMarker = undefined; expecting = 'with';
          }
          break;
      }
    }
  }

  return { originalInteriors, replacementInteriors };
}

function findRangesForPattern(
  document: vscode.TextDocument,
  pattern: RegExp,
): vscode.Range[] {
  const ranges: vscode.Range[] = [];
  for (const match of document.getText().matchAll(pattern)) {
    const index = match.index;
    if (index === undefined) continue;
    ranges.push(
      new vscode.Range(
        document.positionAt(index),
        document.positionAt(index + match[0].length),
      ),
    );
  }
  return ranges;
}

export function refreshReplaceHighlights(
  editor: vscode.TextEditor | undefined,
  config: AnnotationConfig,
): void {
  ensureDecorations(config);

  if (editor === undefined || !isSupportedBrickFile(editor.document)) return;

  const { originalInteriors, replacementInteriors } = findReplaceBlockRegions(
    editor.document.getText(),
  );

  editor.setDecorations(
    boundaryDecoration,
    findRangesForPattern(editor.document, REPLACE_START_END_MARKER_PATTERN),
  );
  editor.setDecorations(
    withDecoration,
    findRangesForPattern(editor.document, WITH_MARKER_PATTERN),
  );
  editor.setDecorations(
    originalDecoration,
    interiorsToRanges(editor.document, originalInteriors),
  );
  editor.setDecorations(
    replacementDecoration,
    interiorsToRanges(editor.document, replacementInteriors),
  );
}

export function registerReplaceHighlighting(context: vscode.ExtensionContext): void {
  context.subscriptions.push(
    new vscode.Disposable(() => {
      boundaryDecoration.dispose();
      withDecoration.dispose();
      originalDecoration.dispose();
      replacementDecoration.dispose();
    }),
  );
}
