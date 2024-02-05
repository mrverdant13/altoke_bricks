import 'dart:async';

import 'package:element_in_memory_cache/element_in_memory_cache.dart';
import 'package:test/test.dart';

void main() {
  test(
    '''

GIVEN a constructor for a cache for a single element
WHEN the constructor is called
THEN an instance of the cache is returned
''',
    () {
      final cache = ElementInMemoryCache<String>();
      expect(cache, isNotNull);
      expect(cache, isA<ElementInMemoryCache>());
    },
  );

  group(
    '''

GIVEN a cache for a single element''',
    () {
      test(
        '''

AND a cached value
WHEN the cached value is cleared
THEN the cached value is null
''',
        () async {
          final cache = ElementInMemoryCache<String>();
          cache.streamController.add('value');
          expect(cache.streamController.value, 'value');
          await cache.set(null);
          expect(cache.streamController.value, isNull);
        },
      );

      test(
        '''

AND a cached value
WHEN another value is cached
THEN the cached value is the new value
''',
        () async {
          final cache = ElementInMemoryCache<String>();
          cache.streamController.add('value');
          expect(cache.streamController.value, 'value');
          await cache.set('new value');
          expect(cache.streamController.value, 'new value');
        },
      );

      test(
        '''

AND no cached value
WHEN the cached value is requested
THEN null is returned
''',
        () async {
          final cache = ElementInMemoryCache<String>();
          expect(cache.streamController.value, isNull);
          final element = await cache.get();
          expect(element, isNull);
        },
      );

      test(
        '''

AND a cached value
WHEN the cached value is requested
THEN the cached value is returned
''',
        () async {
          final cache = ElementInMemoryCache<String>();
          cache.streamController.add('value');
          expect(cache.streamController.value, 'value');
          final cachedValue = await cache.get();
          expect(cachedValue, 'value');
        },
      );

      test(
        '''

WHEN the cached value is watched
THEN the cached value is continuously emitted as it changes
''',
        () async {
          final cache = ElementInMemoryCache<String>();
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

WHEN the cache is disposed
THEN the internal stream is closed
''',
        () async {
          final cache = ElementInMemoryCache<String>();
          expect(cache.streamController.isClosed, isFalse);
          await cache.dispose();
          expect(cache.streamController.isClosed, isTrue);
        },
      );
    },
  );
}
