import 'package:altoke_app/tasks/tasks.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tasks/tasks.dart';

part 'task_editor.pod.g.dart';

@Riverpod(
  dependencies: [
    tasksRepository,
  ],
)
class TaskEditor extends _$TaskEditor {
  @override
  Future<void> build(int taskId) async {
    ref.watch(tasksRepositoryPod);
  }

  Future<void> updateTask({
    required PartialTask partialTask,
  }) async {
    if (state.isLoading) return;
    state = const AsyncLoading();
    final tasksRepository = ref.read(tasksRepositoryPod);
    state = await AsyncValue.guard(
      () async => tasksRepository.updateTask(
        taskId: taskId,
        partialTask: partialTask,
      ),
    );
  }

  Future<void> deleteTask() async {
    if (state.isLoading) return;
    state = const AsyncLoading();
    final tasksRepository = ref.read(tasksRepositoryPod);
    state = await AsyncValue.guard(
      () async => tasksRepository.deleteTask(
        taskId: taskId,
      ),
    );
  }
}
