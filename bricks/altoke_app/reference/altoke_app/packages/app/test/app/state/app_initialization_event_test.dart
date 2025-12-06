// Allow non-const constructors for testing
// ignore_for_file: prefer_const_constructors

import 'package:altoke_app/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$AppInitializationEvent', () {
    group('$AppInitializationRequested', () {
      test('| can be compared', () {
        final subject = AppInitializationRequested();
        final same = AppInitializationRequested();
        expect(subject, same);
      });
    });
  });
}
