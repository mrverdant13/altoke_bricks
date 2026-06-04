import 'package:brick_generator/src/annotation_issue.dart';
import 'package:test/test.dart';

void main() {
  group('AnnotationIssue', () {
    test('formats location without column', () {
      const issue = AnnotationIssue(
        filePath: 'lib/example.dart',
        line: 4,
        message: 'Unmatched remove-start',
      );
      expect(issue.toString(), 'lib/example.dart:4: Unmatched remove-start');
    });

    test('formats location with column', () {
      const issue = AnnotationIssue(
        filePath: 'lib/example.dart',
        line: 4,
        column: 9,
        message: 'Unexpected with marker',
      );
      expect(
        issue.toString(),
        'lib/example.dart:4:9: Unexpected with marker',
      );
    });
  });
}
