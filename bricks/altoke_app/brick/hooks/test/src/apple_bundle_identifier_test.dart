import 'package:altoke_app_brick_hooks/src/apple_bundle_identifier.dart';
import 'package:test/test.dart';

void main() {
  group('$AppleBundleIdentifier', () {
    test('can be created if its value is valid', () {
      final candidates = [
        'com.example.app',
        'test.app-id',
        'some-app.id',
        'com.example.app-',
        '1com.example.app',
      ];
      for (final candidate in candidates) {
        expect(
          () => AppleBundleIdentifier(candidate),
          returnsNormally,
          reason: 'The value "$candidate" should be valid.',
        );
      }
    });

    test('throws an ArgumentError if its value is invalid', () {
      final candidates = [
        'com.example.app.',
        'com.example.app..',
        'com.example_app',
      ];
      for (final candidate in candidates) {
        expect(
          () => AppleBundleIdentifier(candidate),
          throwsArgumentError,
          reason: 'The value "$candidate" should be invalid.',
        );
      }
    });
  });
}
