import 'dart:async';

import 'package:altoke_reactive_caches/reactive_caches.dart';
import 'package:test/test.dart';

void main() {
  test(
    '''

GIVEN a constructor for a reactive cache for a single element
WHEN the constructor is called
THEN an instance of the cache is returned
''',
    () {
      final cache = ReactiveElementCache<String>();
      addTearDown(() => cache.dispose);
      expect(cache, isNotNull);
      expect(cache, isA<ReactiveElementCache>());
    },
  );

  group(
    '''

GIVEN a reactive cache for a single element''',
    () {
      var calledDispose = false;
      late ReactiveElementCache<String> cache;

      setUp(
        () {
          cache = ReactiveElementCache<String>();
        },
      );

      tearDown(
        () {
          if (calledDispose) return;
          cache.dispose();
        },
      );

      test(
        '''

AND a cached value
WHEN the cached value is cleared
THEN the cached value is null
''',
        () {
          cache.streamController.add('value');
          expect(cache.streamController.value, 'value');
          cache.set(null);
          expect(cache.streamController.value, isNull);
        },
      );

      test(
        '''

AND a cached value
WHEN another value is cached
THEN the cached value is the new value
''',
        () {
          cache.streamController.add('value');
          expect(cache.streamController.value, 'value');
          cache.set('new value');
          expect(cache.streamController.value, 'new value');
        },
      );

      test(
        '''

AND no cached value
WHEN a value is cached
THEN the cached value is the value
''',
        () {
          expect(cache.streamController.value, isNull);
          cache.set('new-value');
          expect(cache.streamController.value, 'new-value');
        },
      );

      test(
        '''

AND no cached value
WHEN the cached value is requested
THEN null is returned
''',
        () {
          expect(cache.streamController.value, isNull);
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
          cache.streamController.add('value');
          expect(cache.streamController.value, 'value');
          final cachedValue = cache.get();
          expect(cachedValue, 'value');
        },
      );

      test(
        '''

WHEN the cached value is watched
THEN the cached value is continuously emitted as it changes
''',
        () {
          final stream = cache.watch();
          final values = <String?>[
            null,
            'value 1',
            'value 2',
            null,
            'value 3',
          ];
          unawaited(expectLater(stream, emitsInOrder(values)));
          for (final value in values) {
            cache.streamController.add(value);
          }
        },
      );

      test(
        '''

AND a cached value
WHEN the cached value is updated
THEN the cached value is the updated value
''',
        () {
          cache.streamController.add('original value');
          expect(cache.streamController.value, 'original value');
          cache.update((value) => value?.replaceAll('original', 'updated'));
          expect(cache.streamController.value, 'updated value');
        },
      );

      test(
        '''

WHEN the cache is disposed
THEN the internal stream is closed
''',
        () async {
          expect(cache.streamController.isClosed, isFalse);
          await cache.dispose();
          calledDispose = true;
          expect(cache.streamController.value, isNull);
          expect(cache.streamController.isClosed, isTrue);
        },
      );
    },
  );
}
