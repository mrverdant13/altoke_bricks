import 'package:{{project_name.snakeCase()}}/tasks/tasks.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'async_filtered_tasks_count.pod.g.dart';

@Riverpod(
  dependencies: [
    tasksRepository,
    SelectedTasksStatusFilter,
    TaskSearchTerm,
  ],
)
Stream<int> asyncFilteredTasksCount(
  AsyncFilteredTasksCountRef ref,
) {
  final statusFilter = ref.watch(selectedTasksStatusFilterPod);
  final searchTerm = ref.watch(taskSearchTermPod);
  final tasksRepository = ref.watch(tasksRepositoryPod);
  return tasksRepository.watchCount(
    statusFilter: statusFilter,
    searchTerm: searchTerm,
  );
}
