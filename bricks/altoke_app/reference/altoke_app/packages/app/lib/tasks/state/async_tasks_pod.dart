import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_database/local_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'async_tasks_pod.g.dart';

// coverage:ignore-start
@Riverpod(dependencies: [localTasksDao])
Stream<Iterable<Task>> asyncTasks(Ref ref) {
  return ref.watch(localTasksDaoPod).watchAll();
}

@Riverpod(dependencies: [localTasksDao])
class CreateTaskMutation extends _$CreateTaskMutation {
  @override
  Future<NewTask?> build() async => Future.value();

  Future<void> createTask(NewTask newTask) async {
    if (state is AsyncLoading) return;
    state = const AsyncLoading<NewTask?>().copyWithPrevious(AsyncData(newTask));
    state = await AsyncValue.guard(() async {
      await ref.read(localTasksDaoPod).createOne(newTask);
      return newTask;
    });
    state = const AsyncData(null);
  }
}

@Riverpod(dependencies: [localTasksDao])
class UpdateTaskMutation extends _$UpdateTaskMutation {
  @override
  Future<(int, PartialTask)?> build() async => Future.value();

  Future<void> updateTask({
    required int taskId,
    required PartialTask task,
  }) async {
    if (state is AsyncLoading) return;
    state = const AsyncLoading<(int, PartialTask)>().copyWithPrevious(
      AsyncData((taskId, task)),
    );
    state = await AsyncValue.guard(() async {
      await ref
          .read(localTasksDaoPod)
          .updateOneById(taskId: taskId, task: task);
      return (taskId, task);
    });
    state = const AsyncData(null);
  }
}

@Riverpod(dependencies: [localTasksDao])
class DeleteTaskByIdMutation extends _$DeleteTaskByIdMutation {
  @override
  Future<int?> build() async => Future.value();

  Future<void> deleteTaskById(int taskId) async {
    if (state is AsyncLoading) return;
    state = const AsyncLoading<int>().copyWithPrevious(AsyncData(taskId));
    state = await AsyncValue.guard(() async {
      await ref.read(localTasksDaoPod).deleteOneById(taskId);
      return taskId;
    });
    state = const AsyncData(null);
  }
}

// coverage:ignore-end
