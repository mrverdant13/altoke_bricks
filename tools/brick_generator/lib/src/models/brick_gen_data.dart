import 'package:brick_generator/src/models/brick_gen_options.dart';
import 'package:brick_generator/src/models/line_deletions.dart';
import 'package:brick_generator/src/models/replacement.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;

part 'brick_gen_data.mapper.dart';

/// {@template brick_generator.brick_gen_data}
/// The data used to generate a brick.
/// {@endtemplate}
@immutable
@MappableClass()
class BrickGenData extends BrickGenOptions with BrickGenDataMappable {
  /// {@macro brick_generator.brick_gen_data}
  @visibleForTesting
  const BrickGenData({
    required this.referenceAbsolutePath,
    required this.targetAbsolutePath,
    required super.targetRelativePath,
    required super.replacements,
    required super.lineDeletions,
  });

  /// Creates a [BrickGenData] from existing [BrickGenOptions],
  /// [referenceAbsolutePath] and [targetAbsolutePath].
  factory BrickGenData.fromOptions({
    required String referenceAbsolutePath,
    required String targetAbsolutePath,
    required BrickGenOptions options,
  }) {
    return BrickGenData(
      referenceAbsolutePath: referenceAbsolutePath,
      targetAbsolutePath: targetAbsolutePath,
      targetRelativePath: options.targetRelativePath,
      replacements: options.replacements,
      lineDeletions: options.lineDeletions,
    );
  }

  /// The absolute path to the reference directory.
  final String referenceAbsolutePath;

  /// The absolute path to the target brick.
  final String targetAbsolutePath;

  /// Applies the [replacements] to the [inputPath], considering it as a
  /// relative path to the [targetAbsolutePath].
  String applyReplacementsToTargetRelativeDescendant(String inputPath) {
    final relativePath = path.relative(inputPath, from: targetAbsolutePath);
    final resolvedRelativePath = replacements.apply(relativePath);
    return path.normalize(
      path.join(
        targetAbsolutePath,
        resolvedRelativePath,
      ),
    );
  }
}
