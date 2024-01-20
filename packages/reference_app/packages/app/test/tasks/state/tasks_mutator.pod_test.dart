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

GIVEN an injected tasks mutator notifier
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
AND the initial state should be idle
''',
        () async {
          expect(
            container.read(tasksMutatorPod),
            const TasksMutationIdle(),
          );
        },
      );

      test(
        '''

AND a task ID
AND a partial task
WHEN the notifier is called to update the task
THEN the notifier should start the task update process
├─ BY emitting a loading state
├─ AND calling the tasks repository to update the task
THEN the notifier should finish the task update process
├─ BY emitting an idle state
''',
        () async {
          when(
            () => tasksRepository.updateTask(
              taskId: any(named: 'taskId'),
              partialTask: any(named: 'partialTask'),
            ),
          ).thenAnswer(
            (_) async {},
          );
          final states = <TasksMutationState>[];
          final subscription = container.listen(
            tasksMutatorPod,
            (_, state) {
              states.add(state);
            },
            fireImmediately: true,
          );
          addTearDown(subscription.close);
          const taskId = 753;
          const partialTask = PartialTask();
          await container
              .read(tasksMutatorPod.notifier)
              .updateTask(taskId: taskId, partialTask: partialTask);
          verify(
            () => tasksRepository.updateTask(
              taskId: taskId,
              partialTask: partialTask,
            ),
          ).called(1);
          expect(
            states,
            orderedEquals([
              const TasksMutationIdle(),
              const TasksUpdatingTask(),
              const TasksMutationIdle(),
            ]),
          );
        },
      );

      test(
        '''

AND a task ID
AND a partial task
WHEN the notifier is called to update the task
THEN the notifier should start the task update process
├─ BY emitting a loading state
├─ AND calling the tasks repository to update the task
THEN the notifier should handle any issue during the task update process
├─ BY emitting a failure state
''',
        () async {
          when(
            () => tasksRepository.updateTask(
              taskId: any(named: 'taskId'),
              partialTask: any(named: 'partialTask'),
            ),
          ).thenThrow(
            Exception(),
          );
          final states = <TasksMutationState>[];
          final subscription = container.listen(
            tasksMutatorPod,
            (_, state) {
              states.add(state);
            },
            fireImmediately: true,
          );
          addTearDown(subscription.close);
          const taskId = 753;
          const partialTask = PartialTask();
          await container
              .read(tasksMutatorPod.notifier)
              .updateTask(taskId: taskId, partialTask: partialTask);
          verify(
            () => tasksRepository.updateTask(
              taskId: taskId,
              partialTask: partialTask,
            ),
          ).called(1);
          expect(
            states,
            orderedEquals([
              const TasksMutationIdle(),
              const TasksUpdatingTask(),
              isA<TasksMutationFailure>(),
            ]),
          );
        },
      );

      test(
        '''

AND a task ID
WHEN the notifier is called to delete the task
THEN the notifier should start the task deletion process
├─ BY emitting a loading state
├─ AND calling the tasks repository to delete the task
THEN the notifier should finish the task deletion process
├─ BY emitting an idle state
''',
        () async {
          when(
            () => tasksRepository.deleteTask(
              taskId: any(named: 'taskId'),
            ),
          ).thenAnswer(
            (_) async {},
          );
          final states = <TasksMutationState>[];
          final subscription = container.listen(
            tasksMutatorPod,
            (_, state) {
              states.add(state);
            },
            fireImmediately: true,
          );
          addTearDown(subscription.close);
          const taskId = 753;
          await container
              .read(tasksMutatorPod.notifier)
              .deleteTask(taskId: taskId);
          verify(
            () => tasksRepository.deleteTask(
              taskId: taskId,
            ),
          ).called(1);
          expect(
            states,
            orderedEquals([
              const TasksMutationIdle(),
              const TasksDeletingTask(),
              const TasksMutationIdle(),
            ]),
          );
        },
      );

      test(
        '''

AND a task ID
WHEN the notifier is called to delete the task
THEN the notifier should start the task deletion process
├─ BY emitting a loading state
├─ AND calling the tasks repository to delete the task
THEN the notifier should handle any issue during the task deletion process
├─ BY emitting a failure state
''',
        () async {
          when(
            () => tasksRepository.deleteTask(
              taskId: any(named: 'taskId'),
            ),
          ).thenThrow(
            Exception(),
          );
          final states = <TasksMutationState>[];
          final subscription = container.listen(
            tasksMutatorPod,
            (_, state) {
              states.add(state);
            },
            fireImmediately: true,
          );
          addTearDown(subscription.close);
          const taskId = 753;
          await container
              .read(tasksMutatorPod.notifier)
              .deleteTask(taskId: taskId);
          verify(
            () => tasksRepository.deleteTask(
              taskId: taskId,
            ),
          ).called(1);
          expect(
            states,
            orderedEquals([
              const TasksMutationIdle(),
              const TasksDeletingTask(),
              isA<TasksMutationFailure>(),
            ]),
          );
        },
      );

      test(
        '''

