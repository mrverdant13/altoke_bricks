import 'package:{{project_name.snakeCase()}}/tasks/tasks.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tasks/tasks.dart';

part 'async_task.pod.g.dart';

@Riverpod(dependencies: [scopedTaskId, tasksRepository])
Future<Task?> asyncTask(AsyncTaskRef ref) async {
  final taskId = ref.watch(scopedTaskIdPod);
  final tasksRepository = ref.watch(tasksRepositoryPod);
  final task = await tasksRepository.getTaskById(taskId);
  return task;
}
