import 'package:brick_generator/src/models/line_deletions.dart';
import 'package:brick_generator/src/models/replacement.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:meta/meta.dart';

part 'brick_gen_options.mapper.dart';

/// {@template brick_generator.brick_gen_options}
/// The options used to generate a brick.
/// {@endtemplate}
@immutable
@MappableClass()
class BrickGenOptions with BrickGenOptionsMappable {
  /// {@macro brick_generator.brick_gen_options}
  const BrickGenOptions({
    required this.targetRelativePath,
    this.replacements = const [],
    this.lineDeletions = const [],
  });

  /// Creates a [BrickGenOptions] from a JSON map.
  static const fromJson = BrickGenOptionsMapper.fromMap;

  /// The relative path to the target brick.
  final String targetRelativePath;

  /// The replacements to be applied to the reference folder to generate the
  /// target brick.
  final List<Replacement> replacements;

  /// The lines to be dropped from files within the target brick.
  final List<LinesDeletion> lineDeletions;
}
