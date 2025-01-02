import 'utils.dart';

extension type AndroidIdentifierSegment._(String value) {
  AndroidIdentifierSegment(this.value) {
    validate(value);
  }

  static final pattern = RegExp('[a-zA-Z](?:[a-zA-Z0-9_]*[a-zA-Z0-9])?');

  static void validate(String value) {
    if (!pattern.hasMatch(value)) {
      throw ArgumentError.value(
        value,
        'value',
        'Invalid Android Identifier Segment',
      );
    }
  }

  static bool isValid(String value) => doesNotThrow(() => validate(value));
}
