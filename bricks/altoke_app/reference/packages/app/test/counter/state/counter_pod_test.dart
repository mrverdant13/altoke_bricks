import 'dart:math';

import 'package:altoke_app/counter/counter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    '''

GIVEN a counter pod''',
    () {
      test(
        '''

WHEN the pod is built
THEN its initial state should be 0
''',
        () {
          final container = ProviderContainer();
          final counter = container.read(counterPod.notifier);
          expect(counter.state, isZero);
        },
      );

      test(
        '''

WHEN the increment method is called
THEN the state should be incremented by 1
''',
        () {
          final container = ProviderContainer();
          addTearDown(container.dispose);
          final counterNotifier = container.read(counterPod.notifier);
          final initialValue = Random().nextInt(100);
          counterNotifier.state = initialValue;
          expect(counterNotifier.state, initialValue);
          counterNotifier.increment();
          expect(counterNotifier.state, initialValue + 1);
        },
      );
    },
  );
}
