import 'dart:async';

import 'package:{{project_name.snakeCase()}}/tasks/tasks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tasks/tasks.dart';

import '../../helpers/fallback_values.dart';
import '../../helpers/mocks/mock_tasks_repository.dart';

void main() {
  test(
    '''
GIVEN an async tasks count notifier
AND an injected tasks repository
AND an injected selected tasks status filter
AND an injected task search term
WHEN the notifier is built
THEN the notifier should start watching the tasks count
├─ BY emitting the loading state
├─ AND using the tasks repository to watch the tasks count
THEN the notifier should continuously emit the tasks count
├─ BY emitting a data state
|  ├─ THAT holds the tasks count emitted by the repository
''',
    () async {
      registerFallbackValues();
      final tasksRepository = MockTasksRepository();
      final container = ProviderContainer(
        overrides: [
          tasksRepositoryPod.overrideWithValue(tasksRepository),
        ],
      );
      const tasksStatusFilter = TasksStatusFilter.completed;
      const searchTerm = 'search term';
      container.read(selectedTasksStatusFilterPod.notifier).state =
          tasksStatusFilter;
      container.read(taskSearchTermPod.notifier).state = searchTerm;
      addTearDown(container.dispose);
      const fakeCounts = [
        123,
        4378,
        233,
      ];
      when(
        () => tasksRepository.watchCount(
          statusFilter: any(named: 'statusFilter'),
          searchTerm: any(named: 'searchTerm'),
        ),
      ).thenAnswer(
        (_) => Stream.fromIterable(fakeCounts),
      );
      final testCompleter = Completer<void>();
      final states = <AsyncValue<int>>[];
      final subscription = container.listen(
        asyncFilteredTasksCountPod,
        (_, state) {
          states.add(state);
          if (states.length == fakeCounts.length + 1) {
            testCompleter.complete();
          }
        },
        fireImmediately: true,
      );
      addTearDown(subscription.close);
      await testCompleter.future;
      verify(
        () => tasksRepository.watchCount(
          statusFilter: tasksStatusFilter,
          searchTerm: searchTerm,
        ),
      ).called(1);
      expect(
        states,
        orderedEquals([
          const AsyncValue<int>.loading(),
          for (final count in fakeCounts) AsyncValue<int>.data(count),
        ]),
      );
    },
  );
}
