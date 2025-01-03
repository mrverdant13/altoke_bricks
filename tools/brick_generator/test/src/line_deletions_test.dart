import 'package:brick_generator/src/models/line_deletions.dart';
import 'package:test/test.dart';

void main() {
  group('LinesDeletion', () {
    test('can be instantiated', () {
      const linesDeletion = LinesDeletion(
        filePath: 'file/path',
        ranges: [],
      );
      expect(linesDeletion, isA<LinesDeletion>());
    });

    test('fromJson', () {
      final linesDeletion = LinesDeletion.fromJson(const {
        'filePath': 'file/path',
        'ranges': [
          {'start': 1, 'end': 5},
          {'start': 11, 'end': 15},
        ],
      });
      expect(
        linesDeletion,
        isA<LinesDeletion>()
            .having(
              (r) => r.filePath,
              'filePath',
              'file/path',
            )
            .having(
              (r) => r.ranges,
              'ranges',
              orderedEquals([
                const LinesRange(start: 1, end: 5),
                const LinesRange(start: 11, end: 15),
              ]),
            ),
      );
    });

    test('can be compared', () {
      const reference = LinesDeletion(
        filePath: 'file/path',
        ranges: [],
      );
      const same = LinesDeletion(
        filePath: 'file/path',
        ranges: [],
      );
      const other = LinesDeletion(
        filePath: 'other/file/path',
        ranges: [],
      );

      expect(reference, same);
      expect(reference, isNot(other));
    });

    test('has consistent hash code', () {
      const reference = LinesDeletion(
        filePath: 'file/path',
        ranges: [],
      );
      const same = LinesDeletion(
        filePath: 'file/path',
        ranges: [],
      );
      const other = LinesDeletion(
        filePath: 'other/file/path',
        ranges: [],
      );

      expect(reference.hashCode, same.hashCode);
      expect(reference.hashCode, isNot(other.hashCode));
    });
  });

  group('LinesRange', () {
    test('can be instantiated', () {
      const linesRange = LinesRange(
        start: 1,
        end: 5,
      );
      expect(linesRange, isA<LinesRange>());
    });

    test('fromJson', () {
      final linesRange = LinesRange.fromJson(const {
        'start': 1,
        'end': 5,
      });
      expect(
        linesRange,
        isA<LinesRange>()
            .having(
              (r) => r.start,
              'start',
              1,
            )
            .having(
              (r) => r.end,
              'end',
              5,
            ),
      );
    });

    test('can be compared', () {
      const reference = LinesRange(
        start: 1,
        end: 5,
      );
      const same = LinesRange(
        start: 1,
        end: 5,
      );
      const other = LinesRange(
        start: 1,
        end: 6,
      );

      expect(reference, same);
      expect(reference, isNot(other));
    });

    test('has consistent hash code', () {
      const reference = LinesRange(
        start: 1,
        end: 5,
      );
      const same = LinesRange(
        start: 1,
        end: 5,
      );
      const other = LinesRange(
        start: 1,
        end: 6,
      );

      expect(reference.hashCode, same.hashCode);
      expect(reference.hashCode, isNot(other.hashCode));
    });

    test('contains', () {
      const linesRange = LinesRange(
        start: 1,
        end: 5,
      );
      expect(linesRange.contains(0), isFalse);
      expect(linesRange.contains(1), isTrue);
      expect(linesRange.contains(3), isTrue);
      expect(linesRange.contains(5), isTrue);
      expect(linesRange.contains(6), isFalse);
    });
  });

  group('LineDeletionsList', () {
    test('fromJson', () {
      final lineDeletions = LineDeletionsList.fromJson([
        {
          'filePath': 'file/path',
          'ranges': [
            {'start': 1, 'end': 5},
            {'start': 11, 'end': 15},
          ],
        },
        {
          'filePath': 'other/file/path',
          'ranges': [
            {'start': 2, 'end': 6},
            {'start': 12, 'end': 16},
          ],
        },
      ]);
      expect(lineDeletions, isA<List<LinesDeletion>>());
      expect(
        lineDeletions,
        orderedEquals([
          const LinesDeletion(
            filePath: 'file/path',
            ranges: [
              LinesRange(start: 1, end: 5),
              LinesRange(start: 11, end: 15),
            ],
          ),
          const LinesDeletion(
            filePath: 'other/file/path',
            ranges: [
              LinesRange(start: 2, end: 6),
              LinesRange(start: 12, end: 16),
            ],
          ),
        ]),
      );
    });

    test('apply', () {
      final lineDeletions = [
        const LinesDeletion(
          filePath: 'file/path',
          ranges: [
            LinesRange(start: 1, end: 5),
            LinesRange(start: 11, end: 15),
          ],
        ),
        const LinesDeletion(
          filePath: 'other/file/path',
          ranges: [
            LinesRange(start: 2, end: 6),
            LinesRange(start: 12, end: 16),
          ],
        ),
      ];

      const input = '''
This is line 1.
This is line 2.
This is line 3.
This is line 4.
This is line 5.
This is line 6.
This is line 7.
This is line 8.
This is line 9.
This is line 10.
This is line 11.
This is line 12.
This is line 13.
This is line 14.
This is line 15.
This is line 16.
This is line 17.
This is line 18.
This is line 19.
This is line 20.
''';

      const expected = '''
This is line 1.
This is line 7.
This is line 8.
This is line 9.
This is line 10.
This is line 11.
This is line 17.
This is line 18.
This is line 19.
This is line 20.
''';

      final result = lineDeletions.apply(
        filePath: 'file/path',
        input: input,
      );

      expect(result, expected);
    });
  });

  group('FileContentsWithDeletableLines', () {
    test('apply', () {
      const input = '''
This is line 1.
This is line 2.
This is line 3.
This is line 4.
This is line 5.
This is line 6.
This is line 7.
This is line 8.
This is line 9.
This is line 10.
This is line 11.
This is line 12.
This is line 13.
This is line 14.
This is line 15.
This is line 16.
This is line 17.
This is line 18.
This is line 19.
This is line 20.
''';

      final lineDeletions = [
        const LinesDeletion(
          filePath: 'file/path',
          ranges: [
            LinesRange(start: 1, end: 5),
            LinesRange(start: 11, end: 15),
          ],
        ),
        const LinesDeletion(
          filePath: 'other/file/path',
          ranges: [
            LinesRange(start: 2, end: 6),
            LinesRange(start: 12, end: 16),
          ],
        ),
      ];

      const expected = '''
This is line 1.
This is line 7.
This is line 8.
This is line 9.
This is line 10.
This is line 11.
This is line 17.
This is line 18.
This is line 19.
This is line 20.
''';

      final result = input.applyLineDeletions(
        lineDeletions: lineDeletions,
        filePath: 'file/path',
      );

      expect(result, expected);
    });
  });
}
