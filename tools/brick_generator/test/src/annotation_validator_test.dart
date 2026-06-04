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

      test('detects unexpected with marker before replace-start', () {
        const content = '''
/*with*/
/*replace-start*/
old
/*replace-end*/
''';
        final issues = validator.validateContent(content);
        expect(issues, isNotEmpty);
        expect(
          issues.map((i) => i.message),
          anyElement(contains('Unexpected with before replace-start')),
        );
      });

      test('detects nested replace-start markers', () {
        const content = '''
/*replace-start*/
/*replace-start*/
/*with*/
// new
/*replace-end*/
''';
        final issues = validator.validateContent(content);
        expect(issues, isNotEmpty);
        expect(
          issues.map((i) => i.message),
          anyElement(contains('Nested replace-start is not supported')),
        );
      });

      test('detects unexpected replace-end after a completed block', () {
        const content = '''
/*replace-start*/
/*with*/
// new
/*replace-end*/
/*replace-end*/
''';
        final issues = validator.validateContent(content);
        expect(issues, isNotEmpty);
        expect(
          issues.map((i) => i.message),
          anyElement(contains('Unexpected replace-end before replace-start')),
        );
      });

      test('detects replace-start before closing the previous block', () {
        const content = '''
/*replace-start*/
/*with*/
// new
/*replace-start*/
/*with*/
// newer
/*replace-end*/
''';
        final issues = validator.validateContent(content);
        expect(issues, isNotEmpty);
        expect(
          issues.map((i) => i.message),
          anyElement(
            contains('replace-start block is missing replace-end'),
          ),
        );
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
        const content = '/*partial v foo*/payload/*partial ^ bar*/';
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

      test('detects unmatched partial ^ marker', () {
        const content = '<!--partial ^ footer-->';
        final issues = validator.validateContent(content);
        expect(issues, hasLength(1));
        expect(
          issues.single.message,
          contains('Unmatched partial ^ marker'),
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

    group('validateFile', () {
      late Directory tempDir;

      setUp(() {
        tempDir = Directory.systemTemp.createTempSync(
          'annotation_validator_file_',
        );
      });

      tearDown(() {
        if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
      });

      test('returns issues with the provided display path', () {
        final file = File(p.join(tempDir.path, 'broken.dart'))
          ..createSync(recursive: true)
          ..writeAsStringSync('/*remove-start*/\n');

        final issues = validator.validateFile(file, displayPath: 'broken.dart');
        expect(issues, hasLength(1));
        expect(issues.single.filePath, 'broken.dart');
      });

      test('skips ignored files', () {
        final file = File(p.join(tempDir.path, 'icon.png'))
          ..createSync(recursive: true)
          ..writeAsBytesSync([0, 1, 2]);

        expect(validator.validateFile(file), isEmpty);
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

      test('throws when the reference directory does not exist', () {
        expect(
          () => validator.validateDirectory(
            Directory(p.join(tempDir.path, 'missing')),
          ),
          throwsArgumentError,
        );
      });

      test('walks reference files and attaches paths', () {
        File(p.join(tempDir.path, 'valid.dart'))
          ..createSync(recursive: true)
          ..writeAsStringSync('/*remove-start*/\n/*remove-end*/\n');

        File(p.join(tempDir.path, 'invalid.dart'))
          ..createSync(recursive: true)
          ..writeAsStringSync('/*remove-start*/\n');

        final issues = validator.validateDirectory(tempDir);
        expect(issues, hasLength(1));
        expect(issues.single.filePath, 'invalid.dart');
      });

      test('skips binary extensions', () {
        File(p.join(tempDir.path, 'icon.png'))
          ..createSync(recursive: true)
          ..writeAsBytesSync([0, 1, 2]);

        expect(validator.validateDirectory(tempDir), isEmpty);
      });

      test('skips non-UTF-8 files', () {
        File(p.join(tempDir.path, 'notes.txt'))
          ..createSync(recursive: true)
          ..writeAsBytesSync([0xFF, 0xFE, 0x00]);

        expect(validator.validateDirectory(tempDir), isEmpty);
      });
    });
  });
}
