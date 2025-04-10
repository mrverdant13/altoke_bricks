import 'package:{{#requirements_met}}reactive_caches{{/requirements_met}}/{{#requirements_met}}reactive_caches{{/requirements_met}}.dart';
import 'package:test/test.dart';

void main() {
  test(
    '''

GIVEN a constructor for a reactive cache for a list of elements
WHEN the constructor is called
THEN an instance of the cache is returned
├─ THAT has a default equality checker
''',
    () {
      final cache = ReactiveElementsListCache<String?>();
      addTearDown(cache.dispose);
      expect(cache, isA<ReactiveElementsListCache<String?>>());
      expect(cache.equalityChecker([''], ['']), isTrue);
      expect(
        cache.equalityChecker(
          ['string 1', 'string 2'],
          ['string 1', 'string 2'],
        ),
        isTrue,
      );
      expect(
        cache.equalityChecker(
          ['string 1', 'string 2'],
          ['string 2', 'string 1'],
        ),
        isFalse,
      );
      expect(
        cache.equalityChecker(
          ['string 1', 'string 2'],
          ['string 1', 'string 3'],
        ),
        isFalse,
      );
      expect(
        cache.equalityChecker(
          ['string 1', 'string 2'],
          ['string 0', 'string 1', 'string 2'],
        ),
        isFalse,
      );
    },
  );

  group(
    '''

GIVEN a reactive cache for a list of elements''',
    () {
      late ElementsListEqualityChecker<String?> equalityChecker;
      late ReactiveElementsListCache<String?> cache;

      setUp(() {
        equalityChecker = (a, b) {
          if (a.length != b.length) return false;
          for (var i = 0; i < a.length; i++) {
            if (a[i]?.trim() != b[i]?.trim()) return false;
          }
          return true;
        };
        cache = ReactiveElementsListCache<String?>(
          equalityChecker: equalityChecker,
        );
      });

      tearDown(() async {
        await cache.dispose();
      });

      test(
        '''

AND a cached list
WHEN another list is cached
THEN the cached list is the new list
''',
        () async {
          cache.elements = ['original value 1', 'original value 2'];
          expect(
            cache.elements,
            orderedEquals(['original value 1', 'original value 2']),
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
          cache.elements = ['original value 1', 'original value 2'];
          expect(
            cache.elements,
            orderedEquals(['original value 1', 'original value 2']),
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
          final element = cache.get(where: (element) => element != null);
          expect(
            element,
            orderedEquals(['value 1', 'value 2', 'value 3', 'value 4']),
          );
        },
      );

      test(
        '''

WHEN the cached list is watched without a filter
THEN the complete cached list is continuously emitted as it changes
''',
        () async {
          final streamA = cache.watch();
          final valuesA1 = <List<String?>>[];
          final subA1 = streamA.listen(valuesA1.add);
          addTearDown(subA1.cancel);
          await pumpEventQueue();
          cache.streamController
            ..add([])
            ..add(['value 1', 'value 2', null, 'value 3', null])
            ..add(['value 1   ', '   value 2', null, '   value 3   ', null])
            ..add(['value 1'])
            ..add(['value 1', null, 'value 2'])
            ..add(['   value 1', null, 'value 2   '])
            ..add([null, 'value 1', null, null, 'value 2', 'value 3'])
            ..add([null, 'value 1 ', null, null, ' value 2', ' value 3 ']);
          await pumpEventQueue();
          expect(
            valuesA1,
            pairwiseCompare<List<String?>, List<String?>>(
              [
                <String?>[],
                ['value 1', 'value 2', null, 'value 3', null],
                ['value 1'],
                ['value 1', null, 'value 2'],
                [null, 'value 1', null, null, 'value 2', 'value 3'],
              ],
              equalityChecker,
              'equal (with checker) to',
            ),
          );
          final valuesA2 = <List<String?>>[];
          final subA2 = streamA.listen(valuesA2.add);
          addTearDown(subA2.cancel);
          final streamB = cache.watch();
          final valuesB2 = <List<String?>>[];
          final subB2 = streamB.listen(valuesB2.add);
          addTearDown(subB2.cancel);
          await pumpEventQueue();
          cache.streamController
            ..add([null, 'value 1', null, null, 'value 2', 'value 3'])
            ..add(['value 1', null, null, 'value 2', 'value 3'])
            ..add([' value 1', null, null, 'value 2 ', ' value 3 '])
            ..add([null, 'value 1', null, 'value 2', 'value 3'])
            ..add([null, ' value 1 ', null, ' value 2 ', ' value 3 '])
            ..add([null, 'value 1', 'value 2'])
            ..add([null, '  value 1  ', '  value 2  '])
            ..add([null, 'value 1'])
            ..add([null, '   value 1   '])
            ..add(['value 1'])
            ..add(['       value 1       ']);
          await pumpEventQueue();
          final expectedValues = [
            [null, 'value 1', null, null, 'value 2', 'value 3'],
            ['value 1', null, null, 'value 2', 'value 3'],
            [null, 'value 1', null, 'value 2', 'value 3'],
            [null, 'value 1', 'value 2'],
            [null, 'value 1'],
            ['value 1'],
          ];
          expect(
            valuesA2,
            pairwiseCompare<List<String?>, List<String?>>(
              expectedValues,
              equalityChecker,
              'equal (with checker) to',
            ),
          );
          expect(
            valuesB2,
            pairwiseCompare<List<String?>, List<String?>>(
              expectedValues,
              equalityChecker,
              'equal (with checker) to',
            ),
          );
        },
      );

      test(
        '''

WHEN the cached list is watched with a filter
THEN the complete cached list is continuously emitted as it changes
''',
        () async {
          bool where(String? element) => !(element ?? '').contains('ignore');
          final streamA = cache.watch(where: where);
          final valuesA1 = <List<String?>>[];
          final subA1 = streamA.listen(valuesA1.add);
          addTearDown(subA1.cancel);
          await pumpEventQueue();
          cache.streamController
            ..add([])
            ..add(['value 1', 'ignore', 'value 2', null, 'value 3', null])
            ..add(['value 1   ', '   value 2', null, '   value 3   ', null])
            ..add(['value 1', 'to be ignored'])
            ..add(['value 1', null, 'ignore this', 'value 2'])
            ..add(['   value 1', null, 'value 2   '])
            ..add([null, 'value 1', null, null, 'value 2', 'value 3'])
            ..add([null, 'value 1 ', null, null, ' value 2', ' value 3 ']);
          await pumpEventQueue();
          expect(
            valuesA1,
            pairwiseCompare<List<String?>, List<String?>>(
              [
                <String?>[],
                ['value 1', 'value 2', null, 'value 3', null],
                ['value 1'],
                ['value 1', null, 'value 2'],
                [null, 'value 1', null, null, 'value 2', 'value 3'],
              ],
              equalityChecker,
              'equal (with checker) to',
            ),
          );
          final valuesA2 = <List<String?>>[];
          final subA2 = streamA.listen(valuesA2.add);
          addTearDown(subA2.cancel);
          final streamB = cache.watch(where: where);
          final valuesB2 = <List<String?>>[];
          final subB2 = streamB.listen(valuesB2.add);
          addTearDown(subB2.cancel);
          await pumpEventQueue();
          cache.streamController
            ..add([null, 'value 1', null, null, 'value 2', 'value 3'])
            ..add(['value 1', 'ignore', null, null, 'value 2', 'value 3'])
            ..add([' value 1', null, null, 'value 2 ', ' value 3 '])
            ..add([null, 'value 1', null, 'value 2', 'value 3'])
            ..add([null, ' value 1 ', null, ' value 2 ', ' value 3 '])
            ..add([null, 'value 1', 'to be ignored', 'value 2'])
            ..add([null, '  value 1  ', '  value 2  '])
            ..add([null, 'value 1', 'ignore this'])
            ..add([null, '   value 1   '])
            ..add(['value 1', 'should be ignored'])
            ..add(['       value 1       ']);
          await pumpEventQueue();
          final expectedValues = [
            [null, 'value 1', null, null, 'value 2', 'value 3'],
            ['value 1', null, null, 'value 2', 'value 3'],
            [null, 'value 1', null, 'value 2', 'value 3'],
            [null, 'value 1', 'value 2'],
            [null, 'value 1'],
            ['value 1'],
          ];
          expect(
            valuesA2,
            pairwiseCompare<List<String?>, List<String?>>(
              expectedValues,
              equalityChecker,
              'equal (with checker) to',
            ),
          );
          expect(
            valuesB2,
            pairwiseCompare<List<String?>, List<String?>>(
              expectedValues,
              equalityChecker,
              'equal (with checker) to',
            ),
          );
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
          cache.insertMany([
            'new value 3',
            null,
            'new value 4',
            null,
            null,
            'new value 5',
            null,
            null,
          ], index: 5);
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
          cache.elements = ['0', '1', '2', '3', '4', '5', '6'];
          expect(
            cache.elements,
            orderedEquals(['0', '1', '2', '3', '4', '5', '6']),
          );
          cache.placeMany([
            (2, '2.1'),
            (2, '2.2'),
            (4, '4.1'),
          ], mode: PlacementMode.appendGroup);
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
          cache.elements = ['0', '1', '2', '3', '4', '5', '6'];
          expect(
            cache.elements,
            orderedEquals(['0', '1', '2', '3', '4', '5', '6']),
          );
          cache.placeMany([
            (2, '2.1'),
            (2, '2.2'),
            (4, '4.1'),
          ], mode: PlacementMode.appendFirst);
          expect(
            cache.elements,
            orderedEquals(['0', '1', '2', '2.1', '3', '4', '4.1', '5', '6']),
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
          cache.elements = ['0', '1', '2', '3', '4', '5', '6'];
          expect(
            cache.elements,
            orderedEquals(['0', '1', '2', '3', '4', '5', '6']),
          );
          cache.placeMany([
            (2, '2.1'),
            (2, '2.2'),
            (4, '4.1'),
          ], mode: PlacementMode.appendLast);
          expect(
            cache.elements,
            orderedEquals(['0', '1', '2', '2.2', '3', '4', '4.1', '5', '6']),
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
          cache.elements = ['0', '1', '2', '3', '4', '5', '6'];
          expect(
            cache.elements,
            orderedEquals(['0', '1', '2', '3', '4', '5', '6']),
          );
          cache.placeMany([
            (2, '2.1'),
            (2, '2.2'),
            (4, '4.1'),
          ], mode: PlacementMode.prependGroup);
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
          cache.elements = ['0', '1', '2', '3', '4', '5', '6'];
          expect(
            cache.elements,
            orderedEquals(['0', '1', '2', '3', '4', '5', '6']),
          );
          cache.placeMany([
            (2, '2.1'),
            (2, '2.2'),
            (4, '4.1'),
          ], mode: PlacementMode.prependFirst);
          expect(
            cache.elements,
            orderedEquals(['0', '1', '2.1', '2', '3', '4.1', '4', '5', '6']),
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
          cache.elements = ['0', '1', '2', '3', '4', '5', '6'];
          expect(
            cache.elements,
            orderedEquals(['0', '1', '2', '3', '4', '5', '6']),
          );
          cache.placeMany([
            (2, '2.1'),
            (2, '2.2'),
            (4, '4.1'),
          ], mode: PlacementMode.prependLast);
          expect(
            cache.elements,
            orderedEquals(['0', '1', '2.2', '2', '3', '4.1', '4', '5', '6']),
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
          cache.elements = ['0', '1', '2', '3', '4', '5', '6'];
          expect(
            cache.elements,
            orderedEquals(['0', '1', '2', '3', '4', '5', '6']),
          );
          cache.placeMany([
            (2, '2.1'),
            (2, '2.2'),
            (4, '4.1'),
          ], mode: PlacementMode.replaceWithGroup);
          expect(
            cache.elements,
            orderedEquals(['0', '1', '2.1', '2.2', '3', '4.1', '5', '6']),
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
          cache.elements = ['0', '1', '2', '3', '4', '5', '6'];
          expect(
            cache.elements,
            orderedEquals(['0', '1', '2', '3', '4', '5', '6']),
          );
          cache.placeMany([
            (2, '2.1'),
            (2, '2.2'),
            (4, '4.1'),
          ], mode: PlacementMode.replaceWithFirst);
          expect(
            cache.elements,
            orderedEquals(['0', '1', '2.1', '3', '4.1', '5', '6']),
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
          cache.elements = ['0', '1', '2', '3', '4', '5', '6'];
          expect(
            cache.elements,
            orderedEquals(['0', '1', '2', '3', '4', '5', '6']),
          );
          cache.placeMany([
            (2, '2.1'),
            (2, '2.2'),
            (4, '4.1'),
          ], mode: PlacementMode.replaceWithLast);
          expect(
            cache.elements,
            orderedEquals(['0', '1', '2.2', '3', '4.1', '5', '6']),
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
          cache.remove(where: (_, element) => element == null);
          expect(
            cache.elements,
            orderedEquals(['value 1', 'value 2', 'value 3', 'value 4']),
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
            orderedEquals(['value 1', 'value 2', null, 'value 3']),
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
            orderedEquals([null, 'value 3', null, 'value 4']),
          );
        },
      );
    },
  );
}
