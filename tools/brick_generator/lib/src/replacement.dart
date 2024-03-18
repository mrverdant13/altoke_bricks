import 'package:meta/meta.dart';

/// {@template brick_generator.replacement}
/// A replacement, used to replace a [Pattern] with a [String].
/// {@endtemplate}
@immutable
class Replacement {
  /// {@macro brick_generator.replacement}
  const Replacement({
    required this.from,
    required this.to,
  });

  /// Creates a [Replacement] from a [json] map.
  factory Replacement.fromJson(Map<String, dynamic> json) {
    return Replacement(
      from: RegExp(json['from'] as String),
      to: json['to'] as String,
    );
  }

  /// The pattern to be replaced.
  final RegExp from;

  /// The string to replace the pattern with.
  final String to;

  /// Applies the replacement to the [input].
  String apply(String input) => input.replaceAll(from, to);
}

/// An [Iterable] of [Replacement]s.
extension type ReplacementsIterable(Iterable<Replacement> _root)
    implements Iterable<Replacement> {
  /// Creates a [ReplacementsIterable] from a [json] list.
  factory ReplacementsIterable.fromJson(List<dynamic> json) {
    return ReplacementsIterable(
      json.map(
        (e) => Replacement.fromJson(
          e as Map<String, dynamic>,
        ),
      ),
    );
  }

  /// Applies the replacements to the [input].
  String apply(String input) => _root.fold(
        input,
        (resolved, replacement) => replacement.apply(resolved),
      );
}
