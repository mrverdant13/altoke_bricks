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
): vscode.Range | undefined {
  const capture = match[groupIndex];
  if (capture === undefined || capture.length === 0) {
    return undefined;
  }

  const start = (match.index ?? 0) + match[0].indexOf(capture);
  return new vscode.Range(
    document.positionAt(start),
    document.positionAt(start + capture.length),
  );
}
