import { collectRegexMatches } from './markerScanning';

export interface AnnotationIssue {
  offset: number;
  line: number;
  column: number;
  message: string;
}

interface MarkerSet {
  flavor: string;
  blockName: string;
  start: RegExp;
  end: RegExp;
}

interface ReplaceMarkerSet {
  flavor: string;
  start: RegExp;
  withMarker: RegExp;
  end: RegExp;
}

interface PartialMarkerSet {
  flavor: string;
  start: RegExp;
  end: RegExp;
}

type MarkerKind = 'start' | 'end';

interface Marker {
  kind: MarkerKind;
  offset: number;
}

type ReplaceMarkerKind = 'start' | 'withMarker' | 'end';

interface ReplaceMarker {
  kind: ReplaceMarkerKind;
  offset: number;
}

type PartialMarkerKind = 'start' | 'end';

interface PartialMarker {
  kind: PartialMarkerKind;
  offset: number;
  name: string;
}

const REMOVE_MARKER_SETS: MarkerSet[] = [
  {
    flavor: '/* */',
    blockName: 'remove',
    start: /\/\*(?:x-)?remove-start\*\//g,
    end: /\/\*remove-end(?:-x)?\*\//g,
  },
  {
    flavor: '# #',
    blockName: 'remove',
    start: /#(?:x-)?remove-start#/g,
    end: /#remove-end(?:-x)?#/g,
  },
  {
    flavor: '<!-- -->',
    blockName: 'remove',
    start: /<!--(?:x-)?remove-start-->/g,
    end: /<!--remove-end(?:-x)?-->/g,
  },
];

const INSERT_MARKER_SETS: MarkerSet[] = [
  {
    flavor: '/* */',
    blockName: 'insert',
    start: /\/\*insert-start\*\//g,
    end: /\/\*insert-end\*\//g,
  },
  {
    flavor: '# #',
    blockName: 'insert',
    start: /#insert-start#/g,
    end: /#insert-end#/g,
  },
  {
    flavor: '<!-- -->',
    blockName: 'insert',
    start: /<!--insert-start-->/g,
    end: /<!--insert-end-->/g,
  },
];

const REPLACE_MARKER_SETS: ReplaceMarkerSet[] = [
  {
    flavor: '/* */',
    start: /\/\*replace-start\*\//g,
    withMarker: /\/\*with(?: +i\d+)?\*\//g,
    end: /\/\*replace-end\*\//g,
  },
  {
    flavor: '# #',
    start: /#replace-start#/g,
    withMarker: /#with(?: +i\d+)?#/g,
    end: /#replace-end#/g,
  },
  {
    flavor: '<!-- -->',
    start: /<!--replace-start-->/g,
    withMarker: /<!--with(?: +i\d+)?-->/g,
    end: /<!--replace-end-->/g,
  },
];

const PARTIAL_MARKER_SETS: PartialMarkerSet[] = [
  {
    flavor: '/* */',
    start: /\/\*partial v ([^*]+)\*\//g,
    end: /\/\*partial \^ ([^*]+)\*\//g,
  },
  {
    flavor: '# #',
    start: /#partial v ([^#]+)#/g,
    end: /#partial \^ ([^#]+)#/g,
  },
  {
    flavor: '<!-- -->',
    start: /<!--partial v (.+?)-->/g,
    end: /<!--partial \^ (.+?)-->/g,
  },
];

function replaceMarkerLabel(kind: ReplaceMarkerKind): string {
  switch (kind) {
    case 'start':
      return 'replace-start';
    case 'withMarker':
      return 'with';
    case 'end':
      return 'replace-end';
  }
}

function lineAt(content: string, offset: number): number {
  return content.slice(0, offset).split('\n').length;
}

function columnAt(content: string, offset: number): number {
  const lastNewline = content.lastIndexOf('\n', offset === 0 ? 0 : offset - 1);
  return offset - lastNewline;
}

function issue(content: string, offset: number, message: string): AnnotationIssue {
  return {
    offset,
    line: lineAt(content, offset),
    column: columnAt(content, offset),
    message,
  };
}

function collectMarkers(
  text: string,
  pattern: RegExp,
  kind: MarkerKind,
): Marker[] {
  return collectRegexMatches(text, pattern).map((match) => ({
    kind,
    offset: match.offset,
  }));
}

function validatePairedMarkers(
  content: string,
  markerSets: MarkerSet[],
): AnnotationIssue[] {
  const issues: AnnotationIssue[] = [];

  for (const markerSet of markerSets) {
    const markers = [
      ...collectMarkers(content, markerSet.start, 'start'),
      ...collectMarkers(content, markerSet.end, 'end'),
    ].sort((a, b) => a.offset - b.offset);

    const stack: Marker[] = [];
    for (const marker of markers) {
      if (marker.kind === 'start') {
        stack.push(marker);
        continue;
      }

      if (stack.length === 0) {
        issues.push(
          issue(
            content,
            marker.offset,
            `Unmatched ${markerSet.blockName}-end marker (${markerSet.flavor})`,
          ),
        );
        continue;
      }

      stack.pop();
    }

    for (const unmatched of stack) {
      issues.push(
        issue(
          content,
          unmatched.offset,
          `Unmatched ${markerSet.blockName}-start marker (${markerSet.flavor})`,
        ),
      );
    }
  }

  return issues;
}

