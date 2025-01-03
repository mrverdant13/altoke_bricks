import 'package:brick_generator/src/_internal/regex_hook.dart';
import 'package:test/test.dart';

void main() {
  group('RegexHook', () {
    test('can be instantiated', () {
      // Using non-const constructor to test instantiation
      // ignore: prefer_const_constructors
      final regexHook = RegexHook();
      expect(regexHook, isA<RegexHook>());
    });

    group('beforeDecode', () {
      test('for RegExp input', () {
        final input = RegExp('.*');
        final result = regexHook.beforeDecode(input);
        expect(result, input);
      });

      test('for String input', () {
        const input = '.*';
        final result = regexHook.beforeDecode(input);
        expect(
          result,
          isA<RegExp>().having(
            (r) => r.pattern,
            'pattern',
            input,
          ),
        );
      });

      test('for unknown input', () {
        const input = 1;
        final result = regexHook.beforeDecode(input);
        expect(
          result,
          isA<RegExp>().having(
            (r) => r.pattern,
            'pattern',
            input.toString(),
          ),
        );
      });
    });
  });
}
