import 'package:{{project_name.snakeCase()}}/tasks/tasks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tasks_repository/tasks_repository.dart';

import '../../helpers/helpers.dart';

void main() {
  test(
    '''

GIVEN an injected tasks repository pod
AND an injected cache for the latest deleted task
AND an injected tasks storage
WHEN the pod is read
THEN the pod should return the repository
''',
    () async {
      final container = ProviderContainer(
        overrides: [
          latestDeletedTaskCachePod.overrideWithValue(
            FakeLatestDeletedTaskCache(),
          ),
          tasksStoragePod.overrideWithValue(
            FakeTasksStorage(),
          ),
        ],
      );
      addTearDown(container.dispose);
      final repository = container.read(tasksRepositoryPod);
      expect(
        repository,
        isA<TasksRepository>(),
      );
    },
  );
}
