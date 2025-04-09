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

      setUp(() {
        cache = ReactiveElementCache<String>(
          equalityChecker: (a, b) => a?.trim() == b?.trim(),
        );
      });

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
          final streamA = cache.watch();
          expect(
            streamA,
            emitsInOrder([
              null,
              'value 1   ',
              'value 2',
              null,
              'value 3',
              null,
            ]),
          );
          await pumpEventQueue();
          cache.streamController
            ..add(null)
            ..add('value 1   ')
            ..add('value 2')
            ..add('   value 2')
            ..add(null)
            ..add('value 3')
            ..add(null);
          await pumpEventQueue();
          final streamB = cache.watch();
          expect(
            streamA,
            emitsInOrder([
              'value 3',
              'value 4',
              '   value 5   ',
              null,
              'value 6',
            ]),
          );
          expect(
            streamB,
            emitsInOrder([
              null,
              'value 3',
              'value 4',
              '   value 5   ',
              null,
              'value 6',
            ]),
          );
          await pumpEventQueue();
          cache.streamController
            ..add('value 3')
            ..add('value 4')
            ..add('   value 5   ')
            ..add('value 5')
            ..add(null)
            ..add('value 6');
          await pumpEventQueue();
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
