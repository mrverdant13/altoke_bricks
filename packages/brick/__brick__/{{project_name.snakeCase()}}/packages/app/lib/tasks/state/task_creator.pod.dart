import 'package:{{project_name.snakeCase()}}/tasks/tasks.dart';
import 'package:meta/meta.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tasks/tasks.dart';

part 'task_creator.pod.g.dart';

@Riverpod(
  dependencies: [
    tasksRepository,
  ],
)
class TaskCreator extends _$TaskCreator {
  @override
  Future<bool> build() async {
    return false;
  }

  Future<void> create({
    required NewTask newTask,
  }) async {
    if (state.isLoading) return;
    state = const AsyncLoading();
    final tasksRepository = ref.read(tasksRepositoryPod);
    final newState = await AsyncValue.guard(
      () async => tasksRepository.createTask(newTask: newTask),
    );
    state = newState.whenData((_) => true);
  }
}

@visibleForTesting
typedef TestableTaskCreator = _$TaskCreator;
