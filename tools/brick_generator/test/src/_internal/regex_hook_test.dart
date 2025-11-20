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

      group('for Map<String, dynamic> input', () {
        test('uses inherited defaults for missing keys in the input', () {
          final reference = RegExp('.*');
          const input = {
            'pattern': '.*',
          };
          final result = regexHook.beforeDecode(input);
          expect(
            result,
            isA<RegExp>()
                .having(
                  (r) => r.pattern,
                  'pattern',
                  input['pattern'],
                )
                .having(
                  (r) => r.isDotAll,
                  'dotAll',
                  reference.isDotAll,
                )
                .having(
                  (r) => r.isMultiLine,
                  'multiLine',
                  reference.isMultiLine,
                )
                .having(
                  (r) => r.isUnicode,
                  'unicode',
                  reference.isUnicode,
                )
                .having(
                  (r) => r.isCaseSensitive,
                  'caseSensitive',
                  reference.isCaseSensitive,
                ),
          );
        });

        test('uses values provided in the input', () {
          final reference = RegExp('.*');
          final input = {
            'pattern': '.*',
            'dotAll': !reference.isDotAll,
            'multiLine': !reference.isMultiLine,
            'unicode': !reference.isUnicode,
            'caseSensitive': !reference.isCaseSensitive,
          };
          final result = regexHook.beforeDecode(input);
          expect(
            result,
            isA<RegExp>()
                .having(
                  (r) => r.pattern,
                  'pattern',
                  input['pattern'],
                )
                .having(
                  (r) => r.isDotAll,
                  'dotAll',
                  input['dotAll'],
                )
                .having(
                  (r) => r.isMultiLine,
                  'multiLine',
                  input['multiLine'],
                )
                .having(
                  (r) => r.isUnicode,
                  'unicode',
                  input['unicode'],
                )
                .having(
                  (r) => r.isCaseSensitive,
                  'caseSensitive',
                  input['caseSensitive'],
                ),
          );
        });
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
