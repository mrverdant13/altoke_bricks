import 'package:altoke_app_brick_hooks/src/android_application_identifier.dart';
import 'package:test/test.dart';

void main() {
  group('$AndroidApplicationIdentifier', () {
    test('can be created if its value is valid', () {
      final candidates = [
        'com.example.app',
        'test.app_id',
        'some_app.id',
        'com.example.app_',
      ];
      for (final candidate in candidates) {
        expect(
          () => AndroidApplicationIdentifier(candidate),
          returnsNormally,
          reason: 'The value "$candidate" should be valid.',
        );
      }
    });

    test('throws an ArgumentError if its value is invalid', () {
      final candidates = [
        'com.example.app.',
        'com.example.app..',
        '1com.example.app',
        'com.example-app',
      ];
      for (final candidate in candidates) {
        expect(
          () => AndroidApplicationIdentifier(candidate),
          throwsArgumentError,
          reason: 'The value "$candidate" should be invalid.',
        );
      }
    });

    test('returns the raw segments of the Android Application Identifier', () {
      final androidApplicationIdentifier = AndroidApplicationIdentifier(
        'com.example.app',
      );
      expect(
        androidApplicationIdentifier.rawSegments,
        orderedEquals(['com', 'example', 'app']),
      );
    });
  });
}
