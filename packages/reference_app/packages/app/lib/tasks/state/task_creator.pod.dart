import 'package:altoke_app/tasks/tasks.dart';
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
    ref.watch(tasksRepositoryPod);
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
