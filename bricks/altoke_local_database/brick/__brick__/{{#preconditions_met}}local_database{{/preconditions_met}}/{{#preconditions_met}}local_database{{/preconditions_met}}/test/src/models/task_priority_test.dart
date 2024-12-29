import 'package:{{#preconditions_met}}local_database{{/preconditions_met}}/{{#preconditions_met}}local_database{{/preconditions_met}}.dart';
import 'package:test/test.dart';

void main() {
  group('$TaskPriority', () {
    final cases = <({String name, String description})>[
      (
        name: 'low',
        description: 'a low priority task',
      ),
      (
        name: 'medium',
        description: 'a medium priority task',
      ),
      (
        name: 'high',
        description: 'a high priority task',
      ),
    ];

    test(
      'has a value for each case',
      () {
        expect(TaskPriority.values, hasLength(cases.length));
      },
    );

    for (final value in cases) {
      test(
        'exposes a priority for ${value.description}',
        () {
          expect(
            TaskPriority.values,
            contains(
              isA<Enum>().having(
                (e) => e.name,
                'name',
                value.name,
              ),
            ),
          );
        },
      );
    }
  });
}
