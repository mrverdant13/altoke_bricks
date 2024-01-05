import 'package:altoke_app/tasks/tasks.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tasks_repository/tasks_repository.dart';

part 'tasks_repository.pod.g.dart';

@Riverpod(dependencies: [latestDeletedTaskCache, tasksStorage])
TasksRepository tasksRepository(TasksRepositoryRef ref) {
  final latestDeletedTaskCache = ref.watch(latestDeletedTaskCachePod);
  final tasksStorage = ref.watch(tasksStoragePod);
  final repo = TasksRepository(
    latestDeletedTaskCache: latestDeletedTaskCache,
    tasksStorage: tasksStorage,
  );
  return repo;
}
