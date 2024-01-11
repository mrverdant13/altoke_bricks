import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tasks/tasks.dart';
import 'package:tasks_repository/tasks_repository.dart';

import '../../helpers/fallback_values.dart';

class MockTasksRepository extends Mock implements TasksRepository {}

void main() {
  setUpAll(registerFallbackValues);

  group(
    '''

GIVEN an injected tasks creator notifier
AND an injected tasks repository''',
    () {
      late TasksRepository tasksRepository;
      late ProviderContainer container;

      setUp(
        () {
          tasksRepository = MockTasksRepository();
          container = ProviderContainer(
            overrides: [
              tasksRepositoryPod.overrideWith(
                (ref) => tasksRepository,
              ),
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
AND the initial loaded state should be false (indicating that the new task was not created)

''',
        () async {
          await expectLater(
            container.read(taskCreatorPod.future),
            completion(isFalse),
          );
        },
      );

      test(
        '''

AND valid data for a new task
WHEN the notifier is called to create the new task
THEN the notifier should start the task creation process
├─ BY emitting a loading state
├─ AND calling the tasks repository to create the new task
THEN the notifier should finish the task creation process
├─ BY emitting a data state
|  ├─ THAT holds a true value (indicating that the new task was created)

''',
        () async {
          when(
            () => tasksRepository.createTask(
              newTask: any(
                named: 'newTask',
              ),
            ),
          ).thenAnswer(
            (_) async {},
          );
          final states = <AsyncValue<bool>>[];
          final subscription = container.listen(
            taskCreatorPod,
            (_, state) {
              states.add(state);
            },
            fireImmediately: true,
          );
          addTearDown(subscription.close);
          await container.read(taskCreatorPod.future);
          const newTask = NewTask(title: 'title');
          await container
              .read(taskCreatorPod.notifier)
              .create(newTask: newTask);
          verify(
            () => tasksRepository.createTask(
              newTask: newTask,
            ),
          ).called(1);
          expect(
            states.skip(2), // skips build states
            orderedEquals([
              isA<AsyncLoading<bool>>(),
              const AsyncData(true),
            ]),
          );
        },
      );
    },
  );
}
