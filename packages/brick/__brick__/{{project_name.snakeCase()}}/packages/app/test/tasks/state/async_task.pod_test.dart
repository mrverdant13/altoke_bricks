import 'package:{{project_name.snakeCase()}}/tasks/tasks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tasks/tasks.dart';
import 'package:tasks_repository/tasks_repository.dart';

import '../../helpers/mocks/mock_tasks_repository.dart';

void main() {
  group(
    '''

GIVEN an injected tasks creator notifier
AND an injected tasks repository
AND an injected scoped task ID''',
    () {
      late int taskId;
      late TasksRepository tasksRepository;
      late ProviderContainer container;

      setUp(
        () {
          taskId = 743;
          tasksRepository = MockTasksRepository();
          container = ProviderContainer(
            overrides: [
              tasksRepositoryPod.overrideWithValue(tasksRepository),
              scopedTaskIdPod.overrideWithValue(taskId),
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
AND the initial loaded state should be the task returned by the repository

''',
        () async {
          final task = Task(
            id: taskId,
            title: 'title',
            description: 'description',
            isCompleted: false,
            createdAt: DateTime(2020),
          );
          when(
            () => tasksRepository.getTaskById(
              any(),
            ),
          ).thenAnswer(
            (_) async => task,
          );
          await expectLater(
            container.read(asyncTaskPod.future),
            completion(task),
          );
          verify(
            () => tasksRepository.getTaskById(taskId),
          ).called(1);
        },
      );
    },
  );
}
