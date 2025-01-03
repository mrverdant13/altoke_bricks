import 'package:dart_mappable/dart_mappable.dart';
import 'package:meta/meta.dart';

/// {@template brick_generator.regex_hook}
/// A hook for encoding and decoding [RegExp] objects.
/// {@endtemplate}
@visibleForTesting
class RegexHook extends MappingHook {
  /// {@macro brick_generator.regex_hook}
  @visibleForTesting
  const RegexHook();

  @override
  Object? beforeDecode(Object? value) {
    return switch (value) {
      final String value => RegExp(value),
      _ => value,
    };
  }
}

/// {@macro brick_generator.regex_hook}
const regexHook = RegexHook();
