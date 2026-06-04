import * as vscode from 'vscode';

import type { BrickVariable } from './brickVariables';

type PreviewVarValue = string | boolean | number;

export async function collectPreviewVariableValues(
  variables: BrickVariable[],
): Promise<Record<string, PreviewVarValue> | undefined> {
  const values: Record<string, PreviewVarValue> = {};

  for (const variable of variables) {
    const label = variable.prompt ?? variable.description ?? variable.name;
    const value = await promptForVariableValue(variable, label);
    if (value === undefined) {
      return undefined;
    }
    values[variable.name] = value;
  }

  return values;
}

async function promptForVariableValue(
  variable: BrickVariable,
  label: string,
): Promise<PreviewVarValue | undefined> {
  switch (variable.type) {
    case 'boolean':
      return promptBooleanVariable(variable, label);
    case 'enum':
      return promptEnumVariable(variable, label);
    default:
      return promptStringVariable(variable, label);
  }
}

async function promptBooleanVariable(
  variable: BrickVariable,
  label: string,
): Promise<boolean | undefined> {
  const defaultValue =
    typeof variable.default === 'boolean' ? variable.default : false;
  const selection = await vscode.window.showQuickPick(
    [
      { label: 'true', picked: defaultValue === true },
      { label: 'false', picked: defaultValue === false },
    ],
    {
      title: label,
      placeHolder: `Set ${variable.name}`,
    },
  );
  if (!selection) {
    return undefined;
  }
  return selection.label === 'true';
}

async function promptEnumVariable(
  variable: BrickVariable,
  label: string,
): Promise<string | undefined> {
  const options = (variable.values ?? []).map((value) => ({
    label: value,
    picked: value === variable.default,
  }));
  if (options.length === 0) {
    return promptStringVariable(variable, label);
  }

  const selection = await vscode.window.showQuickPick(options, {
    title: label,
    placeHolder: `Choose ${variable.name}`,
  });
  return selection?.label;
}

async function promptStringVariable(
  variable: BrickVariable,
  label: string,
): Promise<string | undefined> {
  const defaultValue =
    typeof variable.default === 'string' ? variable.default : undefined;
  return vscode.window.showInputBox({
    title: label,
    prompt: variable.description,
    value: defaultValue,
    placeHolder: variable.name,
  });
}
