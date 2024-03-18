import 'package:brick_generator/src/replacement.dart';
import 'package:meta/meta.dart';

/// {@template brick_generator.brick_gen_options}
/// The options used to generate a brick.
/// {@endtemplate}
@immutable
class BrickGenOptions {
  /// {@macro brick_generator.brick_gen_options}
  const BrickGenOptions({
    required this.targetRelativePath,
    required this.replacements,
  });

  /// Creates a [BrickGenOptions] from a [json] map.
  factory BrickGenOptions.fromJson(Map<String, dynamic> json) {
    final targetRelativePath = json['targetRelativePath'] as String;
    final rawReplacements = json['replacements'] as List<dynamic>? ?? [];
    final replacements = ReplacementsIterable.fromJson(rawReplacements);
    return BrickGenOptions(
      targetRelativePath: targetRelativePath,
      replacements: replacements,
    );
  }

  /// The relative path to the target brick.
  final String targetRelativePath;

  /// The replacements to be applied to the reference folder to generate the
  /// target brick.
  final ReplacementsIterable replacements;
}
