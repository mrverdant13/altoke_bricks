import * as vscode from 'vscode';

import type { BrickVariable } from './brickVariables';

export type PreviewVarValue = string | boolean;

const STORAGE_KEY_PREFIX = 'brickGenerator.previewVariables.';

export function loadSavedPreviewVariables(
  context: vscode.ExtensionContext,
  scopeName: string,
  variables: BrickVariable[],
): Record<string, PreviewVarValue> {
  const stored = context.globalState.get<Record<string, PreviewVarValue>>(
    storageKey(scopeName),
  );
  if (!stored) {
    return {};
  }

  const validated: Record<string, PreviewVarValue> = {};
  for (const variable of variables) {
    const value = stored[variable.name];
    if (value !== undefined && isValidStoredValue(variable, value)) {
      validated[variable.name] = value;
    }
  }
  return validated;
}

export async function savePreviewVariables(
  context: vscode.ExtensionContext,
  scopeName: string,
  values: Record<string, PreviewVarValue>,
): Promise<void> {
  await context.globalState.update(storageKey(scopeName), values);
}

function storageKey(scopeName: string): string {
  return `${STORAGE_KEY_PREFIX}${scopeName}`;
}

function isValidStoredValue(
  variable: BrickVariable,
  value: PreviewVarValue,
): boolean {
  switch (variable.type) {
    case 'boolean':
      return typeof value === 'boolean';
    case 'enum':
      return typeof value === 'string' && (variable.values ?? []).includes(value);
    default:
      return typeof value === 'string';
  }
}

export function resolvePreviewDefault(
  variable: BrickVariable,
  savedValues: Record<string, PreviewVarValue>,
): string | boolean | undefined {
  const saved = savedValues[variable.name];
  if (saved !== undefined) {
    if (variable.type === 'boolean' && typeof saved === 'boolean') {
      return saved;
    }
    if (variable.type === 'enum' && typeof saved === 'string') {
      return saved;
    }
    if (variable.type === 'string' && typeof saved === 'string') {
      return saved;
    }
  }

  return variable.default;
}
