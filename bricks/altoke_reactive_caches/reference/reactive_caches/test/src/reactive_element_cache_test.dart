import 'dart:async';

import 'package:altoke_reactive_caches/reactive_caches.dart';
import 'package:test/test.dart';

void main() {
  test(
    '''

GIVEN a constructor for a reactive cache for a single element
WHEN the constructor is called
THEN an instance of the cache is returned
├─ THAT has a default equality checker
''',
    () {
      final cache = ReactiveElementCache<String>();
      expect(cache, isNotNull);
      expect(cache, isA<ReactiveElementCache>());
      expect(cache.equalityChecker('', ''), isTrue);
      expect(cache.equalityChecker('string', 'string'), isTrue);
      expect(cache.equalityChecker('string', 'other string'), isFalse);
    },
  );

  group(
    '''

GIVEN a reactive cache for a single element''',
    () {
      late ReactiveElementCache<String> cache;

      setUp(
        () {
          cache = ReactiveElementCache<String>(
            equalityChecker: (a, b) => a?.trim() == b?.trim(),
          );
        },
      );

      test(
        '''

AND a cached value
WHEN the cached value is cleared
THEN the cached value is null
''',
        () {
          cache.element = 'value';
          expect(cache.element, 'value');
          cache.set(null);
          expect(cache.element, isNull);
        },
      );

      test(
        '''

AND a cached value
WHEN another value is cached
THEN the cached value is the new value
''',
        () {
          cache.element = 'value';
          expect(cache.element, 'value');
          cache.set('new value');
          expect(cache.element, 'new value');
        },
      );

      test(
        '''

AND no cached value
WHEN a value is cached
THEN the cached value is the value
''',
        () {
          expect(cache.element, isNull);
          cache.set('new-value');
          expect(cache.element, 'new-value');
        },
      );

      test(
        '''

AND no cached value
WHEN the cached value is requested
THEN null is returned
''',
        () {
          expect(cache.element, isNull);
          final element = cache.get();
          expect(element, isNull);
        },
      );

      test(
        '''

AND a cached value
WHEN the cached value is requested
THEN the cached value is returned
''',
        () {
          cache.element = 'value';
          expect(cache.element, 'value');
          final cachedValue = cache.get();
          expect(cachedValue, 'value');
        },
      );

      test(
        '''

WHEN the cached value is watched
THEN the cached value is continuously emitted as it changes
''',
        () async {
          final stream = cache.watch();
          final values = <String?>[
            null,
            'value 1   ',
            'value 1',
            'value 2',
            '   value 2',
            null,
            'value 3',
          ];
          final expectedValues = <String?>[
            null,
            'value 1   ',
            'value 2',
            null,
            'value 3',
          ];
          unawaited(expectLater(stream, emitsInOrder(expectedValues)));
          expect(cache.streamController, isNotNull);
          values.forEach(cache.set);
        },
      );

      test(
        '''

WHEN the cached value is listened multiple times
THEN the cached value is continuously emitted as it changes
WHEN all listeners are canceled
THEN the stream controller is closed
''',
        () async {
          expect(cache.streamController, isNull);
          final stream1 = cache.watch();
          expect(stream1.isBroadcast, isTrue);
          final sub1a = stream1.listen((value) {});
          expect(cache.streamController, isNotNull);
          final sub1b = stream1.listen((value) {});
          expect(cache.streamController, isNotNull);
          await sub1a.cancel();
          expect(cache.streamController, isNotNull);
          final controller1 = cache.streamController;
          await sub1b.cancel();
          expect(cache.streamController, isNull);
          expect(controller1?.isClosed, isTrue);
          final stream2 = cache.watch();
          expect(stream2.isBroadcast, isTrue);
          final sub2a = stream2.listen((value) {});
          expect(cache.streamController, isNotNull);
          final sub2b = stream2.listen((value) {});
          expect(cache.streamController, isNotNull);
          await sub2a.cancel();
          expect(cache.streamController, isNotNull);
          final controller2 = cache.streamController;
          await sub2b.cancel();
          expect(cache.streamController, isNull);
          expect(controller2?.isClosed, isTrue);
        },
      );

      test(
        '''

WHEN the cached value is listened by a new listener
THEN the current cached value should be immediately emitted
AND the subsequent cached value changes should be emitted
''',
        () async {
          cache.set('value 1');
          expect(cache.element, 'value 1');
          cache.set(null);
          expect(cache.element, isNull);
          cache.set('value 2');
          expect(cache.element, 'value 2');
          final stream = cache.watch();
          final sub1Values = <String?>[];
          final sub1 = stream.listen(sub1Values.add);
          await Future.microtask(() {});
          expect(
            sub1Values,
            [
              'value 2',
            ],
          );
          cache.set('value 3');
          expect(cache.element, 'value 3');
          cache.set('value 4');
          expect(cache.element, 'value 4');
          final sub2Values = <String?>[];
          final sub2 = stream.listen(sub2Values.add);
          await Future.microtask(() {});
          expect(
            sub1Values,
            [
              'value 2',
              'value 3',
              'value 4',
            ],
          );
          expect(
            sub2Values,
            [
              'value 4',
            ],
          );
          cache.set('value 5');
          expect(cache.element, 'value 5');
          cache.set(null);
          expect(cache.element, isNull);
          cache.set('value 6');
          expect(cache.element, 'value 6');
          expect(
            sub1Values,
            [
              'value 2',
              'value 3',
              'value 4',
              'value 5',
              null,
              'value 6',
            ],
          );
          expect(
            sub2Values,
            [
              'value 4',
              'value 5',
              null,
              'value 6',
            ],
          );
          await [
            sub1.cancel(),
            sub2.cancel(),
          ].wait;
        },
      );

      test(
        '''

AND a cached value
WHEN the cached value is updated
THEN the cached value is the updated value
''',
        () {
          cache.element = 'original value';
          expect(cache.element, 'original value');
          cache.update((value) => value?.replaceAll('original', 'updated'));
          expect(cache.element, 'updated value');
        },
      );
    },
  );
}
