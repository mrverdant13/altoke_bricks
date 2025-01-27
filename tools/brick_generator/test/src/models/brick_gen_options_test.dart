import 'package:brick_generator/src/models/brick_gen_options.dart';
import 'package:brick_generator/src/models/replacement.dart';
import 'package:test/test.dart';

void main() {
  group('BrickGenOptions', () {
    test('can be instantiated', () {
      const brickGenOptions = BrickGenOptions();
      expect(brickGenOptions, isA<BrickGenOptions>());
    });

    test('fromJson', () {
      final brickGenOptions = BrickGenOptions.fromJson(const {
        'replacements': [
          {
            'from': r'^from$',
            'to': 'to',
          },
        ],
        'lineDeletions': [
          {
            'filePath': 'file/path',
            'ranges': [
              {
                'start': 1,
                'end': 5,
              },
            ],
          },
        ],
      });
      expect(
        brickGenOptions,
        isA<BrickGenOptions>()
            .having(
              (r) => r.replacements,
              'replacements',
              isNotEmpty,
            )
            .having(
              (r) => r.lineDeletions,
              'lineDeletions',
              isNotEmpty,
            ),
      );
    });

    test('can be compared', () {
      const reference = BrickGenOptions();
      const same = BrickGenOptions();
      final other = BrickGenOptions(
        replacements: [
          Replacement(
            from: RegExp(r'^from$'),
            to: 'to',
          ),
        ],
      );

      expect(reference, same);
      expect(reference, isNot(other));
    });

    test('has consistent hash code', () {
      const reference = BrickGenOptions();
      const same = BrickGenOptions();
      final other = BrickGenOptions(
        replacements: [
          Replacement(
            from: RegExp(r'^from$'),
            to: 'to',
          ),
        ],
      );

      expect(reference.hashCode, same.hashCode);
      expect(reference.hashCode, isNot(other.hashCode));
    });
  });
}
