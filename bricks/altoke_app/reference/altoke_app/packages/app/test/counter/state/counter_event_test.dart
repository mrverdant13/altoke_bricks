// Allow non-const constructors for testing
// ignore_for_file: prefer_const_constructors

import 'package:altoke_app/counter/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$CounterEvent', () {
    group('$CounterIncreaseRequested', () {
      test('can be compared', () {
        final subject = CounterIncreaseRequested();
        final same = CounterIncreaseRequested();
        expect(subject, same);
      });
    });

    group('$CounterResetRequested', () {
      test('can be compared', () {
        final subject = CounterResetRequested();
        final same = CounterResetRequested();
        expect(subject, same);
      });
    });
  });
}
