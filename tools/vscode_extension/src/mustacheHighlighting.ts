import * as vscode from 'vscode';

import { type AnnotationConfig } from './annotationConfig';
import { captureToRange, matchToRange } from './rangeUtils';
import { isSupportedBrickFile } from './supportedFiles';

/** Full Mustache tag, including `{{` / `}}` delimiters (e.g. `{{#use_foo}}`, `{{{name}}}`). */
export const MUSTACHE_TAG_PATTERN = String.raw`\{\{\{?[^}]+?\}\}?\}`;

/** Same as [MUSTACHE_TAG_PATTERN] with a capture group for the tag body. */
export const MUSTACHE_TAG_BODY_REGEX = new RegExp(
  MUSTACHE_TAG_PATTERN.replace('[^}]+', '([^}]+)'),
  'g',
);

const MUSTACHE_COMMENT_SOURCES = [
  String.raw`/\*(x)?(${MUSTACHE_TAG_PATTERN})(x)?\*/`,
  String.raw`#(x)?(${MUSTACHE_TAG_PATTERN})(x)?#`,
  String.raw`<!--(x)?(${MUSTACHE_TAG_PATTERN})(x)?-->`,
] as const;

export const MUSTACHE_COMMENT_MARKER_PATTERN = new RegExp(
  MUSTACHE_COMMENT_SOURCES.map((source) => `(?:${source})`).join('|'),
  'g',
);

const MUSTACHE_COMMENT_PATTERNS = MUSTACHE_COMMENT_SOURCES.map(
  (source) => new RegExp(source, 'g'),
);

let commentDecoration = vscode.window.createTextEditorDecorationType({});
let tagDecoration = vscode.window.createTextEditorDecorationType({});
let dropFlagDecoration = vscode.window.createTextEditorDecorationType({});
let appliedConfigKey = '';

function ensureDecorations(config: AnnotationConfig): void {
  const key = JSON.stringify(config.mustache);
  if (key === appliedConfigKey) return;

  const prevComment = commentDecoration;
  const prevTag = tagDecoration;
  const prevDropFlag = dropFlagDecoration;

  commentDecoration = vscode.window.createTextEditorDecorationType({
    backgroundColor: config.mustache.commentBackground,
    isWholeLine: false,
  });
  tagDecoration = vscode.window.createTextEditorDecorationType({
    color: config.mustache.tagForeground,
    fontWeight: 'bold',
  });
  dropFlagDecoration = vscode.window.createTextEditorDecorationType({
    color: config.mustache.dropFlagForeground,
    fontWeight: 'bold',
  });

  prevComment.dispose();
  prevTag.dispose();
  prevDropFlag.dispose();
  appliedConfigKey = key;
}

function findMustacheHighlightRanges(document: vscode.TextDocument): {
  comments: vscode.Range[];
  tags: vscode.Range[];
  dropFlags: vscode.Range[];
} {
  const text = document.getText();
  const comments: vscode.Range[] = [];
  const tags: vscode.Range[] = [];
  const dropFlags: vscode.Range[] = [];

  for (const pattern of MUSTACHE_COMMENT_PATTERNS) {
    const expression = new RegExp(pattern.source, pattern.flags);
    for (const match of text.matchAll(expression)) {
      comments.push(matchToRange(document, match));

      const leadingFlag = captureToRange(document, match, 1);
      const tag = captureToRange(document, match, 2);
      const trailingFlag = captureToRange(document, match, 3, 'last');

      if (leadingFlag !== undefined) dropFlags.push(leadingFlag);
      if (tag !== undefined) tags.push(tag);
      if (trailingFlag !== undefined) dropFlags.push(trailingFlag);
    }
  }

  return { comments, tags, dropFlags };
}

export function refreshMustacheHighlights(
  editor: vscode.TextEditor | undefined,
  config: AnnotationConfig,
): void {
  ensureDecorations(config);

  if (editor === undefined || !isSupportedBrickFile(editor.document)) return;

  const { comments, tags, dropFlags } = findMustacheHighlightRanges(editor.document);

  editor.setDecorations(commentDecoration, comments);
  editor.setDecorations(tagDecoration, tags);
  editor.setDecorations(dropFlagDecoration, dropFlags);
}

export function registerMustacheHighlighting(context: vscode.ExtensionContext): void {
  context.subscriptions.push(
    new vscode.Disposable(() => {
      commentDecoration.dispose();
      tagDecoration.dispose();
      dropFlagDecoration.dispose();
    }),
  );
}
