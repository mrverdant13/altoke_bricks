import {
  type NamedStartEndMarkerSet,
  type StartEndMarkerSet,
} from './annotationBlockPairing';

export const REMOVE_MARKER_SETS: StartEndMarkerSet[] = [
  { start: /\/\*(?:x-)?remove-start\*\//g, end: /\/\*remove-end(?:-x)?\*\//g },
  { start: /#(?:x-)?remove-start#/g, end: /#remove-end(?:-x)?#/g },
  { start: /<!--(?:x-)?remove-start-->/g, end: /<!--remove-end(?:-x)?-->/g },
];

export const REPLACE_MARKER_SETS: StartEndMarkerSet[] = [
  { start: /\/\*replace-start\*\//g, end: /\/\*replace-end\*\//g },
  { start: /#replace-start#/g, end: /#replace-end#/g },
  { start: /<!--replace-start-->/g, end: /<!--replace-end-->/g },
];

export const PARTIAL_MARKER_SETS: NamedStartEndMarkerSet[] = [
  { start: /\/\*partial v ([^*]+)\*\//g, end: /\/\*partial \^ ([^*]+)\*\//g },
  { start: /#partial v ([^#]+)#/g, end: /#partial \^ ([^#]+)#/g },
  { start: /<!--partial v (.+?)-->/g, end: /<!--partial \^ (.+?)-->/g },
];

export const REMOVE_BOUNDARY_MARKER_PATTERN =
  /\/\*(?:x-)?remove-start\*\/|\/\*remove-end(?:-x)?\*\/|#(?:x-)?remove-start#|#remove-end(?:-x)?#|<!--(?:x-)?remove-start-->|<!--remove-end(?:-x)?-->/g;

export const DROP_MARKER_SETS = [/\/\*drop\*\//g, /#drop#/g, /<!--drop-->/g];

export const DROP_MARKER_PATTERN = /\/\*drop\*\/|#drop#|<!--drop-->/g;
