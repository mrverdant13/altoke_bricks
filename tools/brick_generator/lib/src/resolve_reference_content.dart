import 'package:brick_generator/src/models/models.dart';
import 'package:brick_generator/src/reference_content_transforms.dart';

/// Applies the brick-generator annotation and [brickGenData] transforms to
/// [content] as if it lived at [targetRelativePath] under [brickGenData]'s
/// target directory.
String resolveReferenceContent({
  required String content,
  required String targetRelativePath,
  required BrickGenData brickGenData,
}) {
  final BrickGenData(:replacements, :lineDeletions, :targetAbsolutePath) =
      brickGenData;
  return content
      .applyLineDeletions(
        filePath: targetRelativePath,
        lineDeletions: lineDeletions,
      )
      .applyReplacements(replacements)
      .withResolvedRemotions
      .withResolveReplacements
      .withResolvedInsertions
      .withResolveMustacheTags
      .withResolveSpacingGroups
      .withResolvedPartials(targetAbsolutePath: targetAbsolutePath);
}
