import 'dart:io';

import 'package:brick_generator/src/models/brick_gen_data.dart';
import 'package:brick_generator/src/models/line_deletions.dart';
import 'package:brick_generator/src/models/replacement.dart';
import 'package:brick_generator/src/reference_file.dart';
import 'package:monorepo_elements/monorepo_elements.dart';
import 'package:test/test.dart';

void main() {
  group('ReferenceFile', () {
    group('parametrize', () {
      group('for a gitignored file', () {
        test('deletes the file', () async {
          final ignoredFile = File('./.dart_tool/ignored.txt');
          expect(ignoredFile.existsSync(), isFalse);
          ignoredFile.createSync();
          expect(ignoredFile.existsSync(), isTrue);
          ignoredFile.writeAsStringSync('ignored');
          await ignoredFile.parametrize(
            brickGenData: const BrickGenData(
              referenceAbsolutePath: '',
              targetAbsolutePath: '',
              replacements: [],
              lineDeletions: [],
            ),
          );
          expect(ignoredFile.existsSync(), isFalse);
        });
      });

      group('for a non-gitignored file', () {
        final tempDir = Directory('./test/_temp_');

        setUpAll(() {
          if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
          tempDir.createSync(recursive: true);
        });

        tearDownAll(() {
          tempDir.deleteSync(recursive: true);
        });

        group('resolves the path', () {
          final testDir = tempDir.descendantDir('test');

          setUpAll(() {
            if (testDir.existsSync()) testDir.deleteSync(recursive: true);
            testDir.createSync(recursive: true);
          });

          tearDownAll(() {
            testDir.deleteSync(recursive: true);
          });

          test('(file name only)', () async {
            final originalFile = testDir.descendantFile('from-file.txt');
            final resultingFile = testDir.descendantFile('to-file.txt');
            expect(originalFile.existsSync(), isFalse);
            expect(resultingFile.existsSync(), isFalse);
            originalFile.createSync(recursive: true);
            expect(originalFile.existsSync(), isTrue);
            expect(resultingFile.existsSync(), isFalse);
            await originalFile.parametrize(
              brickGenData: BrickGenData(
                referenceAbsolutePath: '',
                targetAbsolutePath: '',
                replacements: [Replacement(from: RegExp('from'), to: 'to')],
                lineDeletions: const [],
              ),
            );
            expect(originalFile.existsSync(), isFalse);
            expect(resultingFile.existsSync(), isTrue);
          });

          test('(directory name)', () async {
            final originalFile = testDir.descendantFile('from/file.txt');
            final resultingFile = testDir.descendantFile('to/file.txt');
            expect(originalFile.existsSync(), isFalse);
            expect(resultingFile.existsSync(), isFalse);
            originalFile.createSync(recursive: true);
            expect(originalFile.existsSync(), isTrue);
            expect(resultingFile.existsSync(), isFalse);
            await originalFile.parametrize(
              brickGenData: BrickGenData(
                referenceAbsolutePath: '',
                targetAbsolutePath: '',
                replacements: [Replacement(from: RegExp('from'), to: 'to')],
                lineDeletions: const [],
              ),
            );
            expect(originalFile.existsSync(), isFalse);
            expect(resultingFile.existsSync(), isTrue);
          });

          test('(directory name and file name)', () async {
            final originalFile = testDir.descendantFile('from/from.txt');
            final resultingFile = testDir.descendantFile('to/to.txt');
            expect(originalFile.existsSync(), isFalse);
            expect(resultingFile.existsSync(), isFalse);
            originalFile.createSync(recursive: true);
            expect(originalFile.existsSync(), isTrue);
            expect(resultingFile.existsSync(), isFalse);
            await originalFile.parametrize(
              brickGenData: BrickGenData(
                referenceAbsolutePath: '',
                targetAbsolutePath: '',
                replacements: [Replacement(from: RegExp('from'), to: 'to')],
                lineDeletions: const [],
              ),
            );
            expect(originalFile.existsSync(), isFalse);
            expect(resultingFile.existsSync(), isTrue);
          });
        });

        test('applies line deletions', () async {
          final testDir = tempDir.descendantDir('line_deletions');
          addTearDown(() => testDir.deleteSync(recursive: true));
          const fileName = 'file.txt';
          final file = testDir.descendantFile(fileName);
          expect(file.existsSync(), isFalse);
          file.createSync(recursive: true);
          const deletionRange = LinesRange(start: 3, end: 7);
          const linesDeletion = LinesDeletion(
            filePath: fileName,
            ranges: [deletionRange],
          );
          const originalContent = '''
line 0
line 1
line 2
line 3
line 4
line 5
line 6
line 7
line 8
line 9
''';
          const resultingContent = '''
line 0
line 1
line 2
line 8
line 9
''';
          file.writeAsStringSync(originalContent);
          expect(file.existsSync(), isTrue);
          expect(file.readAsStringSync(), originalContent);
          await file.parametrize(
            brickGenData: BrickGenData(
              referenceAbsolutePath: '',
              targetAbsolutePath: testDir.path,
              replacements: const [],
              lineDeletions: const [linesDeletion],
            ),
          );
          expect(file.existsSync(), isTrue);
          expect(file.readAsStringSync(), resultingContent);
        });

        test('applies replacements', () async {
          final testDir = tempDir.descendantDir('replacements');
          addTearDown(() => testDir.deleteSync(recursive: true));
          final file = testDir.descendantFile('file.txt');
          expect(file.existsSync(), isFalse);
          file.createSync(recursive: true);
          final replacement = Replacement(
            from: RegExp(r'line (\d+) to be replaced'),
            to: 'replaced line',
          );
          const originalContent = '''
line 0
line 1 to be replaced
line 2
line 3
line 4 to be replaced
line 5
line 6
line 7
line 8 to be replaced
line 9
''';
          const resultingContent = '''
line 0
replaced line
line 2
line 3
replaced line
line 5
line 6
line 7
replaced line
line 9
''';
          file.writeAsStringSync(originalContent);
          expect(file.existsSync(), isTrue);
          expect(file.readAsStringSync(), originalContent);
          await file.parametrize(
            brickGenData: BrickGenData(
              referenceAbsolutePath: '',
              targetAbsolutePath: testDir.path,
              replacements: [replacement],
              lineDeletions: const [],
            ),
          );
          expect(file.existsSync(), isTrue);
          expect(file.readAsStringSync(), resultingContent);
        });

        test('deletes remotion blocks', () async {
          final testDir = tempDir.descendantDir('remotion_blocks');
          addTearDown(() => testDir.deleteSync(recursive: true));
          final file = testDir.descendantFile('file.txt');
          expect(file.existsSync(), isFalse);
          file.createSync(recursive: true);
          const originalContent = '''
line   <!--x-remove-start--> asdf
asdf asdf
asdf <!--remove-end-x-->    0
line 1
line  /*x-remove-start*/ asdf
asdf asdf
asdf /*remove-end*/  2
line   #remove-start# asdf
asdf asdf
asdf #remove-end-x#       3
line  <!--remove-start--> asdf
asdf asdf
asdf <!--remove-end-->  4
line 5
''';
          const resultingContent = '''
line0
line 1
line  2
line   3
line    4
line 5
''';
          file.writeAsStringSync(originalContent);
          expect(file.existsSync(), isTrue);
          expect(file.readAsStringSync(), originalContent);
          await file.parametrize(
            brickGenData: BrickGenData(
              referenceAbsolutePath: '',
              targetAbsolutePath: testDir.path,
              replacements: const [],
              lineDeletions: const [],
            ),
          );
          expect(file.existsSync(), isTrue);
          expect(file.readAsStringSync(), resultingContent);
        });

        test('deletes droppable blocks', () async {
          final testDir = tempDir.descendantDir('droppable_blocks');
          addTearDown(() => testDir.deleteSync(recursive: true));
          final dropCases = ['/*drop*/', '#drop#', '<!--drop-->'];
          for (final (index, dropCase) in dropCases.indexed) {
            final file = testDir.descendantFile('file$index.txt');
            expect(file.existsSync(), isFalse);
            file.createSync(recursive: true);
            final originalContent =
                '''
line 0
line 1
line 2
$dropCase
line 3
line 4
line 5
''';
            const resultingContent = '''
line 0
line 1
line 2
''';
            file.writeAsStringSync(originalContent);
            expect(file.existsSync(), isTrue);
            expect(file.readAsStringSync(), originalContent);
            await file.parametrize(
              brickGenData: BrickGenData(
                referenceAbsolutePath: '',
                targetAbsolutePath: testDir.path,
                replacements: const [],
                lineDeletions: const [],
              ),
            );
            expect(file.existsSync(), isTrue);
            expect(file.readAsStringSync(), resultingContent);
          }
        });

        test('replaces replaceable blocks', () async {
          final testDir = tempDir.descendantDir('replaceable_blocks');
          addTearDown(() => testDir.deleteSync(recursive: true));
          final file = testDir.descendantFile('file.txt');
          expect(file.existsSync(), isFalse);
          file.createSync(recursive: true);
          const originalContent = '''
line0
line/*replace-start*/
asdf
asdf asdf
/*with i0*/
// 1
// line2
/*replace-end*/
line3
#replace-start#
asdf
asdf asdf
#with i1#
# line4
# line5
#replace-end#
line6
''';
          const resultingContent = '''
line0
line1
line2
line3
 line4
 line5
line6
''';
          file.writeAsStringSync(originalContent);
          expect(file.existsSync(), isTrue);
          expect(file.readAsStringSync(), originalContent);
          await file.parametrize(
            brickGenData: BrickGenData(
              referenceAbsolutePath: '',
              targetAbsolutePath: testDir.path,
              replacements: const [],
              lineDeletions: const [],
            ),
          );
          expect(file.existsSync(), isTrue);
          expect(file.readAsStringSync(), resultingContent);
        });

        test('applies insertion blocks', () async {
          final testDir = tempDir.descendantDir('insertable_blocks');
          addTearDown(() => testDir.deleteSync(recursive: true));
          final file = testDir.descendantFile('file.txt');
          expect(file.existsSync(), isFalse);
          file.createSync(recursive: true);
          const originalContent = '''
line0
line/*insert-start*/
// 1
// line2
/*insert-end*/
line3
#insert-start#
# line4
# line5
#insert-end#
line6
''';
          const resultingContent = '''
line0
line1
line2
line3
line4
line5
line6
''';
          file.writeAsStringSync(originalContent);
          expect(file.existsSync(), isTrue);
          expect(file.readAsStringSync(), originalContent);
          await file.parametrize(
            brickGenData: BrickGenData(
              referenceAbsolutePath: '',
              targetAbsolutePath: testDir.path,
              replacements: const [],
              lineDeletions: const [],
            ),
          );
          expect(file.existsSync(), isTrue);
          expect(file.readAsStringSync(), resultingContent);
        });

        test('resolves mustache tags', () async {
          final testDir = tempDir.descendantDir('mustache_tags');
          addTearDown(() => testDir.deleteSync(recursive: true));
          final file = testDir.descendantFile('file.txt');
          expect(file.existsSync(), isFalse);
          file.createSync(recursive: true);
          const originalContent = '''
text
/*x{{some-key}}*/
more text
#{{other-key}}x#
yet more text
and even
<!--x{{yet-another-key}}x-->
more text
''';
          const resultingContent = '''
text{{some-key}}
more text
{{other-key}}yet more text
and even{{yet-another-key}}more text
''';
          file.writeAsStringSync(originalContent);
          expect(file.existsSync(), isTrue);
          expect(file.readAsStringSync(), originalContent);
          await file.parametrize(
            brickGenData: BrickGenData(
              referenceAbsolutePath: '',
              targetAbsolutePath: testDir.path,
              replacements: const [],
              lineDeletions: const [],
            ),
          );
          expect(file.existsSync(), isTrue);
          expect(file.readAsStringSync(), resultingContent);
        });

        test('resolves spacing groups', () async {
          final testDir = tempDir.descendantDir('spacing_groups');
          addTearDown(() => testDir.deleteSync(recursive: true));
          final file = testDir.descendantFile('file.txt');
          expect(file.existsSync(), isFalse);
          file.createSync(recursive: true);
          const originalContent = '''
text
/*w 2v 4> w*/
more te#ww#xt
#w 4v 2> w#
yet more <!--w 5> w--> text
''';
          const resultingContent = '''
text

    more text



  yet more     text
''';
          file.writeAsStringSync(originalContent);
          expect(file.existsSync(), isTrue);
          expect(file.readAsStringSync(), originalContent);
          await file.parametrize(
            brickGenData: BrickGenData(
              referenceAbsolutePath: '',
              targetAbsolutePath: testDir.path,
              replacements: const [],
              lineDeletions: const [],
            ),
          );
          expect(file.existsSync(), isTrue);
          expect(file.readAsStringSync(), resultingContent);
        });

        test('extracts and creates partials', () async {
          final testDir = tempDir.descendantDir('partials');
          addTearDown(() => testDir.deleteSync(recursive: true));
          final file = testDir.descendantFile('file.txt');
          expect(file.existsSync(), isFalse);
          file.createSync(recursive: true);
          const originalContent = '''
text
/*partial v partialA*/
/*w w*/
this is
the partial
A
/*partial ^ partialA*/
more text
#partial v partialB#
#w w#
this is
the partial
B
#partial ^ partialB#
yet more text
<!--partial v partialC-->
<!--w w-->
this is
the partial
C
<!--partial ^ partialC-->
and even more text
''';
          const resultingContent = '''
text
{{~partialA.partial}}
more text
{{~partialB.partial}}
yet more text
{{~partialC.partial}}
and even more text
''';
          file.writeAsStringSync(originalContent);
          expect(file.existsSync(), isTrue);
          expect(file.readAsStringSync(), originalContent);
          await file.parametrize(
            brickGenData: BrickGenData(
              referenceAbsolutePath: '',
              targetAbsolutePath: testDir.path,
              replacements: const [],
              lineDeletions: const [],
            ),
          );
          expect(file.existsSync(), isTrue);
          expect(file.readAsStringSync(), resultingContent);
          const cases = ['A', 'B', 'C'];
          for (final partialName in cases) {
            final partialFile = testDir.descendantFile(
              'partial$partialName.partial',
            );
            final partialContent =
                '''
this is
the partial
$partialName
''';
            expect(partialFile.existsSync(), isTrue);
            expect(partialFile.readAsStringSync(), partialContent);
          }
        });
      });
    });
  });
}
