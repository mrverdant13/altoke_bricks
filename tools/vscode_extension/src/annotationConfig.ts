import * as vscode from 'vscode';

import {
  insertedContentBackground,
  insertedMarkerForeground,
  mustacheCommentBackground,
  mustacheDropFlagForeground,
  mustacheTagForeground,
  partialMarkerForeground,
  partialPayloadBackground,
  removedContentBackground,
  removedMarkerForeground,
  replaceBoundaryMarkerForeground,
  replaceOriginalBackground,
  replaceReplacementBackground,
  replaceWithMarkerForeground,
  spacingMarkerBackground,
  spacingMarkerForeground,
} from './annotationColors';

function get(key: string, fallback: string): string {
  return (
    vscode.workspace
      .getConfiguration('brickGenerator.colors')
      .get<string>(key) ?? fallback
  );
}

export interface AnnotationConfig {
  remove: {
    markerForeground: string;
    contentBackground: string;
  };
  replace: {
    boundaryMarkerForeground: string;
    withMarkerForeground: string;
    originalBackground: string;
    replacementBackground: string;
  };
  insert: {
    markerForeground: string;
    contentBackground: string;
  };
  partial: {
    markerForeground: string;
    payloadBackground: string;
  };
  mustache: {
    tagForeground: string;
    commentBackground: string;
    dropFlagForeground: string;
  };
  spacing: {
    markerForeground: string;
    markerBackground: string;
  };
}

export function readAnnotationConfig(): AnnotationConfig {
  return {
    remove: {
      markerForeground: get('remove.markerForeground', removedMarkerForeground),
      contentBackground: get('remove.contentBackground', removedContentBackground),
    },
    replace: {
      boundaryMarkerForeground: get(
        'replace.boundaryMarkerForeground',
        replaceBoundaryMarkerForeground,
      ),
      withMarkerForeground: get(
        'replace.withMarkerForeground',
        replaceWithMarkerForeground,
      ),
      originalBackground: get('replace.originalBackground', replaceOriginalBackground),
      replacementBackground: get(
        'replace.replacementBackground',
        replaceReplacementBackground,
      ),
    },
    insert: {
      markerForeground: get('insert.markerForeground', insertedMarkerForeground),
      contentBackground: get('insert.contentBackground', insertedContentBackground),
    },
    partial: {
      markerForeground: get('partial.markerForeground', partialMarkerForeground),
      payloadBackground: get('partial.payloadBackground', partialPayloadBackground),
    },
    mustache: {
      tagForeground: get('mustache.tagForeground', mustacheTagForeground),
      commentBackground: get('mustache.commentBackground', mustacheCommentBackground),
      dropFlagForeground: get('mustache.dropFlagForeground', mustacheDropFlagForeground),
    },
    spacing: {
      markerForeground: get('spacing.markerForeground', spacingMarkerForeground),
      markerBackground: get('spacing.markerBackground', spacingMarkerBackground),
    },
  };
}
