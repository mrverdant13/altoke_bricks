import 'dart:async';

import 'package:{{project_name.snakeCase()}}/tasks/tasks.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tasks/tasks.dart';

part 'async_latest_deleted_task.pod.g.dart';

@Riverpod(
  dependencies: [
    tasksRepository,
  ],
)
class LatestDeletedTask extends _$LatestDeletedTask {
  @override
  Stream<Task?> build() {
    final tasksRepository = ref.watch(tasksRepositoryPod);
    return tasksRepository.watchLatestDeletedTask();
  }

  Future<void> restore() async {
    final tasksRepository = ref.read(tasksRepositoryPod);
    await tasksRepository.restoreLatestDeletedTask();
  }
}
