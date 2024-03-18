import 'package:brick_generator/src/brick_gen_options.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;

/// {@template brick_generator.brick_gen_data}
/// The data used to generate a brick.
/// {@endtemplate}
@immutable
class BrickGenData extends BrickGenOptions {
  /// {@macro brick_generator.brick_gen_data}
  const BrickGenData._({
    required this.referenceAbsolutePath,
    required this.targetAbsolutePath,
    required super.targetRelativePath,
    required super.replacements,
  });

  /// Creates a [BrickGenData] from existing [BrickGenOptions],
  /// [referenceAbsolutePath] and [targetAbsolutePath].
  factory BrickGenData.fromOptions({
    required String referenceAbsolutePath,
    required String targetAbsolutePath,
    required BrickGenOptions options,
  }) {
    return BrickGenData._(
      referenceAbsolutePath: referenceAbsolutePath,
      targetAbsolutePath: targetAbsolutePath,
      targetRelativePath: options.targetRelativePath,
      replacements: options.replacements,
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
    return path.join(targetAbsolutePath, resolvedRelativePath);
  }
}
