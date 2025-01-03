import 'package:brick_generator/src/models/brick_gen_options.dart';
import 'package:test/test.dart';

void main() {
  group('BrickGenOptions', () {
    test('can be instantiated', () {
      const brickGenOptions = BrickGenOptions(
        targetRelativePath: 'target/relative/path',
      );
      expect(brickGenOptions, isA<BrickGenOptions>());
    });

    test('fromJson', () {
      final brickGenOptions = BrickGenOptions.fromJson(const {
        'targetRelativePath': 'target/relative/path',
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
              (r) => r.targetRelativePath,
              'targetRelativePath',
              'target/relative/path',
            )
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
      const reference = BrickGenOptions(
        targetRelativePath: 'target/relative/path',
      );
      const same = BrickGenOptions(
        targetRelativePath: 'target/relative/path',
      );
      const other = BrickGenOptions(
        targetRelativePath: 'other/target/relative/path',
      );

      expect(reference, same);
      expect(reference, isNot(other));
    });

    test('has consistent hash code', () {
      const reference = BrickGenOptions(
        targetRelativePath: 'target/relative/path',
      );
      const same = BrickGenOptions(
        targetRelativePath: 'target/relative/path',
      );
      const other = BrickGenOptions(
        targetRelativePath: 'other/target/relative/path',
      );

      expect(reference.hashCode, same.hashCode);
      expect(reference.hashCode, isNot(other.hashCode));
    });
  });
}
