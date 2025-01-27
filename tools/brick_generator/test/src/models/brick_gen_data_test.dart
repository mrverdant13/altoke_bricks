import 'package:brick_generator/src/models/brick_gen_data.dart';
import 'package:brick_generator/src/models/brick_gen_options.dart';
import 'package:brick_generator/src/models/replacement.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

void main() {
  group('BrickGenData', () {
    test('can be instantiated', () {
      const brickGenData = BrickGenData(
        referenceAbsolutePath: 'reference/absolute/path',
        targetAbsolutePath: 'target/absolute/path',
        replacements: [],
        lineDeletions: [],
      );
      expect(brickGenData, isA<BrickGenData>());
    });

    test('fromOptions', () {
      final brickGenData = BrickGenData.fromOptions(
        referenceAbsolutePath: 'reference/absolute/path',
        targetAbsolutePath: 'target/absolute/path',
        options: const BrickGenOptions(),
      );
      expect(
        brickGenData,
        isA<BrickGenData>()
            .having(
              (r) => path.equals(
                r.referenceAbsolutePath,
                'reference/absolute/path',
              ),
              'referenceAbsolutePath',
              isTrue,
            )
            .having(
              (r) => path.equals(
                r.targetAbsolutePath,
                'target/absolute/path',
              ),
              'targetAbsolutePath',
              isTrue,
            )
            .having(
              (r) => r.replacements,
              'replacements',
              isEmpty,
            )
            .having(
              (r) => r.lineDeletions,
              'lineDeletions',
              isEmpty,
            ),
      );
    });

    test('can be compared', () {
      const reference = BrickGenData(
        referenceAbsolutePath: 'reference/absolute/path',
        targetAbsolutePath: 'target/absolute/path',
        replacements: [],
        lineDeletions: [],
      );
      const same = BrickGenData(
        referenceAbsolutePath: 'reference/absolute/path',
        targetAbsolutePath: 'target/absolute/path',
        replacements: [],
        lineDeletions: [],
      );
      final other = BrickGenData(
        referenceAbsolutePath: 'reference/absolute/path',
        targetAbsolutePath: 'target/absolute/path',
        replacements: [
          Replacement(
            from: RegExp('from'),
            to: 'to',
          ),
        ],
        lineDeletions: const [],
      );
      expect(reference, same);
      expect(reference, isNot(other));
    });

    test('has consistent hash code', () {
      const reference = BrickGenData(
        referenceAbsolutePath: 'reference/absolute/path',
        targetAbsolutePath: 'target/absolute/path',
        replacements: [],
        lineDeletions: [],
      );
      const same = BrickGenData(
        referenceAbsolutePath: 'reference/absolute/path',
        targetAbsolutePath: 'target/absolute/path',
        replacements: [],
        lineDeletions: [],
      );
      final other = BrickGenData(
        referenceAbsolutePath: 'reference/absolute/path',
        targetAbsolutePath: 'target/absolute/path',
        replacements: [
          Replacement(
            from: RegExp('from'),
            to: 'to',
          ),
        ],
        lineDeletions: const [],
      );
      expect(reference.hashCode, same.hashCode);
      expect(reference.hashCode, isNot(other.hashCode));
    });

    test('applyReplacementsToTargetRelativeDescendant', () {
      final brickGenData = BrickGenData(
        referenceAbsolutePath: 'reference/absolute/path',
        targetAbsolutePath: 'target/absolute/path',
        replacements: [
          Replacement(
            from: RegExp('from'),
            to: 'to',
          ),
        ],
        lineDeletions: const [],
      );
      final result = brickGenData.applyReplacementsToTargetRelativeDescendant(
        'target/absolute/path/from/sub-path',
      );
      const expected = 'target/absolute/path/to/sub-path';
      expect(path.equals(result, expected), isTrue);
    });
  });
}
