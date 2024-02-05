import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tasks/tasks.dart';

void main() {
  group(
    '''

GIVEN a tasks status filter notifier''',
    () {
      late ProviderContainer container;

      setUp(
        () {
          container = ProviderContainer();
        },
      );

      tearDown(
        () {
          container.dispose();
        },
      );

      test(
        '''

WHEN the notifier is built
THEN the notifier should be initialized
AND the initial filter should be the one that accepts all tasks

''',
        () {
          final initialFilter = container.read(selectedTasksStatusFilterPod);
          expect(initialFilter, TasksStatusFilter.all);
        },
      );

      test(
        '''

AND a new tasks status filter
WHEN the new filter is set
THEN the new filter should be set

''',
        () {
          const newFilter = TasksStatusFilter.completed;
          container.read(selectedTasksStatusFilterPod.notifier).filter =
              newFilter;
          expect(container.read(selectedTasksStatusFilterPod), newFilter);
        },
      );
    },
  );
}
