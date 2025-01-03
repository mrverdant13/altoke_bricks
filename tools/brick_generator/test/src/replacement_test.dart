import 'package:brick_generator/src/models/replacement.dart';
import 'package:test/test.dart';

void main() {
  group('Replacement', () {
    test('can be instantiated', () {
      final replacement = Replacement(
        from: RegExp('from'),
        to: 'to',
      );
      expect(replacement, isA<Replacement>());
    });

    test('fromJson', () {
      final replacement = Replacement.fromJson(const {
        'from': r'^from$',
        'to': 'to',
      });
      expect(
        replacement,
        isA<Replacement>()
            .having(
              (r) => r.from,
              'from',
              isA<RegExp>().having(
                (r) => r.pattern,
                'pattern',
                r'^from$',
              ),
            )
            .having(
              (r) => r.to,
              'to',
              'to',
            ),
      );
    });

    test('can be compared', () {
      final reference = Replacement(
        from: RegExp('from'),
        to: 'to',
      );
      final same = Replacement(
        from: RegExp('from'),
        to: 'to',
      );
      final other = Replacement(
        from: RegExp('from'),
        to: 'to2',
      );
      expect(reference, same);
      expect(reference, isNot(other));
    });

    test('has consistent hash code', () {
      final reference = Replacement(
        from: RegExp('from'),
        to: 'to',
      );
      final same = Replacement(
        from: RegExp('from'),
        to: 'to',
      );
      final other = Replacement(
        from: RegExp('from'),
        to: 'to2',
      );
      expect(reference.hashCode, same.hashCode);
      expect(reference.hashCode, isNot(other.hashCode));
    });

    test('apply', () {
      final replacement = Replacement(
        from: RegExp(r'some\w?.*\w?pattern'),
        to: 'XxXxXxX',
      );
      const input = 'This is some test pattern.';
      const expected = 'This is XxXxXxX.';
      final actual = replacement.apply(input);
      expect(actual, expected);
    });
  });

  group('ReplacementsList', () {
    test('fromJson', () async {
      final replacements = ReplacementsList.fromJson([
        {
          'from': r'^from$',
          'to': 'to',
        },
        {
          'from': r'^from2$',
          'to': 'to2',
        },
      ]);
      expect(replacements, isA<List<Replacement>>());
      expect(
        replacements,
        orderedEquals([
          Replacement(
            from: RegExp(r'^from$'),
            to: 'to',
          ),
          Replacement(
            from: RegExp(r'^from2$'),
            to: 'to2',
          ),
        ]),
      );
    });

    test('apply', () {
      final replacements = [
        Replacement(
          from: RegExp('some test pattern'),
          to: 'XxXxXxX',
        ),
        Replacement(
          from: RegExp('another test pattern'),
          to: 'YyYyYyY',
        ),
      ];
      const input = 'This is some test pattern. This is another test pattern.';
      const expected = 'This is XxXxXxX. This is YyYyYyY.';
      final actual = replacements.apply(input);
      expect(actual, expected);
    });
  });

  group('FileContentWithReplacements', () {
    test('applyReplacements', () {
      const input = 'This is some test pattern. This is another test pattern.';
      final replacements = [
        Replacement(
          from: RegExp('some test pattern'),
          to: 'XxXxXxX',
        ),
        Replacement(
          from: RegExp('another test pattern'),
          to: 'YyYyYyY',
        ),
      ];
      const expected = 'This is XxXxXxX. This is YyYyYyY.';
      final actual = input.applyReplacements(replacements);
      expect(actual, expected);
    });
  });
}
