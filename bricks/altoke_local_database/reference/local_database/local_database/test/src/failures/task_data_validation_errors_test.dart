import 'package:local_database/local_database.dart';
import 'package:test/test.dart';

void main() {
  group('$TaskTitleValidationError', () {
    final cases = <({String name, String description})>[
      (name: 'empty', description: 'an empty task title'),
    ];

    test('has a value for each case', () {
      expect(TaskTitleValidationError.values, hasLength(cases.length));
    });

    for (final value in cases) {
      test('exposes an error for ${value.description}', () {
        expect(
          TaskTitleValidationError.values,
          contains(isA<Enum>().having((e) => e.name, 'name', value.name)),
        );
      });
    }
  });

  group('$TaskComplexValidationError', () {
    final cases = <({String name, String description})>[
      (
        name: 'highPriorityWithNoDescription',
        description: 'a high priority task with no description',
      ),
    ];

    test('has a value for each case', () {
      expect(TaskComplexValidationError.values, hasLength(cases.length));
    });

    for (final value in cases) {
      test('exposes an error for ${value.description}', () {
        expect(
          TaskComplexValidationError.values,
          contains(isA<Enum>().having((e) => e.name, 'name', value.name)),
        );
      });
    }
  });
}
