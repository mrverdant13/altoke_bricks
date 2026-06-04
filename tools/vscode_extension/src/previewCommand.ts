import * as path from 'path';
import * as vscode from 'vscode';

import { findBrickScopeForFile } from './brickScope';
import { resolveBrickGeneratorCli } from './brickGeneratorCli';
import { loadBrickVariables } from './brickVariables';
import { resolvePreviewVariables } from './previewFileVariables';
import {
  loadSavedPreviewVariables,
  savePreviewVariables,
} from './previewVariableState';
import { runPreviewCommand } from './previewRunner';
import { isSupportedBrickFile } from './supportedFiles';
import { collectPreviewVariableValues } from './variableQuickPick';

export const PREVIEW_COMMAND_ID = 'brickGenerator.preview';

export function registerPreviewCommand(context: vscode.ExtensionContext): void {
  context.subscriptions.push(
    vscode.commands.registerCommand(
      PREVIEW_COMMAND_ID,
      async (uri?: vscode.Uri) => {
        await previewGeneratedOutput(context, uri);
      },
    ),
  );
}

async function previewGeneratedOutput(
  context: vscode.ExtensionContext,
  uri?: vscode.Uri,
): Promise<void> {
  const document = await resolveTargetDocument(uri);
  if (!document) {
    return;
  }

  if (!isSupportedBrickFile(document)) {
    void vscode.window.showWarningMessage(
      'Brick Generator preview is only available for supported reference files.',
    );
    return;
  }

  const scope = findBrickScopeForFile(document.fileName);
  if (!scope) {
    void vscode.window.showWarningMessage(
      'Could not find a brick scope (brick-gen.json) for this file.',
    );
    return;
  }

  let brickVariables;
  try {
    brickVariables = loadBrickVariables(scope.brickYamlPath);
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    void vscode.window.showErrorMessage(
      `Could not load brick variables: ${message}`,
    );
    return;
  }

  const variables = resolvePreviewVariables(brickVariables, document.getText());
  const savedValues = loadSavedPreviewVariables(context, scope.scopeName, variables);
  const selectedValues = await collectPreviewVariableValues(variables, savedValues);
  if (selectedValues === undefined) {
    return;
  }

  await savePreviewVariables(context, scope.scopeName, selectedValues);

  let cliCommand: string;
  try {
    cliCommand = await resolveBrickGeneratorCli();
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    void vscode.window.showErrorMessage(message);
    return;
  }

  await vscode.window.withProgress(
    {
      location: vscode.ProgressLocation.Notification,
      title: 'Generating preview…',
      cancellable: false,
    },
    async () => {
      try {
        const previewContent = await runPreviewCommand({
          scope,
          filePath: document.fileName,
          vars: selectedValues,
          cliCommand,
        });
        await openPreviewDiff(document, previewContent);
      } catch (error) {
        const message = error instanceof Error ? error.message : String(error);
        void vscode.window.showErrorMessage(`Preview failed: ${message}`);
      }
    },
  );
}

async function resolveTargetDocument(
  uri?: vscode.Uri,
): Promise<vscode.TextDocument | undefined> {
  if (uri) {
    return vscode.workspace.openTextDocument(uri);
  }

  const editor = vscode.window.activeTextEditor;
  if (!editor) {
    void vscode.window.showWarningMessage('Open a reference file to preview.');
    return undefined;
  }

  return editor.document;
}

async function openPreviewDiff(
  original: vscode.TextDocument,
  previewContent: string,
): Promise<void> {
  const previewDocument = await vscode.workspace.openTextDocument({
    content: previewContent,
    language: original.languageId,
  });
  const title = `Preview: ${path.basename(original.fileName)}`;
  await vscode.commands.executeCommand(
    'vscode.diff',
    original.uri,
    previewDocument.uri,
    title,
  );
}
