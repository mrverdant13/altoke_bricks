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
      final RegExp value => value,
      final String value => RegExp(value),
      final Map<String, dynamic> value => () {
        final pattern = value['pattern'] as String;
        final dotAll = value.getOptBool('dotAll');
        final multiLine = value.getOptBool('multiLine');
        final unicode = value.getOptBool('unicode');
        final caseSensitive = value.getOptBool('caseSensitive');
        final dummy = RegExp('.*');
        return RegExp(
          pattern,
          dotAll: dotAll ?? dummy.isDotAll,
          multiLine: multiLine ?? dummy.isMultiLine,
          unicode: unicode ?? dummy.isUnicode,
          caseSensitive: caseSensitive ?? dummy.isCaseSensitive,
        );
      }(),
      _ => RegExp(value.toString()),
    };
  }
}

extension on Map<String, dynamic> {
  bool? getOptBool(String key) {
    return this[key] is bool ? this[key] as bool : null;
  }
}

// coverage:ignore-start
/// {@macro brick_generator.regex_hook}
const regexHook = RegexHook();
// coverage:ignore-end
