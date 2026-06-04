import {
  COMMENT_FLAVORS,
  INSERT_MARKER_SETS,
  PARTIAL_MARKER_SETS,
  REMOVE_MARKER_SETS,
  REPLACE_WITH_MARKER_SETS,
  type CommentFlavor,
} from './annotationMarkerSets';
import { collectRegexMatches } from './markerScanning';

export interface AnnotationIssue {
  offset: number;
  length: number;
  line: number;
  column: number;
  message: string;
}

type MarkerKind = 'start' | 'end';

interface Marker {
  kind: MarkerKind;
  offset: number;
  length: number;
}

type ReplaceMarkerKind = 'start' | 'withMarker' | 'end';

interface ReplaceMarker {
  kind: ReplaceMarkerKind;
  offset: number;
  length: number;
}

type PartialMarkerKind = 'start' | 'end';

interface PartialMarker {
  kind: PartialMarkerKind;
  offset: number;
  length: number;
  name: string;
}

interface FlavoredMarkerSet {
  flavor: CommentFlavor;
  blockName: string;
  start: RegExp;
  end: RegExp;
}

interface FlavoredReplaceMarkerSet {
  flavor: CommentFlavor;
  start: RegExp;
  withMarker: RegExp;
  end: RegExp;
}

interface FlavoredPartialMarkerSet {
  flavor: CommentFlavor;
  start: RegExp;
  end: RegExp;
}

function withBlockName(
  sets: Array<{ start: RegExp; end: RegExp }>,
  blockName: string,
): FlavoredMarkerSet[] {
  return sets.map((set, index) => ({
    ...set,
    flavor: COMMENT_FLAVORS[index],
    blockName,
  }));
}

function withFlavor<T extends { start: RegExp; end: RegExp }>(
  sets: T[],
): Array<T & { flavor: CommentFlavor }> {
  return sets.map((set, index) => ({
    ...set,
    flavor: COMMENT_FLAVORS[index],
  }));
}

const FLAVORED_REMOVE_MARKER_SETS = withBlockName(REMOVE_MARKER_SETS, 'remove');
const FLAVORED_INSERT_MARKER_SETS = withBlockName(INSERT_MARKER_SETS, 'insert');
const FLAVORED_REPLACE_MARKER_SETS: FlavoredReplaceMarkerSet[] = withFlavor(
  REPLACE_WITH_MARKER_SETS,
);
const FLAVORED_PARTIAL_MARKER_SETS: FlavoredPartialMarkerSet[] = withFlavor(
  PARTIAL_MARKER_SETS,
);

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

function issue(
  content: string,
  offset: number,
  length: number,
  message: string,
): AnnotationIssue {
  return {
    offset,
    length,
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
    length: match.length,
  }));
}

function validatePairedMarkers(
  content: string,
  markerSets: FlavoredMarkerSet[],
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
            marker.length,
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
          unmatched.length,
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
    length: match.length,
  }));
}

function validateReplaceBlocks(content: string): AnnotationIssue[] {
  const issues: AnnotationIssue[] = [];

  for (const markerSet of FLAVORED_REPLACE_MARKER_SETS) {
    const markers = [
      ...collectReplaceMarkers(content, markerSet.start, 'start'),
      ...collectReplaceMarkers(content, markerSet.withMarker, 'withMarker'),
      ...collectReplaceMarkers(content, markerSet.end, 'end'),
    ].sort((a, b) => a.offset - b.offset);

    let expecting: ReplaceMarkerKind = 'start';
    const stack: Array<{ offset: number; length: number }> = [];

    for (const marker of markers) {
      switch (expecting) {
        case 'start':
          if (marker.kind === 'start') {
            stack.push({ offset: marker.offset, length: marker.length });
            expecting = 'withMarker';
          } else {
            issues.push(
              issue(
                content,
                marker.offset,
                marker.length,
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
                marker.length,
                `Nested replace-start is not supported (${markerSet.flavor})`,
              ),
            );
          } else {
            issues.push(
              issue(
                content,
                marker.offset,
                marker.length,
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
                  marker.length,
                  `Unmatched replace-end marker (${markerSet.flavor})`,
                ),
              );
            } else {
              stack.pop();
            }
            expecting = 'start';
          } else if (marker.kind === 'withMarker') {
            issues.push(
              issue(
                content,
                marker.offset,
                marker.length,
                `Duplicate with marker in replace block (${markerSet.flavor})`,
              ),
            );
            expecting = 'end';
          } else {
            issues.push(
              issue(
                content,
                marker.offset,
                marker.length,
                `replace-start block is missing replace-end (${markerSet.flavor})`,
              ),
            );
            stack.push({ offset: marker.offset, length: marker.length });
            expecting = 'withMarker';
          }
          break;
      }
    }

    for (const startMarker of stack) {
      issues.push(
        issue(
          content,
          startMarker.offset,
          startMarker.length,
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
      length: match[0].length,
      name: match[1] ?? '',
    });
  }

  return markers;
}

function validatePartialBlocks(content: string): AnnotationIssue[] {
  const issues: AnnotationIssue[] = [];

  for (const markerSet of FLAVORED_PARTIAL_MARKER_SETS) {
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
            marker.length,
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
            marker.length,
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
          unmatched.length,
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
    ...validatePairedMarkers(content, FLAVORED_REMOVE_MARKER_SETS),
    ...validatePairedMarkers(content, FLAVORED_INSERT_MARKER_SETS),
    ...validateReplaceBlocks(content),
    ...validatePartialBlocks(content),
  ];
}
