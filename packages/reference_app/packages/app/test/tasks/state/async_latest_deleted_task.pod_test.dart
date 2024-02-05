import 'dart:async';

import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tasks/tasks.dart';
import 'package:tasks_repository/tasks_repository.dart';

import '../../helpers/fallback_values.dart';
import '../../helpers/mocks/mock_tasks_repository.dart';

void main() {
  setUpAll(registerFallbackValues);

  group(
    '''

GIVEN an injected latest deleted task notifier
AND an injected tasks repository''',
    () {
      late TasksRepository tasksRepository;
      late ProviderContainer container;

      setUp(
        () {
          tasksRepository = MockTasksRepository();
          container = ProviderContainer(
            overrides: [
              tasksRepositoryPod.overrideWithValue(tasksRepository),
            ],
          );
        },
      );

      tearDown(
        () {
          verifyNoMoreInteractions(tasksRepository);
          container.dispose();
        },
      );

      test(
        '''

WHEN the notifier is built
THEN the notifier should be initialized
AND the notifier should start watching the latest deleted task
├─ BY emitting the loading state
├─ AND using the tasks repository to watch the latest deleted task
THEN the notifier should continuously emit the latest deleted task
├─ BY emitting a data state
|  ├─ THAT holds the latest deleted task emitted by the repository

''',
        () async {
          final fakeDeletedTasks = [
            Task(
              id: 123,
              title: 'this is a task',
              isCompleted: false,
              createdAt: DateTime(2020, 1, 13),
            ),
            null,
            Task(
              id: 456,
              title: 'another one',
              isCompleted: true,
              createdAt: DateTime(2010, 11, 3),
            ),
          ];
          when(
            () => tasksRepository.watchLatestDeletedTask(),
          ).thenAnswer(
            (_) => Stream.fromIterable(fakeDeletedTasks),
          );
          final testCompleter = Completer<void>();
          final states = <AsyncValue<Task?>>[];
          final subscription = container.listen(
            latestDeletedTaskPod,
            (_, state) {
              states.add(state);
              if (states.length == fakeDeletedTasks.length + 1) {
                testCompleter.complete();
              }
            },
            fireImmediately: true,
          );
          addTearDown(subscription.close);
          await testCompleter.future;
          verify(
            () => tasksRepository.watchLatestDeletedTask(),
          ).called(1);
          expect(
            states,
            orderedEquals([
              isA<AsyncLoading<Task?>>(),
              for (final fakeDeletedTask in fakeDeletedTasks)
                AsyncData<Task?>(fakeDeletedTask),
            ]),
          );
        },
      );

      test(
        '''

WHEN the latest deleted task is requested to be restored
THEN the latest deleted task should be restored
├─ BY using the tasks repository to restore the latest deleted task

''',
        () async {
          when(
            () => tasksRepository.restoreLatestDeletedTask(),
          ).thenAnswer(
            (_) async {},
          );
          await container.read(latestDeletedTaskPod.notifier).restore();
          verifyInOrder([
            // part of the notifier initialization
            () => tasksRepository.watchLatestDeletedTask(),

            () => tasksRepository.restoreLatestDeletedTask(),
          ]);
        },
      );
    },
  );
}