WHEN the notifier is called to mark all tasks as completed
THEN the notifier should start the all-tasks completion process
├─ BY emitting a loading state
├─ AND calling the tasks repository to mark all tasks as completed
THEN the notifier should finish the all-tasks completion process
├─ BY emitting an idle state
''',
        () async {
          when(
            () => tasksRepository.markAllTasksAsCompleted(),
          ).thenAnswer(
            (_) async {},
          );
          final states = <TasksMutationState>[];
          final subscription = container.listen(
            tasksMutatorPod,
            (_, state) {
              states.add(state);
            },
            fireImmediately: true,
          );
          addTearDown(subscription.close);
          await container.read(tasksMutatorPod.notifier).markAllAsCompleted();
          verify(
            () => tasksRepository.markAllTasksAsCompleted(),
          ).called(1);
          expect(
            states,
            orderedEquals([
              const TasksMutationIdle(),
              const TasksMarkingAllAsCompleted(),
              const TasksMutationIdle(),
            ]),
          );
        },
      );

      test(
        '''

WHEN the notifier is called to mark all tasks as completed
THEN the notifier should start the all-tasks completion process
├─ BY emitting a loading state
├─ AND calling the tasks repository to mark all tasks as completed
THEN the notifier should handle any issue during the all-tasks completion process
├─ BY emitting a failure state
''',
        () async {
          when(
            () => tasksRepository.markAllTasksAsCompleted(),
          ).thenThrow(
            Exception(),
          );
          final states = <TasksMutationState>[];
          final subscription = container.listen(
            tasksMutatorPod,
            (_, state) {
              states.add(state);
            },
            fireImmediately: true,
          );
          addTearDown(subscription.close);
          await container.read(tasksMutatorPod.notifier).markAllAsCompleted();
          verify(
            () => tasksRepository.markAllTasksAsCompleted(),
          ).called(1);
          expect(
            states,
            orderedEquals([
              const TasksMutationIdle(),
              const TasksMarkingAllAsCompleted(),
              isA<TasksMutationFailure>(),
            ]),
          );
        },
      );

      test(
        '''

WHEN the notifier is called to delete all completed tasks
THEN the notifier should start the all-completed-tasks deletion process
├─ BY emitting a loading state
├─ AND calling the tasks repository to delete all completed tasks
THEN the notifier should finish the all-completed-tasks deletion process
├─ BY emitting an idle state
''',
        () async {
          when(
            () => tasksRepository.deleteAllTasks(
              referenceTask: any(named: 'referenceTask'),
            ),
          ).thenAnswer(
            (_) async {},
          );
          final states = <TasksMutationState>[];
          final subscription = container.listen(
            tasksMutatorPod,
            (_, state) {
              states.add(state);
            },
            fireImmediately: true,
          );
          addTearDown(subscription.close);
          await container
              .read(tasksMutatorPod.notifier)
              .deleteAllCompletedTasks();
          verify(
            () => tasksRepository.deleteAllTasks(
              referenceTask: any(
                named: 'referenceTask',
                that: isA<PartialTask>().having(
                  (task) => task.isCompleted?.call(),
                  'isCompleted',
                  isTrue,
                ),
              ),
            ),
          ).called(1);
          expect(
            states,
            orderedEquals([
              const TasksMutationIdle(),
              const TasksDeletingAllCompleted(),
              const TasksMutationIdle(),
            ]),
          );
        },
      );

      test(
        '''

WHEN the notifier is called to delete all completed tasks
THEN the notifier should start the all-completed-tasks deletion process
├─ BY emitting a loading state
├─ AND calling the tasks repository to delete all completed tasks
THEN the notifier should handle any issue during the all-completed-tasks deletion process
├─ BY emitting a failure state
''',
        () async {
          when(
            () => tasksRepository.deleteAllTasks(
              referenceTask: any(named: 'referenceTask'),
            ),
          ).thenThrow(
            Exception(),
          );
          final states = <TasksMutationState>[];
          final subscription = container.listen(
            tasksMutatorPod,
            (_, state) {
              states.add(state);
            },
            fireImmediately: true,
          );
          addTearDown(subscription.close);
          await container
              .read(tasksMutatorPod.notifier)
              .deleteAllCompletedTasks();
          verify(
            () => tasksRepository.deleteAllTasks(
              referenceTask: any(
                named: 'referenceTask',
                that: isA<PartialTask>().having(
                  (task) => task.isCompleted?.call(),
                  'isCompleted',
                  isTrue,
                ),
              ),
            ),
          ).called(1);
          expect(
            states,
            orderedEquals([
              const TasksMutationIdle(),
              const TasksDeletingAllCompleted(),
              isA<TasksMutationFailure>(),
            ]),
          );
        },
      );
    },
  );
}
