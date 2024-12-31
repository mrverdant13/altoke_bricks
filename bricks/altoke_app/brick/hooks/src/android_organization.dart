import 'android_identifier_segment.dart';
import 'utils.dart';

extension type AndroidOrganization._(String value) {
  AndroidOrganization(this.value) {
    validate(value);
  }

  Iterable<AndroidIdentifierSegment> get segments =>
      value.split('.').map(AndroidIdentifierSegment.new);

  static const minSegmentsCount = 2;

  static void validate(String value) {
    final rawSegments = value.split('.');
    if (rawSegments.length < minSegmentsCount) {
      throw ArgumentError.value(
        value,
        'value',
        'Android Organization '
            'must have at least $minSegmentsCount segments',
      );
    }
    rawSegments.forEach(AndroidIdentifierSegment.validate);
  }

  static bool isValid(String value) => doesNotThrow(() => validate(value));
}
