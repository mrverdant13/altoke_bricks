import * as path from 'path';
import * as vscode from 'vscode';

import { findBrickScopeForFile } from './brickScope';
import { resolveClayCli } from './clayCli';
import { loadBrickGenOptions } from './brickGen';
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
export const PREVIEW_TEMPLATE_COMMAND_ID = 'brickGenerator.previewTemplate';

export function registerPreviewCommand(context: vscode.ExtensionContext): void {
  context.subscriptions.push(
    vscode.commands.registerCommand(
      PREVIEW_COMMAND_ID,
      async (uri?: vscode.Uri) => {
        await previewOutput(context, uri, { templateOnly: false });
      },
    ),
    vscode.commands.registerCommand(
      PREVIEW_TEMPLATE_COMMAND_ID,
      async (uri?: vscode.Uri) => {
        await previewOutput(context, uri, { templateOnly: true });
      },
    ),
  );
}

async function previewOutput(
  context: vscode.ExtensionContext,
  uri: vscode.Uri | undefined,
  mode: { templateOnly: boolean },
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
      'Could not find a brick scope (clay.yaml) for this file.',
    );
    return;
  }

  let selectedValues: Record<string, string | boolean> | undefined;

  if (!mode.templateOnly) {
    let brickVariables;
    let brickGen;
    try {
      brickVariables = loadBrickVariables(scope.brickYamlPath);
      brickGen = loadBrickGenOptions(scope.scopeDir);
    } catch (error) {
      const message = error instanceof Error ? error.message : String(error);
      void vscode.window.showErrorMessage(
        `Could not load brick configuration: ${message}`,
      );
      return;
    }

    const variables = resolvePreviewVariables(
      brickVariables,
      document.getText(),
      brickGen,
    );
    const savedValues = loadSavedPreviewVariables(
      context,
      scope.scopeName,
      variables,
    );
    selectedValues = await collectPreviewVariableValues(variables, savedValues);
    if (selectedValues === undefined) {
      return;
    }

    await savePreviewVariables(context, scope.scopeName, selectedValues);
  }

  let cliCommand: string;
  try {
    cliCommand = await resolveClayCli();
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    void vscode.window.showErrorMessage(message);
    return;
  }

  const progressTitle = mode.templateOnly
    ? 'Generating template preview…'
    : 'Generating preview…';
  const diffTitlePrefix = mode.templateOnly ? 'Template preview' : 'Preview';

  await vscode.window.withProgress(
    {
      location: vscode.ProgressLocation.Notification,
      title: progressTitle,
      cancellable: false,
    },
    async () => {
      try {
        const previewContent = await runPreviewCommand({
          scope,
          filePath: document.fileName,
          vars: selectedValues,
          cliCommand,
          templateOnly: mode.templateOnly,
        });
        await openPreviewDiff(document, previewContent, diffTitlePrefix);
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
  titlePrefix: string,
): Promise<void> {
  const previewDocument = await vscode.workspace.openTextDocument({
    content: previewContent,
    language: original.languageId,
  });
  const title = `${titlePrefix}: ${path.basename(original.fileName)}`;
  await vscode.commands.executeCommand(
    'vscode.diff',
    original.uri,
    previewDocument.uri,
    title,
  );
}
