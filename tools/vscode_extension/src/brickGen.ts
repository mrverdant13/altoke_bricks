import * as fs from 'fs';
import * as path from 'path';

import { parse as parseYaml } from 'yaml';

export interface BrickGenReplacement {
  from: RegExp;
  to: string;
}

export interface BrickGenLineRange {
  start: number;
  end: number;
}

export interface BrickGenLineDeletion {
  filePath: string;
  ranges: BrickGenLineRange[];
}

export interface BrickGenOptions {
  replacements: BrickGenReplacement[];
  lineDeletions: BrickGenLineDeletion[];
}

interface BrickGenJson {
  replacements?: Array<{ from: string | RegExpSource; to: string }>;
  lineDeletions?: Array<{ filePath: string; ranges?: BrickGenLineRange[] }>;
}

interface RegExpSource {
  pattern: string;
  dotAll?: boolean;
  multiLine?: boolean;
  unicode?: boolean;
  caseSensitive?: boolean;
}

/** Loads `clay.yaml` from a brick scope directory. */
export function loadBrickGenOptions(scopeDir: string): BrickGenOptions {
  const clayConfigPath = path.join(scopeDir, 'clay.yaml');
  const raw = fs.readFileSync(clayConfigPath, 'utf8');
  const document = parseYaml(raw) as BrickGenJson;
  return {
    replacements: (document.replacements ?? []).map((replacement) => ({
      from: parseReplacementFrom(replacement.from),
      to: replacement.to,
    })),
    lineDeletions: (document.lineDeletions ?? []).map((deletion) => ({
      filePath: deletion.filePath,
      ranges: (deletion.ranges ?? []).map((range) => ({
        start: range.start,
        end: range.end,
      })),
    })),
  };
}

/** Applies clay.yaml content replacements (same order as the CLI). */
export function applyBrickGenReplacements(
  content: string,
  replacements: BrickGenReplacement[],
): string {
  return replacements.reduce(
    (resolved, replacement) => applyReplacement(resolved, replacement),
    content,
  );
}

function applyReplacement(input: string, replacement: BrickGenReplacement): string {
  const groupNumbers = [...uniqueCaptureGroups(replacement.to)];

  return input.replace(replacement.from, (...matchArgs) => {
    let resolvedTo = replacement.to;
    for (const group of groupNumbers) {
      const value = matchArgs[group] ?? '';
      resolvedTo = resolvedTo.replaceAll(`\${${group}}`, value);
    }
    return resolvedTo;
  });
}

function uniqueCaptureGroups(to: string): number[] {
  const seen = new Set<number>();
  const groups: number[] = [];
  for (const match of to.matchAll(/\$\{(\d+)\}/g)) {
    const group = Number.parseInt(match[1] ?? '', 10);
    if (Number.isNaN(group) || seen.has(group)) {
      continue;
    }
    seen.add(group);
    groups.push(group);
  }
  return groups;
}

function parseReplacementFrom(value: string | RegExpSource): RegExp {
  if (typeof value === 'string') {
    return new RegExp(value, 'g');
  }

  const flags = [
    'g',
    value.caseSensitive === false ? 'i' : '',
    value.multiLine ? 'm' : '',
    value.dotAll ? 's' : '',
    value.unicode ? 'u' : '',
  ].join('');

  return new RegExp(value.pattern, flags);
}
