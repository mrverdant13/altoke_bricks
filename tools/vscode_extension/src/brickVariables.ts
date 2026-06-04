import * as fs from 'fs';

import { parse as parseYaml } from 'yaml';

export type BrickVarType = 'string' | 'boolean' | 'enum';

export interface BrickVariable {
  name: string;
  type: BrickVarType;
  description?: string;
  prompt?: string;
  default?: string | boolean;
  values?: string[];
}

interface BrickYamlDocument {
  vars?: Record<string, Record<string, unknown>>;
}

/** Loads Mason variable definitions from a brick's `brick.yaml`. */
export function loadBrickVariables(brickYamlPath: string): BrickVariable[] {
  const content = fs.readFileSync(brickYamlPath, 'utf8');
  const document = parseYaml(content) as BrickYamlDocument | null;
  if (!document?.vars) {
    return [];
  }

  return Object.entries(document.vars).map(([name, definition]) => {
    const type = (definition.type as BrickVarType | undefined) ?? 'string';
    const values = Array.isArray(definition.values)
      ? definition.values.map((value) => normalizeYamlScalar(String(value)))
      : undefined;

    let defaultValue = definition.default;
    if (typeof defaultValue === 'string') {
      defaultValue = normalizeYamlScalar(defaultValue);
    }

    return {
      name,
      type,
      description:
        typeof definition.description === 'string' ? definition.description : undefined,
      prompt: typeof definition.prompt === 'string' ? definition.prompt : undefined,
      default: defaultValue as string | boolean | undefined,
      values,
    };
  });
}

/** Formats a variable map for the preview CLI `--vars` flag. */
export function formatVarsForCli(
  vars: Record<string, string | boolean | number>,
): string {
  return Object.entries(vars)
    .map(([key, value]) => {
      if (typeof value === 'boolean' || typeof value === 'number') {
        return `${key}=${value}`;
      }
      if (value.includes(',') || value.includes('=')) {
        return `${key}="${value}"`;
      }
      return `${key}=${value}`;
    })
    .join(',');
}

function normalizeYamlScalar(value: string): string {
  if (
    (value.startsWith('`') && value.endsWith('`')) ||
    (value.startsWith("'") && value.endsWith("'")) ||
    (value.startsWith('"') && value.endsWith('"'))
  ) {
    return value.slice(1, -1);
  }
  return value;
}