function collectReplaceMarkers(
  text: string,
  pattern: RegExp,
  kind: ReplaceMarkerKind,
): ReplaceMarker[] {
  return collectRegexMatches(text, pattern).map((match) => ({
    kind,
    offset: match.offset,
  }));
}

function validateReplaceBlocks(content: string): AnnotationIssue[] {
  const issues: AnnotationIssue[] = [];

  for (const markerSet of REPLACE_MARKER_SETS) {
    const markers = [
      ...collectReplaceMarkers(content, markerSet.start, 'start'),
      ...collectReplaceMarkers(content, markerSet.withMarker, 'withMarker'),
      ...collectReplaceMarkers(content, markerSet.end, 'end'),
    ].sort((a, b) => a.offset - b.offset);

    let expecting: ReplaceMarkerKind = 'start';
    const stack: number[] = [];

    for (const marker of markers) {
      switch (expecting) {
        case 'start':
          if (marker.kind === 'start') {
            stack.push(marker.offset);
            expecting = 'withMarker';
          } else {
            issues.push(
              issue(
                content,
                marker.offset,
                `Unexpected ${replaceMarkerLabel(marker.kind)} before replace-start (${markerSet.flavor})`,
              ),
            );
          }
          break;
        case 'withMarker':
          if (marker.kind === 'withMarker') {
            expecting = 'end';
          } else if (marker.kind === 'start') {
            issues.push(
              issue(
                content,
                marker.offset,
                `Nested replace-start is not supported (${markerSet.flavor})`,
              ),
            );
          } else {
            issues.push(
              issue(
                content,
                marker.offset,
                `replace-end without a matching with marker (${markerSet.flavor})`,
              ),
            );
            expecting = 'start';
            stack.length = 0;
          }
          break;
        case 'end':
          if (marker.kind === 'end') {
            if (stack.length === 0) {
              issues.push(
                issue(
                  content,
                  marker.offset,
                  `Unmatched replace-end marker (${markerSet.flavor})`,
                ),
              );
            } else {
              stack.pop();
            }
            expecting = 'start';
          } else {
            issues.push(
              issue(
                content,
                marker.offset,
                `replace-start block is missing replace-end (${markerSet.flavor})`,
              ),
            );
            if (marker.kind === 'start') {
              stack.push(marker.offset);
              expecting = 'withMarker';
            } else {
              expecting = 'end';
            }
          }
          break;
      }
    }

    for (const startOffset of stack) {
      issues.push(
        issue(
          content,
          startOffset,
          `Unmatched replace-start marker (${markerSet.flavor})`,
        ),
      );
    }
  }

  return issues;
}

function collectNamedMarkers(
  text: string,
  pattern: RegExp,
  kind: PartialMarkerKind,
): PartialMarker[] {
  const markers: PartialMarker[] = [];
  const expression = new RegExp(pattern.source, pattern.flags);

  for (const match of text.matchAll(expression)) {
    const offset = match.index;
    if (offset === undefined) {
      continue;
    }
    markers.push({
      kind,
      offset,
      name: match[1] ?? '',
    });
  }

  return markers;
}

function validatePartialBlocks(content: string): AnnotationIssue[] {
  const issues: AnnotationIssue[] = [];

  for (const markerSet of PARTIAL_MARKER_SETS) {
    const markers = [
      ...collectNamedMarkers(content, markerSet.start, 'start'),
      ...collectNamedMarkers(content, markerSet.end, 'end'),
    ].sort((a, b) => a.offset - b.offset);

    const stack: PartialMarker[] = [];
    for (const marker of markers) {
      if (marker.kind === 'start') {
        stack.push(marker);
        continue;
      }

      if (stack.length === 0) {
        issues.push(
          issue(
            content,
            marker.offset,
            `Unmatched partial ^ marker for "${marker.name}" (${markerSet.flavor})`,
          ),
        );
        continue;
      }

      const start = stack.pop()!;
      if (start.name !== marker.name) {
        issues.push(
          issue(
            content,
            marker.offset,
            `partial ^ name "${marker.name}" does not match `
              + `partial v name "${start.name}" (${markerSet.flavor})`,
          ),
        );
      }
    }

    for (const unmatched of stack) {
      issues.push(
        issue(
          content,
          unmatched.offset,
          `Unmatched partial v marker for "${unmatched.name}" (${markerSet.flavor})`,
        ),
      );
    }
  }

  return issues;
}

/** Validates brick-generator annotation markers in file contents. */
export function validateAnnotationContent(content: string): AnnotationIssue[] {
  return [
    ...validatePairedMarkers(content, REMOVE_MARKER_SETS),
    ...validatePairedMarkers(content, INSERT_MARKER_SETS),
    ...validateReplaceBlocks(content),
    ...validatePartialBlocks(content),
  ];
}
