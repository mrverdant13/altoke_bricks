import 'package:altoke_app/tasks/tasks.dart';
import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:local_database/local_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'async_tasks_pod.g.dart';

// coverage:ignore-start
@Riverpod(dependencies: [localTasksDao])
Stream<Iterable<Task>> asyncTasks(Ref ref) {
  return ref.watch(localTasksDaoPod).watchAll();
}

final createTaskMutation = Mutation<Task>(
  label: 'createTaskMutation',
);

Future<void> createTask(MutationTarget target, NewTask newTask) async {
  await createTaskMutation.run(target, (tsx) async {
    final localTasksDao = tsx.get(localTasksDaoPod);
    final task = await localTasksDao.createOne(newTask);
    return task;
  });
}

final updateTaskMutation = Mutation<(int, PartialTask)>(
  label: 'updateTaskMutation',
);

Future<void> updateTask(
  MutationTarget target, {
  required int taskId,
  required PartialTask task,
}) async {
  await updateTaskMutation.run(target, (tsx) async {
    final localTasksDao = tsx.get(localTasksDaoPod);
    await localTasksDao.updateOneById(taskId: taskId, task: task);
    return (taskId, task);
  });
}

final deleteTaskByIdMutation = Mutation<int>(
  label: 'deleteTaskByIdMutation',
);

Future<void> deleteTaskById(MutationTarget target, int taskId) async {
  await deleteTaskByIdMutation.run(target, (tsx) async {
    final localTasksDao = tsx.get(localTasksDaoPod);
    await localTasksDao.deleteOneById(taskId);
    return taskId;
  });
}

// coverage:ignore-end
