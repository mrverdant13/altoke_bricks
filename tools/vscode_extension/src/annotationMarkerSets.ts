import {
  type NamedStartEndMarkerSet,
  type StartEndMarkerSet,
} from './annotationBlockPairing';
import { MUSTACHE_COMMENT_MARKER_PATTERN } from './mustacheHighlighting';

export const COMMENT_FLAVORS = ['/* */', '# #', '<!-- -->'] as const;

export type CommentFlavor = (typeof COMMENT_FLAVORS)[number];

export interface ReplaceWithMarkerSet {
  start: RegExp;
  withMarker: RegExp;
  end: RegExp;
}

export const REMOVE_MARKER_SETS: StartEndMarkerSet[] = [
  { start: /\/\*(?:x-)?remove-start\*\//g, end: /\/\*remove-end(?:-x)?\*\//g },
  { start: /#(?:x-)?remove-start#/g, end: /#remove-end(?:-x)?#/g },
  { start: /<!--(?:x-)?remove-start-->/g, end: /<!--remove-end(?:-x)?-->/g },
];

export const INSERT_MARKER_SETS: StartEndMarkerSet[] = [
  { start: /\/\*insert-start\*\//g, end: /\/\*insert-end\*\//g },
  { start: /#insert-start#/g, end: /#insert-end#/g },
  { start: /<!--insert-start-->/g, end: /<!--insert-end-->/g },
];

export const REPLACE_WITH_MARKER_SETS: ReplaceWithMarkerSet[] = [
  {
    start: /\/\*replace-start\*\//g,
    withMarker: /\/\*with(?: +i\d+)?\*\//g,
    end: /\/\*replace-end\*\//g,
  },
  {
    start: /#replace-start#/g,
    withMarker: /#with(?: +i\d+)?#/g,
    end: /#replace-end#/g,
  },
  {
    start: /<!--replace-start-->/g,
    withMarker: /<!--with(?: +i\d+)?-->/g,
    end: /<!--replace-end-->/g,
  },
];

export const REPLACE_MARKER_SETS: StartEndMarkerSet[] = REPLACE_WITH_MARKER_SETS.map(
  ({ start, end }) => ({ start, end }),
);

export const PARTIAL_MARKER_SETS: NamedStartEndMarkerSet[] = [
  { start: /\/\*partial v ([^*]+)\*\//g, end: /\/\*partial \^ ([^*]+)\*\//g },
  { start: /#partial v ([^#]+)#/g, end: /#partial \^ ([^#]+)#/g },
  { start: /<!--partial v (.+?)-->/g, end: /<!--partial \^ (.+?)-->/g },
];

export const REMOVE_BOUNDARY_MARKER_PATTERN =
  /\/\*(?:x-)?remove-start\*\/|\/\*remove-end(?:-x)?\*\/|#(?:x-)?remove-start#|#remove-end(?:-x)?#|<!--(?:x-)?remove-start-->|<!--remove-end(?:-x)?-->/g;

export const INSERT_BOUNDARY_MARKER_PATTERN =
  /\/\*insert-start\*\/|\/\*insert-end\*\/|#insert-start#|#insert-end#|<!--insert-start-->|<!--insert-end-->/g;

export const REPLACE_START_END_MARKER_PATTERN =
  /\/\*replace-start\*\/|\/\*replace-end\*\/|#replace-start#|#replace-end#|<!--replace-start-->|<!--replace-end-->/g;

export const WITH_MARKER_PATTERN =
  /\/\*with(?: +i\d+)?\*\/|#with(?: +i\d+)?#|<!--with(?: +i\d+)?-->/g;

export const PARTIAL_BOUNDARY_MARKER_PATTERN =
  /\/\*partial [v^] [^*]+\*\/|#partial [v^] [^#]+#|<!--partial [v^] .+?-->/g;

export const DROP_MARKER_SETS = [/\/\*drop\*\//g, /#drop#/g, /<!--drop-->/g];

export const DROP_MARKER_PATTERN = /\/\*drop\*\/|#drop#|<!--drop-->/g;

function combineMarkerPatterns(...patterns: RegExp[]): RegExp {
  return new RegExp(
    patterns.map((pattern) => `(?:${pattern.source})`).join('|'),
    'g',
  );
}

/** Matches any brick annotation marker, including mustache comment wrappers. */
export const ANY_ANNOTATION_MARKER_PATTERN = combineMarkerPatterns(
  REMOVE_BOUNDARY_MARKER_PATTERN,
  INSERT_BOUNDARY_MARKER_PATTERN,
  REPLACE_START_END_MARKER_PATTERN,
  WITH_MARKER_PATTERN,
  PARTIAL_BOUNDARY_MARKER_PATTERN,
  DROP_MARKER_PATTERN,
  MUSTACHE_COMMENT_MARKER_PATTERN,
);
