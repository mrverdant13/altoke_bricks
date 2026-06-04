import * as fs from 'fs';
import * as path from 'path';

export interface BrickGenReplacement {
  from: RegExp;
  to: string;
}

export interface BrickGenLineDeletion {
  filePath: string;
}

export interface BrickGenOptions {
  replacements: BrickGenReplacement[];
  lineDeletions: BrickGenLineDeletion[];
}

interface BrickGenJson {
  replacements?: Array<{ from: string | RegExpSource; to: string }>;
  lineDeletions?: Array<{ filePath: string }>;
}

interface RegExpSource {
  pattern: string;
  dotAll?: boolean;
  multiLine?: boolean;
  unicode?: boolean;
  caseSensitive?: boolean;
}

/** Loads `brick-gen.json` from a brick scope directory. */
export function loadBrickGenOptions(scopeDir: string): BrickGenOptions {
  const brickGenPath = path.join(scopeDir, 'brick-gen.json');
  const raw = fs.readFileSync(brickGenPath, 'utf8');
  const document = JSON.parse(raw) as BrickGenJson;
  return {
    replacements: (document.replacements ?? []).map((replacement) => ({
      from: parseReplacementFrom(replacement.from),
      to: replacement.to,
    })),
    lineDeletions: (document.lineDeletions ?? []).map((deletion) => ({
      filePath: deletion.filePath,
    })),
  };
}

/** Applies brick-gen content replacements (same order as the CLI). */
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
