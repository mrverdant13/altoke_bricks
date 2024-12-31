import 'android_identifier_segment.dart';
import 'android_organization.dart';
import 'utils.dart';

extension type AndroidApplicationIdentifier._(String value) {
  AndroidApplicationIdentifier(this.value) {
    validate(value);
  }

  AndroidApplicationIdentifier.fromParts({
    required AndroidOrganization organization,
    required AndroidIdentifierSegment name,
  }) : this('$organization.$name');

  Iterable<AndroidIdentifierSegment> get segments =>
      value.split('.').map(AndroidIdentifierSegment.new);

  static const minSegmentsCount = 2;

  static void validate(String value) {
    final rawSegments = value.split('.');
    if (rawSegments.length < minSegmentsCount) {
      throw ArgumentError.value(
        value,
        'value',
        'Android Application Identifier '
            'must have at least $minSegmentsCount segments',
      );
    }
    rawSegments.forEach(AndroidIdentifierSegment.validate);
  }

  static bool isValid(String value) => doesNotThrow(() => validate(value));
}
