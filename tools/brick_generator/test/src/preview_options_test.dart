import 'package:brick_generator/src/preview_options.dart';
import 'package:test/test.dart';

void main() {
  group('PreviewVars', () {
    test('parses booleans, numbers, and strings', () {
      expect(
        PreviewVars.parse(
          'requirements_met=true,use_drift=false,count=3,name=app',
        ),
        {
          'requirements_met': true,
          'use_drift': false,
          'count': 3,
          'name': 'app',
        },
      );
    });

    test('returns empty map for null input', () {
      expect(PreviewVars.parse(null), isEmpty);
    });

    test('throws for invalid pairs', () {
      expect(() => PreviewVars.parse('not-a-pair'), throwsArgumentError);
    });
  });

  group('PreviewOptions.fromArgs', () {
    test('requires --file and --brick', () {
      expect(
        () => PreviewOptions.fromArgs(['--file', 'a.txt']),
        throwsArgumentError,
      );
    });
  });
}
