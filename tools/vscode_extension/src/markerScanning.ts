export interface TextMatch {
  offset: number;
  length: number;
}

export function collectRegexMatches(
  text: string,
  pattern: RegExp,
): TextMatch[] {
  const matches: TextMatch[] = [];
  const expression = new RegExp(pattern.source, pattern.flags);

  for (const match of text.matchAll(expression)) {
    const offset = match.index;
    if (offset === undefined) {
      continue;
    }
    matches.push({ offset, length: match[0].length });
  }

  return matches;
}
