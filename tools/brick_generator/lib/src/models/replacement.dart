import 'package:brick_generator/src/_internal/regex_hook.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:meta/meta.dart';

part 'replacement.mapper.dart';

/// {@template brick_generator.replacement}
/// A replacement, used to replace a [Pattern] with a [String].
/// {@endtemplate}
@MappableClass()
@immutable
class Replacement with ReplacementMappable {
  /// {@macro brick_generator.replacement}
  const Replacement({required this.from, required this.to});

  /// Creates a [Replacement] from a JSON map.
  static const fromJson = ReplacementMapper.fromMap;

  /// The pattern to be replaced.
  @MappableField(hook: regexHook)
  final RegExp from;

  /// The string to replace the pattern with.
  final String to;

  /// Applies the replacement to the [input].
  String apply(String input) => input.replaceAll(from, to);
}

/// An [List] of [Replacement]s.
extension ReplacementsList on List<Replacement> {
  /// Creates a [ReplacementsList] from a [jsonList].
  static List<Replacement> fromJson(List<dynamic> jsonList) {
    return [
      for (final json in jsonList)
        Replacement.fromJson(json as Map<String, dynamic>),
    ];
  }

  /// Applies the replacements to the [input].
  String apply(String input) =>
      fold(input, (resolved, replacement) => replacement.apply(resolved));
}

/// An extension to apply [ReplacementsList] to a [String].
extension FileContentWithReplacements on String {
  /// Applies the [replacements].
  String applyReplacements(List<Replacement> replacements) =>
      replacements.apply(this);
}
