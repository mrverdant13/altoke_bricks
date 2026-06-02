import * as vscode from 'vscode';

import {
  findNamedPairedBlockSpans,
  findPairedBlockSpans,
  type TextSpan,
} from './annotationBlockPairing';
import {
  PARTIAL_MARKER_SETS,
  REMOVE_MARKER_SETS,
  REPLACE_MARKER_SETS,
} from './annotationMarkerSets';
import { isSupportedBrickFile } from './supportedFiles';

function spansToFoldingRanges(
  document: vscode.TextDocument,
  spans: TextSpan[],
): vscode.FoldingRange[] {
  return spans.map(({ start, end }) => {
    const startLine = document.positionAt(start).line;
    const endLine = document.positionAt(Math.max(start, end - 1)).line;

    return new vscode.FoldingRange(
      startLine,
      endLine,
      vscode.FoldingRangeKind.Region,
    );
  });
}

function collectAnnotationFoldingRanges(
  document: vscode.TextDocument,
): vscode.FoldingRange[] {
  const text = document.getText();
  const spans = [
    ...findPairedBlockSpans(text, REMOVE_MARKER_SETS),
    ...findPairedBlockSpans(text, REPLACE_MARKER_SETS),
    ...findNamedPairedBlockSpans(text, PARTIAL_MARKER_SETS),
  ];

  return spansToFoldingRanges(document, spans);
}

export function registerBlockFolding(context: vscode.ExtensionContext): void {
  const provider: vscode.FoldingRangeProvider = {
    provideFoldingRanges(document) {
      if (!isSupportedBrickFile(document)) {
        return [];
      }

      return collectAnnotationFoldingRanges(document);
    },
  };

  context.subscriptions.push(
    vscode.languages.registerFoldingRangeProvider({ scheme: 'file' }, provider),
  );
}
