import 'dart:async';

import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tasks/tasks.dart';

import '../../helpers/fallback_values.dart';
import '../../helpers/mocks/mock_tasks_repository.dart';

void main() {
  test(
    '''
GIVEN an async paginated tasks notifier
AND an injected tasks repository
AND an injected selected tasks status filter
AND an injected task search term
AND an offset
AND a limit
WHEN the notifier is built
THEN the notifier should start watching the paginated tasks
├─ BY emitting the loading state
├─ AND using the tasks repository to watch the paginated tasks
THEN the notifier should continuously emit the paginated tasks
├─ BY emitting a data state
|  ├─ THAT holds the tasks emitted by the repository
''',
    () async {
      registerFallbackValues();
      final tasksRepository = MockTasksRepository();
      final container = ProviderContainer(
        overrides: [
          tasksRepositoryPod.overrideWithValue(tasksRepository),
        ],
      );
      const tasksStatusFilter = TasksStatusFilter.uncompleted;
      const searchTerm = 'search term';
      container.read(selectedTasksStatusFilterPod.notifier).state =
          tasksStatusFilter;
      container.read(taskSearchTermPod.notifier).state = searchTerm;
      const offset = 13;
      const limit = 42;
      addTearDown(container.dispose);
      final fakePaginatedTaskGroups = <List<Task>>[
        [
          Task(
            id: 123,
            title: 'this is a task',
            isCompleted: false,
            createdAt: DateTime(2020, 1, 13),
          ),
          Task(
            id: 456,
            title: 'another one',
            isCompleted: true,
            createdAt: DateTime(2010, 11, 3),
          ),
        ],
        [
          Task(
            id: 789,
            title: 'a third task',
            isCompleted: false,
            createdAt: DateTime(2019, 2, 23),
          ),
        ],
        [],
        [
          Task(
            id: 1011,
            title: 'a fourth task',
            isCompleted: true,
            createdAt: DateTime(2018, 3, 3),
          ),
          Task(
            id: 1213,
            title: 'a fifth task',
            isCompleted: false,
            createdAt: DateTime(2017, 4, 13),
          ),
          Task(
            id: 1415,
            title: 'a sixth task',
            isCompleted: true,
            createdAt: DateTime(2016, 5, 23),
          ),
        ],
      ];
      when(
        () => tasksRepository.watchPaginatedTasks(
          statusFilter: any(named: 'statusFilter'),
          searchTerm: any(named: 'searchTerm'),
          offset: any(named: 'offset'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer(
        (_) => Stream.fromIterable(fakePaginatedTaskGroups),
      );
      final testCompleter = Completer<void>();
      final states = <AsyncValue<List<Task>>>[];
      final subscription = container.listen(
        asyncPaginatedFilteredTasksPod(limit: limit, offset: offset),
        (_, state) {
          states.add(state);
          if (states.length == fakePaginatedTaskGroups.length + 1) {
            testCompleter.complete();
          }
        },
        fireImmediately: true,
      );
      addTearDown(subscription.close);
      await testCompleter.future;
      verify(
        () => tasksRepository.watchPaginatedTasks(
          statusFilter: tasksStatusFilter,
          searchTerm: searchTerm,
          offset: offset,
          limit: limit,
        ),
      ).called(1);
      expect(
        states,
        orderedEquals([
          const AsyncValue<List<Task>>.loading(),
          for (final paginatedTasks in fakePaginatedTaskGroups)
            AsyncValue<List<Task>>.data(paginatedTasks),
        ]),
      );
    },
  );
}
