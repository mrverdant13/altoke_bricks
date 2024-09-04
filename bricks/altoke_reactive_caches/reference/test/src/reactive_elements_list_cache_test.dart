import 'dart:async';

import 'package:altoke_reactive_caches/reactive_caches.dart';
import 'package:test/test.dart';

void main() {
  test(
    '''

GIVEN a constructor for a reactive cache for a list of elements
WHEN the constructor is called
THEN an instance of the cache is returned
''',
    () {
      final cache = ReactiveElementsListCache<String?>();
      expect(cache, isNotNull);
      expect(cache, isA<ReactiveElementsListCache<String?>>());
    },
  );

  group(
    '''

GIVEN a reactive cache for a list of elements''',
    () {
      late ReactiveElementsListCache<String?> cache;

      setUp(
        () {
          cache = ReactiveElementsListCache<String?>(
            equalityChecker: (a, b) {
              if (a.length != b.length) return false;
              for (var i = 0; i < a.length; i++) {
                if (a[i]?.trim() != b[i]?.trim()) return false;
              }
              return true;
            },
          );
        },
      );

      test(
        '''

AND a cached list
WHEN another list is cached
THEN the cached list is the new list
''',
        () {
          cache.elements = [
            'original value 1',
            'original value 2',
          ];
          expect(
            cache.elements,
            orderedEquals([
              'original value 1',
              'original value 2',
            ]),
          );
          cache.set([
            'new value 1',
            'new value 2',
            null,
            'new value 3',
            null,
            null,
          ]);
          expect(
            cache.elements,
            orderedEquals([
              'new value 1',
              'new value 2',
              null,
              'new value 3',
              null,
              null,
            ]),
          );
        },
      );

      test(
        '''

AND a cached list
WHEN another list is appended
THEN the cached list is updated with the appended list
''',
        () {
          cache.elements = [
            'original value 1',
            'original value 2',
          ];
          expect(
            cache.elements,
            orderedEquals([
              'original value 1',
              'original value 2',
            ]),
          );
          cache.appendMany([
            null,
            'new value 3',
            null,
            'new value 4',
            null,
            null,
            null,
            'new value 5',
            null,
          ]);
          expect(
            cache.elements,
            orderedEquals([
              'original value 1',
              'original value 2',
              null,
              'new value 3',
              null,
              'new value 4',
              null,
              null,
              null,
              'new value 5',
              null,
            ]),
          );
        },
      );

      test(
        '''

AND a cached list
WHEN another list is prepended
THEN the cached list is updated with the prepended list
''',
        () {
          cache.elements = [
            null,
            null,
            'original value 4',
            null,
            'original value 5',
          ];
          expect(
            cache.elements,
            orderedEquals([
              null,
              null,
              'original value 4',
              null,
              'original value 5',
            ]),
          );
          cache.prependMany([
            'new value 1',
            'new value 2',
            null,
            null,
            null,
            null,
            'new value 3',
            null,
          ]);
          expect(
            cache.elements,
            orderedEquals([
              'new value 1',
              'new value 2',
              null,
              null,
              null,
              null,
              'new value 3',
              null,
              null,
              null,
              'original value 4',
              null,
              'original value 5',
            ]),
          );
        },
      );

      test(
        '''

AND a cached list
WHEN the cached list is requested without a filter
THEN the complete cached list is returned
''',
        () {
          cache.elements = [
            'value 1',
            'value 2',
            null,
            'value 3',
            null,
            'value 4',
          ];
          expect(
            cache.elements,
            orderedEquals([
              'value 1',
              'value 2',
              null,
              'value 3',
              null,
              'value 4',
            ]),
          );
          final element = cache.get();
          expect(
            element,
            orderedEquals([
              'value 1',
              'value 2',
              null,
              'value 3',
              null,
              'value 4',
            ]),
          );
        },
      );

      test(
        '''

AND a cached list
WHEN the cached list is requested with a filter
THEN the filtered cached list is returned
''',
        () {
          cache.elements = [
            'value 1',
            'value 2',
            null,
            'value 3',
            null,
            'value 4',
          ];
          expect(
            cache.elements,
            orderedEquals([
              'value 1',
              'value 2',
              null,
              'value 3',
              null,
              'value 4',
            ]),
          );
          final element = cache.get(
            where: (element) => element != null,
          );
          expect(
            element,
            orderedEquals([
              'value 1',
              'value 2',
              'value 3',
              'value 4',
            ]),
          );
        },
      );

      test(
        '''

WHEN the cached list is watched without a filter
THEN the complete cached list is continuously emitted as it changes
''',
        () async {
          final stream = cache.watch();
          final values = <List<String?>>[
            [],
            ['value 1', 'value 2', null, 'value 3', null],
            ['value 1'],
            ['value 1', null, 'value 2'],
            [null, 'value 1', null, null, 'value 2', 'value 3', 'value 4'],
          ];
          unawaited(
            expectLater(
              stream,
              emitsInOrder([
                for (final value in values) orderedEquals(value),
              ]),
            ),
          );
          expect(cache.streamController, isNotNull);
          values.forEach(cache.set);
        },
      );

      test(
        '''

WHEN the cached list is listened (without filters) multiple times
THEN the complete cached list is continuously emitted as it changes
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
          await sub1b.cancel();
          expect(cache.streamController, isNull);
          final stream2 = cache.watch();
          expect(stream2.isBroadcast, isTrue);
          final sub2a = stream2.listen((value) {});
          expect(cache.streamController, isNotNull);
          final sub2b = stream2.listen((value) {});
          expect(cache.streamController, isNotNull);
          await sub2a.cancel();
          expect(cache.streamController, isNotNull);
          await sub2b.cancel();
          expect(cache.streamController, isNull);
        },
      );

      test(
        '''

WHEN the cached list is watched with a filter
THEN the filtered cached list is continuously emitted as it changes
''',
        () async {
          final stream = cache.watch(
            where: (element) => element != null,
          );
          final values = <List<String?>>[
            [],
            ['value 1', 'value 2', null, 'value 3', null],
            ['value 1'],
            ['value 1   '],
            ['value 1', null, 'value 2'],
            [null, 'value 1', 'value 2'],
            [null, 'value 1', null, null, 'value 2', 'value 3', 'value 4'],
          ];
          final expectedValues = <List<String?>>[
            [],
            ['value 1', 'value 2', 'value 3'],
            ['value 1'],
            ['value 1', 'value 2'],
            ['value 1', 'value 2', 'value 3', 'value 4'],
          ];
          unawaited(
            expectLater(
              stream,
              emitsInOrder([
                for (final value in expectedValues)
                  orderedEquals(value.nonNulls),
              ]),
            ),
          );
          expect(cache.streamController, isNotNull);
          values.forEach(cache.set);
        },
      );

      test(
        '''

WHEN the cached list is listened (with a filter) multiple times
THEN the complete cached list is continuously emitted as it changes
WHEN all listeners are canceled
THEN the stream controller is closed
''',
        () async {
          expect(cache.streamController, isNull);
          final stream1 = cache.watch(where: (element) => element != null);
          expect(stream1.isBroadcast, isTrue);
          final sub1a = stream1.listen((value) {});
          expect(cache.streamController, isNotNull);
          final sub1b = stream1.listen((value) {});
          expect(cache.streamController, isNotNull);
          await sub1a.cancel();
          expect(cache.streamController, isNotNull);
          await sub1b.cancel();
          expect(cache.streamController, isNull);
          final stream2 = cache.watch(where: (element) => element != null);
          expect(stream2.isBroadcast, isTrue);
          final sub2a = stream2.listen((value) {});
          expect(cache.streamController, isNotNull);
          final sub2b = stream2.listen((value) {});
          expect(cache.streamController, isNotNull);
          await sub2a.cancel();
          expect(cache.streamController, isNotNull);
          await sub2b.cancel();
          expect(cache.streamController, isNull);
        },
      );

      test(
        '''

AND a cached list
WHEN another list is inserted
THEN the cached list is updated with the inserted list
''',
        () {
          cache.elements = [
            null,
            'original value 1',
            null,
            'original value 2',
            null,
            null,
            null,
            'original value 6',
            null,
            null,
            null,
            'original value 7',
          ];
          expect(
            cache.elements,
            orderedEquals([
              null,
              'original value 1',
              null,
              'original value 2',
              null,
              null,
              null,
              'original value 6',
              null,
              null,
              null,
              'original value 7',
            ]),
          );
          cache.insertMany(
            [
              'new value 3',
              null,
              'new value 4',
              null,
              null,
              'new value 5',
              null,
              null,
            ],
            index: 5,
          );
          expect(
            cache.elements,
            orderedEquals([
              null,
              'original value 1',
              null,
              'original value 2',
              null,
              'new value 3',
              null,
              'new value 4',
              null,
              null,
              'new value 5',
              null,
              null,
              null,
              null,
              'original value 6',
              null,
              null,
              null,
              'original value 7',
            ]),
          );
        },
      );

      test(
        '''

AND a cached list
WHEN another collection of indexed elements is requested to be placed (append group)
THEN the cached list is updated with the placed indexed elements
''',
        () {
          cache.elements = [
            '0',
            '1',
            '2',
            '3',
            '4',
            '5',
            '6',
          ];
          expect(
            cache.elements,
            orderedEquals([
              '0',
              '1',
              '2',
              '3',
              '4',
              '5',
              '6',
            ]),
          );
          cache.placeMany(
            [
              (2, '2.1'),
              (2, '2.2'),
              (4, '4.1'),
            ],
            mode: PlacementMode.appendGroup,
          );
          expect(
            cache.elements,
            orderedEquals([
              '0',
              '1',
              '2',
              '2.1',
              '2.2',
              '3',
              '4',
              '4.1',
              '5',
              '6',
            ]),
          );
        },
      );

      test(
        '''

AND a cached list
WHEN another collection of indexed elements is requested to be placed (append first)
THEN the cached list is updated with the placed indexed elements
''',
        () {
          cache.elements = [
            '0',
            '1',
            '2',
            '3',
            '4',
            '5',
            '6',
          ];
          expect(
            cache.elements,
            orderedEquals([
              '0',
              '1',
              '2',
              '3',
              '4',
              '5',
              '6',
            ]),
          );
          cache.placeMany(
            [
              (2, '2.1'),
              (2, '2.2'),
              (4, '4.1'),
            ],
            mode: PlacementMode.appendFirst,
          );
          expect(
            cache.elements,
            orderedEquals([
              '0',
              '1',
              '2',
              '2.1',
              '3',
              '4',
              '4.1',
              '5',
              '6',
            ]),
          );
        },
      );

      test(
        '''

AND a cached list
WHEN another collection of indexed elements is requested to be placed (append last)
THEN the cached list is updated with the placed indexed elements
''',
        () {
          cache.elements = [
            '0',
            '1',
            '2',
            '3',
            '4',
            '5',
            '6',
          ];
          expect(
            cache.elements,
            orderedEquals([
              '0',
              '1',
              '2',
              '3',
              '4',
              '5',
              '6',
            ]),
          );
          cache.placeMany(
            [
              (2, '2.1'),
              (2, '2.2'),
              (4, '4.1'),
            ],
            mode: PlacementMode.appendLast,
          );
          expect(
            cache.elements,
            orderedEquals([
              '0',
              '1',
              '2',
              '2.2',
              '3',
              '4',
              '4.1',
              '5',
              '6',
            ]),
          );
        },
      );

      test(
        '''

AND a cached list
WHEN another collection of indexed elements is requested to be placed (prepend group)
THEN the cached list is updated with the placed indexed elements
''',
        () {
          cache.elements = [
            '0',
            '1',
            '2',
            '3',
            '4',
            '5',
            '6',
          ];
          expect(
            cache.elements,
            orderedEquals([
              '0',
              '1',
              '2',
              '3',
              '4',
              '5',
              '6',
            ]),
          );
          cache.placeMany(
            [
              (2, '2.1'),
              (2, '2.2'),
              (4, '4.1'),
            ],
            mode: PlacementMode.prependGroup,
          );
          expect(
            cache.elements,
            orderedEquals([
              '0',
              '1',
              '2.1',
              '2.2',
              '2',
              '3',
              '4.1',
              '4',
              '5',
              '6',
            ]),
          );
        },
      );

      test(
        '''

AND a cached list
WHEN another collection of indexed elements is requested to be placed (prepend first)
THEN the cached list is updated with the placed indexed elements
''',
        () {
          cache.elements = [
            '0',
            '1',
            '2',
            '3',
            '4',
            '5',
            '6',
          ];
          expect(
            cache.elements,
            orderedEquals([
              '0',
              '1',
              '2',
              '3',
              '4',
              '5',
              '6',
            ]),
          );
          cache.placeMany(
            [
              (2, '2.1'),
              (2, '2.2'),
              (4, '4.1'),
            ],
            mode: PlacementMode.prependFirst,
          );
          expect(
            cache.elements,
            orderedEquals([
              '0',
              '1',
              '2.1',
              '2',
              '3',
              '4.1',
              '4',
              '5',
              '6',
            ]),
          );
        },
      );

      test(
        '''

AND a cached list
WHEN another collection of indexed elements is requested to be placed (prepend last)
THEN the cached list is updated with the placed indexed elements
''',
        () {
          cache.elements = [
            '0',
            '1',
            '2',
            '3',
            '4',
            '5',
            '6',
          ];
          expect(
            cache.elements,
            orderedEquals([
              '0',
              '1',
              '2',
              '3',
              '4',
              '5',
              '6',
            ]),
          );
          cache.placeMany(
            [
              (2, '2.1'),
              (2, '2.2'),
              (4, '4.1'),
            ],
            mode: PlacementMode.prependLast,
          );
          expect(
            cache.elements,
            orderedEquals([
              '0',
              '1',
              '2.2',
              '2',
              '3',
              '4.1',
              '4',
              '5',
              '6',
            ]),
          );
        },
      );

      test(
        '''

AND a cached list
WHEN another collection of indexed elements is requested to be placed (replace with group)
THEN the cached list is updated with the placed indexed elements
''',
        () {
          cache.elements = [
            '0',
            '1',
            '2',
            '3',
            '4',
            '5',
            '6',
          ];
          expect(
            cache.elements,
            orderedEquals([
              '0',
              '1',
              '2',
              '3',
              '4',
              '5',
              '6',
            ]),
          );
          cache.placeMany(
            [
              (2, '2.1'),
              (2, '2.2'),
              (4, '4.1'),
            ],
            mode: PlacementMode.replaceWithGroup,
          );
          expect(
            cache.elements,
            orderedEquals([
              '0',
              '1',
              '2.1',
              '2.2',
              '3',
              '4.1',
              '5',
              '6',
            ]),
          );
        },
      );

      test(
        '''

AND a cached list
WHEN another collection of indexed elements is requested to be placed (replace with first)
THEN the cached list is updated with the placed indexed elements
''',
        () {
          cache.elements = [
            '0',
            '1',
            '2',
            '3',
            '4',
            '5',
            '6',
          ];
          expect(
            cache.elements,
            orderedEquals([
              '0',
              '1',
              '2',
              '3',
              '4',
              '5',
              '6',
            ]),
          );
          cache.placeMany(
            [
              (2, '2.1'),
              (2, '2.2'),
              (4, '4.1'),
            ],
            mode: PlacementMode.replaceWithFirst,
          );
          expect(
            cache.elements,
            orderedEquals([
              '0',
              '1',
              '2.1',
              '3',
              '4.1',
              '5',
              '6',
            ]),
          );
        },
      );

      test(
        '''

AND a cached list
WHEN another collection of indexed elements is requested to be placed (replace with last)
THEN the cached list is updated with the placed indexed elements
''',
        () {
          cache.elements = [
            '0',
            '1',
            '2',
            '3',
            '4',
            '5',
            '6',
          ];
          expect(
            cache.elements,
            orderedEquals([
              '0',
              '1',
              '2',
              '3',
              '4',
              '5',
              '6',
            ]),
          );
          cache.placeMany(
            [
              (2, '2.1'),
              (2, '2.2'),
              (4, '4.1'),
            ],
            mode: PlacementMode.replaceWithLast,
          );
          expect(
            cache.elements,
            orderedEquals([
              '0',
              '1',
              '2.2',
              '3',
              '4.1',
              '5',
              '6',
            ]),
          );
        },
      );

      test(
        '''

AND a cached list
WHEN the cached list is updated
THEN the cached list is updated list
''',
        () {
          cache.elements = [
            'value 1',
            'value 2',
            null,
            'value 3',
            null,
            'value 4',
          ];
          expect(
            cache.elements,
            orderedEquals([
              'value 1',
              'value 2',
              null,
              'value 3',
              null,
              'value 4',
            ]),
          );
          cache.update(
            where: (_, element) {
              if (element == null) return false;
              return element.contains(RegExp('(1|3)'));
            },
            update: (element) => element?.replaceAll('value', 'updated'),
          );
          expect(
            cache.elements,
            orderedEquals([
              'updated 1',
              'value 2',
              null,
              'updated 3',
              null,
              'value 4',
            ]),
          );
        },
      );

      test(
        '''

AND a cached list
WHEN some elements of the cached list are requested to be removed
THEN the cached list is updated without the removed elements
''',
        () {
          cache.elements = [
            'value 1',
            'value 2',
            null,
            'value 3',
            null,
            'value 4',
          ];
          expect(
            cache.elements,
            orderedEquals([
              'value 1',
              'value 2',
              null,
              'value 3',
              null,
              'value 4',
            ]),
          );
          cache.remove(
            where: (_, element) => element == null,
          );
          expect(
            cache.elements,
            orderedEquals([
              'value 1',
              'value 2',
              'value 3',
              'value 4',
            ]),
          );
        },
      );

      test(
        '''

AND a cached list
WHEN a trailing group of elements is requested to be removed
THEN the cached list is updated without the removed elements
''',
        () {
          cache.elements = [
            'value 1',
            'value 2',
            null,
            'value 3',
            null,
            'value 4',
          ];
          expect(
            cache.elements,
            orderedEquals([
              'value 1',
              'value 2',
              null,
              'value 3',
              null,
              'value 4',
            ]),
          );
          cache.removeLast(2);
          expect(
            cache.elements,
            orderedEquals([
              'value 1',
              'value 2',
              null,
              'value 3',
            ]),
          );
        },
      );

      test(
        '''

AND a cached list
WHEN a leading group of elements is requested to be removed
THEN the cached list is updated without the removed elements
''',
        () {
          cache.elements = [
            'value 1',
            'value 2',
            null,
            'value 3',
            null,
            'value 4',
          ];
          expect(
            cache.elements,
            orderedEquals([
              'value 1',
              'value 2',
              null,
              'value 3',
              null,
              'value 4',
            ]),
          );
          cache.removeFirst(2);
          expect(
            cache.elements,
            orderedEquals([
              null,
              'value 3',
              null,
              'value 4',
            ]),
          );
        },
      );
    },
  );
}
