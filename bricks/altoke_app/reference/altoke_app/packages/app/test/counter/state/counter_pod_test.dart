import 'dart:math';

import 'package:altoke_app/counter/counter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@Dependencies([
  Counter,
])
void main() {
  group(
    '$Counter',
    () {
      test(
        'initial state is 0',
        () {
          final container = ProviderContainer.test();
          final counter = container.read(counterPod.notifier);
          expect(counter.state, isZero);
        },
      );

      test(
        'increment',
        () {
          final container = ProviderContainer.test();
          final counterNotifier = container.read(counterPod.notifier);
          final initialValue = Random().nextInt(100);
          counterNotifier.state = initialValue;
          expect(counterNotifier.state, initialValue);
          counterNotifier.increment();
          expect(counterNotifier.state, initialValue + 1);
        },
      );

      test(
        'reset',
        () {
          final container = ProviderContainer.test(
            overrides: [
              counterPod.overrideWithBuild(
                (ref, counter) => 100,
              ),
            ],
          );
          final counterNotifier = container.read(counterPod.notifier);
          expect(counterNotifier.state, 100);
          counterNotifier.reset();
          expect(counterNotifier.state, 0);
        },
      );
    },
  );
}
