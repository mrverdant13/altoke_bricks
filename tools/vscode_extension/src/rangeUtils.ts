import * as vscode from 'vscode';

export function interiorsToRanges(
  document: vscode.TextDocument,
  interiors: Array<{ start: number; end: number }>,
): vscode.Range[] {
  return interiors.map(
    ({ start, end }) =>
      new vscode.Range(document.positionAt(start), document.positionAt(end)),
  );
}

export function matchToRange(
  document: vscode.TextDocument,
  match: RegExpMatchArray,
): vscode.Range {
  const index = match.index ?? 0;
  return new vscode.Range(
    document.positionAt(index),
    document.positionAt(index + match[0].length),
  );
}

export function captureToRange(
  document: vscode.TextDocument,
  match: RegExpMatchArray,
  groupIndex: number,
  occurrence: 'first' | 'last' = 'first',
): vscode.Range | undefined {
  const capture = match[groupIndex];
  if (capture === undefined || capture.length === 0) {
    return undefined;
  }

  const offsetInMatch =
    occurrence === 'last'
      ? match[0].lastIndexOf(capture)
      : match[0].indexOf(capture);
  const start = (match.index ?? 0) + offsetInMatch;

  return new vscode.Range(
    document.positionAt(start),
    document.positionAt(start + capture.length),
  );
}

function hasNonWhitespaceBefore(
  document: vscode.TextDocument,
  offset: number,
): boolean {
  const line = document.lineAt(document.positionAt(offset).line);
  const before = document.getText(
    new vscode.Range(line.range.start, document.positionAt(offset)),
  );
  return before.trim().length > 0;
}

function hasNonWhitespaceAfter(
  document: vscode.TextDocument,
  offset: number,
): boolean {
  const line = document.lineAt(document.positionAt(offset).line);
  const after = document.getText(
    new vscode.Range(document.positionAt(offset), line.range.end),
  );
  return after.trim().length > 0;
}

/** Maps a marker span to fold lines, keeping same-line leading/trailing code visible. */
export function spanToFoldingRange(
  document: vscode.TextDocument,
  span: { start: number; end: number; endMarkerStart?: number },
): vscode.FoldingRange | undefined {
  const startLine = document.positionAt(span.start).line;
  const endLine = document.positionAt(Math.max(span.start, span.end - 1)).line;

  let foldStartLine = startLine;
  let foldEndLine = endLine;

  if (hasNonWhitespaceBefore(document, span.start)) {
    foldStartLine = startLine + 1;
  }

  const endMarkerStart = span.endMarkerStart ?? span.end;
  if (
    hasNonWhitespaceBefore(document, endMarkerStart) ||
    hasNonWhitespaceAfter(document, span.end)
  ) {
    foldEndLine = endLine - 1;
  }

  if (foldStartLine >= foldEndLine) {
    return undefined;
  }

  return new vscode.FoldingRange(
    foldStartLine,
    foldEndLine,
    vscode.FoldingRangeKind.Region,
  );
}
