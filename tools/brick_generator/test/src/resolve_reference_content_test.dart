import 'package:brick_generator/src/models/brick_gen_data.dart';
import 'package:brick_generator/src/resolve_reference_content.dart';
import 'package:test/test.dart';

void main() {
  group('resolveReferenceContent', () {
    test('removes a remove-start/end block', () {
      const input = '''
line0
/*remove-start*/
scaffold
/*remove-end*/
line1
''';
      const expected = '''
line0

line1
''';
      final result = resolveReferenceContent(
        content: input,
        targetRelativePath: 'file.txt',
        brickGenData: const BrickGenData(
          referenceAbsolutePath: '',
          targetAbsolutePath: '.',
          replacements: [],
          lineDeletions: [],
        ),
      );
      expect(result, expected);
    });

    test('unwraps a commented mustache tag', () {
      const input = '/*x{{flag}}*/tail';
      const expected = '{{flag}}tail';
      final result = resolveReferenceContent(
        content: input,
        targetRelativePath: 'file.txt',
        brickGenData: const BrickGenData(
          referenceAbsolutePath: '',
          targetAbsolutePath: '.',
          replacements: [],
          lineDeletions: [],
        ),
      );
      expect(result, expected);
    });
  });
}
