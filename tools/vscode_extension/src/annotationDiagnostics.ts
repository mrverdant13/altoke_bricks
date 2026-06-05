import * as vscode from 'vscode';

import {
  validateAnnotationContent,
  type AnnotationIssue,
} from './annotationValidator';
import { isSupportedBrickFile } from './supportedFiles';

const DIAGNOSTIC_SOURCE = 'brick-generator';

function issueToDiagnostic(
  document: vscode.TextDocument,
  issue: AnnotationIssue,
): vscode.Diagnostic {
  const start = document.positionAt(issue.offset);
  const end = document.positionAt(issue.offset + issue.length);
  const diagnostic = new vscode.Diagnostic(
    new vscode.Range(start, end),
    issue.message,
    vscode.DiagnosticSeverity.Error,
  );
  diagnostic.source = DIAGNOSTIC_SOURCE;
  return diagnostic;
}

function validateDocument(document: vscode.TextDocument): vscode.Diagnostic[] {
  if (!isSupportedBrickFile(document)) {
    return [];
  }

  return validateAnnotationContent(document.getText()).map((issue) =>
    issueToDiagnostic(document, issue),
  );
}

export function registerAnnotationDiagnostics(
  context: vscode.ExtensionContext,
): void {
  const collection = vscode.languages.createDiagnosticCollection(DIAGNOSTIC_SOURCE);

  const refresh = (document: vscode.TextDocument): void => {
    if (document.uri.scheme !== 'file') {
      return;
    }
    collection.set(document.uri, validateDocument(document));
  };

  const clear = (document: vscode.TextDocument): void => {
    collection.delete(document.uri);
  };

  for (const editor of vscode.window.visibleTextEditors) {
    refresh(editor.document);
  }

  context.subscriptions.push(
    collection,
    vscode.workspace.onDidOpenTextDocument(refresh),
    vscode.workspace.onDidChangeTextDocument((event) => refresh(event.document)),
    vscode.workspace.onDidCloseTextDocument(clear),
  );
}
