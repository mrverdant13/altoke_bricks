import 'dart:io';

import 'package:brick_generator/src/annotation_validator.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  group('AnnotationValidator', () {
    final validator = AnnotationValidator();

    group('validateContent', () {
      test('reports no issues for well-formed annotations', () {
        const content = '''
line0
/*remove-start*/
code
/*remove-end*/
/*replace-start*/
old
/*with*/
// new
/*replace-end*/
/*insert-start*/
// inserted
/*insert-end*/
/*partial v foo*/payload/*partial ^ foo*/
''';
        expect(validator.validateContent(content), isEmpty);
      });

      test('detects unmatched remove-start', () {
        const content = '/*remove-start*/\ncode\n';
        final issues = validator.validateContent(content);
        expect(issues, hasLength(1));
        expect(issues.single.line, 1);
        expect(
          issues.single.message,
          contains('Unmatched remove-start'),
        );
      });

      test('detects unmatched remove-end', () {
        const content = 'code\n/*remove-end*/\n';
        final issues = validator.validateContent(content);
        expect(issues, hasLength(1));
        expect(issues.single.line, 2);
        expect(
          issues.single.message,
          contains('Unmatched remove-end'),
        );
      });

      test('validates nested remove blocks', () {
        const content = '''
/*remove-start*/
  /*remove-start*/
  /*remove-end*/
/*remove-end*/
''';
        expect(validator.validateContent(content), isEmpty);
      });

      test('detects unmatched insert-start', () {
        const content = '#insert-start#\n';
        final issues = validator.validateContent(content);
        expect(issues, hasLength(1));
        expect(
          issues.single.message,
          contains('Unmatched insert-start'),
        );
      });

      test('detects replace-end without with', () {
        const content = '''
/*replace-start*/
old
/*replace-end*/
''';
        final issues = validator.validateContent(content);
        expect(issues, isNotEmpty);
        expect(
          issues.map((i) => i.message),
          anyElement(contains('without a matching with')),
        );
      });

      test('detects unmatched replace-start', () {
        const content = '/*replace-start*/\nold\n';
        final issues = validator.validateContent(content);
        expect(issues, isNotEmpty);
        expect(
          issues.map((i) => i.message),
          anyElement(contains('Unmatched replace-start')),
        );
      });

      test('accepts replace blocks with with marker', () {
        const content = '''
#replace-start#
old
#with i1#
# new
#replace-end#
''';
        expect(validator.validateContent(content), isEmpty);
      });

      test('detects duplicate with marker in replace block', () {
        const content = '''
/*replace-start*/
old
/*with*/
/*with*/
new
/*replace-end*/
''';
        final issues = validator.validateContent(content);
        expect(issues, isNotEmpty);
        expect(
          issues.map((i) => i.message),
          anyElement(contains('Duplicate with marker')),
        );
      });

      test('detects partial name mismatch', () {
        const content =
            '/*partial v foo*/payload/*partial ^ bar*/';
        final issues = validator.validateContent(content);
        expect(issues, hasLength(1));
        expect(
          issues.single.message,
          contains('does not match'),
        );
      });

      test('detects unmatched partial v', () {
        const content = '/*partial v foo*/payload';
        final issues = validator.validateContent(content);
        expect(issues, hasLength(1));
        expect(
          issues.single.message,
          contains('Unmatched partial v'),
        );
      });

      test('validates each comment flavor independently', () {
        const content = '''
/*remove-start*/
#remove-end#
''';
        final issues = validator.validateContent(content);
        expect(issues.length, greaterThanOrEqualTo(2));
      });
    });

    group('validateDirectory', () {
      late Directory tempDir;

      setUp(() {
        tempDir = Directory.systemTemp.createTempSync(
          'annotation_validator_',
        );
      });

      tearDown(() {
        if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
      });

      test('walks reference files and attaches paths', () {
        final validFile = File(p.join(tempDir.path, 'valid.dart'));
        validFile.createSync(recursive: true);
        validFile.writeAsStringSync('/*remove-start*/\n/*remove-end*/\n');

        final invalidFile = File(p.join(tempDir.path, 'invalid.dart'));
        invalidFile.createSync(recursive: true);
        invalidFile.writeAsStringSync('/*remove-start*/\n');

        final issues = validator.validateDirectory(tempDir);
        expect(issues, hasLength(1));
        expect(issues.single.filePath, 'invalid.dart');
      });

      test('skips binary extensions', () {
        final image = File(p.join(tempDir.path, 'icon.png'));
        image.createSync(recursive: true);
        image.writeAsBytesSync([0, 1, 2]);

        expect(validator.validateDirectory(tempDir), isEmpty);
      });

      test('skips non-UTF-8 files', () {
        final binary = File(p.join(tempDir.path, 'notes.txt'));
        binary.createSync(recursive: true);
        binary.writeAsBytesSync([0xFF, 0xFE, 0x00]);

        expect(validator.validateDirectory(tempDir), isEmpty);
      });
    });
  });
}
