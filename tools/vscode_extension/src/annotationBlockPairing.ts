import { collectRegexMatches } from './markerScanning';

export type MarkerKind = 'start' | 'end';

export interface MarkerMatch {
  kind: MarkerKind;
  offset: number;
  length: number;
}

export interface TextSpan {
  start: number;
  end: number;
  endMarkerStart?: number;
}

export interface StartEndMarkerSet {
  start: RegExp;
  end: RegExp;
}

export interface NamedMarkerMatch extends MarkerMatch {
  name: string;
}

export interface NamedStartEndMarkerSet {
  start: RegExp;
  end: RegExp;
}

function collectMarkers(
  text: string,
  pattern: RegExp,
  kind: MarkerKind,
): MarkerMatch[] {
  return collectRegexMatches(text, pattern).map((match) => ({ ...match, kind }));
}

function collectNamedMarkers(
  text: string,
  pattern: RegExp,
  kind: MarkerKind,
): NamedMarkerMatch[] {
  const markers: NamedMarkerMatch[] = [];
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

function pairStartEndMarkers(markers: MarkerMatch[]): TextSpan[] {
  const spans: TextSpan[] = [];
  const stack: MarkerMatch[] = [];

  for (const marker of markers) {
    if (marker.kind === 'start') {
      stack.push(marker);
      continue;
    }
    if (stack.length === 0) {
      continue;
    }

    const startMarker = stack.pop()!;
    spans.push({
      start: startMarker.offset,
      end: marker.offset + marker.length,
      endMarkerStart: marker.offset,
    });
  }

  return spans;
}

/** Full spans from each start marker through its matching end marker (inclusive). */
export function findPairedBlockSpans(
  text: string,
  markerSets: StartEndMarkerSet[],
): TextSpan[] {
  const spans: TextSpan[] = [];

  for (const markerSet of markerSets) {
    const markers = [
      ...collectMarkers(text, markerSet.start, 'start'),
      ...collectMarkers(text, markerSet.end, 'end'),
    ].sort((a, b) => a.offset - b.offset);

    spans.push(...pairStartEndMarkers(markers));
  }

  return spans;
}

/** Interior spans between paired start/end markers (exclusive of the markers). */
export function findPairedBlockInteriors(
  text: string,
  markerSets: StartEndMarkerSet[],
): TextSpan[] {
  const interiors: TextSpan[] = [];

  for (const markerSet of markerSets) {
    const markers = [
      ...collectMarkers(text, markerSet.start, 'start'),
      ...collectMarkers(text, markerSet.end, 'end'),
    ].sort((a, b) => a.offset - b.offset);

    const stack: MarkerMatch[] = [];
    for (const marker of markers) {
      if (marker.kind === 'start') {
        stack.push(marker);
        continue;
      }
      if (stack.length === 0) {
        continue;
      }

      const startMarker = stack.pop()!;
      const interiorStart = startMarker.offset + startMarker.length;
      const interiorEnd = marker.offset;
      if (interiorEnd > interiorStart) {
        interiors.push({ start: interiorStart, end: interiorEnd });
      }
    }
  }

  return interiors;
}

/** Full spans for named partial blocks (`partial v` / `partial ^` with matching names). */
export function findNamedPairedBlockSpans(
  text: string,
  markerSets: NamedStartEndMarkerSet[],
): TextSpan[] {
  const spans: TextSpan[] = [];

  for (const markerSet of markerSets) {
    const markers = [
      ...collectNamedMarkers(text, markerSet.start, 'start'),
      ...collectNamedMarkers(text, markerSet.end, 'end'),
    ].sort((a, b) => a.offset - b.offset);

    const stack: NamedMarkerMatch[] = [];
    for (const marker of markers) {
      if (marker.kind === 'start') {
        stack.push(marker);
        continue;
      }
      if (stack.length === 0) {
        continue;
      }

      const startMarker = stack.at(-1);
      if (startMarker === undefined || startMarker.name !== marker.name) {
        continue;
      }

      stack.pop();
      spans.push({
        start: startMarker.offset,
        end: marker.offset + marker.length,
        endMarkerStart: marker.offset,
      });
    }
  }

  return spans;
}
