import type { BrickGenOptions } from './brickGen';
import { applyBrickGenReplacements } from './brickGen';
import type { BrickVariable, BrickVarType } from './brickVariables';

type InferredVarType = 'boolean' | 'string';

const MUSTACHE_TAG_PATTERN = /\{\{\{?([^}]+)\}\}?\}/g;

/**
 * Variables required to preview [fileContent]: Mustache names in the file after
 * applying [brickGen] content replacements, using [brickVariables] definitions
 * when available.
 */
export function resolvePreviewVariables(
  brickVariables: BrickVariable[],
  fileContent: string,
  brickGen: BrickGenOptions,
): BrickVariable[] {
  const transformedContent = applyBrickGenReplacements(
    fileContent,
    brickGen.replacements,
  );
  const referenced = extractMustacheVariables(transformedContent);
  if (referenced.size === 0) {
    return [];
  }

  const ordered: BrickVariable[] = [];

  for (const variable of brickVariables) {
    if (referenced.has(variable.name)) {
      ordered.push(variable);
      referenced.delete(variable.name);
    }
  }

  for (const [name, inferredType] of [...referenced.entries()].sort(([a], [b]) =>
    a.localeCompare(b),
  )) {
    ordered.push({
      name,
      type: toBrickVarType(inferredType),
    });
  }

  return ordered;
}

function extractMustacheVariables(
  content: string,
): Map<string, InferredVarType> {
  const usages = new Map<string, Set<'section' | 'value'>>();

  for (const match of content.matchAll(MUSTACHE_TAG_PATTERN)) {
    const body = match[1]?.trim();
    if (!body || body.startsWith('>') || body.startsWith('~')) {
      continue;
    }

    const sectionMatch = /^([#^/!])\s*([A-Za-z_][\w]*(?:\.[A-Za-z_][\w]*)*)/.exec(body);
    if (sectionMatch) {
      recordUsage(usages, baseVariableName(sectionMatch[2]), 'section');
      continue;
    }

    const variableMatch = /^([A-Za-z_][\w]*(?:\.[A-Za-z_][\w]*)*)/.exec(body);
    if (variableMatch) {
      recordUsage(usages, baseVariableName(variableMatch[1]), 'value');
    }
  }

  const inferred = new Map<string, InferredVarType>();
  for (const [name, kinds] of usages) {
    inferred.set(name, kinds.has('value') ? 'string' : 'boolean');
  }
  return inferred;
}

function recordUsage(
  usages: Map<string, Set<'section' | 'value'>>,
  name: string,
  kind: 'section' | 'value',
): void {
  const existing = usages.get(name) ?? new Set();
  existing.add(kind);
  usages.set(name, existing);
}

function baseVariableName(expression: string): string {
  return expression.split('.')[0] ?? expression;
}

function toBrickVarType(inferredType: InferredVarType): BrickVarType {
  return inferredType === 'boolean' ? 'boolean' : 'string';
}
